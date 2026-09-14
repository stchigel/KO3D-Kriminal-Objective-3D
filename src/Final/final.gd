extends Control
var texto:String
var correcto:bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Texto.text=texto
	if correcto:
		$Mal.hide()
		$Bien.show()
	else:
		$Mal.show()
		$Bien.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Seleccion/seleccion.tscn")
