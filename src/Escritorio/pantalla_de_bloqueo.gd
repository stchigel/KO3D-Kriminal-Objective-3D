class_name PantallaDeBloqueo
extends Control

signal contrasena_aceptada

@export var nombre_de_usuario: String = "Usuario"
@export var contrasena_correcta: String = "admin123"
@export var texto_de_la_ayuda: String = "Ayuda: está anotada en un post-it del monitor."
@export var intentos_para_mostrar_la_ayuda: int = 3
@export var duracion_del_temblor: float = 0.35
@export var intensidad_del_temblor: float = 12.0

var intentos_fallidos: int = 0

@onready var etiqueta_del_usuario: Label = $Centro/Formulario/EtiquetaDelUsuario
@onready var campo_de_contrasena: LineEdit = $Centro/Formulario/ContenedorDelCampo/CampoDeContrasena
@onready var boton_entrar: Button = $Centro/Formulario/BotonEntrar
@onready var etiqueta_de_error: Label = $Centro/Formulario/EtiquetaDeError
@onready var etiqueta_de_ayuda: Label = $Centro/Formulario/EtiquetaDeAyuda


func _ready() -> void:
	etiqueta_del_usuario.text = nombre_de_usuario
	boton_entrar.pressed.connect(al_tocar_entrar)
	campo_de_contrasena.text_submitted.connect(al_confirmar_con_enter)
	visibility_changed.connect(al_cambiar_la_visibilidad)
	reiniciar()


func reiniciar() -> void:
	intentos_fallidos = 0
	campo_de_contrasena.clear()
	etiqueta_de_error.text = ""
	etiqueta_de_ayuda.hide()


func al_tocar_entrar() -> void:
	intentar_entrar()


func al_confirmar_con_enter(_texto: String) -> void:
	intentar_entrar()


func al_cambiar_la_visibilidad() -> void:
	if visible:
		campo_de_contrasena.grab_focus()


func intentar_entrar() -> void:
	if _normalizar(campo_de_contrasena.text) == _normalizar(contrasena_correcta):
		etiqueta_de_error.text = ""
		contrasena_aceptada.emit()
		return
	intentos_fallidos += 1
	etiqueta_de_error.text = "Contraseña incorrecta"
	campo_de_contrasena.clear()
	campo_de_contrasena.grab_focus()
	temblar_el_campo()
	if intentos_para_mostrar_la_ayuda > 0 and intentos_fallidos >= intentos_para_mostrar_la_ayuda \
			and not texto_de_la_ayuda.is_empty():
		etiqueta_de_ayuda.text = texto_de_la_ayuda
		etiqueta_de_ayuda.show()


func temblar_el_campo() -> void:
	var tween := create_tween()
	var pasos := 6
	for paso in pasos:
		var amplitud := intensidad_del_temblor * (1.0 - float(paso) / pasos)
		var sentido := 1.0 if paso % 2 == 0 else -1.0
		tween.tween_property(campo_de_contrasena, "position:x", amplitud * sentido, duracion_del_temblor / (pasos + 1))
	tween.tween_property(campo_de_contrasena, "position:x", 0.0, duracion_del_temblor / (pasos + 1))


func _normalizar(texto: String) -> String:
	return texto.strip_edges().to_lower()
