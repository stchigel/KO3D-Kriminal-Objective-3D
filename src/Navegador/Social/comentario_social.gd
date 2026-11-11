extends PanelContainer
signal perfil_pedido(autor: String)


func configurar(comentario: Comentario, red: RedSocial, perfil_actual: PerfilSocial, fuente: String) -> void:
	add_theme_stylebox_override("panel", red.estilo(red.color_tarjeta.lightened(0.08), 8))
	$Contenido/Autor.configurar(comentario.autor, red, perfil_actual)
	$Contenido/Autor.perfil_pedido.connect(perfil_pedido.emit)
	$Contenido/Texto.mostrar(comentario.texto, comentario.pistas, fuente)
