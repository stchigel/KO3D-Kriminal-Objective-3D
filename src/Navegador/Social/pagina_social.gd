extends PanelContainer

const TARJETA := preload("res://src/Navegador/Social/tarjeta_publicacion.tscn")

var _navegador: Panel
var _sitio: Sitio
var _red: RedSocial
var _perfil: PerfilSocial


func configurar(navegador: Panel, sitio: Sitio, datos: Resource) -> void:
	_navegador = navegador
	_sitio = sitio
	_red = sitio.datos as RedSocial
	_perfil = datos as PerfilSocial
	if _perfil == null and _red != null:
		_perfil = _red.perfil_inicial
	if _red == null or _perfil == null:
		push_warning("Sitio '%s': la pagina social necesita una RedSocial con perfil inicial." % sitio.id)
		return
	_mostrar()


func _mostrar() -> void:
	var nombre := _perfil.nombre if not _perfil.nombre.is_empty() else _perfil.usuario
	add_theme_stylebox_override("panel", _red.estilo(_red.color_fondo, 0))
	var etiqueta_red: Label = $Margen/Contenido/Red
	etiqueta_red.text = _red.nombre
	etiqueta_red.visible = not _red.nombre.is_empty()
	etiqueta_red.add_theme_color_override("font_color", _red.color_acento)
	$Margen/Contenido/Perfil.add_theme_stylebox_override("panel", _red.estilo(_red.color_tarjeta, 14))
	$Margen/Contenido/Perfil/Datos/Nombre.text = nombre
	var partes := PackedStringArray()
	if not _perfil.usuario.is_empty():
		partes.append("@" + _perfil.usuario)
	if not _perfil.detalle.is_empty():
		partes.append(_perfil.detalle)
	$Margen/Contenido/Perfil/Datos/Detalle.text = " · ".join(partes)
	$Margen/Contenido/Perfil/Datos/Detalle.visible = not partes.is_empty()
	var bio := $Margen/Contenido/Perfil/Datos/Bio
	bio.visible = not _perfil.bio.is_empty()
	bio.mostrar(_perfil.bio, _perfil.bio_pistas, "%s (perfil de %s)" % [_sitio.titulo, nombre])
	var lista := $Margen/Contenido/Publicaciones
	for publicacion in _perfil.publicaciones:
		if publicacion == null:
			continue
		var tarjeta := TARJETA.instantiate()
		lista.add_child(tarjeta)
		tarjeta.configurar(publicacion, _perfil, _red, _sitio.titulo)
		tarjeta.perfil_pedido.connect(_on_perfil_pedido)


func _on_perfil_pedido(autor: String) -> void:
	var destino := _red.buscar_perfil(autor)
	if destino != null:
		_navegador.ir_a(_sitio, null, destino)
