extends PanelContainer


func configurar(seccion: SeccionInformativa, pagina: PaginaInformativa, fuente_base: String) -> void:
	add_theme_stylebox_override("panel", pagina.estilo(pagina.color_tarjeta, 14))
	var encabezado: Label = $Contenido/Encabezado
	encabezado.text = seccion.encabezado
	encabezado.visible = not seccion.encabezado.is_empty()
	encabezado.add_theme_color_override("font_color", pagina.color_acento)
	var fuente := fuente_base if seccion.encabezado.is_empty() else "%s (%s)" % [fuente_base, seccion.encabezado]
	var contenido := seccion.contenido()
	$Contenido/Texto.visible = not contenido.is_empty()
	$Contenido/Texto.add_theme_color_override("default_color", pagina.color_texto)
	$Contenido/Texto.mostrar(contenido, seccion.pistas, fuente)
