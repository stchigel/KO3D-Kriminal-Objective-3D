class_name PistaArea
extends Control

signal clickeada(area: PistaArea, nueva: bool)

@export var pista: Pista
@export var fuente_defecto: String = ""
@export var color_resaltado: Color = Color(1.0, 0.85, 0.2, 0.35)
@export var color_anotada: Color = Color(0.6, 0.6, 0.6, 0.25)

var _encima: bool = false


func _ready() -> void:
	if pista == null or pista.id.is_empty():
		push_warning("PistaArea '%s' no tiene pista con id: se va a anotar cada vez que la clickeen." % name)
	mouse_filter = MOUSE_FILTER_PASS
	mouse_default_cursor_shape = CURSOR_POINTING_HAND
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	visibility_changed.connect(_on_mouse_exited)
	var rect := get_parent() as TextureRect
	if rect != null:
		rect.resized.connect(ubicar)
	ubicar()


func ubicar() -> void:
	var rect := get_parent() as TextureRect
	var pista_imagen := pista as PistaImagen
	if rect == null or rect.texture == null or pista_imagen == null:
		return
	var tamano_textura := rect.texture.get_size()
	var escala := minf(rect.size.x / tamano_textura.x, rect.size.y / tamano_textura.y)
	var origen := (rect.size - tamano_textura * escala) / 2.0
	position = origen + pista_imagen.region.position * escala
	size = pista_imagen.region.size * escala


func actualizar_hover(zona_visible: Rect2) -> void:
	var mouse := get_global_mouse_position()
	var encima := is_visible_in_tree() and zona_visible.has_point(mouse) and get_global_rect().has_point(mouse)
	if encima != _encima:
		_encima = encima
		queue_redraw()


func _gui_input(event: InputEvent) -> void:
	if pista == null:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var fuente := pista.fuente if not pista.fuente.is_empty() else fuente_defecto
		var nueva := Global.anotar(pista.id, pista.titulo, pista.texto, fuente, pista.tipo, pista.puntos)
		queue_redraw()
		clickeada.emit(self, nueva)
		accept_event()


func _on_mouse_entered() -> void:
	_encima = true
	queue_redraw()


func _on_mouse_exited() -> void:
	_encima = false
	queue_redraw()


func _draw() -> void:
	if not _encima or pista == null:
		return
	var color := color_anotada if Global.tiene_pista(pista.id) else color_resaltado
	draw_rect(Rect2(Vector2.ZERO, size), color)
