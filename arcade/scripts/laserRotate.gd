extends Node2D


func _ready():
	var w = randf()
	if w > 0.5:
		get_node("LaserR").rotateDir = 1
	else:
		get_node("LaserR").rotateDir = -1	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
