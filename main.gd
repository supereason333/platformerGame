extends Node2D

func _on_quit_button_pressed():
	get_tree().quit()


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn")

func _ready():
	Utils.load_game()

func _on_delete_save_button_pressed():
	Utils.remove_save()
