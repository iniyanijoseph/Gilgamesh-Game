extends KinematicBody2D

var health = 10

func delete():
	health -= 3
	if health <= 0:
		queue_free()

func _process(_delta):
	$ProgressBar.value = health * 10
