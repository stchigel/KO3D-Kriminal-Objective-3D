extends Control

const ESCENA_FINAL := preload("res://src/Final/final.tscn")
const FONDO_LUCES_ENCENDIDAS := preload("res://assets/fondos/LucesEncendidas.jpg")
const FONDO_LUCES_APAGADAS := preload("res://assets/fondos/LucesApagadas.jpg")
const FONDO_SOLO_LAMPARA := preload("res://assets/fondos/LuzEscritorioEncendida.jpg")
const FONDO_SOLO_TUBO := preload("res://assets/fondos/LuzParedEncendida.jpg")

@export_group("Luces")
@export var lampara_encendida: bool = false
@export var intervalo_del_titileo: float = 1.0

@export_group("Destello CRT")
@export var duracion_del_destello: float = 0.35

@export_group("Monitor")
@export var duracion_del_agrandado: float = 0.2

@export_group("Fundidos")
@export var duracion_del_fundido: float = 0.3
@export var duracion_del_apagado: float = 0.2

var pantalla_activa: Control = null
var _tubo_encendido: bool = true
var _timer_del_titileo: Timer
var _monitor_agrandado: bool = false
var _escala_del_monitor_chico: Vector2
var _escala_del_monitor_grande: Vector2
var _tween_del_agrandado: Tween

@onready var fondo_escritorio: TextureRect = $FondoEscritorio
@onready var boton_monitor: Button = $FondoEscritorio/BotonMonitor
@onready var boton_lampara: Button = $FondoEscritorio/BotonLampara
@onready var boton_libreta: Button = $FondoEscritorio/BotonLibreta
@onready var boton_perfiles: Button = $FondoEscritorio/BotonPerfiles
@onready var monitor: Control = $Monitor
@onready var pantalla_computadora: Control = $Monitor/PantallaComputadora
@onready var pantalla_de_bloqueo: PantallaDeBloqueo = $Monitor/PantallaDeBloqueo
@onready var destello_crt: ColorRect = $Monitor/DestelloCrt
@onready var pantalla_libreta: Control = $PantallaLibreta
@onready var cuaderno_perfiles: Control = $CuadernoPerfiles
@onready var boton_volver: Button = $BotonVolver
@onready var boton_agrandar: Button = $BotonAgrandar
@onready var bloqueo_de_input: Control = $BloqueoDeInput


func _ready() -> void:
	Global.computadora_desbloqueada = false
	boton_monitor.pressed.connect(al_tocar_el_monitor)
	boton_libreta.pressed.connect(al_tocar_la_libreta)
	boton_perfiles.pressed.connect(cuaderno_perfiles.alternar)
	cuaderno_perfiles.acusacion_confirmada.connect(al_acusar)
	boton_volver.pressed.connect(al_tocar_levantarse)
	boton_agrandar.pressed.connect(al_tocar_agrandar)
	_escala_del_monitor_chico = monitor.scale
	_escala_del_monitor_grande = _calcular_la_escala_agrandada()
	pantalla_de_bloqueo.contrasena_aceptada.connect(al_aceptar_la_contrasena)
	pantalla_computadora.connect("desconexion_solicitada", al_tocar_levantarse)
	boton_lampara.pressed.connect(al_tocar_la_lampara)
	_timer_del_titileo = Timer.new()
	_timer_del_titileo.one_shot = true
	_timer_del_titileo.timeout.connect(_titilar_el_tubo)
	add_child(_timer_del_titileo)
	_actualizar_el_fondo()
	_programar_el_titileo()
	_apagar_el_monitor()


func al_tocar_la_lampara() -> void:
	lampara_encendida = not lampara_encendida
	_actualizar_el_fondo()


func _programar_el_titileo() -> void:
	_timer_del_titileo.start(intervalo_del_titileo * randf_range(0.7, 1.3))


func _titilar_el_tubo() -> void:
	var tween := create_tween()
	for i in randi_range(1, 3):
		tween.tween_callback(_fijar_el_tubo.bind(false))
		tween.tween_interval(randf_range(0.04, 0.12))
		tween.tween_callback(_fijar_el_tubo.bind(true))
		tween.tween_interval(randf_range(0.03, 0.08))
	tween.tween_callback(_programar_el_titileo)


func _fijar_el_tubo(encendido: bool) -> void:
	_tubo_encendido = encendido
	_actualizar_el_fondo()


func _actualizar_el_fondo() -> void:
	if lampara_encendida:
		fondo_escritorio.texture = FONDO_LUCES_ENCENDIDAS if _tubo_encendido else FONDO_SOLO_LAMPARA
	else:
		fondo_escritorio.texture = FONDO_SOLO_TUBO if _tubo_encendido else FONDO_LUCES_APAGADAS


func _apagar_el_monitor() -> void:
	for pantalla in [pantalla_computadora, pantalla_de_bloqueo]:
		pantalla.hide()
		pantalla.modulate.a = 1.0
	monitor.hide()
	monitor.modulate.a = 1.0
	pantalla_activa = null
	boton_volver.hide()
	boton_agrandar.hide()
	if _tween_del_agrandado:
		_tween_del_agrandado.kill()
	_monitor_agrandado = false
	_fijar_el_tamano_del_monitor(0.0)
	destello_crt.hide()
	_bloquear_input(false)


