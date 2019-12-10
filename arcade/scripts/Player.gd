extends KinematicBody2D



onready var bullet = load("res://scenes/Bullet.tscn")
var speedX = 50
var speedY = 250
var time = 0.0
var bulletAccuracy = 5 ##smaller is less acuurate
var health = 5
var fallingBack = false
var spawning = false
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
	setPos(Vector2(-100,300))
	connect("pDied",get_parent().get_node("HUD"),"pDied")
	connect("lostLife",get_parent().get_node("HUD"),"lostLife")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	
	

	if Input.is_action_pressed("ui_down"):
		velocity.y = speedY
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -speedY	
	else: velocity.y = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speedX
		Player.accel = 1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speedX	
		Player.accel = -1
	else: 
		velocity.x = 0
		Player.accel = 0
	
	
	if Input.is_action_pressed("button_1"):
		Engine.time_scale = 1
		if time > 0.2:
			var b  = bullet.instance()
			b.setPos(Vector2(position.x + 11,position.y ))
			b.setVelocity(Vector2(3,0))
			b.gradiant =(randf() - randf())/bulletAccuracy
			get_parent().add_child(b)
			time = 0
		
	Player.location = position	
	if fallingBack:
		if position.x > 0:
			fallBack()
	if spawning:
		if position.x < 200:
			spawn()
	pass
	
func takeHit(e):
	print("player took hit")
	health -= e
	if health < 0:
		emit_signal("lostLife")
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
	if position.x < 32:
		position.x = 32
	if position.x > 960:
		position.x = 960
	pass
	

func _on_Node2D_boss():
	fallingBack = true
	pass # Replace with function body.
