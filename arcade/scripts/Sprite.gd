extends Sprite

var timer  = 0.25
var time = 0.0

func _ready():
	pass
func _process(delta):
	time += delta
	if time > timer:
		if frame + 1  == hframes:
			frame = 0 
		else: frame += 1
		time = 0
	
	pass
