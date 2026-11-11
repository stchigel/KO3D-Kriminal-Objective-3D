extends PanelContainer
signal perfil_pedido(autor: String)

const COMENTARIO := preload("res://src/Navegador/Social/comentario_social.tscn")


func configurar(publicacion: Publicacion, perfil: PerfilSocial, red: RedSocial, fuente_base: String) -> void:
	var nombre_perfil := perfil.nombre if not perfil.nombre.is_empty() else perfil.usuario
	var autor := publicacion.autor if not publicacion.autor.is_empty() else nombre_perfil
	var detalle := publicacion.titulo if not publicacion.titulo.is_empty() else autor
	var fuente := "%s (%s)" % [fuente_base, detalle]
	add_theme_stylebox_override("panel", red.estilo(red.color_tarjeta, 12))
	$Contenido/Cabecera/Autor.configurar(autor, red, perfil)
	$Contenido/Cabecera/Autor.perfil_pedido.connect(perfil_pedido.emit)
	$Contenido/Cabecera/Fecha.text = publicacion.fecha
	$Contenido/Titulo.text = publicacion.titulo
	$Contenido/Titulo.visible = not publicacion.titulo.is_empty()
	$Contenido/Texto.mostrar(publicacion.texto, publicacion.pistas, fuente)
	$Contenido/Imagen.texture = publicacion.imagen
	$Contenido/Imagen.visible = publicacion.imagen != null
	$Contenido/Comentarios.visible = not publicacion.comentarios.is_empty()
	for comentario in publicacion.comentarios:
		if comentario == null:
			continue
		var fila := COMENTARIO.instantiate()
		$Contenido/Comentarios.add_child(fila)
		fila.configurar(comentario, red, perfil, fuente)
		fila.perfil_pedido.connect(perfil_pedido.emit)
