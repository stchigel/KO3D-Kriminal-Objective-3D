class_name PerfilSocial
extends Resource

@export var usuario: String = ""
@export var nombre: String = ""
@export var detalle: String = ""
@export_multiline var bio: String = ""
@export var bio_pistas: Array[Pista] = []
@export var publicaciones: Array[Publicacion] = []


func coincide(autor: String) -> bool:
	return not autor.is_empty() and (autor == usuario or autor == nombre)
