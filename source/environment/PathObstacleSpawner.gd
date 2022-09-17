extends Node2D

signal obstacle_created(obs)

onready var timer = $Timer

var Obstacle = preload("res://environment/PathObstacle.tscn")
var obstaclePosition = 0

func _ready():
	randomize()

func _on_Timer_timeout():
	spawn_obstacle()

func spawn_obstacle():
	var obstacle = Obstacle.instance()
	add_child(obstacle)
	
	if obstaclePosition == 0:
		obstacle.position.y = randi() % 400 + 180
	else:
		obstacle.position.y = obstaclePosition + (randi() % 20) - (randi() % + 20)
	
	obstaclePosition = obstacle.position.y
	emit_signal("obstacle_created", obstacle)


func start():
	timer.start()

func stop():
	timer.stop()
