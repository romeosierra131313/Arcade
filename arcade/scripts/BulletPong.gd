extends Area2D

var gradiant = 0
var velocity = Vector2(0,0)
var damage = 1
var health = 3
var speedX = 4
var speedY = 1
var dirY = -1
var rangeY = 20
var movement = 0
onready var explosion = load("res://scenes/bulletContact.tscn")
onready var explosionAnim = load("res://scenes/Fx/Explosion.tscn")

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
	if movement <=  rangeY:
		movement +=speedY
		position.y = position.y + speedY * dirY

	elif movement > rangeY:
		movement = 0
		if dirY == -1:
			dirY = 1
		else:
			dirY = -1
	
	position.x += velocity.x
	position.y += velocity.y + gradiant

	
	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	pass # Replace with function body.

func takeHit(e):
	
	pass
func _on_Bullet_area_entered(area):
	if area.is_in_group("Enemy"):
		area.takeHit(damage)
		queue_free()
	elif area.is_in_group("Player"):
		queue_free()
	pass # Replace with function body.


func _on_Bullet_body_entered(body):
	body.takeHit(damage)
	body.add_child(explosion.instance())
	var exAnim  = explosionAnim.instance()
	exAnim.position = position
	get_parent().add_child(exAnim)
	queue_free()
	pass # Replace with function body.
