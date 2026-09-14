extends Button
@export var chat: Chat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if chat:
		$PanelContainer/Icon.texture = chat.avatar
		$Nombre.text = chat.nombre
		if chat.mensajes.size() > 0:
			$Mensaje.text = chat.mensajes[chat.mensajes.size()-1].text
		else :
			$Mensaje.text = "Placeholder"


func _on_pressed() -> void:
	if chat:
		get_parent().get_parent().get_parent().load_chat(chat)
