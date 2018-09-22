extends Node2D

var transition_triggered = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_pressed("start") and transition_triggered == false:
		transition_triggered = true
		get_parent().next_stage = "stage 1"