extends Area2D

var gradiant = 0
var velocity = Vector2(0,0)
var damage = 1
onready var explosion = load("res://scenes/bulletContact.tscn")

func setPos(e):
	position = e
	pass
func setVelocity(e):
	velocity = e
	pass
func _ready():
	
	pass 
func setEnemy():
	set_collision_layer_bit(0,false)
	set_collision_layer_bit(1,true)
	set_collision_mask_bit(0,true)
	set_collision_mask_bit(1,false)
	get_node("Sprite").flip_h = false
	add_to_group("Enemy")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	position.x += velocity.x 
	position.y += velocity.y + gradiant
	
	if position.x < 0 :
		queue_free()
	
	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	pass # Replace with function body.


func _on_Bullet_area_entered(area):
	if area.is_in_group("Enemy"):
		area.takeHit(damage)
		area.add_child(explosion.instance())
		queue_free()
	pass # Replace with function body.


func _on_Bullet_body_entered(body):
	body.takeHit(damage)
	body.add_child(explosion.instance())
	pass # Replace with function body.
