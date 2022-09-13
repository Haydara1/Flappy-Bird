extends Node2D

signal score

onready var point = $point

const SPEED = 215

func _physics_process(delta):
	position.x += -SPEED * delta
	if global_position.x <= -75:
		queue_free()


func _on_Wall_body_entered(body):
	if body is player or body is reverse_player:
		if body.has_method("die"):
			body.die()


func _on_ScoreArea_body_exited(body):
	if body is player or body is reverse_player:
		point.play()
		emit_signal("score")
