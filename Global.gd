extends Node

var devotion: int = 0 ##преданность

#переменные продуктов
var carrot: int = 0 ##морковь
var nuts: int = 0 ##орехи
var apple: int = 0 ##яблоки
var planks: int = 0 ##доски

#переменные блюд
var carrot_soup: int = 0 ##морковный суп
var nut_snacks: int = 0 ##ореховые снеки
var applesauce: int = 0 ##яблочное пюре 
var fried_bark: int = 0 ##жареная кора

enum prod_types{
	carrot = 0, ##морковка, даёт сытность для зайчиков = довольность :O
	nuts = 1, ##орехи, даёт сытность для белочек = довольность :O
	apple = 2, ##яблочки, даёт сытность для ёжиков = довольность :O
	planks = 3, ##брёвна, даёт сытность для бобров = довольность :O
}
func add_to_integer_res_type(prod_type_check: int, add_value: int):
	match prod_type_check:
		0:
			carrot += add_value
		1:
			nuts += add_value
		2:
			apple += add_value
		3:
			planks += add_value
