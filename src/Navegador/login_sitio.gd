extends Panel
signal acceso_concedido(sitio: Sitio)

var _sitio: Sitio

@onready var _titulo: Label = $Tarjeta/Contenido/Titulo
@onready var _usuario: LineEdit = $Tarjeta/Contenido/Usuario
@onready var _clave: LineEdit = $Tarjeta/Contenido/Clave
@onready var _pista: Label = $Tarjeta/Contenido/Pista
@onready var _error: Label = $Tarjeta/Contenido/Error


func _ready() -> void:
	hide()


func pedir(sitio: Sitio) -> void:
	_sitio = sitio
	_titulo.text = sitio.titulo
	_usuario.text = sitio.usuario
	_usuario.visible = not sitio.usuario.is_empty()
	_pista.text = "Pista: " + sitio.pista_clave
	_pista.visible = not sitio.pista_clave.is_empty()
	_error.hide()
	_clave.clear()
	show()
	_clave.grab_focus.call_deferred()


func _intentar() -> void:
	if _sitio == null:
		return
	if _sitio.clave_correcta(_clave.text):
		_error.hide()
		acceso_concedido.emit(_sitio)
		return
	_error.show()
	_clave.clear()
	_clave.grab_focus()


func _on_clave_text_submitted(_texto: String) -> void:
	_intentar()


func _on_entrar_pressed() -> void:
	_intentar()
