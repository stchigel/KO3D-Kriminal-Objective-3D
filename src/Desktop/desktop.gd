extends Control
@export var ventanas: Array[Node]
@export var juicioScene: PackedScene
var selec := false
var start_pos := Vector2.ZERO
var current_pos := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for ventana in ventanas:
		if ventana:
			ventana.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _gui_input(event):
	if event is InputEventMouseButton:
		print("BUTTON: pressed=", event.pressed, " pos=", event.position)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			selec = true
			start_pos = event.position
			current_pos = event.position
		else:
			selec = false
			aplicar()
		queue_redraw()
	elif event is InputEventMouseMotion and selec:
		current_pos = event.position
		queue_redraw()

func _draw():
	if selec:
		var rect = Rect2(start_pos, current_pos - start_pos).abs()
		draw_rect(rect, Color(0.3, 0.5, 1.0, 0.2), true)
		draw_rect(rect, Color(0.3, 0.5, 1.0, 0.8), false, 1.0)

func aplicar():
	$Topbar/Panel.hide()
	var rect = Rect2(start_pos, current_pos - start_pos).abs()
	for item in get_children():
		if item.is_in_group("archivo"):
			var item_rect = Rect2(item.position, item.size)
			if rect.intersects(item_rect):
				item.select()
			else:
				item.deselect()


func _on_apagar_pressed() -> void:
	$Topbar/Panel.show()


func _on_desconectar_pressed() -> void:
	get_tree().change_scene_to_packed(juicioScene)
