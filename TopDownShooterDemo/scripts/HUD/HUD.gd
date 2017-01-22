#	HUD.gd
#	Author: Jacob Lindey
#	Last Change: 1/21/2017


extends CanvasLayer

onready var player = get_parent().get_node("player_ship")

func _ready():
	set_process(true)

func _process(delta):
	
	# Calculate Speed
	var speed = player.get("velocity")
	speed = sqrt(speed.x * speed.x + speed.y * speed.y)
	var maxSpeed = player.get("maxVel")
	speed = floor(speed / maxSpeed * 100)
	
	# Display Speed
	get_node("location_label").set_text("X : " + str(int(player.get_pos().x)/100) + "  Y : " + str(int(player.get_pos().y)/100))
	
	# Display Minerals
	var minerals = player.get("minerals")
	get_node("minerals_label").set_text("Minerals : " + str(minerals))
	
	# Display Credits
	var credits = player.get("credits")
	get_node("credits_label").set_text("Credits : " + str(credits))
