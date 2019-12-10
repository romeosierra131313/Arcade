extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var damage  = 100
var time = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimationPlayer").current_animation = "Fire"

	pass # Replace with function body.
func setPos(e):
	
	position = e
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time+=delta	

	if time > 0.5:
		rotation_degrees += (get_parent().dirY * -1)
		time = 0
	pass

func takeHit(e):
	
	pass
func _on_Laser_body_entered(body):
	body.takeHit(damage)
	queue_free()
	pass # Replace with function body.
