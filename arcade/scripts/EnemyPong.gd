extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bullet = load("res://scenes/Bullet.tscn")
var time = 0.0
export var timer = 0.01 ### time between bullets
var burstTimer = 0.0 ### length of bursts
var breakTimer = 0.0 ### time between bursts
export var burstTime = 0.0 ### length of bursts
export var breakTime = 0.0 ### time between bursts
var health = 6
var speedX = 2
var speedY = 2
var dirY = -1
var rangeY = 100
var movement = 0

signal died
# Called when the node enters the scene tree for the first time.

func _ready():
	position = Vector2(1080,randi()%536 + 64)
	connect("died",get_parent().get_node("HUD"),"enemyDied")
	pass
func setPos(e):
	position.y = e
	pass

func _process(delta):
	time += delta
	burstTimer += delta
	breakTimer += delta

	
	
	
	if breakTimer >breakTime:	
		
		if breakTimer > breakTime:
			burstTimer = 0.0
			breakTimer = 0
		if burstTimer < burstTime:

			if time > timer:
					

				if Player.location.x - position.x !=0 :
					var b  = bullet.instance()
					b.setPos(position)
					b.setVelocity(Vector2(-3,0))
					b.setEnemy()
					var g = (Player.location.y - position.y)/ (Player.location.x - position.x)
					b.gradiant =randi()%2  * g * dirY +randf()
					get_parent().add_child(b)
					time = 0

	
	
	
	if movement <=  rangeY:
		movement +=speedY
		position.y = position.y + speedY * dirY

	elif movement > rangeY:
		movement = 0
		if dirY == -1:
			dirY = 1
		else:
			dirY = -1
	position = Vector2(position.x - speedX + Player.accel,position.y)
	
	
	
	
	if position.x < 0:
		queue_free()
	pass
func takeHit(e):
	print("enemy took hit")
	health -= e
	if health <= 0:
		
		emit_signal("died")
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
