extends Label

@export var caracteres_por_segundo: float = 55.0


func setup(pista: Pista, numero: int, imprimir: bool = true) -> void:
	text = _armar_texto(pista, numero)
	if imprimir:
		_imprimir()


func duracion_de_impresion() -> float:
	return text.length() / caracteres_por_segundo


func _armar_texto(pista: Pista, numero: int) -> String:
	var cuerpo := pista.titulo
	if not pista.texto.is_empty():
		cuerpo = pista.texto if cuerpo.is_empty() else "%s: %s" % [cuerpo, pista.texto]
	return "%02d. %s" % [numero, cuerpo]


func _imprimir() -> void:
	visible_ratio = 0.0
	var tween := create_tween()
	tween.tween_property(self, "visible_ratio", 1.0, duracion_de_impresion())
