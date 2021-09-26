extends Label

onready var timer = $Timer

var time_left: int = 60 setget time_left_set
#https://docs.godotengine.org/en/3.4/getting_started/scripting/gdscript/gdscript_basics.html#setters-getters

#Setter function that modifies the variable and the label text
func time_left_set(x):
	time_left = x
	text = str(time_left / 60) + ":" + str(time_left % 60)

#When timer reaches 0
func time_out():
	pass

func _on_Timer_timeout():
	time_left_set(time_left - 1)
	if (time_left == 0):
		time_out()
