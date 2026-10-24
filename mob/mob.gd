extends RigidBody3D

var health = 3
var max_speed = 6.0
var min_speed = 3.0
var speed = randf_range(min_speed, max_speed)

@onready var bat_model: Node3D = %bat_model
@onready var timer: Timer = %Timer
@onready var player = get_node("/root/Level_01/Player")

func _ready() -> void:
	lock_rotation = true
	
func _physics_process(delta: float) -> void:
	var dir = global_position.direction_to(player.global_position)
	
	dir.y = 0.0
	linear_velocity = dir * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(dir, Vector3.UP) + PI
	#bat_model.global_rotation.y = Vector3.FORWARD.signed_angle_to(dir, Vector3.UP) + PI

func take_dmg():
	var dir = 0.0
	var rand_up_force = 0.0
	#if health == 0:
		#return
	
	bat_model.hurt()
	health -= 1
	
	if health == 0:
		set_physics_process(false)
		gravity_scale = 1.0
		dir = -1.0* global_position.direction_to(player.global_position)
		rand_up_force = Vector3.UP * randf_range(1.0, 3.0)
		apply_central_impulse(dir * 10.0 + rand_up_force)
		timer.start()
		return


func _on_timer_timeout() -> void:
	queue_free()
