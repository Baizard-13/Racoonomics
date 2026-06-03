extends Control

@onready var bar_loyalty_progress: TextureProgressBar = $BarLoyalty_Progress


func _ready():
	Global.update_bar.connect(change_progress_bar)
	
func change_progress_bar(new_loyalty: int):
	bar_loyalty_progress.value = new_loyalty
	#print(bar_loyalty_progress.value)
