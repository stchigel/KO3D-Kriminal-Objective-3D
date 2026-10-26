class_name Perfil
extends Resource

@export var nombre: String = ""
@export var rol: String = ""
@export var foto: Texture2D
@export var edad: String = ""
@export var ocupacion: String = ""
@export var vinculo: String = ""
@export_multiline var notas: String = ""
@export var es_culpable: bool = false
@export var pistas_de_cargo: PackedStringArray = PackedStringArray()
@export var minimo_de_pistas: int = 0
@export var pistas_obligatorias: PackedStringArray = PackedStringArray()
@export_multiline var final_al_acusar: String = ""
@export_multiline var final_sin_pruebas: String = ""


func pruebas_alcanzan(elegidas: Array[Pista]) -> bool:
	var de_cargo := 0
	var ids_elegidos := PackedStringArray()
	for pista in elegidas:
		if pista.tipo == Pista.Tipo.TRAMPA:
			return false
		ids_elegidos.append(pista.id)
		if pista.id in pistas_de_cargo:
			de_cargo += 1
	for obligatoria in pistas_obligatorias:
		if obligatoria not in ids_elegidos:
			return false
	return de_cargo >= minimo_de_pistas


func gana_la_acusacion(elegidas: Array[Pista]) -> bool:
	return es_culpable and pruebas_alcanzan(elegidas)


func texto_del_final(elegidas: Array[Pista]) -> String:
	if es_culpable and not pruebas_alcanzan(elegidas) and not final_sin_pruebas.is_empty():
		return final_sin_pruebas
	return final_al_acusar
