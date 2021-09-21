extends KinematicBody

enum HAND {
	LEFT,
	RIGHT
}

export var speed=1
export(HAND) var hand=HAND.RIGHT


func _physics_process(delta: float) -> void:
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

	var velocity = direction.normalized() * speed * 0.1
	move_and_collide(velocity)
