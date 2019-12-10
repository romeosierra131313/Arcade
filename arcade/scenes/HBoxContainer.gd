extends HBoxContainer

var time = -1
var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func setTime(e):
	time = e
	get_node("VBoxContainer/Label").text = str(time)
	show()
	
	return true
func _process(delta):
	timer += delta
	if timer > 1:
		time -= 1
		get_node("VBoxContainer/Label").text = str(time)
		
		timer = 0
		if time == -1:
			Global.goto_scene("res://scenes/Main.tscn")
			hide()
	pass
func coinAdded():
	time = 10 
	pass
	