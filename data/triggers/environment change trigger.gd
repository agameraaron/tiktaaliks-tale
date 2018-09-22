extends Area2D

export var environment_type = ""

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	for overlapping_body in range(0,get_overlapping_bodies().size()):
		if overlapping_bodies[overlapping_body].get_name() == "player":
			if overlapping_bodies[overlapping_body].environment_state == environment_type:
				pass
			else:
				overlapping_bodies[overlapping_body].environment_state = environment_type
				#if environment_type == "water":
				#overlapping_bodies[overlapping_body].command_velocity = Vector2(0,0)
				overlapping_bodies[overlapping_body].physics_velocity = Vector2(0,0)
