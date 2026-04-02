extends Node2D

const TILE_SIZE   = 64
const GRID_COLS   = 8
const GRID_ROWS   = 6

const COLOR_NORMAL      = Color(0.15, 0.35, 0.6,  1.0)
const COLOR_REACHABLE   = Color(0.2,  0.7,  0.4,  1.0)
const COLOR_ATTACKABLE  = Color(0.9,  0.5,  0.1,  1.0)  # oranye = bisa diserang
const COLOR_ENEMY_RANGE = Color(0.6,  0.15, 0.15, 1.0)

# ================================
#  DATA UNIT
# ================================

var player_pos      = Vector2i(1, 3)
var player_selected = false
var player_moved    = false
var player_attacked = false
var player_hp       = 10
var player_atk      = 3
var move_range      = 3
var player_node: ColorRect
var player_hp_label: Label

var enemy_pos  = Vector2i(6, 3)
var enemy_hp   = 10
var enemy_atk  = 2
var enemy_node: ColorRect
var enemy_hp_label: Label

# ================================
#  GILIRAN
# ================================

enum Turn { PLAYER, ENEMY }
var current_turn = Turn.PLAYER

var turn_label:   Label
var log_label:    Label

# ================================
#  SETUP
# ================================

func _ready():
	create_grid()
	create_player()
	create_enemy()
	create_ui()
	update_hp_labels()
	refresh_tiles()

func create_grid():
	for row in range(GRID_ROWS):
		for col in range(GRID_COLS):
			var tile      = ColorRect.new()
			tile.size     = Vector2(TILE_SIZE - 2, TILE_SIZE - 2)
			tile.position = Vector2(col * TILE_SIZE + 1, row * TILE_SIZE + 1)
			tile.color    = COLOR_NORMAL
			tile.set_meta("grid_pos", Vector2i(col, row))
			add_child(tile)

func create_player():
	player_node          = ColorRect.new()
	player_node.size     = Vector2(TILE_SIZE - 16, TILE_SIZE - 16)
	player_node.color    = Color(0.2, 0.5, 1.0, 1.0)
	player_node.position = grid_to_pixel(player_pos) + Vector2(8, 8)
	add_child(player_node)

	player_hp_label = Label.new()
	player_hp_label.add_theme_font_size_override("font_size", 11)
	player_hp_label.add_theme_color_override("font_color", Color.WHITE)
	add_child(player_hp_label)

func create_enemy():
	enemy_node          = ColorRect.new()
	enemy_node.size     = Vector2(TILE_SIZE - 16, TILE_SIZE - 16)
	enemy_node.color    = Color(0.9, 0.2, 0.2, 1.0)
	enemy_node.position = grid_to_pixel(enemy_pos) + Vector2(8, 8)
	add_child(enemy_node)

	enemy_hp_label = Label.new()
	enemy_hp_label.add_theme_font_size_override("font_size", 11)
	enemy_hp_label.add_theme_color_override("font_color", Color.WHITE)
	add_child(enemy_hp_label)

func create_ui():
	var base_y = GRID_ROWS * TILE_SIZE + 10

	turn_label          = Label.new()
	turn_label.position = Vector2(10, base_y)
	turn_label.add_theme_font_size_override("font_size", 18)
	add_child(turn_label)

	log_label          = Label.new()
	log_label.position = Vector2(10, base_y + 30)
	log_label.add_theme_font_size_override("font_size", 14)
	log_label.add_theme_color_override("font_color", Color(0.8, 0.8, 0.8, 1.0))
	add_child(log_label)

	update_turn_label()

# ================================
#  HELPER
# ================================

func grid_to_pixel(pos: Vector2i) -> Vector2:
	return Vector2(pos.x * TILE_SIZE, pos.y * TILE_SIZE)

func get_distance(a: Vector2i, b: Vector2i) -> int:
	return abs(a.x - b.x) + abs(a.y - b.y)

func is_adjacent(a: Vector2i, b: Vector2i) -> bool:
	return get_distance(a, b) == 1

func update_turn_label():
	if current_turn == Turn.PLAYER:
		turn_label.text = "Giliran: PEMAIN"
	else:
		turn_label.text = "Giliran: MUSUH"

func update_hp_labels():
	player_hp_label.text     = "HP: " + str(player_hp)
	player_hp_label.position = grid_to_pixel(player_pos) + Vector2(6, -18)

	enemy_hp_label.text     = "HP: " + str(enemy_hp)
	enemy_hp_label.position = grid_to_pixel(enemy_pos) + Vector2(6, -18)

func add_log(text: String):
	log_label.text = text
	print(text)

func refresh_tiles():
	for child in get_children():
		if not child.has_meta("grid_pos"):
			continue
		var pos = child.get_meta("grid_pos")

		# Tampilkan jangkauan gerak
		if current_turn == Turn.PLAYER and player_selected and not player_moved:
			if get_distance(player_pos, pos) <= move_range and pos != enemy_pos:
				child.color = COLOR_REACHABLE
				continue

		# Tampilkan tile musuh bisa diserang (setelah bergerak)
		if current_turn == Turn.PLAYER and player_moved and not player_attacked:
			if pos == enemy_pos and is_adjacent(player_pos, enemy_pos):
				child.color = COLOR_ATTACKABLE
				continue

		# Tampilkan jangkauan musuh saat giliran musuh
		if current_turn == Turn.ENEMY:
			if get_distance(enemy_pos, pos) <= 1:
				child.color = COLOR_ENEMY_RANGE
				continue

		child.color = COLOR_NORMAL

