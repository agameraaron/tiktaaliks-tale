extends Node2D

var game_state = ""
var top_stage = 0
var current_stage = "tutorial"
var next_stage = "tutorial"
var fadeout_active = 0
var instantly_fadeout = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	
	if game_state == "win":
		next_stage = "win"
		
		if Input.is_action_just_pressed("start"):
			game_state = ""
			get_parent().next_mode = "title"
		#play ending music
	if game_state == "lose":
		#stop music
		next_stage = "lose"
		
		if Input.is_action_just_pressed("start"):
			game_state = ""
			#get_parent().current_mode = ""
			next_stage = "stage 1"
			top_stage = 1
	
	if next_stage != current_stage:
		
		if instantly_fadeout == true:
			instant_fadeout()
			fadeout_active = 22
			instantly_fadeout = false
			
		
		if fadeout_active > 1:
			fadeout_active += -1
		elif fadeout_active <= 0:
			fadeout()
		else: # 1
			free_stage()
			load_new_stage()
			fadein()
			current_stage = next_stage
			fadeout_active = 0
		

func load_new_stage():
	var new_stage = load("res://data/stages/"+next_stage+".tscn").instance()
	add_child(new_stage)
	

func instant_fadeout():
	get_parent().get_node("proscenium/curtain").set_frame_color(Color(0,0,0,255))

func fadeout():
	fadeout_active = 100
	get_parent().get_node("proscenium/transition player").play("fade out")

func fadein():
	get_parent().get_node("proscenium/transition player").play("fade in")
	
func free_stage():
	get_node("stage").free()