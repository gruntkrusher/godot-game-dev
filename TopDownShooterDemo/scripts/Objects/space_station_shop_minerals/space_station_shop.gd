extends Control

onready var player = get_tree().get_root().get_node("main").get_node("player_ship")

func _ready():
	pass


func _on_minerals_button_pressed():
	if(player.get("minerals") >= 100):
		player.add_minerals( -100)
		player.add_credits( 10)

func _on_minerals_all_button_pressed():
	while(player.get("minerals") >= 100):
		player.add_minerals(-100)
		player.add_credits(10)

func _on_fuel_button_pressed():
	if(player.get("credits") >= 100 and ( player.get("fuel") < player.get("max_fuel"))):
		player.add_credits(-100)
		player.add_fuel( player.get("max_fuel") * 0.1)

func _on_fuel_all_button_pressed():
	while(player.get("credits") >= 100 and ( player.get("fuel") < player.get("max_fuel"))):
		player.add_credits(-100)
		player.add_fuel( player.get("max_fuel") * 0.1)

