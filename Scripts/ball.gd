extends RigidBody3D

# not much to do with the ball other than applying bounce forces on collision
# might need to watch speed in case there is a need for a cap
enum AnimationState {
	NORMAL,
	COLLIDE,
}

var currentAnimationState := AnimationState.NORMAL
var storedBounceForce : Vector3 = Vector3.ZERO

signal inSpawnZone
signal assignNewPoints(points : float)
@export var gravity : float = 1
@onready var divider_hit_sfx = $DividerHitSFX

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = gravity
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed : float = linear_velocity.length()
	if gravity_scale != gravity:
		gravity_scale = move_toward(gravity_scale, gravity, delta)
	
	var bodies : Array[Node3D] = get_colliding_bodies()
	for body in bodies:
		if body.collision_layer == 64:
			inSpawnZone.emit()
	pass

func _integrate_forces(state):
	var velocity = state.get_linear_velocity()
	# applying the bounce force
	if storedBounceForce != Vector3.ZERO:
		state.set_linear_velocity(storedBounceForce)
		storedBounceForce = Vector3.ZERO
	
	# print(velocity.y)
	if velocity.y < -5:
		velocity.y *= 0.95
	
	state.set_linear_velocity(velocity)

func apply_bounce_force(force : Vector3):
	storedBounceForce = force # a direction vector * bounce force via stats.gd


func _on_body_entered(body):
	print(body.collision_layer)
	if body.collision_layer == 4 or body.collision_layer == 128:
		gravity_scale = 0
	elif body.collision_layer == 64:
		inSpawnZone.emit()
	
	if body.collision_layer == 128:
		var earned_points : float = body.get_parent().pinInfo.hit_reward
		assignNewPoints.emit(earned_points)
		divider_hit_sfx.pitch_scale = randf_range(0.9,1.1)
		divider_hit_sfx.stop()
		divider_hit_sfx.play()
	if body.collision_layer == 4:
		var earned_points : float = body.pinInfo.hit_reward
		assignNewPoints.emit(earned_points)
		# print(body.collision_layer)
	pass # Replace with function body.
