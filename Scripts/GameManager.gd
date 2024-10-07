extends Node3D

@onready var ball = $Ball
@onready var spawn_point = $Base1/SpawnPoint
var in_spawn_zone : bool = true
var launch_power : float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	ball.global_position = spawn_point.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_spawn_zone and Input.is_action_pressed("Launch_Ball"):
		launch_power = move_toward(launch_power, 1, delta)
		print(launch_power)
	elif in_spawn_zone and Input.is_action_just_released("Launch_Ball"):
		ball.apply_central_impulse(Vector3.FORWARD * launch_power * 10)
	pass


func _on_spawn_area_detector_body_entered(body):
	in_spawn_zone = !in_spawn_zone
	pass # Replace with function body.
