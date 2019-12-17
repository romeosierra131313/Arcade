extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rotDir  = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	rotDir = get_parent().rotDir
	pass # Replace with function body.
func _process(delta):
	rotate(delta/5 * -rotDir)
	pass
