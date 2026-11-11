class_name BotonAutor
extends Button
signal perfil_pedido(autor: String)

var _autor: String = ""


func _ready() -> void:
	flat = true
	focus_mode = Control.FOCUS_NONE
	pressed.connect(_on_pressed)


func configurar(autor: String, red: RedSocial, perfil_actual: PerfilSocial) -> void:
	_autor = autor
	text = autor
	var destino := red.buscar_perfil(autor)
	var es_enlace := destino != null and destino != perfil_actual
	disabled = not es_enlace
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND if es_enlace else Control.CURSOR_ARROW
	var color := red.color_acento if es_enlace else Color(1, 1, 1, 0.9)
	add_theme_color_override("font_color", color)
	add_theme_color_override("font_disabled_color", color)
	add_theme_color_override("font_hover_color", color.lightened(0.3))
	add_theme_color_override("font_pressed_color", color.lightened(0.3))


func _on_pressed() -> void:
	perfil_pedido.emit(_autor)
