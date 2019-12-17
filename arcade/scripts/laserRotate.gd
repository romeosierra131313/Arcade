extends Node2D

var damage = 15
export var rotDir  =  1
func _ready():

	pass # Replace with function body.

func _on_LaserR_body_entered(body):
	body.takeHit(damage)
	pass # Replace with function body.


func _on_LaserR2_body_entered(body):
	body.takeHit(damage)
	pass # Replace with function body.
func _process(delta):
	rotate(delta/5 *rotDir)
	
	pass