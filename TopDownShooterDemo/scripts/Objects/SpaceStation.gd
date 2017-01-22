#	SpaceStation.gd
#	Author: Jacob Lindey
#	Last Change: 1/21/2017

extends KinematicBody2D
var shop_range = 500
var shop_open = false
onready var hud_obj = get_tree().get_root().get_node("main").get_node("hud_root")

func _ready():
	set_process(true)
	set_process_input(true)
	
func _process(delta):
	
	# Control Tip 
	if(player_in_range()):
		hud_obj.get_node("tip_label").set_text("Press 'E' to Shop")
	else:
		hud_obj.get_node("tip_label").set_text("")
		shop_open = false
	
	if(shop_open):
		get_node("shop_ui").set_hidden(false)
	else:
		get_node("shop_ui").set_hidden(true)
	
func _input(event):
	if(event.type == InputEvent.KEY):
		if(event.scancode == KEY_E and event.pressed == false):
			shop_open = not shop_open
	
func player_in_range():
	
	var player = get_tree().get_root().get_node("main").get_node("player_ship")
	var dist = get_pos() - player.get_pos()
	dist = sqrt(dist.x * dist.x + dist.y * dist.y)
	if(dist <= shop_range):
		return true
	else:
		return false
