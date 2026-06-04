extends Node


#signal max_money_changed(new_value:int)

@export var update_money_add: int = 15 ##How many money player will reseave at the level_updrage
@export var max_money: int = 20: ##How maximum money count player can have at the start
	set(value):
		max_money = value
		#max_money_changed.emit(value)
		update_vizual()

@export var money: int = 0: ##Current money count. In Inspector(right here) you set start money count
	set(value):
		money = clamp(value, 0, max_money)
		#money_value_changed.emit(money)
		update_vizual()

@onready var money_label: Label = $Money_count/MoneyLabel

func _ready() -> void:
	update_vizual()

func new_lvl_money_add():
	money += update_money_add
	max_money += update_money_add

## Cost check, if have needed count = true
func check_cost(cost: int) -> bool:
	if cost <= money:
		money -= cost
		update_vizual()
		return true
	return false

func update_vizual():
	money_label.text = "%d/%d" % [money, max_money]
	Global.money_value_changed.emit(money, max_money)

# DEBUG, need to delete after adding money reseave logic
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released():
		if event.keycode == KEY_P:
			new_lvl_money_add()
