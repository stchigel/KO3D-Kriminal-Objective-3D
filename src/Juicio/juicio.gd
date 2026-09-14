extends Control
var finales=["Texto1 CORR","Texto2 MAL","Texto3 MAL"]
const finalScene=preload("res://src/Final/final.tscn")
var final

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	final = finalScene.instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func cargar():
	var actual = get_tree().current_scene
	get_tree().root.add_child(final)
	get_tree().current_scene = final
	actual.queue_free()

func _on__pressed() -> void:
	final.texto = finales[0]
	final.correcto = true
	cargar()


func _on_2_pressed() -> void:
	final.texto = finales[1]
	final.correcto = false
	cargar()


func _on_3_pressed() -> void:
	final.texto = finales[2]
	final.correcto = false
	cargar()
