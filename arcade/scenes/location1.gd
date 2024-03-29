extends Node2D

onready var ec = load("res://scenes/EnemyCurve.tscn")
onready var ea = load("res://scenes/EnemyAngle.tscn")
onready var es = load("res://scenes/EnemyStraight.tscn")
onready var ep = load("res://scenes/EnemyPong.tscn")
onready var eb1 = load("res://scenes/EnemyBoss1.tscn")
var time = 0.0
var difficulty = 1
var goal = 700
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

func setHighscore():
	get_node("HUD").setHighscore()
	pass
func setCredit():
	get_node("HUD").setCredit()
	pass
	


func _ready():
	Player.difficulty = difficulty
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
		
	if Player.location.x > goal:
		if boss == false:
			eaTimer = 10000
			esTimer = 10000
			ecTimer = 10000
			epTimer = 10000
			add_child(eb1.instance())
			emit_signal("boss")
			boss = true
	pass