extends PanelContainer

const SECCION := preload("res://src/Navegador/Informativa/seccion_vista.tscn")


func configurar(_navegador: Panel, sitio: Sitio, datos: Resource) -> void:
	var pagina := datos as PaginaInformativa
	if pagina == null:
		pagina = sitio.datos as PaginaInformativa
	if pagina == null:
		push_warning("Sitio '%s': la pagina informativa necesita una PaginaInformativa." % sitio.id)
		return
	_mostrar(pagina, sitio)


func _mostrar(pagina: PaginaInformativa, sitio: Sitio) -> void:
	add_theme_stylebox_override("panel", pagina.estilo(pagina.color_fondo, 0))
	var sobre := pagina.color_sobre_acento()
	var cabecera: PanelContainer = $Margen/Contenido/Cabecera
	cabecera.visible = not pagina.titulo.is_empty() or not pagina.lema.is_empty()
	cabecera.add_theme_stylebox_override("panel", pagina.estilo(pagina.color_acento, 18))
	var titulo: Label = $Margen/Contenido/Cabecera/Texto/Titulo
	titulo.text = pagina.titulo
	titulo.visible = not pagina.titulo.is_empty()
	titulo.add_theme_color_override("font_color", sobre)
	var lema: RichTextLabel = $Margen/Contenido/Cabecera/Texto/Lema
	lema.visible = not pagina.lema.is_empty()
	lema.add_theme_color_override("default_color", sobre)
	lema.mostrar(pagina.lema, pagina.pistas, sitio.titulo)
	var introduccion: RichTextLabel = $Margen/Contenido/Introduccion
	introduccion.visible = not pagina.introduccion.is_empty()
	introduccion.add_theme_color_override("default_color", pagina.color_texto)
	introduccion.mostrar(pagina.introduccion, pagina.pistas, sitio.titulo)
	var lista := $Margen/Contenido/Secciones
	for seccion in pagina.secciones:
		if seccion == null:
			continue
		var tarjeta := SECCION.instantiate()
		lista.add_child(tarjeta)
		tarjeta.configurar(seccion, pagina, sitio.titulo)
