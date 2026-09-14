extends Button

var mensajes = [
	{"text": "Hello!", "time": "10:32", "sent": false},
	{"text": "Hi there", "time": "10:33", "sent": true},
	{"text": "How are you?", "time": "10:34", "sent": false}
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	$"..".load_messages(mensajes)
