extends KinematicBody2D

export(int) var bouncepointa
var bouncepointb = position.x
var velocity = Vector2(2, 0)
var health = 10
var collisions
onready var spike = preload("res://Spike.tscn")

func delete():
	health -= 3
	if health <= 0:
		queue_free()

func _process(_delta):
	$ProgressBar.value = health * 10

	if position.x <= bouncepointb or position.x >= bouncepointa or collisions:
		velocity.x *= -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h

	collisions = move_and_collide(velocity)

	if $Timer.time_left < 2.5:
		$Timer.start()
		var spikenode = spike.instance()
		spikenode.position = position
		get_parent().add_child(spikenode)

