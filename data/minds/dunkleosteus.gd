extends KinematicBody2D

var activate = false
var sine_reverse = true
var sine_value = 0
var command_velocity = Vector2(0,0)
var sine_velocity = Vector2(0,0)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	sine_value = randi()%2
	sine_reverse = randi()%2
	
	

func _process(delta):
	
	damage()
	
	var bodies_seen = get_node("sight").get_overlapping_bodies()
	for overlapping_body in range(0,bodies_seen.size()):
		if bodies_seen[overlapping_body].get_name() == "player":
			activate = true
	
	if activate == true:
		
		sine_value += -0.018
		
		
		command_velocity.x = -20
		sine_velocity.y = ((sin(sine_value)*55)+100)
		
		#print(sine_value)
		move_and_slide(command_velocity)
		
		set_position(Vector2(get_position().x,sine_velocity.y))


func damage():
	var overlapping_bodies = get_node("hurt collider").get_overlapping_bodies()
	for overlapping_body in range(0,overlapping_bodies.size()):
		if overlapping_bodies[overlapping_body].get_name() == "player" and overlapping_bodies[overlapping_body].invincibility_time <= 0:
			overlapping_bodies[overlapping_body].health += -1
			overlapping_bodies[overlapping_body].invincibility_time = 90