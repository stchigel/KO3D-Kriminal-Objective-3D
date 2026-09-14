extends Control
var finales=["Lorenzo Machi fue detenido tras allanamientos en sus propiedades. El encargado Darío Campos confesó haber desactivado las cámaras y facilitado el acceso a cambio de dinero. Machi fue imputado por homicidio agravado, asociación ilícita y defraudación. Dante Ferreyra fue procesado por su rol en la red de falsificación. Rodrigo Iturbe quedó prófugo. Las obras falsas fueron retiradas del mercado y del Museo de Rosario. Lucas Mirabal declaró como testigo protegido.",
"Dante Ferreyra fue detenido y admitió su participación en el fraude, pero tenía coartada sólida para la noche de la muerte y ningún vínculo con el encargado del edificio. Fue condenado por la estafa, no por el homicidio. Lorenzo Machi, señalado solo tangencialmente, movió sus influencias y la causa por la muerte quedó caratulada como accidente. El verdadero asesino nunca respondió por Vidal.",
"Sin pruebas que conecten la muerte con la red de falsificación, la causa se archivó como muerte accidental. Machi vendió sus propiedades y se instaló en el exterior. En algún lugar, Lucas Mirabal siguió esperando noticias de un hombre que ya no iba a contestar."]
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
