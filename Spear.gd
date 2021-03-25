extends RigidBody2D

var collisions

func _process(_delta):
	collisions = get_colliding_bodies()
	for collision in collisions:
		if collision.is_in_group("Enemy"):
			collision.delete()
			queue_free()
	if $Timer.time_left < 0.5:
		queue_free()
