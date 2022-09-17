extends Area2D

const SPEED = 450

func _physics_process(delta: float) -> void:
	position.x += -SPEED * delta
	if global_position.x <= -75:
		queue_free()


func _on_Bullet_body_entered(body: Node) -> void:
	if body is player or body is reverse_player:
		if body.has_method("die"):
			body.die()
