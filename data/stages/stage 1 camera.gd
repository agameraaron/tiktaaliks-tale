extends Camera2D

export var horizontal_minumum = 160
export var horizontal_maximum = 1020

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var player_node = get_node("../sprites/player")
	
	#follow player
	if player_node.get_position().x < horizontal_minumum:
		pass
	elif player_node.get_position().x > horizontal_maximum:
		pass
	else:
		self.set_position(Vector2(player_node.get_position().x,self.get_position().y))
	
	#if horizontal_minimum < position.x and :
	
	
	