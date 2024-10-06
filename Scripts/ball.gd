extends RigidBody3D

# not much to do with the ball other than applying bounce forces on collision
# might need to watch speed in case there is a need for a cap
enum AnimationState {
	NORMAL,
	COLLIDE,
}

var currentAnimationState := AnimationState.NORMAL

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed : float = linear_velocity.length()
	pass

func _integrate_forces(state):
	var velocity = state.get_linear_velocity()
