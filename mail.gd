class_name Mail
extends Resource

@export var nombre: String = ""
@export var asunto: String
@export_multiline var mensaje: String
@export var pistas: Array[Pista] = []
