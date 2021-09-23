extends RigidBody

enum HAND {
	LEFT,
	RIGHT
}

export var speed=1
export(HAND) var hand=HAND.RIGHT

onready var caught_area: Area=$CaughtArea
onready var fruits_container: Spatial=$Fruits

onready var left_mesh=$LeftHandMesh
onready var right_mesh=$RightHandMesh

onready var thumb_collision_left=$ThumbCollisionLeft
onready var thumb_collision_right=$ThumbCollisionRight

func _ready():
	match hand:
		HAND.RIGHT:
			left_mesh.visible=false
			right_mesh.visible=true
			thumb_collision_left.queue_free()
		HAND.LEFT:
			left_mesh.visible=true
			right_mesh.visible=false
			thumb_collision_right.queue_free()




func _physics_process(_delta: float) -> void:
	var direction = Vector3()
	match hand:
		HAND.LEFT:
			if Input.is_action_pressed("move_lhand_right"):
				direction.x += 1
			if Input.is_action_pressed("move_lhand_left"):
				direction.x -= 1
		HAND.RIGHT:
			if Input.is_action_pressed("move_rhand_right"):
				direction.x += 1
			if Input.is_action_pressed("move_rhand_left"):
				direction.x -= 1

	var velocity = direction.normalized() * speed
	add_central_force(velocity)

func lock_caught_fruits():
	var fruits=get_caught_fruits()
	for fruit in fruits:
		fruit.mode=MODE_KINEMATIC
		fruits_container.add_child(fruit)
	return fruits


func get_caught_fruits() -> Array:
	var bodies=caught_area.get_overlapping_bodies()
	var fruits=[]
	for body in bodies:
		if body.is_in_group("fruit"):
			fruits.append(body)
	return fruits

