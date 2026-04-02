extends Node2D

const HEX_SIZE   = 48.0
const GRID_COLS  = 9
const GRID_ROWS  = 6
const MAP_OFFSET = Vector2(56.0, 48.0)

# Layout terrain peta tutorial Aurestia
const MAP = [
	["plain","plain","hill", "hill",  "plain","plain","ruin",  "ruin", "hill" ],
	["plain","plain","road", "plain", "plain","plain","ruin",  "plain","hill" ],
	["plain","plain","road", "forest","plain","plain","plain","plain", "plain"],
	["forest","forest","road","forest","plain","river","river","plain","plain"],
	["plain","plain","road", "plain", "plain","river","plain","plain", "plain"],
	["plain","hill", "road", "road",  "road", "plain","plain","ruin",  "plain"],
]

const T_COLOR = {
	"plain":  Color(0.25, 0.50, 0.20),
	"hill":   Color(0.55, 0.50, 0.35),
	"forest": Color(0.10, 0.40, 0.15),
	"road":   Color(0.65, 0.55, 0.30),
	"river":  Color(0.15, 0.40, 0.75),
	"ruin":   Color(0.45, 0.40, 0.35),
}

# Biaya mobilitas saat memasuki terrain tertentu
func move_cost(terrain: String, unit_type: Unit.Type) -> int:
	match terrain:
		"river":
			if unit_type == Unit.Type.CAVALRY:  return 99  # tidak bisa lewat
			if unit_type == Unit.Type.INFANTRY: return 2
		"forest":
			if unit_type == Unit.Type.CAVALRY:  return 2
		"road":
			return 0   # lebih cepat
	return 1

# ================================
#  DATA
# ================================

var tile_nodes: Dictionary = {}  # Vector2i -> Polygon2D

var player_unit:       Unit
var player_pos       = Vector2i(1, 3)
var player_node:       Polygon2D
var player_lbl:        Label
var player_can_move    = true
var player_can_attack  = true

var enemies: Array = []   # [{unit, pos, node, lbl}]

var selected    = false
var reachable:  Array = []
var attackable: Array = []

enum Turn { PLAYER, ENEMY }
var current_turn = Turn.PLAYER

var turn_lbl:   Label
var log_lbl:    Label
var action_lbl: Label

# ================================
#  SETUP
# ================================

func _ready():
	build_terrain()
	build_units()
	build_ui()
	refresh()

func build_terrain():
	var verts = HexGrid.hex_vertices(HEX_SIZE - 2.0)
	for row in GRID_ROWS:
		for col in GRID_COLS:
			var pos  = Vector2i(col, row)
			var poly = Polygon2D.new()
			poly.polygon  = verts
			poly.position = HexGrid.hex_to_pixel(col, row, HEX_SIZE) + MAP_OFFSET
			poly.color    = T_COLOR[MAP[row][col]]
			poly.set_meta("hex_pos", pos)
			add_child(poly)
			tile_nodes[pos] = poly

func build_units():
	# Pemain -- Infantry
	player_unit = Unit.new().setup(Unit.Type.INFANTRY)
	player_node = make_unit_poly(player_unit.color, 0.58)
	player_lbl  = make_label()
	place_unit(player_node, player_lbl, player_unit, player_pos)

	# Musuh 1 -- Cavalry (hijau)
	var e1 = Unit.new().setup(Unit.Type.CAVALRY)
	var n1 = make_unit_poly(e1.color, 0.52)
	var l1 = make_label()
	var p1 = Vector2i(6, 2)
	place_unit(n1, l1, e1, p1)
	enemies.append({"unit": e1, "pos": p1, "node": n1, "lbl": l1})

	# Musuh 2 -- Range (ungu)
	var e2 = Unit.new().setup(Unit.Type.RANGE)
	var n2 = make_unit_poly(e2.color, 0.52)
	var l2 = make_label()
	var p2 = Vector2i(7, 4)
	place_unit(n2, l2, e2, p2)
	enemies.append({"unit": e2, "pos": p2, "node": n2, "lbl": l2})

func make_unit_poly(col: Color, scale: float) -> Polygon2D:
	var poly    = Polygon2D.new()
	poly.polygon = HexGrid.hex_vertices(HEX_SIZE * scale)
	poly.color   = col
	add_child(poly)
	return poly

func make_label() -> Label:
	var l = Label.new()
	l.add_theme_font_size_override("font_size", 10)
	l.add_theme_color_override("font_color", Color.WHITE)
	add_child(l)
	return l

