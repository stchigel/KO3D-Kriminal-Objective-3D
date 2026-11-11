extends MarginContainer


func configurar(_navegador: Panel, sitio: Sitio, _datos: Resource) -> void:
	$Contenido/Titulo.text = sitio.titulo
	$Contenido/Direccion.text = sitio.direccion
