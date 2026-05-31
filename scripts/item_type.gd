class_name ItemType
extends Resource

@export var id: StringName
@export var display_name: String
@export var icon: Texture2D
@export var tags: Array[StringName]

func has_tag(tag: StringName) -> bool:
	return tags.has(tag)
