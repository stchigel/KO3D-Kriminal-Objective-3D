class_name Pista
extends Resource

enum Tipo { CONTEXTO, PISTA, LUGAR, TRAMPA, DEFINITIVA }

@export var id: String = ""
@export var tipo: Tipo = Tipo.CONTEXTO
@export var titulo: String = ""
@export_multiline var texto: String = ""
@export var fuente: String = ""
@export var hora: String = ""
## Peso de la pista al acusar: chica 1-2, mediana 3, grande 5. 0 = no suma.
@export var puntos: int = 0
