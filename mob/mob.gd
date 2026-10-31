extends RigidBody3D

var health = 3
var max_speed = 6.0
var min_speed = 3.0
var speed = randf_range(min_speed, max_speed)
var sight_range = randf_range(10.0, 20.0)

@onready var player = get_node("/root/Level_01/Player")
@onready var bat_model: Node3D = %bat_model
@onready var obstacle_ray: RayCast3D = %Obsticale_Ray
@onready var timer: Timer = %Timer
#@onready var heal_timer: Timer = %Timer

func _ready() -> void:
	lock_rotation = true
	#heal_timer.one_shot = false
	#heal_timer.timeout.connect(heal)
	#heal_timer.start(2.0)
	
#func _physics_process(delta: float) -> void:
	#pass

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if health <= 0:
		return
		
	pursue_player(state)

func _on_timer_timeout() -> void:
	queue_free()

func take_dmg():
	var dir = 0.0
	var rand_up_force = 0.0
	if health == 0:
		return
	
	bat_model.hurt()
	health -= 1
	
	if health == 0:
		set_physics_process(false)
		gravity_scale = 1.0
		dir = -1.0* global_position.direction_to(player.global_position)
		rand_up_force = Vector3.UP * randf_range(1.0, 3.0)
		apply_central_impulse(dir * 7.5 + rand_up_force)
		timer.start()

#func heal():
	#if health > 0 && health < 3:
		#health += 1
	

func pursue_player(state: PhysicsDirectBodyState3D) -> void:
	var distance_to_player: float = global_position.distance_to(player.global_position)
	var dir = global_position.direction_to(player.global_position)
	var look_ahead_distance: float = 2.0
	var ray_end: Vector3 = obstacle_ray.global_position + dir * look_ahead_distance

	obstacle_ray.target_position = obstacle_ray.to_local(ray_end)
	obstacle_ray.force_raycast_update()
	if obstacle_ray.is_colliding():
		var wall_normal: Vector3 = obstacle_ray.get_collision_normal()
		dir.slide(wall_normal).normalized()
		
	if distance_to_player <= sight_range:
		state.linear_velocity = dir * speed
		bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(dir, Vector3.UP) + PI
	
