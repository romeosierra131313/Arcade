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
var health = 3
var speedX = 1
var speedY = 1
var dirY = -1
signal eadied
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("eadied",get_parent().get_node("HUD"),"eaDied")
	var y = randi()%630
	if y < 300:
		dirY = 1
	else:
		dirY = -1
	
	position = Vector2(1080,y)
	burstTime += Player.difficulty
	for i in range(0,Player.difficulty):
		breakTime -= 0.25
	pass
func _process(delta):
	time += delta
	burstTimer += delta
	breakTimer += delta

	
	
	
	if breakTimer >breakTime:	
		
		if breakTimer > breakTimer+burstTimer:
			burstTimer = 0.0
			breakTimer = 0
		if burstTimer < burstTime:

			if time > timer:
					
				var b  = bullet.instance()
				b.setPos(position)
				b.setVelocity(Vector2(-3,0))
				b.setEnemy()
				var g = (Player.location.y - position.y)/ (Player.location.x - position.x)
				b.gradiant =randi()%1  * g * dirY + randf()
				get_parent().add_child(b)
				time = 0

			
	position = Vector2(position.x - speedX + Player.accel,position.y  + speedY * dirY)
	if position.x < 0:
		queue_free()
	pass
func takeHit(e):
	health -= e
	if health <= 0:
		queue_free()
	pass

func _on_Enemy_area_entered(area):
	print("hit")
	#takeHit(area.damage)
	pass # Replace with function body.

