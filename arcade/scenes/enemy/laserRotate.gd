extends Area2D

export var health = 25
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


func takeHit(e):
	print("enemy took hit")
	health -= e
	if health <= 0:
		emit_signal("eDied")
		emit_signal("esdied")
		queue_free()
	pass

func _on_LR_area_entered(area):
	pass # Replace with function body.


func _on_LR_body_entered(body):
	if body.is_in_group("Player"):
		body.takeHit(20)
	pass # Replace with function body.
