extends Area2D


onready var bullet = load("res://scenes/BulletRotating.tscn")
var time = 0.0
export var timer = 0.01 ### time between bullets
var burstTimer = 0.0 ### length of bursts
var breakTimer = 0.0 ### time between bursts
export var burstTime = 0.0 ### length of bursts
export var breakTime = 0.0 ### time between bursts
export var health = 15
export var speedX = 1
export var rotDir = 1
var g  = 1
var x = 0
var y = 0
var bullets  =0
var vis = false
# Called when the node enters the scene tree for the first time.

func _ready():
	pass
func setPos(e):
	position.y = e
	pass

func _process(delta):
	rotate(delta * rotDir)
	if vis == true:
		time += delta
		burstTimer += delta
		breakTimer += delta
	
	
		if burstTimer < burstTime:
	
			if time > timer:
				match bullets:
					0:	
						var b  = bullet.instance()
						b.setPos(position)
						b.setEnemy()
						b.setVelocity(Vector2(0,5))	
						get_parent().add_child(b)
					
					1:
						var b4  = bullet.instance()
						b4.setPos(position)
						b4.setEnemy()
						b4.setVelocity(Vector2(3.5,3.5))	
						get_parent().add_child(b4)
					2:
						var b1  = bullet.instance()
						b1.setPos(position)
						b1.setEnemy()
						b1.setVelocity(Vector2(-5,0))	
						get_parent().add_child(b1)
					3:
						var b5  = bullet.instance()
						b5.setPos(position)
						b5.setEnemy()
						b5.setVelocity(Vector2(-3.5,3.5))	
						get_parent().add_child(b5)
					4:
						var b2  = bullet.instance()
						b2.setPos(position)
						b2.setEnemy()
						b2.setVelocity(Vector2(0,-5))	
						get_parent().add_child(b2)
					
					5:
						var b6  = bullet.instance()
						b6.setPos(position)
						b6.setEnemy()
						b6.setVelocity(Vector2(-3.5,-3.5))	
						get_parent().add_child(b6)
					6:
						var b3  = bullet.instance()
						b3.setPos(position)
						b3.setEnemy()
						b3.setVelocity(Vector2(5,0))	
						get_parent().add_child(b3)
					7:
						var b7  = bullet.instance()
						b7.setPos(position)
						b7.setEnemy()
						b7.setVelocity(Vector2(3.5,-3.5))	
						get_parent().add_child(b7)
					
				
				if bullets == 8:
					bullets = 0
				breakTimer = 0
				bullets +=1
				time = 0
		
		elif burstTimer > burstTime:	
			
			if breakTimer > breakTime:
				burstTimer = 0.0
				breakTimer = 0
				bullets = 0
	
				
		#position = Vector2(position.x - speedX,position.y)
		if position.x < 0:
			queue_free()
	pass
func takeHit(e):
	get_node("damage").play(0.0)
	health -= e
	if health <= 0:
		get_node("3").play(0.0)
		queue_free()
	pass

func _on_Enemy_area_entered(area):
	print("hit")
	#takeHit(area.damage)
	pass # Replace with function body.



func _on_EnemyGunRotating_body_entered(body):
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

