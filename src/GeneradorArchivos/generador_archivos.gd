extends Node

@export var carpetas: Array[NodePath] = []
@export var cantidad_min: int = 3
@export var cantidad_max: int = 8
@export var archivo_scene: PackedScene = preload("res://src/Archivo/archivo.tscn")
@export var texto_scene: PackedScene = preload("res://src/Texto/texto.tscn")
@export var icono_txt: Texture2D = preload("res://assets/iconos/text.svg")

const NOMBRES_BASE: Array[String] = [
	"proyecto", "presupuesto", "informe", "propuesta", "contrato",
	"reporte", "carta", "nota", "acta", "borrador", "memo", "factura",
	"resumen", "analisis", "plan", "agenda", "solicitud", "pedido",
	"presentacion", "oferta", "convenio", "declaracion", "balance", "inventario"
]

const SUFIJOS: Array[String] = [
	"_final", "_v2", "_1", " (1)", "_copia", "_revisado",
	"_definitivo", "_borrador", "_ok", "_2", " (2)", "_nuevo",
	"_actualizado", "_entregado", "_firmado", " - copia"
]

const PARRAFOS: Array[String] = [
	"En respuesta a su consulta del día de ayer, nos comunicamos para informarle que el trámite solicitado ha sido procesado satisfactoriamente. Adjuntamos la documentación correspondiente para su revisión y archivo. Quedamos a su disposición para cualquier aclaración adicional que pudiera requerir al respecto.",
	"Tal como acordamos en la reunión del martes, se adjunta el detalle completo de los gastos proyectados para el próximo trimestre. Los números reflejan un incremento del ocho por ciento respecto al período anterior, principalmente por el ajuste en los costos operativos. Solicitamos su conformidad antes del viernes para poder elevar el informe a dirección.",
	"Me dirijo a usted con el fin de comunicarle que hemos recibido la totalidad de los documentos requeridos para iniciar el proceso de evaluación. El equipo técnico procederá a realizar el análisis correspondiente en un plazo no mayor a diez días hábiles. Cualquier observación será notificada de manera inmediata al correo consignado en el expediente.",
	"Luego de revisar detenidamente la propuesta presentada el mes pasado, el área de contrataciones ha determinado que los términos y condiciones se ajustan a los requerimientos institucionales. Por lo tanto, se procederá a la firma del instrumento en la fecha convenida. Se adjunta el borrador final para la revisión de ambas partes antes de la formalización.",
	"Estimado equipo: se los convoca a la reunión de cierre de ciclo prevista para el próximo jueves a las 14:00 horas en la sala de conferencias del piso cuatro. Se solicita a cada área que prepare un resumen ejecutivo de los avances obtenidos durante el período. La asistencia es obligatoria; en caso de impedimento, comunicar con al menos veinticuatro horas de anticipación.",
	"A continuación se detallan los puntos discutidos durante la sesión ordinaria celebrada el día de la fecha. Se aprobó por unanimidad la modificación del artículo séptimo del reglamento interno, efectiva a partir del primer día del mes entrante. Asimismo, se postergó el tratamiento del punto cuatro de la orden del día para la próxima sesión ordinaria.",
	"El análisis de los datos relevados durante el último semestre indica una mejora sostenida en los indicadores de satisfacción, alcanzando un promedio del noventa y dos por ciento en la encuesta de calidad. No obstante, se identificaron áreas de mejora en los tiempos de respuesta al cliente, para las cuales se propone implementar un protocolo de seguimiento semanal a partir del mes próximo.",
	"Con motivo del vencimiento del período contractual, se comunica formalmente la intención de renovar el acuerdo bajo las mismas condiciones vigentes, sujeto a la revisión del anexo de precios que se adjunta. Se solicita respuesta por escrito antes del día veinte del corriente mes para proceder con la documentación necesaria y evitar interrupciones en la prestación del servicio.",
	"Habiendo realizado la auditoría interna correspondiente al ejercicio fiscal, se hace constar que los registros contables se encuentran en orden y reflejan fielmente la situación patrimonial de la organización. Se recomienda, sin embargo, revisar los procedimientos de archivo para los comprobantes físicos, ya que se detectaron faltantes en las carpetas del segundo trimestre.",
	"Se informa que el proceso de selección para cubrir las vacantes publicadas en el mes de marzo ha concluido satisfactoriamente. Los candidatos seleccionados han sido notificados y deberán presentarse el próximo lunes con la documentación completa para iniciar los trámites de incorporación. Agradecemos la participación de todos los postulantes.",
	"En virtud de lo establecido en la cláusula décima del contrato vigente, se procede a notificar formalmente la existencia de un incumplimiento parcial en los plazos de entrega acordados. Se otorga un período de gracia de cinco días hábiles para regularizar la situación. De no mediar respuesta, se aplicarán las penalidades previstas en el instrumento contractual.",
	"Compartimos los resultados preliminares del relevamiento efectuado durante los últimos quince días. Los datos obtenidos señalan una demanda sostenida en el segmento principal, con un leve descenso en las categorías secundarias atribuible a factores estacionales. Se recomienda mantener la estrategia actual y reevaluar en el próximo ciclo de revisión.",
	"Este documento tiene carácter confidencial y es de uso exclusivo del personal autorizado. Contiene información sensible relativa a las operaciones internas del área, incluyendo proyecciones financieras y datos de clientes. Su reproducción o distribución sin autorización expresa está estrictamente prohibida y puede tener consecuencias legales.",
	"A fin de dar cumplimiento a las disposiciones reglamentarias vigentes, se procede a la formalización del presente instrumento en cuatro copias de igual tenor y a un solo efecto. Firmado en la ciudad de Buenos Aires, a los días del mes en curso, en presencia de los testigos abajo indicados, quienes prestan su conformidad mediante su firma al pie.",
	"Nos complace informarle que su solicitud de acceso al sistema ha sido aprobada por el área de seguridad informática. Las credenciales de acceso han sido enviadas al correo electrónico registrado. Por razones de seguridad, le solicitamos que cambie la contraseña provisional en su primer ingreso al sistema y que no la comparta con terceros bajo ninguna circunstancia.",
]

