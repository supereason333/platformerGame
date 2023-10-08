extends Node

const SAVE_PATH = "res://savegame.bin"

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var dictionary: Dictionary = {
		"playerHP": Game.playerHP,
		"playerGold": Game.playerGold,
	}
	var jstr = JSON.stringify(dictionary)
	file.store_line(jstr)
func load_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		if !file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.playerHP = current_line["playerHP"]
				Game.playerGold = current_line["playerGold"]
