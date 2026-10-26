extends Control

signal acusacion_confirmada(perfil: Perfil, pruebas: Array[Pista])

const COLOR_POR_ROL := {
	"víctima": Color(0.25, 0.3, 0.4),
	"sospechoso": Color(0.7, 0.13, 0.11),
	"sospechosa": Color(0.7, 0.13, 0.11),
	"testigo": Color(0.2, 0.42, 0.25),
}
const COLOR_ROL_POR_DEFECTO := Color(0.4, 0.33, 0.22)

@export var perfiles: Array[Perfil] = []
@export var subida: float = 524.0
@export var duracion: float = 0.35
@export var anillos_del_espiral: int = 11
@export var duracion_del_volteo: float = 0.35
@export var exigir_pruebas: bool = false

var abierto: bool = false
var pagina: int = 0
var _y_cerrado: float
var _tween: Tween
var _volteando: bool = false

@onready var hoja: Panel = $Hoja
@onready var encabezado: Button = $Hoja/Encabezado
@onready var paginacion: Label = $Hoja/Paginacion
@onready var espiral: HBoxContainer = $Espiral
@onready var contenido: Control = $Hoja/Contenido
@onready var foto: TextureRect = $Hoja/Contenido/Foto
@onready var iniciales: Label = $Hoja/Contenido/Iniciales
@onready var rol: Label = $Hoja/Contenido/Rol
@onready var nombre: Label = $Hoja/Contenido/Nombre
@onready var datos: RichTextLabel = $Hoja/Contenido/Datos
@onready var vacio: Label = $Hoja/Vacio
@onready var anterior: Button = $Hoja/Anterior
@onready var siguiente: Button = $Hoja/Siguiente
@onready var acusar: Button = $Hoja/Acusar
@onready var confirmacion: Panel = $Hoja/Confirmacion
@onready var detalle_de_la_acusacion: Label = $Hoja/Confirmacion/Detalle
@onready var confirmar_acusacion: Button = $Hoja/Confirmacion/Si
@onready var cancelar_acusacion: Button = $Hoja/Confirmacion/No
@onready var panel_de_pruebas: Panel = $Hoja/Pruebas
@onready var indicacion_de_pruebas: Label = $Hoja/Pruebas/Indicacion
@onready var lista_de_pruebas: VBoxContainer = $Hoja/Pruebas/Scroll/Lista
@onready var sin_pruebas: Label = $Hoja/Pruebas/SinPruebas
@onready var presentar_pruebas: Button = $Hoja/Pruebas/Presentar
@onready var volver_de_las_pruebas: Button = $Hoja/Pruebas/Volver


func _ready() -> void:
	_y_cerrado = position.y
	acusar.pressed.connect(_pedir_confirmacion)
	confirmar_acusacion.pressed.connect(_confirmar_la_acusacion)
	cancelar_acusacion.pressed.connect(confirmacion.hide)
	presentar_pruebas.pressed.connect(_presentar_la_acusacion)
	volver_de_las_pruebas.pressed.connect(panel_de_pruebas.hide)
	var anillo := espiral.get_child(0)
	for i in anillos_del_espiral - 1:
		espiral.add_child(anillo.duplicate())
	encabezado.pressed.connect(alternar)
	anterior.pressed.connect(_pasar_pagina.bind(-1))
	siguiente.pressed.connect(_pasar_pagina.bind(1))
	_mostrar_pagina()


func abrir() -> void:
	abierto = true
	_animar(_y_cerrado - subida)


func cerrar() -> void:
	abierto = false
	confirmacion.hide()
	panel_de_pruebas.hide()
	_animar(_y_cerrado)


func alternar() -> void:
	if abierto:
		cerrar()
	else:
		abrir()


func _pasar_pagina(paso: int) -> void:
	if perfiles.size() < 2 or _volteando:
		return
	_volteando = true
	var hoja_vieja := _copiar_la_hoja()
	pagina = wrapi(pagina + paso, 0, perfiles.size())
	_mostrar_pagina()
	if paso > 0:
		await _voltear(hoja_vieja, 1.0, 0.0, Tween.EASE_IN)
	else:
		var hoja_nueva := _copiar_la_hoja()
		await _voltear(hoja_nueva, 0.0, 1.0, Tween.EASE_OUT)
		hoja_nueva.queue_free()
	hoja_vieja.queue_free()
	_volteando = false


func _copiar_la_hoja() -> Control:
	var copia := hoja.duplicate(0) as Control
	add_child(copia)
	move_child(copia, espiral.get_index())
	copia.pivot_offset = Vector2(copia.size.x / 2.0, 0.0)
	return copia


