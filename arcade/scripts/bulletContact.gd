extends Particles2D

var time = 0.0
var timer = 0.25
func _ready():
	pass # Replace with function body.

func setTimer(e):
	timer = e
	pass
func _process(delta):

	time += delta
	position.x = randi()%16+1
	if time > timer:
		queue_free()
	pass
