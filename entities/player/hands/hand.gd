extends RigidBody

enum HAND {
	LEFT,
	RIGHT
}

enum HAND_STATE {
	READY,
	CLAPPING,
	RETURNING
}

const clap_duration=0.2
const clap_padding=0.5

export var speed=1
export(HAND) var hand=HAND.RIGHT

onready var caught_area: Area=$CaughtArea
onready var fruits_container: Spatial=$Fruits

onready var left_mesh=$LeftHandMesh
onready var right_mesh=$RightHandMesh

onready var thumb_collision_left=$ThumbCollisionLeft
onready var thumb_collision_right=$ThumbCollisionRight

onready var tween=$Tween

var position_before_clap

var state=HAND_STATE.READY

signal clap_end

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
	if state==HAND_STATE.READY:
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
		var parent=fruit.get_parent() as Node
		var old_transform=fruit.global_transform
		fruit.remove_from_group("fruit") #TO avoid despawning
		parent.remove_child(fruit)
		fruits_container.add_child(fruit)
		fruit.global_transform=old_transform
		fruit.add_to_group("fruit")
	return fruits


func get_caught_fruits() -> Array:
	var bodies=caught_area.get_overlapping_bodies()
	var fruits=[]
	for body in bodies:
		if body.is_in_group("fruit"):
			fruits.append(body)
	return fruits


func on_clap(final_position:Vector3):
	var fruits=lock_caught_fruits()
	position_before_clap=translation
	tween.interpolate_property(self, "translation",
		translation,get_clap_position(final_position), clap_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "rotation_degrees",
		rotation_degrees,Vector3(0,0,get_clap_rotation()), clap_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	state=HAND_STATE.CLAPPING
	return fruits

func _on_tween_all_completed() -> void:
	if state==HAND_STATE.CLAPPING:
		state=HAND_STATE.RETURNING
		tween.interpolate_property(self, "translation",
		translation,position_before_clap, clap_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

		tween.interpolate_property(self, "rotation_degrees",
		rotation_degrees,Vector3(0,0,0), clap_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		emit_signal("clap_end")
	elif state==HAND_STATE.RETURNING:
		state=HAND_STATE.READY

func get_clap_rotation()->int:
	match hand:
		HAND.RIGHT:
			return 90
		HAND.LEFT, _:
			return -90

func get_clap_position(base_position:Vector3)->Vector3:
	match hand:
		HAND.RIGHT:
			return base_position+Vector3(clap_padding,0,0)
		HAND.LEFT, _:
			return base_position-Vector3(clap_padding,0,0)

func can_clap()->bool:
	return state==HAND_STATE.READY
