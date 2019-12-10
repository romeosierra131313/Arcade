extends CanvasLayer


signal coin


func setHighscore():
	get_node("HIGHSCORE").text = str(Player.highScore)
	pass
func setCredit():
	get_node("CREDIT").text = str(Player.credits)
	pass
func _ready():
	pass # Replace with function body.
func _unhandled_key_input(event):
	if event.is_action("coin"):
		Player.credits += 1
		setCredit()
		get_node("GameOver").coinAdded()
		emit_signal("coin")
	if event.is_action("start"):	
		get_parent().spawnPlayer() 
	pass
func enemyDied():
	print("e Pong died")
	Player.highScore += 10
	setHighscore()
	pass
func eaDied():
	print("e angle died")
	Player.highScore += 10
	setHighscore()
	pass
func ecDied():
	print("e c died")
	Player.highScore += 10
	setHighscore()
	pass
func esDied():
	print("e straight died")
	Player.highScore += 10
	setHighscore()
	pass
func pDied():
	Player.credits -= 1
	setCredit()
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