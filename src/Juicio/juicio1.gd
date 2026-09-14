extends Control
var finales=[
"Camila Rossi fue detenida 48 horas después. La cámara apareció en su departamento, con las fotos de la zona de cajas borradas, pero recuperadas por el equipo forense. Fue imputada por homicidio y hurto agravado. En su declaración dijo que 'no era su intención'. Lucas nunca iba a denunciarla.

[i]Buen trabajo, agente.[/i]"
,"Tomás Herrera fue interrogado y liberado a las pocas horas. Tenía coartada: estaba en un casamiento esa noche con cincuenta testigos. El caso quedó sin resolver. En algún lugar, ██████ █████ siguió con su vida.

[i]Gracias por intentarlo, agente.[/i]"]
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
