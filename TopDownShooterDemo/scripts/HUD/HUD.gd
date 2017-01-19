extends CanvasLayer

onready var player = get_parent().get_node("PlayerShip")

func _ready():
	set_process(true)

func _process(delta):
	
	# Calculate Speed
	var speed = player.get("velocity")
	speed = sqrt(speed.x * speed.x + speed.y * speed.y)
	var maxSpeed = player.get("maxVel")
	speed = floor(speed / maxSpeed * 100)
	
	# Display Speed
	get_node("Speed").set_text("Speed : " + str(speed) + "%")
	
	# Display Minerals
	var minerals = player.get("minerals")
	get_node("Minerals").set_text("Minerals : " + str(minerals))
