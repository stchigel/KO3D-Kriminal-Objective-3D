class_name PaginaEntradas
extends Resource

@export var nombre: String = ""
@export var titulo: String = ""
@export var subtitulo: String = ""
@export_multiline var descripcion: String = ""
@export var descripcion_pistas: Array[Pista] = []
@export var meta: int = 0
@export var recaudado: int = 0
@export var prefijo_monto: String = "$"
@export var etiqueta_entradas: String = ""
@export var entradas: Array[EntradaPagina] = []
@export var color_fondo: Color = Color(0.09, 0.1, 0.12)
@export var color_tarjeta: Color = Color(0.15, 0.16, 0.19)
@export var color_acento: Color = Color(0.36, 0.6, 0.95)


func estilo(color: Color, margen: int) -> StyleBoxFlat:
	var caja := StyleBoxFlat.new()
	caja.bg_color = color
	caja.set_corner_radius_all(6)
	caja.set_content_margin_all(margen)
	return caja


func monto(valor: int) -> String:
	var digitos := str(valor)
	var resultado := ""
	var contador := 0
	for i in range(digitos.length() - 1, -1, -1):
		if contador > 0 and contador % 3 == 0:
			resultado = "." + resultado
		resultado = digitos[i] + resultado
		contador += 1
	return prefijo_monto + resultado
