extends Button
class_name PurchaseOption

signal PurchaseOptionPressed(definition: BuildingDefinition)

@export var definition: BuildingDefinition

@onready var title: Label = $Title
@onready var money_icon: TextureRect = $Panel/MoneyIcon
@onready var price: Label = $Panel/Price

func _ready() -> void:
	update_visuals()

func update_visuals():
	if definition:
		title.text = definition.title
		price.text = str(definition.purchase_cost) + "М"

func _pressed() -> void:
	PurchaseOptionPressed.emit(definition)
