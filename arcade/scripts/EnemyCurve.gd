extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bullet = load("res://scenes/Bullet.tscn")
var time = 0.0
export var timer = 0.5
var mTime = 0.0
var mTimer = 0.2
var health = 3
var speedX = 10
var speedY = 10
var dirY = 1
var y = 35
var arcCentre = 500
signal ecdied
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("ecdied",get_parent().get_node("HUD"),"ecDied")
	arcCentre = randi()%500
	clamp(arcCentre,100,700)
	y = randi()%600
	if y < 300:
		dirY = 1
		position = Vector2(1100,y)
	else:
		dirY = -1
		position = Vector2(-80,y)
	pass
func _process(delta):
	time += delta
	if time > timer:
			
		var b  = bullet.instance()
		b.setPos(position)
		b.setVelocity(Vector2(-10,0))
		b.setEnemy()
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
	if position.x < -100  or  position.x > 1110 :
		queue_free()
	pass
func takeHit(e):
	print("enemy took hit")
	health -= e
	if health <= 0:
		emit_signal("ecdied")
		queue_free()
	pass

func _on_Enemy_area_entered(area):
	print("hit")
	#takeHit(area.damage)
	pass # Replace with function body.

