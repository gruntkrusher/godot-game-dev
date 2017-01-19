extends KinematicBody2D

# Class Vars
export(PackedScene) var bullet    # round used when shooting
export(PackedScene) var laser     # pellet for laser simulation
onready var bulletHolder = get_parent().get_node("BulletHolder")  # Holder object for all rounds

var velocity = Vector2(0,0)  # Velocity in X and Y
var maxVel = 30              # max magnitude of velocity
var thruster_acc = 10        # acceleration force applied by main thruster
var stablizer_acc = 5        # acceleration force applied by stabilizers

var minShootWait = 0.25      # time between cannon shots
var shoot_wait = 0           # time since last shot

var minerals = 0             # Number of minerals collected

# Class Functions

func _ready():
	set_process(true)
	set_process_input(true)
	pass
	
func _process(delta):
	
	# Look at Mouse
	var mouse_pos = get_global_mouse_pos()
	look_at(mouse_pos)
	
	# Defer to Funcions
	_movement(delta)
	_shoot(delta)
	detect_coll()

### Movement ###	
func _movement(delta):
	# Get Input from player
	if(Input.is_action_pressed("thrust")):
		var dir = Vector2( sin(get_rot()), cos(get_rot())).normalized()
		velocity += dir * thruster_acc * delta
		get_node("thrusterEffect").set_hidden(false)
	elif( velocity.length_squared() > 0):
		get_node("thrusterEffect").set_hidden(true)
		var dir = velocity.normalized()
		velocity -= dir * stablizer_acc * delta
	
	# Limit Velocity
	var mag = sqrt(velocity.x * velocity.x + velocity.y * velocity.y)
	if ( mag > maxVel):
		velocity *= maxVel / mag
	
	# Move player
	var motion = velocity
	motion = move(motion)

### Shooting ###
func _shoot(delta):
	
	# Laser Cannon
	if(Input.is_action_pressed("shoot") and shoot_wait > minShootWait):
		var clone = bullet.instance()
		# set position to muzzle position
		clone.set_global_pos(get_node("Muzzle").get_global_pos())
		# set rotation to the rotation of ship
		clone.set_rot(get_rot())
		# place in bulltetHolder
		bulletHolder.add_child(clone)
		# Reset Shoot Wait
		shoot_wait = 0
	# Mining Laser
	elif(Input.is_action_pressed("mining_laser")):
		var clone = laser.instance()
		# set position to muzzle position
		clone.set_global_pos(get_node("Muzzle").get_global_pos())
		# set rotation to the rotation of ship
		clone.set_rot(get_rot())
		# place in bulltetHolder
		bulletHolder.add_child(clone)
		# Reset Shoot Wait
		shoot_wait = 0
	else:
		shoot_wait += delta
		
	
		

### Detect Collisions ###
func detect_coll():
	
	if(is_colliding()):
		if(get_collider().get_type() == "StaticBody2D"):
			var norm
			if(get_collider().is_in_group("LR")):
				norm = Vector2( 1, 0)
			elif(get_collider().is_in_group("UL")):
				norm = Vector2( 0, 1)
				
			velocity = velocity - 2 * norm.dot(velocity) * norm
		else:
			var norm = get_pos() - get_collider().get_pos()
			norm = norm.normalized()
			velocity = velocity - 2 * norm.dot(velocity) * norm

func add_minerals(num):
	minerals += int(num)