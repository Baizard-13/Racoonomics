extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Location/location.tscn")


func _on_authors_pressed() -> void:
	get_tree().change_scene_to_file("res://Location/Main_Menu/authors.tscn")

#Верните функцию, когда будет создана сцена для доп контента. Сейчас эта сцена серого экрана, из нее не выйти
#func _on_additional_pressed() -> void:
#	get_tree().change_scene_to_file("res://Location/Main_Menu/Additional.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
