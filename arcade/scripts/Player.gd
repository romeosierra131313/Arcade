extends KinematicBody2D



onready var bullet = load("res://scenes/Bullet.tscn")
onready var rocket = load("res://scenes/rocket.tscn")
onready var laser = load("res://scenes/LaserP.tscn")

var rocketTimer = 0.0
var laserTimer = 0.0
var speedX = 150
var speedY = 450
var time = 0.0
var bulletAccuracy = 5 ##smaller is less acuurate
var health = 5
var fallingBack = false
var spawning = false
var exiting = false
var velocity = Vector2(0,0)
signal pDied
signal lostLife


func spawn():
	position.x += 1
	
	if position.x >= 190:
		health = 5
		spawning = false
		set_collision_mask_bit(0,true)
		speedX = 250
	pass
func fallBack():
	position.x -= 5
	if position.x <= 50:
		fallingBack = false
		speedX = 250
	pass
func setPos(e):
	position = e
	pass

func _ready():
	spawning = true
	setPos(Vector2(100,300))
	connect("pDied",get_parent().get_node("HUD"),"pDied")
	connect("lostLife",get_parent().get_node("HUD"),"lostLife")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	rocketTimer +=delta
	laserTimer +=delta
	position.x += Player.scrollSpeed
	


	if Input.is_action_pressed("ui_down"):
		velocity.y += 50
		if velocity.y > 450 :
			velocity.y = 450
	elif Input.is_action_pressed("ui_up"):
		velocity.y -= 50
		if velocity.y < -450 :
			velocity.y = -450
	else: velocity.y = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x = -500
		Player.accel = 1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speedX	
		Player.accel = -1
	else: 
		velocity.x = 0
		Player.accel = 0
	
	
	if Input.is_action_pressed("button_1"):
		Engine.time_scale = 1
		if time > 0.1:
			get_node("BulletSOUND").play(0.0)
			var b  = bullet.instance()
			b.setPos(Vector2(position.x + 11,position.y ))
			b.setVelocity(Vector2(16,0))
			b.gradiant =(randf() - randf())/bulletAccuracy
			get_parent().add_child(b)
			time = 0
	if Input.is_action_pressed("button_2"):	
		if rocketTimer > 1:
			get_node("ROCKET").play(0.0)
			var r  = rocket.instance()
			r.setPos(Vector2(position.x + 11,position.y ))
			r.setVelocity(Vector2(6,0))
			r.dirY = 1
			r.gradiant =(randf() - randf())/bulletAccuracy
			get_parent().add_child(r)
			
			var r1  = rocket.instance()
			r1.setPos(Vector2(position.x + 11,position.y ))
			r1.setVelocity(Vector2(6,0))
			r1.dirY = -1
			r1.gradiant =(randf() - randf())/bulletAccuracy
			get_parent().add_child(r1)
			rocketTimer = 0	
			
	if Input.is_action_just_pressed("button_3"):	
		if laserTimer > 5:
			get_node("LASER").play(0.0)		
			var l  = laser.instance()
			l.scale.y = 0.5
			l.setPos(Vector2(11,0))
			l.rotation_degrees = 180
			add_child(l)
			
			
			laserTimer = 0		
		
	Player.location = position	
	if fallingBack:
		if position.x > 0:
			fallBack()
	if spawning:
		if position.x < 200:
			spawn()
	if exiting:
		position.x += 10
	pass
	
func takeHit(e):
	print("player took hit")
	health -= e
	if health < 0:
		emit_signal("lostLife")
		get_node("DIE").play(0.0)
		Player.lives -= 1
		spawning = true
		set_collision_mask_bit(0,false)
		setPos(Vector2(-100,300))
		if Player.lives == 0:
			emit_signal("pDied")
			queue_free()
	pass
func _physics_process(delta):
	move_and_slide(velocity)
	checkbounds()
	
	pass
	
func checkbounds():
	if position.y < 64:
		position.y = 64
	if position.y > 536:
		position.y = 536
	if position.x < (get_parent().getCamera().x - 1024/2 -64 ):
		position.x = get_parent().getCamera().x - 1024/2 -64
	if position.x > (get_parent().getCamera().x + 1024/2 - 128):
		position.x = get_parent().getCamera().x + 1024/2 - 128
	pass
	

func _on_Node2D_boss():
	fallingBack = true
	pass # Replace with function body.
