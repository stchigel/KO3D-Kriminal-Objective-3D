extends Button
@export var nom: String = "default.txt"
@export var contra: String
@export var icono: Texture2D = preload("res://assets/icon.svg")
@export var oculto: bool
@export var abrir: Node
var seleccionado: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$icono.texture = icono
	$name.text = nom
	$caja.hide()
	$Panel.hide()
	if oculto:
		$".".hide()
		$icono.hide()
		$name.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func select():
	$caja.show()
	seleccionado=true
	if oculto:
		$".".show()
		$icono.show()
		$name.show()
	else:
		# aca poner q lo ponga con el cuadradito tipo windows
		pass

func deselect():
	$caja.hide()
	seleccionado=false
	if oculto:
		$".".hide()
		$icono.hide()
		$name.hide()
	else:
		# aca poner q lo ponga con el cuadradito tipo windows
		pass

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and event.double_click:
		if abrir:
			if contra:
				$Panel.show()
			else:
				abrir.show()

#func _on_pressed() -> void:
#	if abrir:
#		abrir.show()


func _on_line_edit_text_submitted(new_text: String) -> void:
	$Panel.hide()
	if new_text==contra:
		abrir.show()
