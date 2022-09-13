extends Node2D

var classicGame = preload("res://Main game/Scenes/World.tscn")
var reverseGame = preload("res://Main game/Scenes/Reverse.tscn")
var colour = ""

signal HalfAnimation

func _ready():
	play_scene_fade()

func play_scene_fade():
	$SceneFade/BlackRect/AnimationPlayer.play("SceneFade")


func _on_Yellow_pressed() -> void:
	colour = "y"
	AddLevelChoosing()

func _on_Green_pressed() -> void:
	colour = "g"
	AddLevelChoosing()

func _on_Blue_pressed() -> void:
	colour = "b"
	AddLevelChoosing()

func AddLevelChoosing():
	$"Main menu".visible = false
	play_scene_fade()
	yield(self, "HalfAnimation")
	$Choose_level.visible = true

func ClassicGame():
	Physics2DServer.area_set_param(get_viewport().find_world_2d().get_space(), Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, 1))
	play_scene_fade()
	yield(self, "HalfAnimation")
	$Choose_level.visible = false
	
	self.add_child(classicGame.instance())
	get_child(get_child_count() - 1).colour = colour
	get_child(get_child_count() - 1).setColour()

func ReverseGame():
	Physics2DServer.area_set_param(get_viewport().find_world_2d().get_space(), Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, -1))
	play_scene_fade()
	yield(self, "HalfAnimation")
	$Choose_level.visible = false
	
	self.add_child(reverseGame.instance())
	get_child(get_child_count() - 1).colour = colour
	get_child(get_child_count() - 1).setColour()

func Restart(node):
	remove_child(get_child(get_child_count() - 1))
	if node == "Classic":
		ClassicGame()
	elif node == "Reverse":
		ReverseGame()

func HalfAnimatinon():
	emit_signal("HalfAnimation")
