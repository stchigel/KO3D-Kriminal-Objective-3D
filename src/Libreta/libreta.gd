extends Control

@onready var expediente: Control = $Expediente


func alternar() -> void:
	expediente.alternar()
