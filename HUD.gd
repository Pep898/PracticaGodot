extends CanvasLayer

signal start_game
signal moneda

var scoreHUD=0
var noMoneda=0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if(scoreHUD%20==0 || (scoreHUD-1)%20==0) && (scoreHUD!=0 && scoreHUD!=1):
		if (scoreHUD-noMoneda)>18:
			emit_signal("moneda")
			noMoneda=scoreHUD

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

func update_score(score):
	scoreHUD+=score
	$ScoreLabel.text = str(scoreHUD)

func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
