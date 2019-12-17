extends Node2D

onready var player = load("res://scenes/Player.tscn")
export var scrollSpeed = 3
var pointCount = 0
var time = 0.0
var difficulty = 1


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
func eDied():
	difficulty+=0.1
	Player.difficulty = difficulty
	pass
func getCamera():
	if get_node("Camera2D").position != null:
		return get_node("Camera2D").position
	else: return Vector2(0,0)
func _ready():
	
	Player.scrollSpeed = scrollSpeed
	Player.health = 5
	Player.lives = 3
	Player.difficulty = difficulty
	get_node("HUD").lifeRestored()
	add_child(player.instance())
	pass 
func _process(delta):
	time += delta

	pass