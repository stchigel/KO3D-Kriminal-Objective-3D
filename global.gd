extends Node

## Estado compartido entre escenas. OJO: los autoload sobreviven a los
## cambios de escena, por eso Desktop llama a limpiar_pistas() al arrancar.

## Se emite cada vez que se anota una pista nueva. El Expediente lo escucha.
signal pista_agregada(pista: Pista)
## Se emite cuando se vacia el expediente (arranque de un caso nuevo).
signal pistas_limpiadas
signal sitio_desbloqueado(id: String)

var pistas: Array[Pista] = []
var sitios_desbloqueados: Array[String] = []
var sesiones: Array[String] = []

var computadora_desbloqueada: bool = false


## Atajo para anotar una pista sin crear el recurso a mano:
##     Global.anotar("cam2_camila", "Camila entro al edificio",
##         "La camara 2 la registra entrando 20:14, dijo que no fue.", "Camara 2")
## Devuelve true si la pista era nueva.
func anotar(id: String, titulo: String, texto: String, fuente: String = "", tipo: Pista.Tipo = Pista.Tipo.CONTEXTO, puntos: int = 0) -> bool:
	if tiene_pista(id):
		return false
	var pista := Pista.new()
	pista.id = id
	pista.tipo = tipo
	pista.titulo = titulo
	pista.texto = texto
	pista.fuente = fuente
	pista.puntos = puntos
	return agregar_pista(pista)


## Igual que anotar() pero con una Pista ya armada (por ejemplo un .tres).
func agregar_pista(pista: Pista) -> bool:
	if pista == null:
		return false
	if tiene_pista(pista.id):
		return false
	if pista.hora.is_empty():
		pista.hora = _hora_actual()
	pistas.append(pista)
	pista_agregada.emit(pista)
	return true


## true si ya se anoto una pista con ese id. Las pistas sin id nunca
## se consideran repetidas.
func tiene_pista(id: String) -> bool:
	if id.is_empty():
		return false
	for pista in pistas:
		if pista.id == id:
			return true
	return false


func cantidad_pistas() -> int:
	return pistas.size()


## Vacia el expediente. Se llama al empezar un caso.
func limpiar_pistas() -> void:
	pistas.clear()
	sitios_desbloqueados.clear()
	sesiones.clear()
	pistas_limpiadas.emit()


func desbloquear_sitio(id: String) -> bool:
	if id.is_empty() or sitios_desbloqueados.has(id):
		return false
	sitios_desbloqueados.append(id)
	sitio_desbloqueado.emit(id)
	return true


func tiene_sitio(id: String) -> bool:
	return sitios_desbloqueados.has(id)


func iniciar_sesion(id: String) -> void:
	if not sesiones.has(id):
		sesiones.append(id)


func tiene_sesion(id: String) -> bool:
	return sesiones.has(id)


func _hora_actual() -> String:
	var t := Time.get_datetime_dict_from_system()
	return "%02d/%02d %02d:%02d" % [t["day"], t["month"], t["hour"], t["minute"]]
