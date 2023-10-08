extends Node

var playerHP = 10
var playerGold = 0
var PLAYERHP_MAX = 10

var autosave_time = 0
var AUTPSAVE_TIME_MAX = 300
func _process(delta):
	autosave_time += 1
	if autosave_time >= AUTPSAVE_TIME_MAX:
		autosave_time = 0
		Utils.save_game()
