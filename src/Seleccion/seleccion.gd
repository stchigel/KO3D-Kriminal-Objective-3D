extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on__pressed() -> void:
	get_tree().change_scene_to_file("res://src/Intro/Intro.tscn")


func _on_2_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Intro/Intro2.tscn")


func _on_3_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Intro/IntroPancho.tscn")


func _on_4_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Intro/IntroTomi.tscn")

func _on_5_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Intro/IntroHotel412.tscn")

func _on_6_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Intro/IntroFondos.tscn")

func _on_7_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Intro/IntroRadio.tscn")

func _on_8_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Intro/IntroDepto3b.tscn")
