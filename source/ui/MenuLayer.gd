extends CanvasLayer

signal start_game

onready var start_message = $StartMenu/StartMessage
onready var tween = $Tween
onready var score_label = $GameOverMenu/VBoxContainer/ScoreLabel
onready var high_score_label = $GameOverMenu/VBoxContainer/HighScoreLabel
onready var game_over_menu = $GameOverMenu
onready var game_over_sprite = $GameOver

signal over

var game_started = false
export var game = ""

func _input(event):
	if event.is_action_pressed("flap")  && !game_started :
		emit_signal("start_game")
		tween.interpolate_property(start_message, "modulate:a", 1, 0, 0.5)
		tween.start()
		game_started = true
		

func init_game_over_menu(score, highscore):
	emit_signal("over")
	
	score_label.text = "SCORE: " + str(score)
	high_score_label.text = "HIGH: " + str(highscore)
	game_over_sprite.visible = true
	
	tween.interpolate_property(game_over_sprite, "modulate:a", 0, 1, 1)
	tween.start()
	yield(tween, "tween_completed")
	
	tween.interpolate_property(game_over_sprite, "modulate:a", 1, 0, 1)
	tween.start()
	yield(tween, "tween_completed")
	
	game_over_menu.visible = true

func _on_RestartButton_pressed():
	get_tree().current_scene.Restart(game)


func _on_MainMenu_pressed() -> void:
	var _bin = get_tree().reload_current_scene()
