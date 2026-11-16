class_name PaginaInformativa
extends Resource

@export var titulo: String = ""
@export var lema: String = ""
@export_multiline var introduccion: String = ""
@export var pistas: Array[Pista] = []
@export var secciones: Array[SeccionInformativa] = []
@export var color_fondo: Color = Color(0.09, 0.1, 0.12)
@export var color_tarjeta: Color = Color(0.15, 0.16, 0.19)
@export var color_acento: Color = Color(0.36, 0.6, 0.95)
@export var color_texto: Color = Color(1, 1, 1)


func estilo(color: Color, margen: int) -> StyleBoxFlat:
	var caja := StyleBoxFlat.new()
	caja.bg_color = color
	caja.set_corner_radius_all(6)
	caja.set_content_margin_all(margen)
	return caja


func color_sobre_acento() -> Color:
	if color_acento.get_luminance() > 0.55:
		return Color(0.1, 0.1, 0.1)
	return Color(1, 1, 1)
