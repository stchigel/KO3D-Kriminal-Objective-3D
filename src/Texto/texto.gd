extends Panel
@export_multiline var texto: String = "lorem ipsum"
@export var nombre: String = "archivo.txt"
@export var pistas: Array[Pista] = []
@export var color_encontrada: Color = Color(1.0, 0.85, 0.2, 0.35)
var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var _regex_link := RegEx.create_from_string("(?s)\\[url=([^\\]]+)\\](.*?)\\[/url\\]")
var _recien_encontrada: String = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RichTextLabel.meta_underlined = false
	$RichTextLabel.meta_clicked.connect(_on_meta_clicked)
	Global.pistas_limpiadas.connect(_actualizar_texto)
	$Label.text = nombre
	_actualizar_texto()


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

func _on_meta_clicked(meta: Variant) -> void:
	var id := str(meta)
	var pista := _buscar_pista(id)
	if pista == null:
		push_warning("Texto '%s': el link '%s' no tiene una Pista con ese id." % [nombre, id])
		return
	var fuente := pista.fuente if not pista.fuente.is_empty() else nombre
	if not Global.anotar(pista.id, pista.titulo, pista.texto, fuente):
		return
	_recien_encontrada = id
	_actualizar_texto()
	await get_tree().create_timer(0.5).timeout
	if _recien_encontrada == id:
		_recien_encontrada = ""
		_actualizar_texto()

func _buscar_pista(id: String) -> Pista:
	for pista in pistas:
		if pista != null and pista.id == id:
			return pista
	return null

func _actualizar_texto() -> void:
	var rtl: RichTextLabel = $RichTextLabel
	var scroll := rtl.get_v_scroll_bar().value
	var resultado := ""
	var ultimo := 0
	for m in _regex_link.search_all(texto):
		var id := m.get_string(1)
		var contenido := m.get_string(2)
		if Global.tiene_pista(id):
			contenido = "[bgcolor=#%s]%s[/bgcolor]" % [color_encontrada.to_html(), contenido]
			if id == _recien_encontrada:
				contenido = "[shake rate=25 level=8]%s[/shake]" % contenido
		resultado += texto.substr(ultimo, m.get_start() - ultimo)
		resultado += "[url=%s]%s[/url]" % [id, contenido]
		ultimo = m.get_end()
	resultado += texto.substr(ultimo)
	rtl.text = resultado
	rtl.get_content_height()
	rtl.get_v_scroll_bar().value = scroll
