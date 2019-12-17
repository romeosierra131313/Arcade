extends Control

var scrollSpeed = 3

func _ready():
	get_node("HUD/HIGHSCORE").hide()
	get_node("HUD/sky_rocket").hide()
	get_node("HUD/sky_rocket2").hide()
	get_node("HUD/sky_rocket3").hide()
	pass 
	
func spawnPlayer():
	print("hi im a dud func")
	pass
func _process(delta):
			
	if Input.is_action_just_pressed("start"):
		print("i also triggered")
		get_node("HUD/HIGHSCORE").show()
		get_node("HUD/sky_rocket").show()
		get_node("HUD/sky_rocket2").show()
		get_node("HUD/sky_rocket3").show()
		Global.goto_scene("res://scenes/location2.tscn")
		queue_free()

	pass