func place_unit(node: Polygon2D, lbl: Label, unit: Unit, pos: Vector2i):
	var center   = HexGrid.hex_to_pixel(pos.x, pos.y, HEX_SIZE) + MAP_OFFSET
	node.position = center
	lbl.text      = unit.label + "\n" + str(unit.hp) + "/" + str(unit.max_hp)
	lbl.position  = center + Vector2(-20, -HEX_SIZE * 0.95)

func build_ui():
	var by = MAP_OFFSET.y + GRID_ROWS * HEX_SIZE * HexGrid.SQRT3 + 16
	turn_lbl   = make_ui_label(Vector2(10, by),      16)
	log_lbl    = make_ui_label(Vector2(10, by + 26), 13)
	action_lbl = make_ui_label(Vector2(10, by + 48), 12)
	action_lbl.add_theme_color_override("font_color", Color(0.5, 0.95, 0.5))
	update_turn_label()

func make_ui_label(pos: Vector2, size: int) -> Label:
	var l = Label.new()
	l.position = pos
	l.add_theme_font_size_override("font_size", size)
	add_child(l)
	return l

# ================================
#  HELPER
# ================================

func update_turn_label():
	if current_turn == Turn.PLAYER:
		turn_lbl.text = "Giliran: PEMAIN  |  E = akhiri giliran"
	else:
		turn_lbl.text = "Giliran: MUSUH -- tunggu..."

func update_action_label():
	if current_turn != Turn.PLAYER:
		action_lbl.text = ""
		return
	var acts: Array = []
	if player_can_move:   acts.append("Bisa gerak")
	if player_can_attack: acts.append("Bisa serang")
	if acts.is_empty():   acts.append("Aksi habis -- tekan E")
	action_lbl.text = " | ".join(acts)

func get_alive_enemies() -> Array:
	return enemies.filter(func(e): return e["unit"].hp > 0)

func get_enemy_positions() -> Array:
	return get_alive_enemies().map(func(e): return e["pos"])

# BFS untuk tile yang bisa dijangkau unit
func get_reachable(start: Vector2i, mobility: int,
				   unit_type: Unit.Type, blocked: Array) -> Array:
	var result  = []
	var visited = {}
	var queue   = [{"pos": start, "mp": mobility}]
	while queue.size() > 0:
		var cur = queue.pop_front()
		var pos = cur["pos"]
		var mp  = cur["mp"]
		if visited.has(pos): continue
		visited[pos] = true
		if pos != start: result.append(pos)
		for nb in HexGrid.get_neighbors(pos.x, pos.y):
			if visited.has(nb): continue
			if nb.x < 0 or nb.x >= GRID_COLS: continue
			if nb.y < 0 or nb.y >= GRID_ROWS: continue
			if blocked.has(nb): continue
			var cost = move_cost(MAP[nb.y][nb.x], unit_type)
			if cost == 99: continue
			if mp - cost >= 0:
				queue.append({"pos": nb, "mp": mp - cost})
	return result

# ================================
#  DISPLAY
# ================================

func refresh():
	# Reset semua tile ke warna asli terrain
	for pos in tile_nodes:
		tile_nodes[pos].color = T_COLOR[MAP[pos.y][pos.x]]

	if current_turn == Turn.PLAYER and selected:
		# Hitung & tampilkan tile yang bisa dituju (gerak)
		reachable = []
		if player_can_move:
			reachable = get_reachable(
				player_pos, player_unit.mobility,
				player_unit.type, get_enemy_positions())
			for pos in reachable:
				if tile_nodes.has(pos):
					tile_nodes[pos].color = T_COLOR[MAP[pos.y][pos.x]].lightened(0.45)

		# Hitung & tampilkan musuh yang bisa diserang
		attackable = []
		if player_can_attack:
			for e in get_alive_enemies():
				if HexGrid.hex_distance(player_pos, e["pos"]) <= player_unit.atk_range:
					attackable.append(e["pos"])
					if tile_nodes.has(e["pos"]):
						tile_nodes[e["pos"]].color = Color(0.9, 0.5, 0.1)

	update_action_label()

# ================================
#  INPUT
# ================================

func _input(event):
	if current_turn != Turn.PLAYER: return

	if event is InputEventKey and event.pressed and event.keycode == KEY_E:
		log_lbl.text = "Giliran diakhiri."
		selected = false
		refresh()
		await get_tree().create_timer(0.3).timeout
		start_enemy_turn()
		return

	if event is InputEventMouseButton and event.pressed \
	   and event.button_index == MOUSE_BUTTON_LEFT:
		var hex = HexGrid.pixel_to_offset(
			get_global_mouse_position(), HEX_SIZE, MAP_OFFSET)
		if hex.x < 0 or hex.x >= GRID_COLS: return
		if hex.y < 0 or hex.y >= GRID_ROWS: return
		handle_click(hex)

