extends Control


func _ready():
	get_node("HUD/HIGHSCORE").hide()
	pass 
func _process(delta):
			
	if Input.is_action_just_pressed("start"):
		get_node("HUD/HIGHSCORE").show()
		Global.goto_scene("res://scenes/location1.tscn")
	pass
