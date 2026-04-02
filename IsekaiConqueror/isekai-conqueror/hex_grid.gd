extends Node
class_name HexGrid

const SQRT3 := 1.7320508075688772

# Flat-top hex: posisi pixel dari koordinat offset (col, row)
static func hex_to_pixel(col: int, row: int, size: float) -> Vector2:
	var x = size * 1.5 * col
	var y = size * SQRT3 * row
	if col % 2 == 1:   # kolom ganjil digeser ke bawah
		y += size * SQRT3 * 0.5
	return Vector2(x, y)

# Klik pixel -> koordinat hex offset terdekat
static func pixel_to_offset(px: Vector2, size: float, map_offset: Vector2) -> Vector2i:
	var local = px - map_offset
	var fq    = (2.0 / 3.0 * local.x) / size
	var fr    = (-local.x / 3.0 + SQRT3 / 3.0 * local.y) / size
	return axial_to_offset(axial_round(fq, fr))

# Bulatkan koordinat axial pecahan ke integer terdekat
static func axial_round(fq: float, fr: float) -> Vector2i:
	var fs = -fq - fr
	var rq = roundi(fq); var rr = roundi(fr); var rs = roundi(fs)
	var dq = abs(rq - fq); var dr = abs(rr - fr); var ds = abs(rs - fs)
	if dq > dr and dq > ds: rq = -rr - rs
	elif dr > ds:            rr = -rq - rs
	return Vector2i(rq, rr)

# Konversi offset <-> axial (untuk perhitungan jarak & tetangga)
static func offset_to_axial(col: int, row: int) -> Vector2i:
	return Vector2i(col, row - (col - (col & 1)) / 2)

static func axial_to_offset(ax: Vector2i) -> Vector2i:
	return Vector2i(ax.x, ax.y + (ax.x - (ax.x & 1)) / 2)

# Jarak hex antara dua posisi offset
static func hex_distance(a: Vector2i, b: Vector2i) -> int:
	var aa = offset_to_axial(a.x, a.y)
	var ba = offset_to_axial(b.x, b.y)
	var d  = ba - aa
	return (abs(d.x) + abs(d.x + d.y) + abs(d.y)) / 2

# 6 tetangga dari sebuah hex offset
static func get_neighbors(col: int, row: int) -> Array:
	var ax   = offset_to_axial(col, row)
	var dirs = [
		Vector2i( 1, 0), Vector2i( 1,-1), Vector2i(0,-1),
		Vector2i(-1, 0), Vector2i(-1, 1), Vector2i(0, 1)
	]
	var result = []
	for d in dirs:
		result.append(axial_to_offset(ax + d))
	return result

# Titik-titik sudut hexagon flat-top (berpusat di 0,0)
static func hex_vertices(size: float) -> PackedVector2Array:
	var pts = PackedVector2Array()
	for i in 6:
		var a = deg_to_rad(60.0 * i)   # flat-top: sudut 0,60,120,180,240,300
		pts.append(Vector2(cos(a) * size, sin(a) * size))
	return pts