func _voltear(copia: Control, desde: float, hasta: float, suavizado: Tween.EaseType) -> void:
	copia.scale.y = desde
	copia.modulate = Color.WHITE.darkened(0.35 * (1.0 - desde))
	var tween := create_tween().set_parallel(true).set_trans(Tween.TRANS_SINE).set_ease(suavizado)
	tween.tween_property(copia, "scale:y", hasta, duracion_del_volteo)
	tween.tween_property(copia, "modulate", Color.WHITE.darkened(0.35 * (1.0 - hasta)), duracion_del_volteo)
	await tween.finished


func _pedir_confirmacion() -> void:
	if perfiles.is_empty():
		return
	detalle_de_la_acusacion.text = "Vas a acusar a %s. No hay vuelta atrás." % perfiles[pagina].nombre
	confirmacion.show()


func _confirmar_la_acusacion() -> void:
	confirmacion.hide()
	if exigir_pruebas:
		_abrir_las_pruebas()
		return
	var ninguna: Array[Pista] = []
	acusacion_confirmada.emit(perfiles[pagina], ninguna)


func _abrir_las_pruebas() -> void:
	for boton in lista_de_pruebas.get_children():
		lista_de_pruebas.remove_child(boton)
		boton.queue_free()
	indicacion_de_pruebas.text = "Marcá las pistas que demuestran que %s es culpable." % perfiles[pagina].nombre
	sin_pruebas.visible = Global.pistas.is_empty()
	for pista in Global.pistas:
		lista_de_pruebas.add_child(_crear_boton_de_prueba(pista))
	panel_de_pruebas.show()


func _crear_boton_de_prueba(pista: Pista) -> Button:
	var texto := pista.titulo
	if not pista.texto.is_empty():
		texto = pista.texto if texto.is_empty() else "%s: %s" % [texto, pista.texto]
	var boton := Button.new()
	boton.toggle_mode = true
	boton.alignment = HORIZONTAL_ALIGNMENT_LEFT
	boton.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	boton.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	boton.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	boton.text = "[ ] " + texto
	boton.set_meta("pista", pista)
	boton.toggled.connect(_al_marcar_prueba.bind(boton, texto))
	return boton


func _al_marcar_prueba(marcada: bool, boton: Button, texto: String) -> void:
	boton.text = ("[X] " if marcada else "[ ] ") + texto


func _presentar_la_acusacion() -> void:
	var elegidas: Array[Pista] = []
	for boton in lista_de_pruebas.get_children():
		if boton is Button and boton.button_pressed:
			elegidas.append(boton.get_meta("pista"))
	panel_de_pruebas.hide()
	acusacion_confirmada.emit(perfiles[pagina], elegidas)


func _mostrar_pagina() -> void:
	var hay_perfiles := not perfiles.is_empty()
	contenido.visible = hay_perfiles
	vacio.visible = not hay_perfiles
	anterior.disabled = perfiles.size() < 2
	siguiente.disabled = perfiles.size() < 2
	confirmacion.hide()
	panel_de_pruebas.hide()
	acusar.visible = hay_perfiles and not perfiles[pagina].final_al_acusar.is_empty()
	if not hay_perfiles:
		paginacion.text = ""
		return
	var perfil := perfiles[pagina]
	paginacion.text = "%d / %d" % [pagina + 1, perfiles.size()]
	nombre.text = perfil.nombre
	foto.texture = perfil.foto
	iniciales.visible = perfil.foto == null
	iniciales.text = _iniciales(perfil.nombre)
	_pintar_rol(perfil.rol)
	datos.text = _armar_datos(perfil)


func _pintar_rol(texto: String) -> void:
	rol.visible = not texto.is_empty()
	rol.text = texto.to_upper()
	var color: Color = COLOR_POR_ROL.get(texto.to_lower(), COLOR_ROL_POR_DEFECTO)
	var estilo := rol.get_theme_stylebox("normal").duplicate() as StyleBoxFlat
	estilo.border_color = color
	rol.add_theme_stylebox_override("normal", estilo)
	rol.add_theme_color_override("font_color", color)


func _armar_datos(perfil: Perfil) -> String:
	var lineas := PackedStringArray()
	for campo in [["EDAD", perfil.edad], ["OCUPACIÓN", perfil.ocupacion], ["VÍNCULO", perfil.vinculo]]:
		if not campo[1].is_empty():
			lineas.append("[b]%s:[/b] %s" % [campo[0], _escapar(campo[1])])
	if not perfil.notas.is_empty():
		lineas.append("\n" + _escapar(perfil.notas))
	return "\n".join(lineas)


func _escapar(texto: String) -> String:
	return texto.replace("[", "[lb]")


func _iniciales(texto: String) -> String:
	var partes := texto.split(" ", false)
	if partes.is_empty():
		return "?"
	var resultado := partes[0].left(1)
	if partes.size() > 1:
		resultado += partes[partes.size() - 1].left(1)
	return resultado.to_upper()


func _animar(destino_y: float) -> void:
	if _tween and _tween.is_running():
		_tween.kill()
	_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	_tween.tween_property(self, "position:y", destino_y, duracion)
