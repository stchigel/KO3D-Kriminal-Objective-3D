class_name TextoResaltable
extends RichTextLabel

@export var color_encontrada: Color = Color(1.0, 0.85, 0.2, 0.35)

var _texto: String = ""
var _pistas: Array[Pista] = []
var _fuente: String = ""
var _recien_encontrada: String = ""
var _regex_link := RegEx.create_from_string("(?s)\\[url=([^\\]]+)\\](.*?)\\[/url\\]")


func _ready() -> void:
	bbcode_enabled = true
	meta_underlined = false
	fit_content = true
	scroll_active = false
	meta_clicked.connect(_on_meta_clicked)
	Global.pistas_limpiadas.connect(_actualizar)
	_actualizar()


func mostrar(texto: String, pistas: Array[Pista], fuente: String) -> void:
	_texto = texto
	_pistas = pistas
	_fuente = fuente
	_recien_encontrada = ""
	if is_node_ready():
		_actualizar()


func _on_meta_clicked(meta: Variant) -> void:
	var id := str(meta)
	var pista := _buscar_pista(id)
	if pista == null:
		push_warning("Texto resaltable: el link '%s' no tiene una Pista con ese id." % id)
		return
	var fuente := pista.fuente if not pista.fuente.is_empty() else _fuente
	if not Global.anotar(pista.id, pista.titulo, pista.texto, fuente, pista.tipo, pista.puntos):
		return
	_recien_encontrada = id
	_actualizar()
	var temporizador := create_tween()
	temporizador.tween_interval(0.5)
	temporizador.tween_callback(_terminar_destello.bind(id))


func _terminar_destello(id: String) -> void:
	if _recien_encontrada == id:
		_recien_encontrada = ""
		_actualizar()


func _buscar_pista(id: String) -> Pista:
	for pista in _pistas:
		if pista != null and pista.id == id:
			return pista
	return null


func _actualizar() -> void:
	var resultado := ""
	var ultimo := 0
	for m in _regex_link.search_all(_texto):
		var id := m.get_string(1)
		var contenido := m.get_string(2)
		if Global.tiene_pista(id):
			contenido = "[bgcolor=#%s]%s[/bgcolor]" % [color_encontrada.to_html(), contenido]
			if id == _recien_encontrada:
				contenido = "[shake rate=25 level=8]%s[/shake]" % contenido
		resultado += _texto.substr(ultimo, m.get_start() - ultimo)
		resultado += "[url=%s]%s[/url]" % [id, contenido]
		ultimo = m.get_end()
	resultado += _texto.substr(ultimo)
	text = resultado
