extends Node2D

var speed = 20
var velocity = Vector2(0,0)
var damage = 5

func _ready():
	add_to_group("Missiles")
	set_process(true)
	
func _process(delta):
	
	velocity = Vector2( sin(get_rot()), cos(get_rot())).normalized() * speed
	
	var motion = velocity
	motion = move(motion)

func _on_Area2D_body_enter( body ):
	
	if(body.get_name() != "PlayerShip"):
		queue_free()
		