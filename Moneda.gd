extends RigidBody2D
	
signal hit
var max_time

# Called when the node enters the scene tree for the first time.
func _ready():
	max_time=rand_range(2,5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	max_time-=delta
	$MonedaTime.set_text(str(stepify(max_time,0.01)))
	if max_time<=0:
		hide()
