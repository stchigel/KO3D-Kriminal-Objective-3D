extends Panel

class Entrada:
	var sitio: Sitio
	var escena: PackedScene
	var datos: Resource

	func _init(p_sitio: Sitio, p_escena: PackedScene, p_datos: Resource) -> void:
		sitio = p_sitio
		escena = p_escena
		datos = p_datos

	func es_igual(otra: Entrada) -> bool:
		return sitio == otra.sitio and escena == otra.escena and datos == otra.datos


@export var nombre: String = "Navegador"
@export var sitios: Array[Sitio] = []

var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var _historial: Array[Entrada] = []
var _indice: int = -1


func _ready() -> void:
	$Titulo/Label.text = nombre
	Global.pistas_limpiadas.connect(_reiniciar)
	Global.sitio_desbloqueado.connect(_on_sitio_desbloqueado)
	_reiniciar()


func abrir_sitio(id: String) -> void:
	var sitio := _buscar_sitio(id)
	if sitio == null or not Global.tiene_sitio(id):
		return
	show()
	ir_a(sitio)


func ir_a(sitio: Sitio, escena: PackedScene = null, datos: Resource = null) -> void:
	if sitio == null:
		return
	var destino := escena if escena != null else sitio.pagina_inicial
	var contenido := datos if datos != null else sitio.datos
	var entrada := Entrada.new(sitio, destino, contenido)
	if _indice >= 0 and _historial[_indice].es_igual(entrada):
		_actualizar_marcadores()
		return
	_historial.resize(_indice + 1)
	_historial.append(entrada)
	_indice += 1
	_actualizar_vista()


func atras() -> void:
	if _indice > 0:
		_indice -= 1
		_actualizar_vista()


func adelante() -> void:
	if _indice < _historial.size() - 1:
		_indice += 1
		_actualizar_vista()


func _reiniciar() -> void:
	_historial.clear()
	_indice = -1
	for sitio in sitios:
		if sitio != null and sitio.desbloqueado_al_inicio:
			Global.desbloquear_sitio(sitio.id)
	_actualizar_vista()


func _actualizar_vista() -> void:
	_limpiar_pagina()
	_actualizar_marcadores()
	$Barra/Atras.disabled = _indice <= 0
	$Barra/Adelante.disabled = _indice >= _historial.size() - 1
	$Vacio.visible = _indice < 0
	if _indice < 0:
		$Barra/Direccion.text = ""
		$Login.hide()
		return
	var entrada := _historial[_indice]
	$Barra/Direccion.text = entrada.sitio.direccion
	if entrada.sitio.pide_login() and not Global.tiene_sesion(entrada.sitio.id):
		$Login.pedir(entrada.sitio)
		return
	$Login.hide()
	_cargar_pagina(entrada)


func _cargar_pagina(entrada: Entrada) -> void:
	if entrada.escena == null:
		push_warning("Sitio '%s': no tiene pagina para mostrar." % entrada.sitio.id)
		return
	var pagina := entrada.escena.instantiate()
	$Pagina/Contenido.add_child(pagina)
	if pagina.has_method("configurar"):
		pagina.configurar(self, entrada.sitio, entrada.datos)


func _limpiar_pagina() -> void:
	var contenido := $Pagina/Contenido
	for hijo in contenido.get_children():
		contenido.remove_child(hijo)
		hijo.queue_free()


func _actualizar_marcadores() -> void:
	var lista: HBoxContainer = $Marcadores/Lista
	for hijo in lista.get_children():
		lista.remove_child(hijo)
		hijo.queue_free()
	var actual: Sitio = _historial[_indice].sitio if _indice >= 0 else null
	for sitio in sitios:
		if sitio == null or not Global.tiene_sitio(sitio.id):
			continue
		var boton := Button.new()
		boton.text = sitio.titulo
		boton.toggle_mode = true
		boton.button_pressed = sitio == actual
		boton.add_theme_font_size_override("font_size", 13)
		boton.pressed.connect(abrir_sitio.bind(sitio.id))
		lista.add_child(boton)


func _buscar_sitio(id: String) -> Sitio:
	for sitio in sitios:
		if sitio != null and sitio.id == id:
			return sitio
	return null


func _on_sitio_desbloqueado(_id: String) -> void:
	_actualizar_marcadores()


func _on_login_acceso_concedido(sitio: Sitio) -> void:
	Global.iniciar_sesion(sitio.id)
	_actualizar_vista()


func _on_cerrar_pressed() -> void:
	hide()


func _on_titulo_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed
		if event.pressed:
			drag_offset = get_global_mouse_position() - global_position
	if event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() - drag_offset
