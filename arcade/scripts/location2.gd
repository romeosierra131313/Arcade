extends Node2D

onready var player = load("res://scenes/Player.tscn")
onready var ene = load("res://scenes/enemy/Enemy.tscn")
onready var lr = load("res://scenes/enemy/laserRotate.tscn")
onready var espb = load("res://scenes/enemy/EnemyStraightPongBullets.tscn")
onready var b2 = load("res://scenes/enemy/EnemyBoss2.tscn")

var time = 0.0
var difficulty = 1
var pointCount = 0
var goal = 700
var boss = false
signal boss


export var lrTimer = 0.0
var lrTime = 3.0

export var espbTimer = 0.0
var espbTime = 4.0

export var eneTimer = 0.0
var eneTime = 2.0

func spawnPlayer():
	var playerCount  = 0
	for i in range(0,get_child_count()):
		if get_child(i).is_in_group("Player"):
			playerCount += 1
			break
	if playerCount == 0:
		add_child(player.instance())
		get_node("HUD").lifeRestored()
		Player.lives = 3
		get_node("HUD/GameOver").setTime(-2)
		get_node("HUD/GameOver").hide()
		
		return 1
	return 0

func destroyGameOver():
	get_node("HUD").destroyGameOver()
	pass
func setHighscore():
	get_node("HUD").setHighscore()
	pass
func setCredit():
	get_node("HUD").setCredit()
	pass


func _ready():
	
	Player.health = 5
	Player.lives = 3
	Player.difficulty = difficulty
	get_node("HUD").lifeRestored()
	add_child(player.instance())
	pass 
func _process(delta):
	time += delta
	lrTime += delta
	espbTime += delta
	eneTime += delta
	
	
	if lrTime > lrTimer	:
		var e = ene.instance()
		var r = lr.instance()
		e.add_child(r)
		add_child(e)
		lrTime = 0

	if espbTime > espbTimer	:
		add_child(espb.instance())
		espbTime = 0
	if eneTime > eneTimer	:
		add_child(ene.instance())
		eneTime = 0	
	if pointCount > goal:
		if boss == false:
			eneTimer = 30
			espbTimer = 150
			lrTimer = 250
			add_child(b2.instance())
			emit_signal("boss")
			boss = true
	pass