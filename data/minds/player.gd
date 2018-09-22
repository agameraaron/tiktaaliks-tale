extends KinematicBody2D


var land_gravity = 120
var land_gravity_cap = 160
var horizontal_walk_speed = 80
var water_gravity = 8.5
var water_gravity_cap = 10
var horizontal_swim_speed = 95
var vertical_swim_speed = 110
var jump_force = 290


var environment_state = "land"
var physics_velocity = Vector2(0,0)
var command_velocity = Vector2(0,0)


var descent_force = 6
var jump_available = 0
var jump_initiated = 0
var jump_time_available = 0
var jump_time_max = 30
var jump_descending = 1
var jump_cooldown = 0
var jump_cooldown_max = 46

var health = 1
var invincibility_time = 0


#func _ready():
	#pass



func _input(event):
	pass
	
func _process(delta):
	
	#print(jump_initiated)
	
	if invincibility_time > 0:
		invincibility_time += -1
	
	
	if health <= 0 and get_node("/root/program manager/mode").game_state != "lose":
		get_node("/root/program manager/mode").game_state = "lose"
		get_node("/root/program manager/mode").instantly_fadeout = true
		
		get_node("sound player").set_stream(load("res://assets/sounds/big hurts.wav"))
		get_node("sound player").play()
	#command_velocity = Vector2(0,0)
	if environment_state == "land":
		
		
		if is_on_floor():
			jump_available = 1
			jump_descending = 0
			jump_initiated = 0
		
		if jump_initiated > 0:
			jump_initiated += -1
			#for AI observance of player jumping
			
		if jump_descending and command_velocity.y < 0:
			command_velocity.y += descent_force
			#print("descending: "+str(command_velocity.y))
		
		if jump_available == 1:
			#if command_velocity.y < 0: #still going upwards, more rapidly descend
				#command_velocity.y += 0.1
			if Input.is_action_pressed("cross") and jump_time_available >= 0 and jump_descending == 0: #swim/jump
				jump_initiated = 4
				command_velocity.y = -jump_force
				#jump_cooldown = jump_cooldown_max
				jump_time_available += -1
			else:
				jump_available = 0
				jump_descending = 1
				jump_time_available = jump_time_max
		
		if Input.is_action_pressed("left"):
			command_velocity.x = -horizontal_walk_speed
			get_node("sprite").set_flip_h(true)
			if $"animator".get_current_animation() != "walk":
				$"animator".play("walk")
		elif Input.is_action_pressed("right"):
			command_velocity.x = horizontal_walk_speed
			get_node("sprite").set_flip_h(false)
			if $"animator".get_current_animation() != "walk":
				$"animator".play("walk")
		else:
			command_velocity.x = 0
			if $"animator".get_current_animation() != "walk idle":
				$"animator".play("walk idle")
		
		if physics_velocity.y < land_gravity_cap: #gravity
			physics_velocity.y += land_gravity * delta
	
	elif environment_state == "water":
		
		if $"animator".get_current_animation() != "swim":
			$"animator".play("swim")
		
	#velocity.x = 0
		if Input.is_action_pressed("up"):
			command_velocity.y = -vertical_swim_speed
		elif Input.is_action_pressed("down"):
			command_velocity.y = vertical_swim_speed+10
		else:
			command_velocity.y = 0
		if Input.is_action_pressed("left"):
			command_velocity.x = -horizontal_swim_speed
		elif Input.is_action_pressed("right"):
			command_velocity.x = horizontal_swim_speed
		else:
			command_velocity.x = 0
		#reset momentum
		#velocity.x = 0
		
		if physics_velocity.y < water_gravity_cap: #gravity
			physics_velocity.y += water_gravity * delta
	
	#print(velocity.y)
	var total_velocity = move_and_slide(physics_velocity+command_velocity,Vector2(0,-1))#.set_position(Vector2(get_position().x,get_position().y + gravity))