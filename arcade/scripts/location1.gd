extends Node2D

onready var player = load("res://scenes/Player.tscn")

onready var ec = load("res://scenes/enemy/EnemyCurve.tscn")
onready var ea = load("res://scenes/enemy/EnemyAngle.tscn")
onready var es = load("res://scenes/enemy/EnemyStraight.tscn")
onready var ep = load("res://scenes/enemy/EnemyPong.tscn")
onready var eb1 = load("res://scenes/enemy/EnemyBoss1.tscn")

var pointCount = 0
var time = 0.0
var difficulty = 1
var goal = 40
var boss = false
signal boss
export var epTimer = 0.0
var epTime = 3.0

export var esTimer = 0.0
var esTime = 4.0

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
	Player.health = 5
	Player.lives = 3
	Player.difficulty = difficulty
	get_node("HUD").lifeRestored()
	add_child(player.instance())
	pass 
func _process(delta):
	time += delta
	epTime += delta
	esTime += delta
	eaTime += delta
	ecTime += delta
	
	
	if epTime > epTimer	:
		add_child(ep.instance())
		epTime = 0
	if eaTime > eaTimer	:
		add_child(ea.instance())
		eaTime = 0
	if ecTime > ecTimer	:
		add_child(ec.instance())
		ecTime = 0
	if esTime > esTimer	:
		add_child(es.instance())
		esTime = 0
		
	if Player.highScore > goal:
		if boss == false:
			eaTimer = 10000
			esTimer = 10000
			ecTimer = 10000
			epTimer = 10000
			add_child(eb1.instance())
			emit_signal("boss")
			boss = true
	pass