extends Node3D

@onready var ball = $Ball
@onready var spawn_point = $Base1/SpawnPoint
@onready var spring = $Base1/Spring
@onready var score_canvas_layer = $CanvasLayer
@onready var cooldown_timer = $Cooldown
@onready var game_over_score_canvas_layer = $GameOver

@onready var respawn_sfx = $Audio/RespawnSFX
@onready var lose_sfx = $Audio/LoseSFX
@onready var obstacle_hit_sfx = $Audio/ObstacleHitSFX
@onready var spring_launch_sfx = $Audio/SpringLaunchSFX



var game_info : GameInfo = GameInfo.new()

var in_spawn_zone : bool = true
var launch_power : float = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	ball.global_position = spawn_point.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_info.balls_Left >= 0:
		if in_spawn_zone and Input.is_action_pressed("Launch_Ball"):
			launch_power = move_toward(launch_power, 1, delta)
			spring.position.z = move_toward(spring.position.z, 2.9, delta/3)
			print(launch_power)
		elif in_spawn_zone and Input.is_action_just_released("Launch_Ball"):
			ball.apply_central_impulse(Vector3.UP * launch_power * 15)
			launch_power = 0
			in_spawn_zone = false
			cooldown_timer.start()
			spring_launch_sfx.play()
		elif !Input.is_action_pressed("Launch_Ball") and spring.position.z != 2.5:
			spring.position.z = move_toward(spring.position.z, 2.5, delta*5)
	pass




func _on_ball_in_spawn_zone():
	if !in_spawn_zone and cooldown_timer.is_stopped():
		in_spawn_zone = true
	pass # Replace with function body.


func _on_ball_assign_new_points(points):
	game_info.score += points
	score_canvas_layer.target_score = game_info.score
	print(game_info.score)
	pass # Replace with function body.


func _on_out_of_bounds_area_body_entered(body):
	game_info.balls_Left -= 1
	ball.global_position = spawn_point.global_position
	respawn_sfx.play()
	if game_info.balls_Left >= 0:
		score_canvas_layer.UpdateBallsLeft(game_info.balls_Left)
	if game_info.balls_Left < 0:
		game_over_score_canvas_layer.bring_up()
		lose_sfx.play()
		# bring up end of game info
		pass
	pass # Replace with function body.


func _on_cooldown_timeout():
	pass # Replace with function body.


func _on_game_over_reset_game():
	game_info.balls_Left = 3
	game_info.score = 0
	score_canvas_layer.UpdateBallsLeft(game_info.balls_Left)
	score_canvas_layer.current_score = 0
	score_canvas_layer.target_score = 0
	pass # Replace with function body.
