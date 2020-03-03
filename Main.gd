extends Node2D

export (PackedScene) var Mob
export (PackedScene) var Creep
export (PackedScene) var Moneda
var score
var screen_size
var time
var moneda

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$Music.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$DeathSound.play()

func new_game():
	#score=0
	#$HUD.update_score(score)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	$Music.play()

func _on_MobTimer_timeout():
	var rndMobs=randi()%11+1 
	if rndMobs > 8 :
		# Choose a random location on Path2D.
		$MobPath/MobSpawnLocation.set_offset(randi())
		# Create a Mob instance and add it to the scene.
		var creep = Creep.instance()
		add_child(creep)
		# Set the creep's direction perpendicular to the path direction.
		var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
		# Set the creep's position to a random location.
		creep.position = $MobPath/MobSpawnLocation.position
		# Add some randomness to the direction.
		direction += rand_range(-PI / 4, PI / 4)
		creep.rotation = direction
		# Set the velocity (speed & direction).
		creep.linear_velocity = Vector2(rand_range(creep.min_speed, creep.max_speed), 0)
		creep.linear_velocity = creep.linear_velocity.rotated(direction)
		$HUD.connect("start_game", creep, "_on_start_game")
		$HUD.update_score(2)
	else:
		# Choose a random location on Path2D.
		$MobPath/MobSpawnLocation.set_offset(randi())
		# Create a Mob instance and add it to the scene.
		var mob = Mob.instance()
		add_child(mob)
		# Set the mob's direction perpendicular to the path direction.
		var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
		# Set the mob's position to a random location.
		mob.position = $MobPath/MobSpawnLocation.position
		# Add some randomness to the direction.
		direction += rand_range(-PI / 4, PI / 4)
		mob.rotation = direction
		# Set the velocity (speed & direction).
		mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
		mob.linear_velocity = mob.linear_velocity.rotated(direction)
		$HUD.connect("start_game", mob, "_on_start_game")
		$HUD.update_score(1)
func _on_ScoreTimer_timeout():
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_HUD_moneda():
	#var moneda = 
	moneda=Moneda.instance()
	add_child(moneda)
	screen_size = get_viewport_rect().size
	var x=rand_range(0,screen_size.x)
	var y=rand_range(0,screen_size.y)
	moneda.position.x = x
	moneda.position.y = y


func _on_Player_hitMoneda():
	$HUD.update_score(5)
	moneda.hide()