func handle_click(hex: Vector2i):
	# Prioritas 1: klik musuh yang bisa diserang
	if player_can_attack and attackable.has(hex):
		await do_attack(hex)
		return

	# Prioritas 2: klik unit pemain sendiri = toggle select
	if hex == player_pos:
		selected = not selected
		refresh()
		return

	# Prioritas 3: klik tile tujuan untuk bergerak
	if selected and player_can_move and reachable.has(hex):
		player_pos      = hex
		player_can_move = false
		selected        = false
		place_unit(player_node, player_lbl, player_unit, player_pos)
		log_lbl.text = "Pindah ke " + str(player_pos) + \
					   "  [" + MAP[player_pos.y][player_pos.x] + "]"
		refresh()

# ================================
#  COMBAT
# ================================

func do_attack(target_pos: Vector2i):
	player_can_attack = false
	selected = false

	var target = null
	for e in enemies:
		if e["pos"] == target_pos and e["unit"].hp > 0:
			target = e
			break
	if target == null: return

	var t_unit: Unit = target["unit"]
	var dmg = player_unit.calc_damage(t_unit)
	t_unit.hp = max(t_unit.hp - dmg, 0)

	var tri = " [triangle +25%!]" if player_unit.beats(t_unit) else ""
	log_lbl.text = "Serang " + t_unit.label + "! DMG: " + str(dmg) + tri

	var orig = target["node"].color
	target["node"].color = Color(1.0, 1.0, 0.2)
	await get_tree().create_timer(0.25).timeout
	target["node"].color = orig

	place_unit(target["node"], target["lbl"], t_unit, target_pos)

	if t_unit.hp <= 0:
		target["node"].visible = false
		target["lbl"].visible  = false
		log_lbl.text = t_unit.label + " dikalahkan!"
		if get_alive_enemies().is_empty():
			end_game("SEMUA MUSUH DIKALAHKAN! MENANG!")
			return

	refresh()

# ================================
#  GILIRAN MUSUH
# ================================

func start_enemy_turn():
	current_turn = Turn.ENEMY
	update_turn_label()
	refresh()
	await get_tree().create_timer(0.6).timeout
	for e in enemies:
		if e["unit"].hp <= 0: continue
		await enemy_act(e)
		await get_tree().create_timer(0.4).timeout
	if player_unit.hp > 0:
		start_player_turn()

func enemy_act(e: Dictionary):
	# Kalau sudah dalam jangkauan serang, langsung serang
	if HexGrid.hex_distance(e["pos"], player_pos) <= e["unit"].atk_range:
		await enemy_attack(e)
		return

	# Hitung tile terbaik untuk mendekati pemain
	var others  = enemies.filter(
		func(x): return x["unit"].hp > 0 and x["pos"] != e["pos"]
	).map(func(x): return x["pos"])
	others.append(player_pos)   # jangan masuk tile pemain

	var reachable_e = get_reachable(
		e["pos"], e["unit"].mobility, e["unit"].type, others)

	var best   = e["pos"]
	var best_d = HexGrid.hex_distance(e["pos"], player_pos)
	for r in reachable_e:
		var d = HexGrid.hex_distance(r, player_pos)
		if d < best_d:
			best_d = d
			best   = r

	if best != e["pos"]:
		e["pos"] = best
		place_unit(e["node"], e["lbl"], e["unit"], e["pos"])
		log_lbl.text = e["unit"].label + " bergerak ke " + str(e["pos"])
		refresh()
		await get_tree().create_timer(0.35).timeout

	if HexGrid.hex_distance(e["pos"], player_pos) <= e["unit"].atk_range:
		await enemy_attack(e)

func enemy_attack(e: Dictionary):
	var dmg = e["unit"].calc_damage(player_unit)
	player_unit.hp = max(player_unit.hp - dmg, 0)
	var tri = " [triangle +25%!]" if e["unit"].beats(player_unit) else ""
	log_lbl.text = e["unit"].label + " menyerang! DMG: " + str(dmg) + tri

	var orig = player_node.color
	player_node.color = Color(1.0, 0.3, 0.3)
	await get_tree().create_timer(0.25).timeout
	player_node.color = orig

	place_unit(player_node, player_lbl, player_unit, player_pos)
	if player_unit.hp <= 0:
		end_game("PEMAIN DIKALAHKAN!")

func start_player_turn():
	current_turn      = Turn.PLAYER
	player_can_move   = true
	player_can_attack = true
	selected          = false
	update_turn_label()
	refresh()
	log_lbl.text = "Giliran pemain. Klik unit untuk memilih."

# ================================
#  AKHIR GAME
# ================================

func end_game(msg: String):
	turn_lbl.text = msg
	selected = false
	set_process_input(false)
