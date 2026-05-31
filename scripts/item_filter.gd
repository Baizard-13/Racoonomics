class_name ItemFilter
extends Resource

enum Mode { ONLY, ANY_EXCEPT, ANY, TAG }

@export var mode: Mode = Mode.ANY
@export var allowed_types: Array[ItemType]
@export var required_tag: StringName

func accepts(type: ItemType) -> bool:
	match mode:
		Mode.ANY: return true
		Mode.ONLY: return allowed_types.has(type)
		Mode.ANY_EXCEPT: return not allowed_types.has(type)
		Mode.TAG: return type.has_tag(required_tag)
		_: return false