var _pos_index: Dictionary = {}

func _ready() -> void:
	generar.call_deferred()

func generar() -> void:
	var nodos_carpeta: Array = []
	for path in carpetas:
		var nodo = get_node_or_null(path)
		if nodo:
			nodos_carpeta.append(nodo)

	if nodos_carpeta.is_empty():
		push_warning("GeneradorArchivos: no se encontraron carpetas válidas.")
		return

	for carpeta in nodos_carpeta:
		var count := 0
		for child in carpeta.get_children():
			if child.is_in_group("archivo"):
				count += 1
		_pos_index[carpeta] = count

	for _i in range(randi_range(cantidad_min, cantidad_max)):
		var nombre := _generar_nombre()
		var contenido := _generar_contenido()
		var carpeta: Node = nodos_carpeta[randi() % nodos_carpeta.size()]

		var ventana = texto_scene.instantiate()
		ventana.nombre = nombre
		ventana.texto = contenido
		ventana.hide()
		get_parent().add_child(ventana)

		var icono = archivo_scene.instantiate()
		icono.nom = nombre
		icono.icono = icono_txt
		icono.abrir = ventana
		icono.position = _siguiente_posicion(carpeta)
		carpeta.add_child(icono)

func _generar_nombre() -> String:
	var base: String = NOMBRES_BASE[randi() % NOMBRES_BASE.size()]
	var sufijo: String = SUFIJOS[randi() % SUFIJOS.size()]
	return base + sufijo + ".txt"

func _generar_contenido() -> String:
	var p1: String = PARRAFOS[randi() % PARRAFOS.size()]
	if randi() % 2 == 0:
		var p2: String = PARRAFOS[randi() % PARRAFOS.size()]
		while p2 == p1:
			p2 = PARRAFOS[randi() % PARRAFOS.size()]
		return p1 + "\n\n" + p2
	return p1

func _siguiente_posicion(carpeta: Node) -> Vector2:
	var idx: int = _pos_index.get(carpeta, 0)
	_pos_index[carpeta] = idx + 1

	const ICON_W := 88
	const ICON_H := 100
	const PADDING_X := 8
	const PADDING_Y := 48
	const COLS := 9

	var col := idx % COLS
	var row := idx / COLS
	return Vector2(PADDING_X + col * ICON_W, PADDING_Y + row * ICON_H)
