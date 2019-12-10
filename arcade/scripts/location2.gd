extends Node2D

onready var player = load("res://scenes/Player.tscn")
onready var ene = load("res://scenes/enemy/Enemy.tscn")
onready var lr = load("res://scenes/enemy/laserRotate.tscn")
onready var espb = load("res://scenes/enemy/EnemyStraightPongBullets.tscn")

var time = 0.0
var difficulty = 1
var goal = 700
var boss = false
signal boss


export var lrTimer = 0.0
var lrTime = 3.0

export var espbTimer = 0.0
var espbTime = 4.0

export var eaTimer = 0.0
var eaTime = 4.0

export var ecTimer = 0.0
var ecTime = 2.0

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
	add_child(player.instance())
	Player.difficulty = difficulty
	pass 
func _process(delta):
	time += delta
	lrTime += delta
	espbTime += delta
	eaTime += delta
	ecTime += delta
	
	
	if lrTime > lrTimer	:
		
		var e = ene.instance()
		var r = lr.instance()
		e.add_child(r)
		add_child(e)
		lrTime = 0
	if eaTime > eaTimer	:
		eaTime = 0
	if ecTime > ecTimer	:
		ecTime = 0
	if espbTime > espbTimer	:
		add_child(espb.instance())
		espbTime = 0
		
	if Player.location.x > goal:
		if boss == false:

			#add_child(eb1.instance())
			emit_signal("boss")
			boss = true
	pass