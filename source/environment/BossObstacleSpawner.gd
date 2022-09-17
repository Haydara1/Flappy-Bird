extends Node2D

signal obstacle_created(obs)

onready var timer = $Timer
onready var timer2 =$Timer2
onready var bullet_sound = $Bullet

var Obstacle = preload("res://environment/PlantObstacle.tscn")
var Bullet = preload("res://Characters/Enemies/Bullet.tscn")

func _ready():
	randomize()

func _on_Timer_timeout():
	spawn_obstacle()

func _on_Timer2_timeout() -> void:
	spawn_bullet()

func spawn_obstacle():
	var obstacle = Obstacle.instance()
	add_child(obstacle)
	
	obstacle.position.y = randi() % 400 + 200
	emit_signal("obstacle_created", obstacle)

func spawn_bullet():
	var bullet = Bullet.instance()
	add_child(bullet)
	
	bullet.position.y = randi() % 450 + 100
	bullet_sound.position.y = bullet.position.y
	bullet_sound.play()

func start():
	timer.start()
	timer2.start()

func stop():
	timer.stop()
	timer2.stop()

