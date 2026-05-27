class_name Item
extends Resource

@export var quantity: int = 0

# override this
func get_produce_types() -> Array[Global.ProduceType]:
	return []

func is_any_of(types: Array[Global.ProduceType]) -> bool:
	for t in get_produce_types():
		if types.has(t):
			return true

	return false

func split(split_qty: int) -> Item:
	if split_qty >= quantity:
		var full_item := duplicate()
		quantity = 0
		return full_item
	else:
		var split_item := duplicate()
		split_item.quantity = split_qty
		quantity -= split_qty
		return split_item

func combine(other: Item) -> bool:
	if get_produce_types() != other.get_produce_types():
		return false

	quantity += other.quantity
	other.quantity = 0

	return true
