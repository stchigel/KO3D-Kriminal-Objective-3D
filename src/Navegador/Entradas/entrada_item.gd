extends PanelContainer

const COMENTARIO := preload("res://src/Navegador/Entradas/comentario_entrada.tscn")


func configurar(entrada: EntradaPagina, pagina: PaginaEntradas, fuente_base: String) -> void:
	var detalle := entrada.titulo
	if detalle.is_empty():
		detalle = entrada.autor
	if detalle.is_empty():
		detalle = entrada.fecha
	var fuente := fuente_base if detalle.is_empty() else "%s (%s)" % [fuente_base, detalle]
	add_theme_stylebox_override("panel", pagina.estilo(pagina.color_tarjeta, 12))
	var autor: Label = $Contenido/Cabecera/Autor
	autor.text = entrada.autor
	autor.visible = not entrada.autor.is_empty()
	autor.add_theme_color_override("font_color", pagina.color_acento)
	var valoracion: Label = $Contenido/Cabecera/Valoracion
	valoracion.text = "★".repeat(entrada.valoracion) + "☆".repeat(5 - entrada.valoracion)
	valoracion.visible = entrada.valoracion > 0
	valoracion.add_theme_color_override("font_color", pagina.color_acento)
	$Contenido/Cabecera/Fecha.text = entrada.fecha
	$Contenido/Cabecera.visible = not entrada.autor.is_empty() or not entrada.fecha.is_empty() or entrada.valoracion > 0
	$Contenido/Titulo.text = entrada.titulo
	$Contenido/Titulo.visible = not entrada.titulo.is_empty()
	$Contenido/Texto.mostrar(entrada.texto, entrada.pistas, fuente)
	$Contenido/Comentarios.visible = not entrada.comentarios.is_empty()
	for comentario in entrada.comentarios:
		if comentario == null:
			continue
		var fila := COMENTARIO.instantiate()
		$Contenido/Comentarios.add_child(fila)
		fila.configurar(comentario, pagina, fuente)
