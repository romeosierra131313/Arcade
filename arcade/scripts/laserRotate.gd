extends Node2D

var damage = 1

func _ready():
	var w = randf()
	if w > 0.5:
		get_node("LaserR").rotateDir = 1
	else:
		get_node("LaserR").rotateDir = -1	
	pass # Replace with function body.
func takeHit(e):
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
