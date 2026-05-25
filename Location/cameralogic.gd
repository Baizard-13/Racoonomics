extends CharacterBody3D
var speedmulti = 1
const SPEED = 25.0 


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("shift"):
		speedmulti = 2
	else :
		speedmulti = 1
	var input_dir = Input.get_vector("a","d","w","s") * SPEED * speedmulti
	velocity = Vector3(input_dir.x, 0, input_dir.y)
	move_and_slide()
	if Input.is_action_just_pressed("q"):
		$Camera3D.rotation.y += 90
	if Input.is_action_just_pressed("e"):
		$Camera3D.rotation.y += 90
