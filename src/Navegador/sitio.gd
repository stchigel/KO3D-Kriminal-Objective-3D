class_name Sitio
extends Resource

@export var id: String = ""
@export var titulo: String = ""
@export var direccion: String = ""
@export var pagina_inicial: PackedScene
@export var datos: Resource
@export var desbloqueado_al_inicio: bool = false

@export_group("Inicio de sesion")
@export var usuario: String = ""
@export var clave: String = ""
@export var pista_clave: String = ""
@export var distinguir_mayusculas: bool = false


func pide_login() -> bool:
	return not clave.is_empty()


func clave_correcta(intento: String) -> bool:
	var ingresada := intento.strip_edges()
	if distinguir_mayusculas:
		return ingresada == clave
	return ingresada.to_lower() == clave.to_lower()
