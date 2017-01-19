extends Node2D

export(PackedScene) var asteroid_prefab
var num_asteroids = 250

func _ready():
	randomize()
	
	for a in range(num_asteroids):
		var clone = asteroid_prefab.instance()
		clone.set_global_pos( Vector2( randi() % 19200, randi() % 10800))
		get_node("BulletHolder").add_child(clone)
	
	pass
