extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

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
func enemyDied():
	setHighscore()
	pass
func pDied():
	Player.credits -= 1
	setCredit()
	pass
