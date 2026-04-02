extends  Resource
class_name Unit

# tipe unit
enum Type { INFANTRY, CAVALRY, RANGE }

# data dasar unit
var type: Unit.Type
var label: String
var hp: int
var max_hp: int
var attack: int
var defense: int
var mobility: int
var atk_range: int # jangkauan serangan dalam tile

# warna representasi di grid (sementara, belum ada sprite)
var color: Color

func setup(p_type: Unit.Type) -> Unit:
	type = p_type
	match type:
		Unit.Type.INFANTRY:
			label = "Infantry"
			max_hp = 12
			attack = 5
			defense = 4
			mobility = 2
			atk_range = 1
			color = Color(0.2, 0.5, 1.0, 1.0) # biru = infantry
		Unit.Type.CAVALRY:
			label = "Cavalry"
			max_hp = 9
			attack = 7
			defense = 2
			mobility = 4
			atk_range = 1
			color = Color(0.2, 0.75, 0.35, 1.0) # hijau = cavalry
		Unit.Type.RANGE:
			label = "Range"
			max_hp = 7
			attack = 5
			defense = 1
			mobility = 3
			atk_range = 3
			color = Color(0.75, 0.4, 0.9, 1.0) # ungu = range
	hp = max_hp
	return self
	
# hitung damage ke target dengan triangle system
func calc_damage(target: Unit) -> int:
	var base = max(attack - target.defense, 1)
	var bonus = get_triangle_bonus(target)
	var result = int(base * bonus) + randi_range(-1, 1)
	return max(result, 1)
	
# triangle sistem: infantry > cavalry > range > infantry
func get_triangle_bonus(target: Unit) -> float:
	if type == Unit.Type.INFANTRY and target.type == Unit.Type.CAVALRY:
		return 1.25
	if type == Unit.Type.CAVALRY and target.type == Unit.Type.RANGE:
		return 1.25
	if type == Unit.Type.RANGE and target.type == Unit.Type.INFANTRY:
		return 1.25
	return 1.0
	
# cek apakah unit ini unggul di triangle sistem
func beats(target: Unit) -> bool:
	return get_triangle_bonus(target) > 1.0
