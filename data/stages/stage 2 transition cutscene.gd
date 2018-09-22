extends Node2D

var timer = 180

func _ready():
	pass

func _process(delta):
	if timer > 0:
		timer += -1
	else:
		get_parent().next_stage = "stage 2"