func al_tocar_el_monitor() -> void:
	if monitor.visible:
		return
	var destino: Control = pantalla_computadora if Global.computadora_desbloqueada else pantalla_de_bloqueo
	_bloquear_input(true)
	monitor.show()
	boton_agrandar.show()
	await _encender_la_pantalla(destino)
	boton_volver.visible = destino != pantalla_computadora
	_bloquear_input(false)


func al_tocar_agrandar() -> void:
	_monitor_agrandado = not _monitor_agrandado
	boton_agrandar.text = "-" if _monitor_agrandado else "+"
	boton_agrandar.tooltip_text = "Achicar" if _monitor_agrandado else "Agrandar"
	if _tween_del_agrandado:
		_tween_del_agrandado.kill()
	_tween_del_agrandado = create_tween()
	_tween_del_agrandado.tween_method(_fijar_el_tamano_del_monitor, _avance_del_agrandado(), 1.0 if _monitor_agrandado else 0.0, duracion_del_agrandado) 		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


func _avance_del_agrandado() -> float:
	return inverse_lerp(_escala_del_monitor_chico.x, _escala_del_monitor_grande.x, monitor.scale.x)


func _calcular_la_escala_agrandada() -> Vector2:
	var ocupado := monitor.size * monitor.scale
	var margen := size - monitor.position - ocupado
	var disponible := size - monitor.position - margen / 2.0
	var factor := minf(disponible.x / monitor.size.x, disponible.y / monitor.size.y)
	return Vector2(factor, factor)


func _fijar_el_tamano_del_monitor(avance: float) -> void:
	monitor.scale = _escala_del_monitor_chico.lerp(_escala_del_monitor_grande, avance)
	var esquina := monitor.position + monitor.size * monitor.scale
	boton_agrandar.position = esquina - boton_agrandar.size - Vector2(8, 8)
	boton_volver.position.y = esquina.y + 8.0


func al_acusar(perfil: Perfil, pruebas: Array[Pista]) -> void:
	var final = ESCENA_FINAL.instantiate()
	final.texto = perfil.texto_del_final(pruebas)
	final.correcto = perfil.gana_la_acusacion(pruebas)
	if perfil.puntos_necesarios > 0:
		final.puntaje = "Puntaje: %d / %d" % [perfil.puntos_de(pruebas), perfil.puntos_necesarios]
	var actual := get_tree().current_scene
	get_tree().root.add_child(final)
	get_tree().current_scene = final
	actual.queue_free()


func al_tocar_la_libreta() -> void:
	pantalla_libreta.alternar()


func al_tocar_levantarse() -> void:
	if not monitor.visible:
		return
	_bloquear_input(true)
	boton_volver.hide()
	var tween := create_tween()
	tween.tween_property(monitor, "modulate:a", 0.0, duracion_del_apagado)
	await tween.finished
	_apagar_el_monitor()



func al_aceptar_la_contrasena() -> void:
	if Global.computadora_desbloqueada:
		return
	Global.computadora_desbloqueada = true
	boton_volver.hide()
	await mostrar_pantalla_con_fundido(pantalla_computadora)
	

func mostrar_pantalla_con_fundido(pantalla: Control) -> void:
	_bloquear_input(true)
	var anterior := pantalla_activa
	pantalla.modulate.a = 0.0
	pantalla.show()
	var tween := create_tween().set_parallel(true)
	tween.tween_property(pantalla, "modulate:a", 1.0, duracion_del_fundido)
	if anterior != null:
		tween.tween_property(anterior, "modulate:a", 0.0, duracion_del_fundido)
	await tween.finished
	if anterior != null:
		anterior.hide()
		anterior.modulate.a = 1.0
	pantalla_activa = pantalla
	_bloquear_input(false)


func _encender_la_pantalla(destino: Control) -> void:
	_fijar_apertura_del_destello(0.0)
	_fijar_brillo_del_destello(1.0)
	destello_crt.show()
	var tween := create_tween()
	tween.tween_method(_fijar_apertura_del_destello, 0.0, 1.0, duracion_del_destello * 0.6) \
		.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_callback(_mostrar_pantalla_sin_fundido.bind(destino))
	tween.tween_method(_fijar_brillo_del_destello, 1.0, 0.0, duracion_del_destello * 0.4)
	await tween.finished
	destello_crt.hide()

func _mostrar_pantalla_sin_fundido(pantalla: Control) -> void:
	pantalla.modulate.a = 1.0
	pantalla.show()
	pantalla_activa = pantalla


func _fijar_apertura_del_destello(valor: float) -> void:
	(destello_crt.material as ShaderMaterial).set_shader_parameter("apertura", valor)


func _fijar_brillo_del_destello(valor: float) -> void:
	(destello_crt.material as ShaderMaterial).set_shader_parameter("brillo", valor)


func _bloquear_input(bloqueado: bool) -> void:
	bloqueo_de_input.visible = bloqueado
	
