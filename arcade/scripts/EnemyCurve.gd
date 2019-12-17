extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bullet = load("res://scenes/Fx/Bullet_green.tscn")
var time = 0.0
export var timer = 0.5
var mTime = 0.0
var mTimer = 0.1
export var health = 3
export var speedX = 10
export var speedY = 10
export var dirY = 1
var y = 35
var arcCentre = 500
var vis = false
signal ecdied
signal eDied
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("ecdied",get_parent().get_node("HUD"),"ecDied")
	connect("eDied",get_parent(),"eDied")
	arcCentre =position.x - arcCentre
	

	pass
func _process(delta):
	if vis == true:
		time += delta
		if time > timer:
				
			var b  = bullet.instance()
			b.setPos(position)
			b.setVelocity(Vector2(-10,0))
			get_parent().add_child(b)
			time = 0
		mTime += delta
		if mTime > mTimer:
			var x = 0
			if dirY == -1:
				x =	position.x + 1 
			else:
				x =	position.x - 1 	
			y = sqrt(  (arcCentre*arcCentre)  -  (x- arcCentre)*(x - arcCentre))	
	
			position = Vector2(x ,y)

	pass
func takeHit(e):
	get_node("damage").play(0.0)
	health -= e
	if health <= 0:
		get_node("4").play(0.0)
		emit_signal("ecdied")
		emit_signal("eDied")
		queue_free()
	pass


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


func _on_Enemy_area_entered(area):
	pass # Replace with function body.
