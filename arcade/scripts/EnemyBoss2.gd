extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bullet = load("res://scenes/Fx/Bullet_red.tscn")
onready var laser = load("res://scenes/Laser.tscn")
onready var ex = load("res://scenes/Fx/ExplosionBlue.tscn")
export var bulletSpeed = -5
var posInit = Vector2(0,0)
var time = 0.0
export var timer = 0.01 ### time between bullets
var burstTimer = 0.0 ### length of bursts
var breakTimer = 0.0 ### time between bursts
export var burstTime = 0.0 ### length of bursts
export var breakTime = 0.0 ### time between bursts
var health =300
var speedX = 1
var speedY = 1
var dirX = 1
var dirY = -1
var state = "1"
var lasers = 0
var death = false
var vis = false
signal boss2Died
# Called when the node enters the scene tree for the first time.

func _ready():
	connect("boss2Died",get_parent().get_node("HUD"),"boss2Died")
	posInit = position
	pass
func setPos(e):
	position.y = e
	pass

func _process(delta):
	if vis == true:
		if death == false:
			time += delta
			burstTimer += delta
			breakTimer += delta
		
			
			
			if state == "1":	
				if breakTimer >breakTime:	
					
					if breakTimer > burstTime:
						burstTimer = 0.0
						breakTimer = 0
					if burstTimer < burstTime:
						if time > timer:
								
							var b  = bullet.instance()
							b.setPos(Vector2(position.x , position.y + get_node("Boss2Turret").position.y))
							b.setVelocity(Vector2(bulletSpeed,0))
							var g = (Player.location.y - position.y)/ (Player.location.x - position.x)
							b.gradiant =randi()%4  * g + randf()
							get_parent().add_child(b)
							time = 0
							
							
							var b1  = bullet.instance()
							b1.setPos(Vector2(position.x , position.y + get_node("Boss2Turret2").position.y))
							b1.setVelocity(Vector2(bulletSpeed,0))
							var g1 = (Player.location.y - position.y)/ (Player.location.x - position.x)
							b1.gradiant =randi()%4  * g + randf()
							get_parent().add_child(b1)
							time = 0
							
							
							
			elif state == "2":
				if breakTimer >breakTime:	
					
					if breakTimer > burstTime:
						burstTimer = 0.0
						breakTimer = 0
						lasers = 0
						get_node("Boss2Turret").fired = false
						get_node("Boss2Turret2").fired = false
		
				
				
				else:
					if lasers < 1:
						var l = laser.instance()
						lasers += 1
						add_child(l)
					
					
					
					
			var x = 0
			var y = 0
			if dirX == 1:
				x = position.x -speedX		
			else: x = position.x  + speedX	
			if dirY == 1:
				y = position.y -speedY		
			else: y = position.y  + speedY
			
			if position.x < posInit.x -200:
				dirX = -1
			elif position.x > posInit.x -100:
				dirX  = 1
			if position.y < 200:
				dirY = -1
			elif position.y > 400:
				dirY  = 1	
			
				
			position = Vector2(x,y)
			
			
		else:
			time += delta
			position = Vector2(position.x +randi()%5+1,position.y +randi()%5+1)	
			var exB = ex.instance()
			exB.position = Vector2(randi()%200+1,randi()%200+1)	
			add_child(exB)
			if time > 10:
				queue_free()
	pass
func takeHit(e):
	get_node("damage").play(0.0)
	health -= e
	print(health)
	if health < 100:
		state = "2"
		breakTime = 10
		get_node("Boss2Turret").state = 2
		get_node("Boss2Turret").dirY = 1
		get_node("Boss2Turret2").state = 2
		get_node("Boss2Turret2").dirY = -1
	if health <= 0:
		death = true
		health = 100000
		get_node("1").play(0.0)
		emit_signal("boss2Died")
		print("winner winner")
		
	pass





func _on_Boss2_body_entered(body):
	if body.is_in_group("Player"):
		body.takeHit(20)
	pass # Replace with function body.


func _on_Boss2_area_entered(area):
	if area.is_in_group("Player"):
		takeHit(area.damage)
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_entered():
	print("screen entered")
	position.x -= 20
	Player.scrollSpeed = 0
	get_parent().scrollSpeed = 0
	vis = true
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	print("screen exited")
	#queue_free()
	pass # Replace with function body.
