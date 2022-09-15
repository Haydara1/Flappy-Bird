extends Node2D

onready var hud = $HUD
onready var obstacle_spawner = $ObstacleSpawner
onready var ground = $Ground
onready var menu_layer = $MenuLayer

var greenBird = preload("res://assets/textures/GreenBird.png")
var yellowBird = preload("res://assets/textures/bird.png")
var blueBird = preload("res://assets/textures/BlueBird.png")
var redBird = preload("res://assets/textures/RedBird.png")
var koopa = preload("res://assets/textures/Koopa.png")

const SAVE_FILE_PATH = "user://Reverse.save"

export var colour = ""

var score = 0 setget set_score
var highscore = 0

func _ready():
	obstacle_spawner.connect("obstacle_created",self, "_on_obstacle_created")
	load_highscore()

func new_game():
	self.score = 0
	obstacle_spawner.start()

func player_score():
	self.score += 1

func set_score(new_score):
	score = new_score
	hud.update_score(score)

func _on_obstacle_created(obs):
	obs.connect("score", self, "player_score")


func _on_DeathZone_body_entered(body):
	if body is reverse_player:
		if body.has_method("die"):
			body.die()


func _on_player_die():
	game_over()

func game_over():
	obstacle_spawner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	
	if score > highscore:
		highscore = score
		save_highscore()
	
	menu_layer.init_game_over_menu(score, highscore)

func _on_MenuLayer_start_game():
	new_game()


func setColour() -> void:
	if colour == "g":
		$player/Sprite.set_texture(greenBird)
	elif colour == "y":
		$player/Sprite.set_texture(yellowBird)
	elif colour == "b":
		$player/Sprite.set_texture(blueBird)
	elif colour == "r":
		$player/Sprite.set_texture(redBird)
	elif colour == "k":
		$player/Sprite.set_texture(koopa)

func save_highscore():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_32(highscore)
	save_data.close()

func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		highscore = save_data.get_32()
		save_data.close()
