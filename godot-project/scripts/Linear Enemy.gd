extends Node2D

export var period = 5

onready var start = get_node("Start").global_position
onready var end = get_node("End").global_position
onready var sprite = get_node("KinematicBody2D/Sprite")

var last_position = Vector2()
var time = 0

func _physics_process(delta):
	time += delta
	if ((global_position - last_position).x > 0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	last_position = global_position
	var omega = 2*PI/period
	if end != null:
		global_position = start + sin(omega * time) * (end - start)

# In case someone doesn't read the comment at the top
func _get_configuration_warning():
	var warning = ""
	if (not get_node("Start") or not get_node("End")):
		warning = "Enemy is missing start or end position"
	return warning
