extends Area2D

var gradiant = 0
var velocity = Vector2(0,0)
var damage = 1
var distanceTravelled = 0
export var rotDir = 1
onready var EB = load("res://scenes/Fx/ExplosionBlue.tscn")

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
	distanceTravelled += 1
	rotate(delta * rotDir)

	position.x += velocity.x/5  + randi()%2
	position.y += velocity.y /5 + randi()%2
	
	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	pass # Replace with function body.

func takeHit(e):
	pass
func _on_Bullet_area_entered(area):
	if area.is_in_group("Player"):
		area.takeHit(damage)
		queue_free()
	pass # Replace with function body.


func _on_Bullet_body_entered(body):
	body.takeHit(damage)
	var eb = EB.instance()
	eb.oneShot = true
	body.add_child(eb)
	queue_free()
	pass # Replace with function body.
