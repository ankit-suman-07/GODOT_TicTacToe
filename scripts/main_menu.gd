extends Control

func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_game_scene.tscn")



func _on_exit_btn_pressed() -> void:
	get_tree().quit()


func _on_play_ai_pressed() -> void:
	pass # Replace with function body.
