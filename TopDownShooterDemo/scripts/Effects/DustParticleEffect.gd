#	DustParticleEffect.gd
#	Author: Jacob Lindey
#	Last Change: 1/21/2017

extends Node2D

# Class vars

# Dust Sprite Nodes
onready var Dust1 = get_node("Dust 1")
onready var Dust2 = get_node("Dust 2")
onready var Dust3 = get_node("Dust 3")

# Randomized Movement Dirs
var traj1 = Vector2( 2 * randf() - 1.0, 2 * randf() - 1.0).normalized()
var traj2 = Vector2( 2 * randf() - 1.0, 2 * randf() - 1.0).normalized()
var traj3 = Vector2( 2 * randf() - 1.0, 2 * randf() - 1.0).normalized()

var speed = 20	# speed of movement in traj direction
var opacityChange = 0.5 # speed of change in opacity

func _ready():
	
	set_process(true)
	
func _process(delta):
	
	if(Dust1.get_opacity() <= 0):
		queue_free()
		
	# Change Position of Dust Particles
	Dust1.set_pos(Dust1.get_pos() + traj1 * speed * delta)
	Dust2.set_pos(Dust2.get_pos() + traj2 * speed * delta)
	Dust3.set_pos(Dust3.get_pos() + traj3 * speed * delta)
	
	# Change Opacity of Dust Particles
	Dust1.set_opacity(Dust1.get_opacity() - opacityChange * delta)
	Dust2.set_opacity(Dust2.get_opacity() - opacityChange * delta)
	Dust3.set_opacity(Dust3.get_opacity() - opacityChange * delta)