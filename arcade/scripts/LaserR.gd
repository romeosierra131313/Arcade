extends Area2D

var time = 0.0
export var timer = 1.5
var enabled = true
var rotateDir = 1
var damage = 10



func _ready():

		
	pass 

func disable():
	set_collision_layer_bit(0,false)
	get_node("Sprite").hide()
	enabled = false
	pass
func enable():
	set_collision_layer_bit(0,true)
	get_node("Sprite").show()
	enabled = true
	pass
func _process(delta):
	
	time +=delta
	if time > timer:
		if enabled:
			disable()
		else:
			enable()
		time = 0
	rotate(delta/5 * rotateDir)
	
	pass