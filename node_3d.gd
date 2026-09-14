extends Node3D
@export var pitch_min_deg: float = -70.0
@export var pitch_max_deg: float = 70.0
@export var yaw_min_deg: float = -80.0
@export var yaw_max_deg: float = 80.0
var inicial: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inicial = $Camera3D.rotation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func rotarCamaraX(rot: float) -> void:
	var new_rot_x: float = $Camera3D.rotation.x + rot
	new_rot_x = clamp(new_rot_x, deg_to_rad(pitch_min_deg), deg_to_rad(pitch_max_deg))
	$Camera3D.rotation.x = new_rot_x

func rotarCamaraY(rot: float) -> void:
	var new_rot_y: float = $Camera3D.rotation.y + rot
	new_rot_y = clamp(new_rot_y, deg_to_rad(yaw_min_deg), deg_to_rad(yaw_max_deg))
	$Camera3D.rotation.y = new_rot_y

func rotarCamaraZ(rot: float) -> void:
	$Camera3D.rotate_z(rot)
	
func resetearCamara() -> void:
	$Camera3D.rotation = inicial
