@icon ("res://Images/paintdotnet_y9vSMDoCGH.png")
class_name Farm
extends Resource

@export_category("Данные фермы")
#@export var product_type:Global.prod_types ##тип продукта
@export var prod_count_per_timer: int = 0 ##Количество выработки продукта в сек
@export var prod_timer_lvl_1: float = 3 ##Время таймера lvl1 секунды
@export var prod_timer_lvl_2: float = 1 ##Время таймера lvl2 минуты
@export var model_lvl_1: PackedScene ##Модель что используется фермой lvl1
@export var model_lvl_2: PackedScene ##Модель что используется фермой lvl2

@export_category("Данные магазина")
@export var buy_cost: int = 0 ##Цена фермы в магазине
@export var upgrade_cost: int = 0 ##Цена апрегейда фермы

@export var naming: String ##Название фермы в магазине
@export_multiline var description: String ## Описание фермы в магазине
@export var shop_icon: Texture2D ## Иконка в магазине
