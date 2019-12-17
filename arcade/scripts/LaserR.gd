extends Area2D

var time = 0.0
export var timer = 1.5
var enabled = true
var rotateDir = 1
var damage = 10



func _ready():

		
	pass 

func disable():
	set_collision_layer_bit(1,false)
	set_collision_mask_bit(0,false)
	enabled = false
	pass
func enable():
	set_collision_layer_bit(1,true)
	set_collision_mask_bit(0,true)
	enabled = true
	pass
