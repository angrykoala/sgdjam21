extends Spatial

onready var left_hand=$LeftHand

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clap"):
		print("CLAP")
		var fruits=left_hand.lock_caught_fruits()
		print("Points", fruits.size())
		for fruit in fruits:
			fruit.queue_free()
