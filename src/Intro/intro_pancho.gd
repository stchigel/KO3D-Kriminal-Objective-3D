extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Escritorio/escritorio_del_agente_pancho.tscn")


func _on_buttonclose_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Seleccion/seleccion.tscn")


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Seleccion/seleccion.tscn")
