tool
extends HBoxContainer

const HEART_SPRITE = preload("res://assets/art/heart.png")
const HALFHEART_SPRITE = preload("res://assets/art/halfheart.png")

export (int, 2, 20, 2) var max_health setget set_max_health

func _ready():
	pass

func set_max_health(x):
	for child in get_children():
		child.free()
	for i in range(x/2):
		var new_heart = TextureRect.new()
		new_heart.name = str(i)
		new_heart.texture = HEART_SPRITE
		add_child(new_heart)
	max_health = x
	property_list_changed_notify()
