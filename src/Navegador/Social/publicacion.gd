class_name Publicacion
extends Resource

@export var autor: String = ""
@export var fecha: String = ""
@export var titulo: String = ""
@export_multiline var texto: String = ""
@export var pistas: Array[Pista] = []
@export var imagen: Texture2D
@export var comentarios: Array[Comentario] = []
