extends KinematicBody2D

export var leftward_force = 15

const gravity = 120
var land_gravity_cap = 140
const jump_force = 200
var jumping = false
var jump_time = 0
var jump_time_max = 120
var player_seen = false
var command_velocity_deceleration = 0
var command_velocity = Vector2()
var physics_velocity = Vector2()


func _ready():
	pass

func _process(delta):
	
	#reset physics
	#physics_velocity = Vector2(0,0)
	
	damage()
	if jumping == true:
		jumping()
	
	var overlapping_bodies = get_node("sight").get_overlapping_bodies()
	for overlapping_body in range(0,overlapping_bodies.size()):
		if overlapping_bodies[overlapping_body].get_name() == "player":
			player_seen = true
			var player_body = overlapping_bodies[overlapping_body]
			if player_body.jump_initiated > 0: #player is jumping while in range, initialize jump
				if jumping != true:
					jump()
					
	
	if player_seen == true:
		#move left
		command_velocity.x = -leftward_force
		print("physics velocity.y: "+str(physics_velocity.y))
		print("command velocity.y: "+str(command_velocity.y))
	#gravity
	if physics_velocity.y < land_gravity_cap:
		physics_velocity.y += gravity * delta
	
	
	
	move_and_slide(command_velocity+physics_velocity,Vector2(0,-1))
	

func damage():
	var overlapping_bodies = get_node("hurt collider").get_overlapping_bodies()
	for overlapping_body in range(0,overlapping_bodies.size()):
		if overlapping_bodies[overlapping_body].get_name() == "player" and overlapping_bodies[overlapping_body].invincibility_time <= 0:
			overlapping_bodies[overlapping_body].health += -1
			overlapping_bodies[overlapping_body].invincibility_time = 90

func jump():
	print("jump!")
	jumping = true
	jump_time = jump_time_max

func jumping():
	
	#print("currently jumping...")
	if jump_time < jump_time_max -10: #able to test if on floor again
		if is_on_floor():
			print("reached floor")
			jumping = false
			command_velocity_deceleration = 0
			command_velocity.y = 0
	elif jump_time > 0: #decrease jump time
		jump_time += -1
		command_velocity.y = -jump_force
		#command_velocity_deceleration += gravity #increase deceleration
		#command_velocity.y += command_velocity_deceleration
	
	
	command_velocity_deceleration += 0.01 #increase deceleration
	command_velocity.y += command_velocity_deceleration
		
		
		
		
		