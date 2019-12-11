extends RichTextLabel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	time += delta
	
	if time < 10:
		rect_position.y -= 0.5
	if time > 15:
		Global.goto_scene("res://scenes/Main.tscn")
	
	
	pass
