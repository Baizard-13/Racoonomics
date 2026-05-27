class_name ItemStorage
extends Resource

@export var accepted_types : Array[Global.ProduceType]
@export var capacity : int = 10
## is_input and is_output don't affect the logic of the storage itself, it's supposed to be used by external code
@export var is_input : bool = true
@export var is_output : bool = true

@export var items : Array[Item] = []
@export var filled_capacity : int = 0

func take(qty: int) -> Array[Item]:
	var taken_items : Array[Item] = []
	for item in items:
		if item.quantity > 0:
			var taken_item := item.split(qty)
			taken_items.append(taken_item)
			filled_capacity -= taken_item.quantity
			qty -= taken_item.quantity
			if qty <= 0:
				break

	return taken_items

func take_filtered(qty: int, types: Array[Global.ProduceType]) -> Array[Item]:
	var taken_items : Array[Item] = []
	for item in items:
		if item.quantity > 0 and item.is_any_of(types):
			var taken_item := item.split(qty)
			taken_items.append(taken_item)
			filled_capacity -= taken_item.quantity
			qty -= taken_item.quantity
			if qty <= 0:
				break

	return taken_items

func put(item: Item) -> Array[Item]:
	if not item.is_any_of(accepted_types):
		return [item]
	if filled_capacity >= capacity:
		return [item]

	var space_left := capacity - filled_capacity

	if item.quantity <= space_left:
		items.append(item)
		filled_capacity += item.quantity
		return []
	else:
		var to_store := item.split(space_left)
		items.append(to_store)
		filled_capacity += to_store.quantity
		return [item]

func merge_duplicates():
	var unique_items : Array[Item] = []
	for item in items:
		var merged := false
		for unique_item in unique_items:
			if item.combine(unique_item):
				merged = true
				break
		if not merged:
			unique_items.append(item)

	items = unique_items
