extends Panel

signal link_clickeado(meta: Variant)

var texto_original: String = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Texto.bbcode_enabled = true
	$Texto.meta_underlined = false
	$Texto.meta_clicked.connect(link_clickeado.emit)

func setup(text: String, time: String):
	texto_original = text
	$Texto.text = text
	$Texto2.text = time

func mostrar_texto(bbcode: String) -> void:
	$Texto.text = bbcode

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
