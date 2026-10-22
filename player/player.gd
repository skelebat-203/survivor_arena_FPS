## Tutorial video 
## https://www.youtube.com/watch?v=NJJNWGD25rg&list=TLPQMTcxMDIwMjZe_5w-SfpDnA&index=3

extends CharacterBody3D

const GRAVITY = 20
const SPEED = 5.0
const JUMP_VELOCITY = 7.5
const MOUSE_SPEED = 4

var print_interval_ms: int = 1000
var last_print_ms: int = 500
var plain: float = 0
var current_y: float = 0

# fires when the object enters the scene
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Camera movement, UI inputs
func _unhandled_input(event: InputEvent) -> void:
	# Camera movement
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x / MOUSE_SPEED
		# Set min/max for up/down camera movement
		%Camera3D.rotation_degrees.x = clampf(
			%Camera3D.rotation_degrees.x - event.relative.y / MOUSE_SPEED,
			-55.0,
			30.0
			)
	# ESC displays cursor allowing player to move mouse outside the game window
	elif event.is_action_pressed("ui_cancel"): # "ui_cancel" is a pre-definded action. I maps to ESC
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
## Character movement	
func _physics_process(delta):
	var movement = 0.0 # used to switch between walk / sprint
	var input_dir_2D = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_back" # map to move actions
		)
	var input_dir_3D = Vector3(
		input_dir_2D.x, 0.0, input_dir_2D.y # shift the 2d plain to 3D, from (x,y) to (x,y,z)
	)
	var dir = transform.basis * input_dir_3D
	
	# Sprinting
	if Input.is_action_pressed("sprint"):
		movement = SPEED * 1.5
	else:
		movement = SPEED
		
	velocity.x = dir.x * movement
	velocity.z = dir.z * movement
	
	# Jumping
	velocity.y -= GRAVITY * delta
	if Input.is_action_just_pressed("jump") and is_on_floor(): # start jumping
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_released("jump") and velocity.y > 0.0: # stop jumping when "jump is no longer pressed
		velocity.y = 0.0
		
	move_and_slide()
	
	if Input.is_action_pressed("shoot") and %Timer.is_stopped():
		shoot_bullet() 

func shoot_bullet ():
	const BULLET_3D = preload("res://player/bullet_3d.tscn")
	var new_bullet = BULLET_3D.instantiate()
	%Marker3D.add_child(new_bullet)
	
	new_bullet.global_transform = %Marker3D.global_transform
	
	%Timer.start()
