extends Area2D

export var next_stage = ""
export var stage_number = 0
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var bodies_overlapping = get_overlapping_bodies()
	for body_overlapping in range(0,bodies_overlapping.size()):
		if bodies_overlapping[body_overlapping].get_name() == "player":
			get_node("/root/program manager/mode").next_stage = next_stage
			get_node("/root/program manager/mode").top_stage = stage_number
