extends Resource
class_name Terrain

enum Type { PLAIN, HILL, FOREST, ROAD, RIVER, RUIN }

var type:  Terrain.Type
var label: String
var color: Color

func setup(p_type: Terrain.Type) -> Terrain:
	type = p_type
	match type:
		Terrain.Type.PLAIN:
			label = "Dataran"
			color = Color(0.25, 0.45, 0.2, 1.0)
		Terrain.Type.HILL:
			label = "Bukit"
			color = Color(0.55, 0.5, 0.35, 1.0)
		Terrain.Type.FOREST:
			label = "Hutan"
			color = Color(0.1, 0.45, 0.15, 1.0)
		Terrain.Type.ROAD:
			label = "Jalan"
			color = Color(0.65, 0.55, 0.3, 1.0)
		Terrain.Type.RIVER:
			label = "Sungai"
			color = Color(0.15, 0.4, 0.75, 1.0)
		Terrain.Type.RUIN:
			label = "Reruntuhan"
			color = Color(0.45, 0.4, 0.35, 1.0)
	return self

# Bonus defense (persentase) berdasarkan unit type
func get_defense_bonus(unit_type: Unit.Type) -> float:
	match type:
		Terrain.Type.HILL:
			if unit_type == Unit.Type.INFANTRY:
				return 0.10
		Terrain.Type.FOREST:
			if unit_type == Unit.Type.INFANTRY:
				return 0.15
		Terrain.Type.RUIN:
			if unit_type == Unit.Type.INFANTRY:
				return 0.10
	return 0.0

# Bonus attack (persentase) berdasarkan unit type
func get_attack_bonus(unit_type: Unit.Type) -> float:
	match type:
		Terrain.Type.HILL:
			if unit_type == Unit.Type.RANGE:
				return 0.20
	return 0.0

# Penalti mobility -- berapa tile yang dikurangi saat MASUK tile ini
func get_mobility_cost(unit_type: Unit.Type) -> int:
	match type:
		Terrain.Type.RIVER:
			if unit_type == Unit.Type.CAVALRY:
				return 99   # tidak bisa lewat
			if unit_type == Unit.Type.INFANTRY:
				return 2    # butuh 2 jatah gerak
		Terrain.Type.FOREST:
			if unit_type == Unit.Type.CAVALRY:
				return 2
		Terrain.Type.ROAD:
			return 0        # gratis, lebih cepat
	return 1                # default: 1 tile = 1 jatah gerak

# Cek apakah unit bisa masuk sama sekali
func is_passable(unit_type: Unit.Type) -> bool:
	if type == Terrain.Type.RIVER and unit_type == Unit.Type.CAVALRY:
		return false
	return true
