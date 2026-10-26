class_name Pista
extends Resource

enum Tipo { CONTEXTO, PISTA, LUGAR, TRAMPA, DEFINITIVA }

@export var id: String = ""
@export var tipo: Tipo = Tipo.CONTEXTO
@export var titulo: String = ""
@export_multiline var texto: String = ""
@export var fuente: String = ""
@export var hora: String = ""
