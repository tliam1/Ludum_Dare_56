extends RigidBody3D

# not much to do with the ball other than applying bounce forces on collision
# might need to watch speed in case there is a need for a cap
enum AnimationState {
	NORMAL,
	COLLIDE,
}

var currentAnimationState := AnimationState.NORMAL
var storedBounceForce : Vector3 = Vector3.ZERO
@export var gravity : float = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = gravity
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed : float = linear_velocity.length()
	if gravity_scale != gravity:
		gravity_scale = move_toward(gravity_scale, gravity, delta * 2)
	pass

func _integrate_forces(state):
	var velocity = state.get_linear_velocity()
	# applying the bounce force
	if storedBounceForce != Vector3.ZERO:
		state.set_linear_velocity(storedBounceForce)
		storedBounceForce = Vector3.ZERO
	
	state.set_linear_velocity(velocity)

func apply_bounce_force(force : Vector3):
	storedBounceForce = force # a direction vector * bounce force via stats.gd


func _on_body_entered(body):
	print(body.collision_layer)
	if body.collision_layer == 4:
		gravity_scale = 0
		print(body.collision_layer)
	pass # Replace with function body.