# ================================
#  INPUT PEMAIN
# ================================

func _input(event):
	if current_turn != Turn.PLAYER:
		return
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var click_pos = get_global_mouse_position()
			var grid_pos  = Vector2i(
				int(click_pos.x / TILE_SIZE),
				int(click_pos.y / TILE_SIZE)
			)
			if grid_pos.x < 0 or grid_pos.x >= GRID_COLS:
				return
			if grid_pos.y < 0 or grid_pos.y >= GRID_ROWS:
				return
			handle_player_click(grid_pos)

	# Tekan E untuk End Turn manual
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_E and current_turn == Turn.PLAYER:
			add_log("Pemain mengakhiri giliran.")
			await get_tree().create_timer(0.3).timeout
			start_enemy_turn()

func handle_player_click(grid_pos: Vector2i):
	# Klik musuh saat bisa menyerang
	if grid_pos == enemy_pos and player_moved and not player_attacked:
		if is_adjacent(player_pos, enemy_pos):
			player_attack()
			return

	# Klik unit pemain = pilih / batal
	if grid_pos == player_pos and not player_moved:
		player_selected = not player_selected
		refresh_tiles()
		return

	# Klik tile tujuan
	if player_selected and not player_moved:
		if get_distance(player_pos, grid_pos) <= move_range and grid_pos != enemy_pos:
			player_pos      = grid_pos
			player_selected = false
			player_moved    = true
			player_node.position = grid_to_pixel(player_pos) + Vector2(8, 8)
			update_hp_labels()
			add_log("Pemain bergerak ke " + str(player_pos))
			refresh_tiles()
		else:
			add_log("Tidak bisa ke sana!")

# ================================
#  COMBAT
# ================================

func player_attack():
	player_attacked = true

	# Hitung damage dengan sedikit variasi acak
	var damage = player_atk + randi_range(-1, 1)
	damage      = max(damage, 1)
	enemy_hp   -= damage
	add_log("Pemain menyerang! Damage: " + str(damage) + " | HP Musuh: " + str(enemy_hp))

	# Flash merah pada musuh
	flash_unit(enemy_node, Color(1.0, 1.0, 0.2, 1.0))
	update_hp_labels()

	if enemy_hp <= 0:
		end_game("MUSUH DIKALAHKAN! PEMAIN MENANG!")
		return

	refresh_tiles()
	add_log("Tekan E untuk akhiri giliran.")

func enemy_attack():
	var damage  = enemy_atk + randi_range(-1, 1)
	damage      = max(damage, 1)
	player_hp  -= damage
	add_log("Musuh menyerang! Damage: " + str(damage) + " | HP Pemain: " + str(player_hp))

	flash_unit(player_node, Color(1.0, 1.0, 0.2, 1.0))
	update_hp_labels()

	if player_hp <= 0:
		end_game("PEMAIN DIKALAHKAN! MUSUH MENANG!")

# Flash warna saat unit terkena serangan
func flash_unit(unit: ColorRect, flash_color: Color):
	var original = unit.color
	unit.color   = flash_color
	await get_tree().create_timer(0.25).timeout
	unit.color   = original

# ================================
#  GILIRAN MUSUH
# ================================

func start_enemy_turn():
	current_turn    = Turn.ENEMY
	player_moved    = false
	player_attacked = false
	player_selected = false
	update_turn_label()
	refresh_tiles()

	await get_tree().create_timer(0.8).timeout
	enemy_move()

func enemy_move():
	# Kalau sudah bersebelahan, langsung serang
	if is_adjacent(enemy_pos, player_pos):
		add_log("Musuh menyerang langsung!")
		await get_tree().create_timer(0.3).timeout
		enemy_attack()
		if player_hp > 0:
			await get_tree().create_timer(0.5).timeout
			start_player_turn()
		return

	# Bergerak mendekati pemain
	var best_pos  = enemy_pos
	var best_dist = get_distance(enemy_pos, player_pos)

	var directions = [
		Vector2i( 0, -1),
		Vector2i( 0,  1),
		Vector2i(-1,  0),
		Vector2i( 1,  0)
	]

	for dir in directions:
		var next = enemy_pos + dir
		if next.x < 0 or next.x >= GRID_COLS:
			continue
		if next.y < 0 or next.y >= GRID_ROWS:
			continue
		if next == player_pos:
			continue
		var dist = get_distance(next, player_pos)
		if dist < best_dist:
			best_dist = dist
			best_pos  = next

	enemy_pos = best_pos
	enemy_node.position = grid_to_pixel(enemy_pos) + Vector2(8, 8)
	update_hp_labels()
	add_log("Musuh bergerak ke " + str(enemy_pos))
	refresh_tiles()

	# Serang kalau sekarang sudah bersebelahan
	await get_tree().create_timer(0.5).timeout
	if is_adjacent(enemy_pos, player_pos):
		enemy_attack()
		if player_hp <= 0:
			return

	await get_tree().create_timer(0.4).timeout
	start_player_turn()

func start_player_turn():
	current_turn    = Turn.PLAYER
	player_moved    = false
	player_attacked = false
	update_turn_label()
	refresh_tiles()
	add_log("Giliran pemain -- klik unitmu atau tekan E untuk skip.")

# ================================
#  AKHIR GAME
# ================================

func end_game(result: String):
	turn_label.text = result
	add_log("Game selesai!")
	set_process_input(false)
