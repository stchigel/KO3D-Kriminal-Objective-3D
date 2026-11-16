extends PanelContainer


func configurar(comentario: Comentario, pagina: PaginaEntradas, fuente: String) -> void:
	add_theme_stylebox_override("panel", pagina.estilo(pagina.color_tarjeta.lightened(0.08), 8))
	var autor: Label = $Contenido/Autor
	autor.text = comentario.autor
	autor.visible = not comentario.autor.is_empty()
	autor.add_theme_color_override("font_color", pagina.color_acento)
	$Contenido/Texto.mostrar(comentario.texto, comentario.pistas, fuente)
