extends PanelContainer


func setup(pista: Pista) -> void:
	$HBox/Contenido/VBox/Titulo.text = pista.titulo
	$HBox/Contenido/VBox/Texto.text = pista.texto
	var pie := _armar_pie(pista)
	$HBox/Contenido/VBox/Pie.text = pie
	$HBox/Contenido/VBox/Pie.visible = not pie.is_empty()
	_aparecer()
	


func _armar_pie(pista: Pista) -> String:
	if pista.fuente.is_empty():
		return pista.hora
	if pista.hora.is_empty():
		return pista.fuente
	return "%s  ·  %s" % [pista.fuente, pista.hora]


func _aparecer() -> void:
	modulate.a = 0.0
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.25)
	
