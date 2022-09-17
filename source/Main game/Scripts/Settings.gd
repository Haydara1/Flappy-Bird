extends Node2D

const SAVE_FILE = "user://sound.save"

var sound = 1

func _ready():
	load_mute()
	var pressed = false
	if sound == 1:
		$MusicButton.pressed = true
		pressed = true
	else:
		$MusicButton.pressed = false
	var master_sound = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_sound, !pressed)

func _on_BackButton_pressed() -> void:
	queue_free()

func save_mute():
	var save_data = File.new()
	save_data.open(SAVE_FILE, File.WRITE)
	save_data.store_8(sound)
	save_data.close()

func load_mute():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE):
		save_data.open(SAVE_FILE, File.READ)
		sound = save_data.get_8()
		save_data.close()


func _on_MusicButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		sound = 1
	else:
		sound = 0
	save_mute()
	var master_sound = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_sound, !button_pressed)
	
