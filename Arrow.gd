extends RigidBody2D

var collisions

func _process(_delta):
	collisions = get_colliding_bodies()
	for i in collisions:
		if i.is_in_group("Gilgamesh"):
			i.delete(2)
			queue_free()
	if $Timer.time_left < 0.5:
		queue_free()
