extends PanelContainer

const ENTRADA := preload("res://src/Navegador/Entradas/entrada_item.tscn")


func configurar(_navegador: Panel, sitio: Sitio, datos: Resource) -> void:
	var pagina := datos as PaginaEntradas
	if pagina == null:
		pagina = sitio.datos as PaginaEntradas
	if pagina == null:
		push_warning("Sitio '%s': la pagina de entradas necesita una PaginaEntradas." % sitio.id)
		return
	_mostrar(pagina, sitio)


func _mostrar(pagina: PaginaEntradas, sitio: Sitio) -> void:
	add_theme_stylebox_override("panel", pagina.estilo(pagina.color_fondo, 0))
	var nombre: Label = $Margen/Contenido/Nombre
	nombre.text = pagina.nombre
	nombre.visible = not pagina.nombre.is_empty()
	nombre.add_theme_color_override("font_color", pagina.color_acento)
	$Margen/Contenido/Titulo.text = pagina.titulo
	$Margen/Contenido/Titulo.visible = not pagina.titulo.is_empty()
	$Margen/Contenido/Subtitulo.text = pagina.subtitulo
	$Margen/Contenido/Subtitulo.visible = not pagina.subtitulo.is_empty()
	var descripcion: RichTextLabel = $Margen/Contenido/Descripcion
	descripcion.visible = not pagina.descripcion.is_empty()
	descripcion.mostrar(pagina.descripcion, pagina.descripcion_pistas, sitio.titulo)
	var progreso: VBoxContainer = $Margen/Contenido/Progreso
	progreso.visible = pagina.meta > 0
	if pagina.meta > 0:
		var barra: ProgressBar = progreso.get_node("Barra")
		barra.max_value = pagina.meta
		barra.value = pagina.recaudado
		barra.add_theme_stylebox_override("fill", pagina.estilo(pagina.color_acento, 0))
		barra.add_theme_stylebox_override("background", pagina.estilo(pagina.color_tarjeta, 0))
		progreso.get_node("Monto").text = "Recaudado: %s de %s" % [pagina.monto(pagina.recaudado), pagina.monto(pagina.meta)]
	$Margen/Contenido/Etiqueta.text = pagina.etiqueta_entradas
	$Margen/Contenido/Etiqueta.visible = not pagina.etiqueta_entradas.is_empty()
	var lista := $Margen/Contenido/Entradas
	for entrada in pagina.entradas:
		if entrada == null:
			continue
		var tarjeta := ENTRADA.instantiate()
		lista.add_child(tarjeta)
		tarjeta.configurar(entrada, pagina, sitio.titulo)
