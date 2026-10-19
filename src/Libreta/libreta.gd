extends Control

@onready var expediente: Control = $Expediente


func _ready() -> void:
	visibility_changed.connect(al_cambiar_la_visibilidad)


func al_cambiar_la_visibilidad() -> void:
	if is_visible_in_tree():
		expediente.abrir()
	else:
		expediente.cerrar()
