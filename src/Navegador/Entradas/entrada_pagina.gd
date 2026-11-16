class_name EntradaPagina
extends Resource

@export var titulo: String = ""
@export var autor: String = ""
@export var fecha: String = ""
@export_range(0, 5) var valoracion: int = 0
@export_multiline var texto: String = ""
@export var pistas: Array[Pista] = []
@export var comentarios: Array[Comentario] = []
