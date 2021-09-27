tool
extends Node2D

export var period = 5

var start = self.position
onready var end = get_node("End").position

var time = 0
func _physics_process(delta):
	time += delta
	var omega = 2*PI/period
	if end != null:
		self.position = start + sin(omega*time)*(end - start)

# In case someone doesn't read the comment at the top
func _get_configuration_warning():
	var warning = ""
	if get_child_count() == 1:
		warning = "Must have a Linear End node as a child"
	
	return warning
