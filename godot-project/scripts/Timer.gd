extends Label

const DANGER_TIME = 5

onready var timer = $Timer
onready var tick_sound = $Tick
onready var tick_scary = $Tick2

var time_left: int = 10 setget time_left_set
#https://docs.godotengine.org/en/3.4/getting_started/scripting/gdscript/gdscript_basics.html#setters-getters

#Setter function that modifies the variable and the label text
func time_left_set(x):
	time_left = x
	text = str(time_left / 60) + ":" + "%02d" % [time_left % 60]

#When timer reaches 0
func time_out():
	timer.stop()
	Game.player.kill()

func time_tick():
	time_left_set(time_left - 1)

func _on_Timer_timeout():
	time_tick()
	if (time_left <= DANGER_TIME):
		tick_scary.play()
		set("custom_colors/font_color", Color(1, 0, 0))
	else:
		tick_sound.play()
		set("custom_colors/font_color", Color(1, 1, 1))
	if (time_left == 0):
		time_out()
