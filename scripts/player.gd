extends CharacterBody2D

@export var initial_velocity := Vector2(120, 10)
@export var max_collisions := 6

var collision_count := 0

func _ready():
	velocity = initial_velocity
	
func _physics_process(delta):
	collision_count = 0
	var collision = move_and_collide(velocity * delta)
	
	while (collision and collision_count < max_collisions):
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		var remainder = collision.get_remainder()
		velocity = velocity.bounce(normal)
		remainder = remainder.bounce(normal)
		collision_count += 1
		collision = move_and_collide(remainder)
		
		set_global_rotation(remainder.angle())
	
