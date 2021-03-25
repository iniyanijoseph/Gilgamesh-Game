extends KinematicBody2D

var velocity = Vector2.ZERO
var gravity = 400
var health = 10
var speed = 100
onready var sprite = $AnimatedSprite
onready var gilagamesh = get_parent().get_node("Gilgamesh")

func animations():
	if gilagamesh.position.x > position.x:
		sprite.flip_h = false
		sprite.play("Side")
	if gilagamesh.position.x < position.x:
		sprite.flip_h = true
		sprite.play("Side")

	if gilagamesh.position.x == position.x:
		sprite.play("Straight")


func move(delta):
	velocity.y += gravity * delta
	velocity.x = 0

	if gilagamesh.position.x > position.x:
		velocity.x += speed

	elif gilagamesh.position.x < position.x:
		velocity.x -= speed

	velocity = move_and_slide(velocity, Vector2.UP)

	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("Gilgamesh"):
			collision.collider.delete(0.1)

func delete():
	health -= 3
	if health <= 0:
		queue_free()

func _process(delta):
	move(delta)
	animations()

	# Set Progress Bar
	$ProgressBar.value = health * 10
