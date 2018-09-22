extends Node2D

var input_disabled = false

func _ready():
	get_node("begin label/begin flashing animation").play("begin")
	get_node("version label").set_text("version 0.1 alpha\n\"Competition Submission\"")

func _process(delta):
	
	if Input.is_action_just_pressed("start") and input_disabled == false:
		get_parent().next_mode = "game"
		get_node("menu sounds").set_stream(load("res://assets/sounds/confirmdialogue2.wav"))
		get_node("menu sounds").play()
		input_disabled = true
	
	
	if get_node("begin label/begin flashing animation").get_current_animation() == "begin":
		pass
		#if get_node("begin label/begin flashing animation").is_playing():
		#print("still playing at frame: "+str(get_node("begin label/begin flashing animation").get_current_animation_position()))
	elif get_node("begin label/begin flashing animation").get_current_animation() == "begin loop":
		pass
	else:
		#print("triggered flashing animation loop")
		get_node("begin label/begin flashing animation").play("begin loop")
