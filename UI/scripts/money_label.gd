extends Label


func _ready() -> void:
	Global.money_value_changed.connect(update_money_label)
	
	
func update_money_label(new_value, new_max_value):
	text = "%d/%d" % [new_value, new_max_value] + " M"
