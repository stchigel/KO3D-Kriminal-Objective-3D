class_name PistaClickeable
extends Area3D

signal clickeada(pista: PistaClickeable, nueva: bool)
signal hover_cambiado(pista: PistaClickeable, encima: bool)

@export var id: String = ""
@export var titulo: String = ""
@export_multiline var texto: String = ""
@export var fuente: String = ""
@export var color_resaltado: Color = Color(1.0, 0.85, 0.2, 0.35)
@export var color_anotada: Color = Color(0.6, 0.6, 0.6, 0.25)

var _material_resaltado: StandardMaterial3D


func _ready() -> void:
	if id.is_empty():
		push_warning("PistaClickeable '%s' no tiene id: se va a anotar cada vez que la clickeen." % name)
	input_ray_pickable = true
	_material_resaltado = StandardMaterial3D.new()
	_material_resaltado.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	_material_resaltado.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	


func _on_input_event(_camera: Node, event: InputEvent, _posicion: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var nueva := Global.anotar(id, titulo, texto, fuente)
		resaltar(true)
		clickeada.emit(self, nueva)


func _on_mouse_entered() -> void:
	resaltar(true)
	hover_cambiado.emit(self, true)
	


func _on_mouse_exited() -> void:
	resaltar(false)
	hover_cambiado.emit(self, false)
	


func resaltar(encendido: bool) -> void:
	_material_resaltado.albedo_color = color_anotada if Global.tiene_pista(id) else color_resaltado
	for nodo in find_children("*", "GeometryInstance3D", true, false):
		(nodo as GeometryInstance3D).material_overlay = _material_resaltado if encendido else null
