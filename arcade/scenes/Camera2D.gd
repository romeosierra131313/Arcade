extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func moveY(e):
	position.y = 300
	pass
func moveX(e):
	position.x += e
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moveX(Player.scrollSpeed)
	pass
