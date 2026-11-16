class_name SeccionInformativa
extends Resource

@export var encabezado: String = ""
@export_multiline var texto: String = ""
@export var lista: Array[String] = []
@export var pistas: Array[Pista] = []


func contenido() -> String:
	var partes := PackedStringArray()
	if not texto.is_empty():
		partes.append(texto)
	if not lista.is_empty():
		partes.append("[ul]" + "\n".join(PackedStringArray(lista)) + "[/ul]")
	return "\n".join(partes)
