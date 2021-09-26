extends KinematicBody2D
class_name Player

const MAX_SPEED_X = 256
const MAX_SPEED_Y = 512
const GRAVITY = 512
const JUMP_FORCE = 350
const ACCEL_CURVE_TIME = 0.25
const FRICTION_CURVE_TIME = 0.5

export (Curve) var accel_curve
export (Curve) var friction_curve

var velocity = Vector2()
var move_direction = 0
var max_speed_reached = 0 #var to save max speed for friction handling
var accel_time = 0 #vars for curve time position
var friction_time = 0

#Returns WASD/arrow keys as a Vector2
func get_input_vector():
	var right_input = Input.get_action_strength("move_right")
	var left_input = Input.get_action_strength("move_left")
	var down_input = Input.get_action_strength("move_down")
	var up_input = Input.get_action_strength("move_up")
	return Vector2(right_input - left_input, down_input - up_input)

func _ready():
	pass

func _process(delta):
	var input_vector = get_input_vector()
	#If left/right pressed, move, else, friction
	if (input_vector.x != 0): #accelerate x speed according to accel_curve
		#handle frame perfect turnarounds keeping accel_time at 1
		if (input_vector.x != move_direction):
			accel_time = 0
		move_direction = sign(input_vector.x)
		friction_time = 0
		accel_time += delta / ACCEL_CURVE_TIME
		velocity.x = move_direction * MAX_SPEED_X * accel_curve.interpolate(accel_time)
		max_speed_reached = sign(velocity.x) * max(abs(velocity.x), max_speed_reached) #save max speed for friction
	else:
		accel_time = 0
		friction_time += delta / FRICTION_CURVE_TIME
		velocity.x = max_speed_reached * friction_curve.interpolate(friction_time)
		if (friction_time >= 1):
			max_speed_reached = 0
	#jump
	if (is_on_floor() and Input.is_action_just_pressed("jump")):
		velocity.y -= JUMP_FORCE

func _physics_process(delta):
	#Clamp movement speeds in x/y directions
	if (abs(velocity.x) > MAX_SPEED_X):
		velocity.x = sign(velocity.x) * MAX_SPEED_X
	if (abs(velocity.y) > MAX_SPEED_Y):
		velocity.y = sign(velocity.y) * MAX_SPEED_Y
	#gravity
	velocity.y += GRAVITY * delta
	#inherited move_and_slide function from kinematicbody2d
	velocity = move_and_slide(velocity, Vector2.UP)
