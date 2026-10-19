extends Panel
@export var nombre: String = "Gmail"
@export var mails: Array[Mail] #Inbox
@export var borradores: Array[Mail]
@export var contacto_scene: PackedScene
@export var color_encontrada: Color = Color(1.0, 0.85, 0.2, 0.35)

var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var _regex_link := RegEx.create_from_string("(?s)\\[url=([^\\]]+)\\](.*?)\\[/url\\]")
var _mail_actual: Mail
var _recien_encontrada: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MailData/Cuerpo.bbcode_enabled = true
	$MailData/Cuerpo.meta_underlined = false
	$MailData/Cuerpo.meta_clicked.connect(_on_meta_clicked)
	Global.pistas_limpiadas.connect(_actualizar_cuerpo)
	$MailData.hide()
	$Panel/Label.text = nombre
	cargar_mails(mails)

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
		

func load_mail(mail:Mail):
	$MailData.show()
	$MailData/Asunto.text = mail.asunto
	$MailData/Remitente.text = mail.nombre
	_mail_actual = mail
	_recien_encontrada = ""
	_actualizar_cuerpo(false)

func _on_meta_clicked(meta: Variant) -> void:
	if _mail_actual == null:
		return
	var mail := _mail_actual
	var id := str(meta)
	var pista := _buscar_pista(mail, id)
	if pista == null:
		push_warning("Mail '%s': el link '%s' no tiene una Pista con ese id." % [mail.asunto, id])
		return
	var fuente := pista.fuente if not pista.fuente.is_empty() else "%s (%s)" % [nombre, mail.asunto]
	if not Global.anotar(pista.id, pista.titulo, pista.texto, fuente):
		return
	_recien_encontrada = id
	_actualizar_cuerpo()
	await get_tree().create_timer(0.5).timeout
	if _mail_actual == mail and _recien_encontrada == id:
		_recien_encontrada = ""
		_actualizar_cuerpo()

func _buscar_pista(mail: Mail, id: String) -> Pista:
	for pista in mail.pistas:
		if pista != null and pista.id == id:
			return pista
	return null

func _actualizar_cuerpo(conservar_scroll: bool = true) -> void:
	if _mail_actual == null:
		return
	var rtl: RichTextLabel = $MailData/Cuerpo
	var scroll := rtl.get_v_scroll_bar().value if conservar_scroll else 0.0
	var texto := _mail_actual.mensaje
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

func cargar_mails(mails:Array[Mail]):
	for child in $ScrollContainer2/VBoxContainer.get_children():
		child.queue_free()
	for mail in mails:
		var cont = contacto_scene.instantiate()
		cont.mail = mail
		cont.custom_minimum_size.y = 64
		cont.custom_minimum_size.x = 512
		$ScrollContainer2/VBoxContainer.add_child(cont)


func _on_volver_pressed() -> void:
	$MailData.hide()


func _on_inbox_pressed() -> void:
	cargar_mails(mails)


func _on_borradores_pressed() -> void:
	cargar_mails(borradores)
