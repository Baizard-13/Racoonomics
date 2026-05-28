extends CharacterBody3D

@export var speedmultiplier := 1.0 ## Множитель скорости
@export var speed := 50.0 ## Скорость

#@export var mi_max_scale: Vector2 = Vector2(2, 30) ## Мин/макс высота камеры
@export var distance_bounds := Vector2(100, 400)
@export var zoom_step: float = 25 # Сделал еще больше, чтобы зум чувствовался
@onready var camera: Camera3D = $Camera3D

func _physics_process(_delta: float) -> void:
	var rot = Input.get_axis("e", "q")
	rotation.y += 0.05 * rot

	if Input.is_action_pressed("shift"):
		speedmultiplier = 2.5
	else :
		speedmultiplier = 1.0

	var input_dir = Input.get_vector("a", "d", "w", "s") * speed * speedmultiplier
	var move_dir = Vector3(input_dir.x, 0, input_dir.y)

	velocity = move_dir.rotated(Vector3.UP, rotation.y)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouseScrollDown"):
		camera.position.z = clamp(camera.position.z + zoom_step, distance_bounds.x, distance_bounds.y)
	elif event.is_action_pressed("mouseScrollUp"):
		camera.position.z = clamp(camera.position.z - zoom_step, distance_bounds.x, distance_bounds.y)
