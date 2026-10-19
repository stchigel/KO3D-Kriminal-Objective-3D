extends Panel
@export var nombre: String = "imagen"
@export var pags: Array[Texture]
@export var pistas: Array[PistaPdf] = []
var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var areas: Array[PistaArea] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = nombre
	_crear_paginas()
	$ScrollContainer.get_v_scroll_bar().value_changed.connect(_on_scroll)
	$ScrollContainer.get_h_scroll_bar().value_changed.connect(_on_scroll)


func _crear_paginas() -> void:
	for i in pags.size():
		if pags[i] == null:
			continue
		var pagina := TextureRect.new()
		pagina.name = str(i + 1)
		pagina.texture = pags[i]
		pagina.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		$ScrollContainer/VBoxContainer.add_child(pagina)
		_crear_areas(pagina, i + 1)
	for pista in pistas:
		if pista != null and (pista.pagina < 1 or pista.pagina > pags.size() or pags[pista.pagina - 1] == null):
			push_warning("Pdf '%s': la pista '%s' esta en la pagina %d, que no existe." % [nombre, pista.id, pista.pagina])


func _crear_areas(pagina: TextureRect, numero: int) -> void:
	for pista in pistas:
		if pista == null or pista.pagina != numero:
			continue
		var area := PistaArea.new()
		area.name = "Pista_" + pista.id
		area.pista = pista
		area.fuente_defecto = nombre
		pagina.add_child(area)
		areas.append(area)


func _on_scroll(_valor: float) -> void:
	_actualizar_hover_areas.call_deferred()


func _actualizar_hover_areas() -> void:
	var zona: Rect2 = $ScrollContainer.get_global_rect()
	for area in areas:
		area.actualizar_hover(zona)


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
