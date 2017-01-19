extends KinematicBody2D

# Class Vars
export(PackedScene) var effect

var max_health = 20.0
var curr_health
var velocity = Vector2(0,0)
onready var rotationSpeed = rand_range(-1,1)

var missile_damage_modifier = 0.25
export(PackedScene) var drop_item
var minDrops = 3
var maxDrops = 7

func _ready():
	curr_health = max_health
	set_process(true)
	
func _process(delta):
	
	# Check: Is asteroid health too high
	if curr_health > max_health :
		curr_health = max_health
		
	# Check: Is asteroid destroyed
	if curr_health <= 0 :
		_death()
	
	# Rotate Asteroid
	set_rot(get_rot() + rotationSpeed * delta)

func _on_Area2D_area_enter( area ):
	
	# Check: Is what hit asteroid a missile
	if(area.get_parent().is_in_group("Missiles")):	
		# deal damage to asteroid
		curr_health -= area.get_parent().get("damage") * missile_damage_modifier
		
		# delete the missile 
		area.get_parent().queue_free()
		
	# Spawn Dust Particle Effect at point of impact
	var clone = effect.instance()
	clone.set_global_pos(area.get_global_pos())
	get_tree().get_root().get_node("main").get_node("BulletHolder").add_child(clone);


func _on_Area2D_body_enter( body ):
	if(body != self):
		# Spawn Dust Particle Effect at point of impact
		var clone = effect.instance()
		var dist = body.get_pos() - get_pos()
		var len = sqrt(dist.x * dist.x + dist.y * dist.y)
		clone.set_global_pos(get_pos() + Vector2(110 * dist.x / len, 100 * dist.y / len))
		get_tree().get_root().get_node("main").get_node("BulletHolder").add_child(clone);

func _death():
	
	# Dust Particle Effect
	var clone = effect.instance()
	clone.set_global_pos( get_global_pos())
	get_tree().get_root().get_node("main").get_node("BulletHolder").add_child(clone)
	clone.scale( Vector2(4, 4))
		
	# Spawn Drops
	var randDrops = randi() % (maxDrops - minDrops + 1) + minDrops
	for d in range(randDrops):
		var clone = drop_item.instance()
		get_tree().get_root().get_node("main").get_node("BulletHolder").add_child(clone)
		clone.set_global_pos(get_global_pos() + Vector2( randi() % 200 - 100.0, randi() % 200 - 100.0))
	
	# destroy asteroid
	queue_free()