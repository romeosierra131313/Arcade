extends Area2D

signal enedied
var health = 3
var speedX = 1
func _ready():
	connect("enedied",get_parent().get_node("HUD"),"eneenemyDied")
	position = Vector2(1080,randi()%536 + 64)
	pass
func setPos(e):
	position.y = e
	pass
func setHealth(e):
	health = e
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
		emit_signal("enedied")
		queue_free()
	pass

func _on_Enemy_area_entered(area):
	print("hit")
	#takeHit(area.damage)
	pass # Replace with function body.



func _on_Enemy_body_entered(body):
	if body.is_in_group("Player"):
		body.health = 0
	pass # Replace with function body.
