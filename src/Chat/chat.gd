extends Panel
@export var nombre: String = "Whatsapp"
@export var sent_bubble_scene: PackedScene
@export var received_bubble_scene: PackedScene
@export var chats: Array[Chat]
@export var contacto_scene: PackedScene
@export var color_encontrada: Color = Color(1.0, 0.85, 0.2, 0.35)
@onready var messages_container = $ScrollContainer/VBoxContainer
@onready var selector = $Escribir/Mensaje

var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var current_chat: Chat = null
var _regex_link := RegEx.create_from_string("(?s)\\[url=([^\\]]+)\\](.*?)\\[/url\\]")
var _recien_encontrada: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.pistas_limpiadas.connect(_actualizar_burbujas)
	$Label.text = nombre
	for chat in chats:
		var cont = contacto_scene.instantiate()
		cont.chat = chat
		cont.custom_minimum_size.y = 63
		cont.custom_minimum_size.x = 300
		$ScrollContainer2/VBoxContainer.add_child(cont)

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
		

func load_chat(chat: Chat) -> void:
	current_chat = chat
	_recien_encontrada = ""
	load_messages(chat.mensajes)
	_populate_selector(chat.mensajes_enviables)

func load_messages(mensajes: Array) -> void:
	for child in messages_container.get_children():
		child.queue_free()
	for msg in mensajes:
		_add_bubble(msg.text, msg.time, msg.sent)
		

func _add_bubble(text: String, time: String, sent: bool) -> void:
	var bubble: Control
	if sent:
		bubble = sent_bubble_scene.instantiate()
	else:
		bubble = received_bubble_scene.instantiate()
	bubble.custom_minimum_size.y = 100
	if bubble.has_method("setup"):
		bubble.setup(text, time)
	if bubble.has_signal("link_clickeado"):
		bubble.link_clickeado.connect(_on_meta_clicked)
	messages_container.add_child(bubble)
	_actualizar_burbuja(bubble)
	await get_tree().process_frame
	$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value

func _on_meta_clicked(meta: Variant) -> void:
	if current_chat == null:
		return
	var chat := current_chat
	var id := str(meta)
	var pista := _buscar_pista(chat, id)
	if pista == null:
		push_warning("Chat '%s': el link '%s' no tiene una Pista con ese id." % [chat.nombre, id])
		return
	var fuente := pista.fuente if not pista.fuente.is_empty() else "%s (%s)" % [nombre, chat.nombre]
	if not Global.anotar(pista.id, pista.titulo, pista.texto, fuente):
		return
	_recien_encontrada = id
	_actualizar_burbujas()
	await get_tree().create_timer(0.5).timeout
	if current_chat == chat and _recien_encontrada == id:
		_recien_encontrada = ""
		_actualizar_burbujas()

func _buscar_pista(chat: Chat, id: String) -> Pista:
	for pista in chat.pistas:
		if pista != null and pista.id == id:
			return pista
	return null

func _actualizar_burbujas() -> void:
	for bubble in messages_container.get_children():
		if not bubble.is_queued_for_deletion():
			_actualizar_burbuja(bubble)

func _actualizar_burbuja(bubble) -> void:
	if bubble.has_method("mostrar_texto"):
		bubble.mostrar_texto(_formatear(bubble.texto_original))

func _formatear(texto: String) -> String:
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
	return resultado

func _populate_selector(enviables: Array[String]) -> void:
	selector.clear()
	selector.add_item("Escriba aqui...", 0)
	selector.set_item_disabled(0, true)
	selector.selected = 0
	for i in enviables.size():
		selector.add_item(enviables[i], i + 1)

func _on_enviar_pressed() -> void:
	if current_chat == null:
		return
	var selected_id = selector.get_selected_id()
	if selected_id <= 0:
		return
	var idx = selected_id - 1
	var enviables = current_chat.mensajes_enviables
	var respuestas = current_chat.respuestas
	if idx >= enviables.size():
		return
		
	var now = _get_time_string()
	
	_add_bubble(enviables[idx], now, true)
	
	var item_idx = selector.get_item_index(selected_id)
	selector.remove_item(item_idx)
	selector.selected = 0
	
	
	if idx < respuestas.size() and respuestas[idx] != "":
		await get_tree().create_timer(1.0).timeout
		_add_bubble(respuestas[idx], _get_time_string(), false)
	

func _get_time_string() -> String:
	var t = Time.get_datetime_dict_from_system()
	return "%02d/%02d %02d:%02d" % [t["day"], t["month"], t["hour"], t["minute"]]
	
