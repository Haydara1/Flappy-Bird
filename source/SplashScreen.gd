extends Node2D

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("flap")):
		queue_free()
