extends CanvasLayer

onready var spotlight = $Spotlight
onready var tween = $Tween

func _process(delta):
	spotlight.global_position = Game.player.get_global_transform_with_canvas().get_origin()

func spotlight_out():
	tween.interpolate_property(spotlight, "scale", Vector2(2, 2), Vector2.ZERO, 2, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

func spotlight_in():
	tween.interpolate_property(spotlight, "scale", Vector2.ZERO, Vector2(2, 2), 2, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

func _on_Player_died():
	spotlight_out()
