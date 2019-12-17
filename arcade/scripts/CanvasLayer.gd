extends CanvasLayer


signal coin
var tempScore = 0
var score = 0
var scoreCounter = 0
var bossDied = false
var boss2Died = false

func setHighscore():
	get_node("HIGHSCORE").text = str(scoreCounter)
	pass
func setCredit():
	get_node("CREDIT").text = str(Player.credits)
	pass
func _ready():
	scoreCounter = Player.highScore
	setHighscore()
	setCredit()
	pass # Replace with function body.
func _unhandled_key_input(event):
	if event.is_action("coin"):
		Player.credits += 1
		get_node("COIN").play(0.0)
		setCredit()
		get_node("GameOver").coinAdded()
		get_node("GameOver").setText("PRESS START")
		emit_signal("coin")
	if event.is_action("start"):	
		if Player.credits > 0:
			if get_parent().scrollSpeed != null:
				Player.scrollSpeed = get_parent().scrollSpeed
				get_parent().spawnPlayer() 
		
	pass
func enemyDied():
	print("e Pong died")
	Player.highScore += 30
	get_parent().pointCount += 30
	score += 30 
	pass
func eaDied():
	print("e angle died")
	Player.highScore += 20
	get_parent().pointCount += 20
	score += 20
	pass
func ecDied():
	print("e c died")
	Player.highScore += 75
	get_parent().pointCount += 75
	score += 75
	pass
func esenemyDied():
	Player.highScore += 10
	get_parent().pointCount += 10
	score += 10
	pass
func espbnemyDied():
	Player.highScore += 30
	get_parent().pointCount += 30
	score += 30
	pass
func eneenemyDied():
	Player.highScore += 50
	get_parent().pointCount += 50
	score +=  50
	pass
func boss1Died():
	tempScore = Player.highScore
	Player.highScore += 500
	get_parent().pointCount += 500
	score += 500
	bossDied = true
	
	
	pass
func boss2Died():
	tempScore = Player.highScore
	Player.highScore += 550
	get_parent().pointCount += 500
	score += 550
	boss2Died = true
	
	
	pass
func pDied():
	Player.scrollSpeed = 0
	setCredit()
	if Player.credits == -1:
		Player.credits = 0
		setCredit()
	get_node("GameOver").setText("INSERT COIN")
	get_node("GameOver").setTime(10)
		
	pass
func lostLife():
	if Player.lives == 1:
		get_node("sky_rocket").hide()
		get_node("sky_rocket2").hide()
		get_node("sky_rocket3").hide()
	elif Player.lives == 2:
		get_node("sky_rocket2").hide()
		get_node("sky_rocket3").hide()
	elif Player.lives == 3:
		get_node("sky_rocket3").hide()
	
	pass
func lifeRestored():
	get_node("sky_rocket").show()
	get_node("sky_rocket2").show()
	get_node("sky_rocket3").show()
	pass
func _process(delta):
	if Player.highScore != scoreCounter:
		score -= 1
		scoreCounter += 1
		setHighscore()
		if boss2Died == true:
			if scoreCounter - tempScore == 550:
				Global.goto_scene("res://scenes/UI/Credits.tscn")

		if bossDied == true:
			if scoreCounter - tempScore == 500:
				get_parent().get_node("Player").queue_free()
				Global.goto_scene("res://scenes/location2.tscn")
	pass