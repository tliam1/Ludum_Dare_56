extends CanvasLayer
@onready var panel = $Control/Panel
@onready var retry_button = $Control/Panel/retry_button

signal reset_game

# Called when the node enters the scene tree for the first time.
func _ready():
	retry_button.disabled = true
	panel.global_position.y += 2000
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func bring_up():
	var tween = create_tween()
	retry_button.disabled = false
	tween.tween_property(panel, "global_position:y", 202.5, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUINT).from_current() 
	
func bring_down():
	var tween = create_tween()
	tween.tween_property(panel, "global_position:y", 2202.5, 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUINT).from_current() 
	reset_game.emit()
	retry_button.disabled = true


func _on_button_pressed():
	bring_down()
	pass # Replace with function body.
