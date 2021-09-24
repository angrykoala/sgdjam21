extends Spatial

onready var left_hand=$LeftHand
onready var right_hand=$RightHand

onready var clap_center=$ClapCenter

var fruit_caught_left=[]
var fruit_caught_right=[]

func _ready()->void:
	left_hand.connect("clap_end", self, "on_clap_end")
	right_hand.connect("clap_end", self, "on_clap_end")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clap") and can_clap():
		print("CLAP")
		fruit_caught_left = left_hand.on_clap(clap_center.translation)
		fruit_caught_right = right_hand.on_clap(clap_center.translation)

func can_clap()->bool:
	return left_hand.can_clap() and right_hand.can_clap()

func on_clap_end() -> void:
	for fruit in fruit_caught_left:
		fruit.queue_free()
	for fruit in fruit_caught_right:
		fruit.queue_free()
