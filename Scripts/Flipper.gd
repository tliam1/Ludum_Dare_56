extends RigidBody3D

enum FlipperType {
	LEFT_FLIPPER,
	RIGHT_FLIPPER,
}

@export var flipperType : FlipperType
@onready var flipper_mesh = $Flipper
@export var pinInfo : PinInfo
@onready var sfx = $sfx



# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_degrees.y = (65 if flipperType == FlipperType.LEFT_FLIPPER else -65)
	physics_material_override.bounce = .3
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _integrate_forces(state):
	Move_Flipper()

# Rotate mesh on button press
func Move_Flipper():
	if flipperType == FlipperType.RIGHT_FLIPPER and Input.is_action_just_pressed("Move_Right"):
#		print("RIGHT FLIPPER MOVES to yRot -150")
		rotate_flipper_to(-150)
		sfx.stop()
		sfx.play()
		physics_material_override.bounce = 1
		pass
	elif flipperType == FlipperType.LEFT_FLIPPER and Input.is_action_just_pressed("Move_Left"):
#		print("LEFT FLIPPER MOVES yRot 150")
		rotate_flipper_to(150)
		sfx.stop()
		sfx.play()
		physics_material_override.bounce = 1
		pass
	
	
	if flipperType == FlipperType.RIGHT_FLIPPER and Input.is_action_just_released("Move_Right"):
#		print("RIGHT FLIPPER MOVES BACK to -90")
		rotate_flipper_to(-65)
		physics_material_override.bounce = .3
		pass
	elif flipperType == FlipperType.LEFT_FLIPPER and Input.is_action_just_released("Move_Left"):
#		print("LEFT FLIPPER MOVES BACK to 90")
		rotate_flipper_to(65)
		physics_material_override.bounce = .3
		pass


func rotate_flipper_to(target_angle: float):
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees:y", target_angle, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR).from_current() 
