extends Button
class_name PurchaseOption

signal PurchaseOptionPressed(definition: BuildingDefinition)

@export var definition: BuildingDefinition

@onready var title: Label = $Title
@onready var money_icon: TextureRect = $Panel/MoneyIcon
@onready var price: Label = $Panel/Price
@onready var building_icon: TextureRect = $BuildingIcon

func _ready() -> void:
	update_visuals()

func update_visuals():
	if definition:
		building_icon.texture = definition.shop_icon
		title.text = definition.title
		price.text = str(definition.purchase_cost) + "м"

func _pressed() -> void:
	PurchaseOptionPressed.emit(definition)
