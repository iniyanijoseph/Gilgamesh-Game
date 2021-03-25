extends KinematicBody2D

var velocity = Vector2.ZERO
var jumpforce = 300
var gravity = 400
var speed = 300
var jump = false
var spear = preload("res://Spear.tscn")
var health = 10
onready var sprite = $AnimatedSprite

func animations():
	if Input.is_action_pressed("Right"):
		if jump:
			sprite.play("Side")
		sprite.flip_h = false
	elif Input.is_action_pressed("Left"):
		if jump:
			sprite.play("Side")
		sprite.flip_h = true
	else:
		sprite.play("Straight")
	if Input.is_action_pressed("Jump") and not is_on_floor():
		sprite.play("Jump")

func move(delta):
	if Input.is_action_pressed("Right"):
		velocity.x = speed
	elif Input.is_action_pressed("Left"):
		velocity.x = -speed
	else:
		velocity.x = 0

	if Input.is_action_pressed("Jump") and jump:
		velocity.y = -jumpforce

	velocity = move_and_slide(velocity, Vector2.UP)

	if is_on_floor():
		jump = true
	else:
		jump = false

	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += gravity * delta

func delete(num):
	health -= num

	if health <= 0:
		var _x = get_tree().reload_current_scene()


func attack():
	var spearnode
	var startpos = Vector2.ZERO
	if Input.is_action_just_pressed("Throw"):
		startpos = get_local_mouse_position()
	if Input.is_action_just_released("Throw"):
		spearnode = spear.instance()
		spearnode.position = position
		spearnode.apply_impulse(position, get_local_mouse_position() - startpos)
		spearnode.rotation = get_angle_to(get_local_mouse_position()*4*PI)
		get_parent().add_child(spearnode)

func _process(delta):
	move(delta)
	animations()
	attack()

	#Reset Scene On KeyPress
	if Input.is_action_just_pressed("Reload"):
		var _x = get_tree().reload_current_scene()

	$ProgressBar.value = health * 10


