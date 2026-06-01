extends Control

var current_building: Building

@onready var bar_loyalty: Control = $BarLoyalty
@onready var tab_hotbar: Control = $TabHotbar
@onready var description_popup: Control = $DescriptionPopup

@onready var building_icon: TextureRect = $DescriptionPopup/Building_icon
@onready var build_name: Label = $DescriptionPopup/Name
@onready var description: Label = $DescriptionPopup/Description

func _ready() -> void:
	description_popup.hide()

func openDescription(build_def: BuildingDefinition):
	build_name.text = build_def.title
	building_icon.texture = build_def.shop_icon
	description.text = build_def.description
	description_popup.show()

func closeDescription():
	description_popup.hide()

func _on_bt_close_pressed() -> void:
	closeDescription()

func _on_bt_sell_pressed() -> void:
	pass #Тут логика удаления здания или сигнал для её вызова
