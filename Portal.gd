extends Area2D

func _process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Gilgamesh"):
			var _x = get_tree().change_scene("res://TabletOne.tscn")
