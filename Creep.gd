extends RigidBody2D

signal creepOut

export var min_speed = 200  # Minimum speed range.
export var max_speed = 300  # Maximum speed range.
var creep_types = "coronavirus"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation ="coronavirus"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Visibility_screen_exited():
	emit_signal("creepOut")
	queue_free()
	

func _on_start_game():
	queue_free()

