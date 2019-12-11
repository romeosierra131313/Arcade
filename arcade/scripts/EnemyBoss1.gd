extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bullet = load("res://scenes/Bullet.tscn")
onready var explosion = load("res://scenes/bulletContactHAF.tscn")
var time = 0.0
export var timer = 0.01 ### time between bullets
var burstTimer = 0.0 ### length of bursts
var breakTimer = 0.0 ### time between bursts
export var burstTime = 0.0 ### length of bursts
export var breakTime = 0.0 ### time between bursts
var health =150
var speedX = 1
var speedY = 1
var dirX = 1
var dirY = -1
signal boss1Died
# Called when the node enters the scene tree for the first time.

func _ready():
	connect("boss1Died",get_parent().get_node("HUD"),"boss1Died")
	position = Vector2(1100,randi()%536 + 64)
	pass
func setPos(e):
	position.y = e
	pass

func _process(delta):
	time += delta
	burstTimer += delta
	breakTimer += delta

	if breakTimer >breakTime:	
		
		if breakTimer > burstTime:
			burstTimer = 0.0
			breakTimer = 0
		if burstTimer < burstTime:

			if time > timer:
					
				var b  = bullet.instance()
				b.setPos(position)
				b.setVelocity(Vector2(-3,0))
				b.setEnemy()
				var g = (Player.location.y - position.y)/ (Player.location.x - position.x)
				b.gradiant =randi()%4  * g + randf()
				get_parent().add_child(b)
				time = 0

	var x = 0
	var y = 0
	if dirX == 1:
		x = position.x -speedX		
	else: x = position.x  + speedX	
	if dirY == 1:
		y = position.y -speedY		
	else: y = position.y  + speedY
	
	if position.x < 900:
		dirX = -1
	elif position.x > 1000:
		dirX  = 1
	if position.y < 200:
		dirY = -1
	elif position.y > 400:
		dirY  = 1	
	
		
	position = Vector2(x,y)
	if position.x < 0:
		queue_free()
	pass
func takeHit(e):
	health -= e
	if health < 75:
		burstTime = 4
		breakTime = 0.5
		timer = 0.2
	if health <= 0:
		emit_signal("boss1Died")
		queue_free()
	pass



func _on_Area2D_area_entered(area):
	add_child(explosion.instance())
	takeHit(area.damage)
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.health = 0
	pass # Replace with function body.
