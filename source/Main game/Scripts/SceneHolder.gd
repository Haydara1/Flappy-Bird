extends Node2D

func _ready():
	play_scene_fade()

func play_scene_fade():
	$SceneFade/BlackRect/AnimationPlayer.play("SceneFade")
