extends Panel
@export var imagen: Texture2D = preload("res://assets/icon.svg")
@export var nombre: String = "imagen"
@export var pistas: Array[PistaImagen] = []
var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var areas: Array[PistaArea] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.texture = imagen
	$Label.text = nombre
	_crear_areas()


func _crear_areas() -> void:
	for pista in pistas:
		if pista == null:
			continue
		var area := PistaArea.new()
		area.name = "Pista_" + pista.id
		area.pista = pista
		area.fuente_defecto = nombre
		$TextureRect.add_child(area)
		areas.append(area)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	hide()

func _on_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_offset = get_global_mouse_position() - global_position
		else:
			dragging = false
	if event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() - drag_offset
