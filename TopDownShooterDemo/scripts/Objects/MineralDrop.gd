extends Node2D

var min_minerals = 10
var max_minerals = 50

func _ready():
	pass



func _on_PickupArea_body_enter( body ):
	if(body.get_name() == "PlayerShip"):
		body.add_minerals(randi() % (max_minerals- min_minerals + 1) + min_minerals)
		queue_free()
