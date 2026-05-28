extends Node
var current_farm: Farm = preload("res://resources/CarrotFarm.tres")
var timer_active: bool = true
var time_accumulator: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#time_accumulator += delta
	#if timer_active == true and time_accumulator >= 1.0:
		#Global.add_to_integer_res_type(current_farm.product_type,current_farm.prod_count_per_timer)
		#time_accumulator = 0
	#print (Global.carrot)
	#print ("   " )
	#print (time_accumulator)
