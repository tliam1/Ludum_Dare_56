extends CanvasLayer
@onready var score = $Control/Panel/Score
@onready var remaining_balls = $Control/Panel/Remaining_Balls
var current_score : float = 0
var target_score : float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	UpdateScore(delta)
	pass

func UpdateBallsLeft(balls : int):
	remaining_balls.text = str(balls) + " balls remaining"

func UpdateScore(delta):
	current_score = move_toward(current_score, target_score, delta * 200)
	score.text = str(round(current_score))
