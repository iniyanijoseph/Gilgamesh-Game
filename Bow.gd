extends Sprite

onready var gilgamesh = get_parent().get_parent().get_node("Gilgamesh")
onready var timer = get_parent().get_node("Timer")
onready var arrow = preload("res://Arrow.tscn")
var health = 10

func shoot(_delta):
	if timer.time_left <= 0.05 and abs(position.x - gilgamesh.position.x) < 500:
		var arrownode
		arrownode = arrow.instance()
		arrownode.position = get_parent().position
		arrownode.apply_impulse(Vector2.ZERO, gilgamesh.position - get_parent().position)
		arrownode.rotation = get_angle_to(gilgamesh.position) * 4 * PI
		get_parent().get_parent().add_child(arrownode)
		timer.start()


func _process(delta):
	shoot(delta)
	look_at(gilgamesh.position)
