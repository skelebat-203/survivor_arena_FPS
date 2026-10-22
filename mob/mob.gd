extends RigidBody3D

@onready var bat_model: Node3D = %bat_model
func take_dmg():
	bat_model.hurt()
