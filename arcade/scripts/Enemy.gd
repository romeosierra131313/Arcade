extends Area2D

signal enedied
export var health = 1
var speedX = 1
var vis = false


func _ready():
	connect("enedied",get_parent().get_node("HUD"),"eneenemyDied")

	pass
func setPos(e):
	position.y = e
	pass
func setHealth(e):
	health = e
	pass
func _process(delta):
	if vis == true:		
		position = Vector2(position.x - speedX,position.y)
		if position.x < 0:
			queue_free()
	pass
func takeHit(e):
	get_node("damage").play(0.0)
	print("enemy took hit")
	health -= e
	if health <= 0:
		get_node("4").play(0.0)
		emit_signal("enedied")
		queue_free()
	pass

func _on_Enemy_area_entered(area):
	print("hit")
	#takeHit(area.damage)
	pass # Replace with function body.



func _on_Enemy_body_entered(body):
	if body.is_in_group("Player"):
		body.takeHit(20)
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_entered():
	print("screen entered")
	vis = true
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	print("screen exited")
	queue_free()
	pass # Replace with function body.
