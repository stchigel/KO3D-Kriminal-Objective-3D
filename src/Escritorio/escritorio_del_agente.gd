extends Control


@export_group("Zoom al monitor")
@export var centro_de_la_pantalla_del_monitor: Vector2 = Vector2(0.281, 0.378)
@export_range(1.0, 6.0, 0.05) var escala_del_zoom: float = 2.4
@export var duracion_del_zoom: float = 0.8


@export_group("Destello CRT")
@export var duracion_del_destello: float = 0.35

@export_group("Fundidos")
@export var duracion_del_fundido: float = 0.3
@export var duracion_del_apagado: float = 0.2

var pantalla_activa: Control = null

@onready var fondo_escritorio: TextureRect = $FondoEscritorio
@onready var boton_monitor: Button = $FondoEscritorio/BotonMonitor
@onready var boton_libreta: Button = $FondoEscritorio/BotonLibreta
@onready var pantalla_computadora: Control = $PantallaComputadora
@onready var pantalla_libreta: Control = $PantallaLibreta
@onready var pantalla_de_bloqueo: PantallaDeBloqueo = $PantallaDeBloqueo
@onready var boton_volver: Button = $BotonVolver
@onready var destello_crt: ColorRect = $DestelloCrt
@onready var bloqueo_de_input: Control = $BloqueoDeInput


func _ready() -> void:
	Global.computadora_desbloqueada = false
	boton_monitor.pressed.connect(al_tocar_el_monitor)
	boton_libreta.pressed.connect(al_tocar_la_libreta)
	boton_volver.pressed.connect(al_tocar_levantarse)
	pantalla_de_bloqueo.contrasena_aceptada.connect(al_aceptar_la_contrasena)
	pantalla_computadora.connect("desconexion_solicitada", al_tocar_levantarse)
	mostrar_solo_el_escritorio()
	


func mostrar_solo_el_escritorio() -> void:
	for pantalla in [pantalla_computadora, pantalla_libreta, pantalla_de_bloqueo]:
		pantalla.hide()
		pantalla.modulate.a = 1.0
	pantalla_activa = null
	boton_volver.hide()
	destello_crt.hide()
	fondo_escritorio.show()
	fondo_escritorio.scale = Vector2.ONE
	fondo_escritorio.position = Vector2.ZERO
	_bloquear_input(false)

func al_tocar_el_monitor() -> void:
	var destino: Control = pantalla_computadora if Global.computadora_desbloqueada else pantalla_de_bloqueo
	_bloquear_input(true)
	await _hacer_zoom(true)
	await _encender_la_pantalla(destino)
	boton_volver.visible = destino != pantalla_computadora
	_bloquear_input(false)
	

func al_tocar_la_libreta() -> void:
	await mostrar_pantalla_con_fundido(pantalla_libreta)
	boton_volver.show()
	

func al_tocar_levantarse() -> void:
	_bloquear_input(true)
	boton_volver.hide()
	var estaba_en_el_monitor := pantalla_activa != pantalla_libreta
	if estaba_en_el_monitor:
		_ajustar_el_zoom_al_tamano_actual()
		fondo_escritorio.show()
	await _apagar_la_pantalla_activa()
	if estaba_en_el_monitor:
		await _hacer_zoom(false)
	_bloquear_input(false)
	


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


func _hacer_zoom(acercando: bool) -> void:
	var punto := centro_de_la_pantalla_del_monitor * fondo_escritorio.size
	fondo_escritorio.pivot_offset = punto
	var escala_final := Vector2.ONE * (escala_del_zoom if acercando else 1.0)
	var posicion_final := fondo_escritorio.size / 2.0 - punto if acercando else Vector2.ZERO
	var tween := create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(fondo_escritorio, "scale", escala_final, duracion_del_zoom)
	tween.tween_property(fondo_escritorio, "position", posicion_final, duracion_del_zoom)
	await tween.finished
	

func _ajustar_el_zoom_al_tamano_actual() -> void:
	var punto := centro_de_la_pantalla_del_monitor * fondo_escritorio.size
	fondo_escritorio.pivot_offset = punto
	fondo_escritorio.scale = Vector2.ONE * escala_del_zoom
	fondo_escritorio.position = fondo_escritorio.size / 2.0 - punto

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
	fondo_escritorio.hide()
	pantalla.modulate.a = 1.0
	pantalla.show()
	pantalla_activa = pantalla


func _apagar_la_pantalla_activa() -> void:
	var pantalla := pantalla_activa
	if pantalla != null:
		var tween := create_tween()
		tween.tween_property(pantalla, "modulate:a", 0.0, duracion_del_apagado)
		await tween.finished
		pantalla.hide()
		pantalla.modulate.a = 1.0
	pantalla_activa = null
	


func _fijar_apertura_del_destello(valor: float) -> void:
	(destello_crt.material as ShaderMaterial).set_shader_parameter("apertura", valor)


func _fijar_brillo_del_destello(valor: float) -> void:
	(destello_crt.material as ShaderMaterial).set_shader_parameter("brillo", valor)


func _bloquear_input(bloqueado: bool) -> void:
	bloqueo_de_input.visible = bloqueado
	
