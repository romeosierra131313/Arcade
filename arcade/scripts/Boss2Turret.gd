extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bullet = load("res://scenes/Bullet.tscn")
onready var laser = load("res://scenes/LaserSweep.tscn")
var time = 0.0
var dirY = 0
var state = 0 
var fired = false
export var timer = 0.01 ### time between bullets
var burstTimer = 5.0 ### length of bursts
var breakTimer = 0.5 ### time between bursts
export var burstTime = 0.0 ### length of bursts
export var breakTime = 0.0 ### time between bursts
var speedX = 1
# Called when the node enters the scene tree for the first time.

func _ready():
	pass
func setPos(e):
	position.y = e
	pass
func takeHit(e):
	pass
func _process(delta):
	time += delta
	breakTimer += delta
	if state == 2:
		if fired == false:
			if get_child_count() <3:
				var l = laser.instance()
				l.setPos(Vector2(0,0))
				add_child(l)
				fired = true
			



	pass