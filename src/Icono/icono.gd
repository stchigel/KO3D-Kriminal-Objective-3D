extends Button
@export var icono: Texture2D = preload("res://assets/icon.svg")
@export var oculto: bool
@export var abrir: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$icono.texture = icono
	$caja.hide()
	if oculto:
		$".".hide()
		$icono.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func select():
	$caja.show()
	if oculto:
		$".".show()
		$icono.show()
	else:
		# aca poner q lo ponga con el cuadradito tipo windows
		pass

func deselect():
	$caja.hide()
	if oculto:
		$".".hide()
		$icono.hide()
	else:
		# aca poner q lo ponga con el cuadradito tipo windows
		pass

func _on_pressed() -> void:
	if abrir:
		abrir.show()
