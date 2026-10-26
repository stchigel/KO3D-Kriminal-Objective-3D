extends Button
@export var chat: Chat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if chat:
		$PanelContainer/Icon.texture = chat.avatar
		$Nombre.text = chat.nombre
		if chat.mensajes.size() > 0:
			var ultimo: String = chat.mensajes[chat.mensajes.size()-1].text
			$Mensaje.text = RegEx.create_from_string("(?s)\\[url=[^\\]]+\\](.*?)\\[/url\\]").sub(ultimo, "$1", true)
		else :
			$Mensaje.text = "Sin mensajes previos"


func _on_pressed() -> void:
	if chat:
		get_parent().get_parent().get_parent().load_chat(chat)
