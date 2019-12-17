extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bullet = load("res://scenes/Fx/Bullet_yellow.tscn")
var time = 0.0
export var timer = 0.01 ### time between bullets
var burstTimer = 0.0 ### length of bursts
var breakTimer = 0.0 ### time between bursts
export var burstTime = 0.0 ### length of bursts
export var breakTime = 0.0 ### time between bursts
export var health = 3
export var speedX = 4
export var speedY = 4
export var dirY = -1
var vis = false
signal eadied
signal eDied
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("eadied",get_parent().get_node("HUD"),"eaDied")
	connect("eDied",get_parent(),"eDied")

	burstTime += Player.difficulty
	for i in range(0,Player.difficulty):
		breakTime -= 0.25
	pass
func _process(delta):
	if vis == true:
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
					var g = (Player.location.y - position.y)/ (Player.location.x - position.x)
					b.gradiant =randi()%1  * g * dirY + randf()
					get_parent().add_child(b)
					time = 0
	
				
		position = Vector2(position.x - speedX + Player.accel,position.y  + speedY * dirY)
		if position.x < 0:
			queue_free()
	pass
func takeHit(e):
	get_node("damage").play(0.0)
	health -= e
	if health <= 0:
		get_node("3").play(0.0)
		emit_signal("eadied")
		emit_signal("eDied")
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
