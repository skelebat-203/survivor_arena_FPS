extends Area3D

const SPEED = 55.0
const RANGE = 40.0

var traveled_dist = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	position += transform.basis.z * SPEED * delta
	traveled_dist += SPEED * delta
	
	if traveled_dist > RANGE:
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	queue_free()
	if body.has_method("take_dmg"):
		body.take_dmg() 
