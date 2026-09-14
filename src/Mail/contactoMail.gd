extends Button
@export var mail: Mail

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if mail:
		$Nombre.text = mail.nombre
		$Asunto.text = mail.asunto

func _on_pressed() -> void:
	pass
	if mail:
		get_parent().get_parent().get_parent().load_mail(mail)
