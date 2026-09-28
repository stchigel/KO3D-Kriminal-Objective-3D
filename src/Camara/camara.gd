extends Panel
@export var nombre: String = "camara"
@export var rotation_speed: float = 1.5
var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
@export var escena: PackedScene = preload("res://node_3d.tscn")
var escena_instancia: Node3D

var moving_left: bool = false
var moving_right: bool = false
var moving_up: bool = false
var moving_down: bool = false

## Las PistaClickeable de la escena 3D, para apagarles el resaltado.
var pistas_3d: Array[PistaClickeable] = []
var tween_aviso: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = nombre
	escena_instancia = escena.instantiate()
	$SubViewportContainer/SubViewport.add_child(escena_instancia)
	_conectar_pistas(escena_instancia)


## Busca las PistaClickeable de la escena 3D y escucha sus clicks.
func _conectar_pistas(nodo: Node) -> void:
	if nodo is PistaClickeable:
		pistas_3d.append(nodo)
		nodo.clickeada.connect(_on_pista_clickeada)
		nodo.hover_cambiado.connect(_on_pista_hover_cambiado)
	for hijo in nodo.get_children():
		_conectar_pistas(hijo)


func _on_pista_clickeada(pista: PistaClickeable, nueva: bool) -> void:
	if nueva:
		_mostrar_aviso("Pista anotada: " + pista.titulo)
	else:
		_mostrar_aviso("Ya anotaste esta pista")


func _on_pista_hover_cambiado(_pista: PistaClickeable, encima: bool) -> void:
	$SubViewportContainer.mouse_default_cursor_shape = CURSOR_POINTING_HAND if encima else CURSOR_ARROW


func _on_sub_viewport_container_mouse_exited() -> void:
	# Si el mouse sale rapido de la ventana puede quedar una pista resaltada.
	for pista in pistas_3d:
		pista.resaltar(false)
	$SubViewportContainer.mouse_default_cursor_shape = CURSOR_ARROW


func _mostrar_aviso(texto: String) -> void:
	$Aviso.text = texto
	$Aviso.modulate.a = 1.0
	$Aviso.show()
	if tween_aviso:
		tween_aviso.kill()
	tween_aviso = create_tween()
	tween_aviso.tween_interval(1.5)
	tween_aviso.tween_property($Aviso, "modulate:a", 0.0, 0.5)
	tween_aviso.tween_callback($Aviso.hide)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not escena_instancia:
		return
	var step: float = rotation_speed * delta
	if moving_left:
		escena_instancia.rotarCamaraY(step)
	if moving_right:
		escena_instancia.rotarCamaraY(-step)
	if moving_up:
		escena_instancia.rotarCamaraX(step)
	if moving_down:
		escena_instancia.rotarCamaraX(-step)


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


func _on_left_button_down() -> void:
	moving_left = true


func _on_left_button_up() -> void:
	moving_left = false


func _on_down_button_down() -> void:
	moving_down = true


func _on_down_button_up() -> void:
	moving_down = false


func _on_up_button_down() -> void:
	moving_up = true


func _on_up_button_up() -> void:
	moving_up = false
	


func _on_right_button_down() -> void:
	moving_right = true


func _on_right_button_up() -> void:
	moving_right = false
	


func _on_reset_pressed() -> void:
	escena_instancia.resetearCamara()
