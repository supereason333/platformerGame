extends Node2D

const SAVE_PATH = "res://savegame.bin"
var autosave_time = 0

func _process(delta):
	autosave_time += delta * 100
	if autosave_time >= 3000:
		save_game()
		print_debug("saved game")
		autosave_time = 0

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var dictionary: Dictionary = {
		"playerHP": Game.playerHP,
		"playerGold": Game.playerGold,
	}
	var jstr = JSON.stringify(dictionary)
	file.store_line(jstr)
	file.close()
	print_debug("Game Saved")

func load_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) and !file.eof_reached():
		var current_line = JSON.parse_string(file.get_line())
		if current_line:
			Game.playerHP = current_line["playerHP"]
			Game.playerGold = current_line["playerGold"]
			print_debug("Game Loaded")
	file.close()
