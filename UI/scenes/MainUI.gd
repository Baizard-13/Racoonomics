extends Control

func _ready() -> void:
	$DescriptionPopup.hide()
	
func openDescription():
	$DescriptionPopup.show()
	
func closeDescription():
	$DescriptionPopup.hide()


func _on_bt_close_pressed() -> void:
	closeDescription()
