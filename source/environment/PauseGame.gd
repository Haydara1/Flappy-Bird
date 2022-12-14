extends Area2D

var paused = false

onready var pause_sound = $PauseSound

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("flap")):
		if get_parent().get_parent().over:
			return
		if paused == true:
			pause_sound.play()
			get_tree().paused = !paused
			paused = !paused
			return
		if get_global_mouse_position().y > 720:
			pause_sound.play()
			get_tree().paused = !paused
			paused = !paused
