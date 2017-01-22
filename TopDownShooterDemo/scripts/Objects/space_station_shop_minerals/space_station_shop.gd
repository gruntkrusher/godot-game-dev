extends Control

onready var player = get_tree().get_root().get_node("main").get_node("player_ship")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_minerals_button_pressed():
	if(player.get("minerals") >= 100):
		player.add_minerals( -100)
		player.add_credits( 10)


func _on_all_button_pressed():
	
	while(player.get("minerals") >= 100):
		player.add_minerals(-100)
		player.add_credits(10)
