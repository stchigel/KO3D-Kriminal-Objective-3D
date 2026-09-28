extends Control

## Expediente de papel que asoma desde abajo.
## Click en el encabezado = se abre / se cierra.
## Cuando Global anota una pista nueva se asoma solo, la agrega y se baja.
##
## COMO UBICARLO: arrastralo en el editor hasta donde quieras que quede
## apoyado, asomando lo justo. Esa es la posicion de reposo (cerrado).
## "subida" dice cuantos pixeles sube al abrirse. Los dos se ajustan a ojo.
##
## Conviene que sea el ULTIMO hijo del Desktop, asi queda dibujado arriba
## de las ventanas.

## Cuantos pixeles sube al abrirse.
@export var subida: float = 510.0
## Duracion de la animacion de subida/bajada.
@export var duracion: float = 0.35
## Cuanto se queda arriba cuando se asoma solo por una pista nueva.
@export var tiempo_visible_auto: float = 2.5
@export var entrada_scene: PackedScene = preload("res://src/Expediente/entrada.tscn")

@onready var pestana: Button = $Papel/Pestana
@onready var contador: Label = $Papel/Contador
@onready var scroll: ScrollContainer = $Papel/ScrollContainer
@onready var lista: VBoxContainer = $Papel/ScrollContainer/Lista
@onready var vacio: Label = $Papel/Vacio

var abierto: bool = false

## Donde lo dejaron en el editor. Es la posicion de reposo.
var _y_cerrado: float
var _tween: Tween
## Cada asomada automatica se queda con un id. Si llega otra pista o el
## jugador toca el expediente, el id cambia y la bajada vieja se descarta.
var _asomada_id: int = 0


func _ready() -> void:
	_y_cerrado = position.y

	Global.pista_agregada.connect(_on_pista_agregada)
	Global.pistas_limpiadas.connect(_on_pistas_limpiadas)

	# Por si ya habia pistas anotadas antes de que existiera el expediente.
	for pista in Global.pistas:
		_crear_entrada(pista)
	_actualizar_estado()


# --- API publica ---------------------------------------------------------

func abrir() -> void:
	_asomada_id += 1
	abierto = true
	_actualizar_estado()
	_animar(_y_cerrado - subida)


func cerrar() -> void:
	_asomada_id += 1
	abierto = false
	_actualizar_estado()
	_animar(_y_cerrado)


func alternar() -> void:
	if abierto:
		cerrar()
	else:
		abrir()


# --- Pistas --------------------------------------------------------------

func _on_pista_agregada(pista: Pista) -> void:
	_crear_entrada(pista)
	_actualizar_estado()
	if abierto:
		return
	await _asomarse()


## Sube, muestra la pista nueva un rato y se vuelve a bajar.
func _asomarse() -> void:
	_asomada_id += 1
	var id := _asomada_id
	_animar(_y_cerrado - subida)
	await get_tree().create_timer(duracion + tiempo_visible_auto).timeout
	# Si mientras tanto llego otra pista o el jugador lo abrio, no bajamos.
	if not is_inside_tree() or id != _asomada_id or abierto:
		return
	_animar(_y_cerrado)


func _crear_entrada(pista: Pista) -> void:
	var entrada := entrada_scene.instantiate()
	lista.add_child(entrada)
	if entrada.has_method("setup"):
		entrada.setup(pista)
	await get_tree().process_frame
	if not is_inside_tree():
		return
	scroll.scroll_vertical = int(scroll.get_v_scroll_bar().max_value)


func _on_pistas_limpiadas() -> void:
	for entrada in lista.get_children():
		entrada.queue_free()
	_actualizar_estado()


# --- Interno -------------------------------------------------------------

func _on_pestana_pressed() -> void:
	alternar()


func _actualizar_estado() -> void:
	var cantidad := Global.cantidad_pistas()
	vacio.visible = cantidad == 0
	contador.text = "%d %s" % [cantidad, "pista" if cantidad == 1 else "pistas"]


func _animar(destino_y: float) -> void:
	if _tween and _tween.is_running():
		_tween.kill()
	_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	_tween.tween_property(self, "position:y", destino_y, duracion)
