extends Panel
@export var nombre: String = "Gmail"
@export var mails: Array[Mail] #Inbox
@export var borradores: Array[Mail]
@export var contacto_scene: PackedScene

var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	$MailData/Cuerpo.text = mail.mensaje
	
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
