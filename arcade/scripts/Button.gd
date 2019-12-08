extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pos = rect_position
export var distance = 10
export var speed = 0.1
var time = 0.25
var dir = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time > speed:
		rect_position.y = rect_position.y + 1 * dir
		if abs(rect_position.y - pos.y) >= distance:
			dir  =dir * -1	
		
	
	
	
	pass
