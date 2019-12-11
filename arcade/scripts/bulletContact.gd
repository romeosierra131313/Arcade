extends Particles2D

var time = 0.0
func _ready():
	pass # Replace with function body.


func _process(delta):

	time += delta
	position.x = randi()%16+1
	if time > 0.25:
		queue_free()
	pass
