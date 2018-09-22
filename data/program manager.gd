extends Node

var debug = false

var current_mode = "title"
var next_mode = "title"

var fadeout_active = 0

func _ready():
	if debug == true:
		pass
	else:
		OS.set_window_maximized(true)
	fadein()

func _process(delta):
	if Input.is_action_just_pressed("select"):
		if current_mode == "title":
			get_tree().quit()
		else:
			fadeout_active = 1 #skip transition
			instant_fadeout()
			next_mode = "title"
	if next_mode != current_mode:
		#free everything under program manager aside from exceptions
		
		#instant_fadeout()
		if fadeout_active > 1:
			fadeout_active += -1
		elif fadeout_active == 1:
			free_mode()
			load_next_mode()
			fadein()
			fadeout_active = 0
		else:
			fadeout()
		
	

func fadein():
	get_node("proscenium/transition player").play("fade in")
	#print("fade in triggered")

func fadeout():
	get_node("proscenium/transition player").play("fade out")
	#print("fade out triggered")
	fadeout_active = 100

func instant_fadeout():
	get_node("proscenium/curtain").set_frame_color(Color(0,0,0,255))

func load_next_mode():
	var mode_load = load("res://data/modes/"+str(next_mode)+".tscn").instance()
	add_child(mode_load)
	current_mode = next_mode


func free_mode():
	for child_counter in range(0,self.get_child_count()):
		#exceptions
		if get_child(child_counter).get_name() == "mode":
			get_child(child_counter).free()