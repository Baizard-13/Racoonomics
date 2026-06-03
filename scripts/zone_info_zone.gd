extends Area3D

enum zone_name {
	Beaver = 0,
	Raccoon = 1,
	Squirrel = 2,
	Hare = 3
}

var icons: Array = [
	preload("res://UI/textures/SpaceUI/IMG_9682.PNG"),
	preload("res://UI/textures/SpaceUI/IMG_9680.PNG"),
	preload("res://UI/textures/SpaceUI/IMG_9679.PNG"),
	preload("res://UI/textures/SpaceUI/IMG_9678.PNG")
]
@export var ID: zone_name

@onready var collision: CollisionShape3D = $CollisionShape3D
@onready var icon: TextureRect = $SubViewport/Control/Icon
@onready var control: Control = $SubViewport/Control
@onready var info: Sprite3D = $Info

func _ready() -> void:
	info.modulate = Color(1.0, 1.0, 1.0, 0.0)
	icon.texture = icons[ID]
	self.mouse_entered.connect(_on_area_pickable_mouse_entered)
	self.mouse_exited.connect(_on_area_pickable_mouse_exited)

func _on_area_pickable_mouse_entered() -> void:
	show_info_tween(true)

func _on_area_pickable_mouse_exited() -> void:
	show_info_tween(false)

func show_info_tween(value: bool):
	var tws = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	var twm = create_tween().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tws.tween_property(info,"pixel_size",0.0002 if value else 0.0, 0.2)
	twm.tween_property(info,"modulate",Color(1.0, 1.0, 1.0, 1.0) if value else Color(1.0, 1.0, 1.0, 0.0), 0.3)
