class_name RedSocial
extends Resource

@export var nombre: String = ""
@export var perfil_inicial: PerfilSocial
@export var perfiles: Array[PerfilSocial] = []
@export var color_fondo: Color = Color(0.09, 0.1, 0.12)
@export var color_tarjeta: Color = Color(0.15, 0.16, 0.19)
@export var color_acento: Color = Color(0.36, 0.6, 0.95)


func buscar_perfil(autor: String) -> PerfilSocial:
	if perfil_inicial != null and perfil_inicial.coincide(autor):
		return perfil_inicial
	for perfil in perfiles:
		if perfil != null and perfil.coincide(autor):
			return perfil
	return null


func estilo(color: Color, margen: int) -> StyleBoxFlat:
	var caja := StyleBoxFlat.new()
	caja.bg_color = color
	caja.set_corner_radius_all(6)
	caja.set_content_margin_all(margen)
	return caja
