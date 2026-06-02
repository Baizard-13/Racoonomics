extends Control

var current_building: Building

@onready var bar_loyalty: Control = $BarLoyalty
@onready var tab_hotbar: Control = $TabHotbar
@onready var description_popup: Control = $DescriptionPopup

@onready var building_icon: TextureRect = $DescriptionPopup/Building_icon
@onready var build_name: Label = $DescriptionPopup/Name
@onready var description: Label = $DescriptionPopup/Description
@onready var world_grid: WorldGrid = $"../../WorldGrid"




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
	if !current_building:
		return
	world_grid.buildings_cache.erase(current_building)
	var rect = Rect2i(current_building.origin_cell.x, current_building.origin_cell.y, current_building.dimensions.x, current_building.dimensions.y)
	print(world_grid.get_overlap(rect))
	world_grid._free_rect(rect)
	current_building.queue_free() #Тут логика удаления здания или сигнал для её вызова
	closeDescription()
