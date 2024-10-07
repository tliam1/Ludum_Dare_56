extends Node3D

@onready var ball = $Ball
@onready var spawn_point = $Base1/SpawnPoint
var in_spawn_zone : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	ball.global_position = spawn_point.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if in_spawn_zone and Input.key
	pass
