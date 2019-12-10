extends Area2D


var health = 3
var speedX = 1
func _ready():
	position = Vector2(1080,randi()%536 + 64)
	pass
func setPos(e):
	position.y = e
	pass

func _process(delta):
			
	position = Vector2(position.x - speedX,position.y)
	if position.x < 0:
		queue_free()
	pass
func takeHit(e):
	print("enemy took hit")
	health -= e
	if health <= 0:
		queue_free()
	pass

func _on_Enemy_area_entered(area):
	print("hit")
	#takeHit(area.damage)
	pass # Replace with function body.

