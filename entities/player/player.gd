extends Spatial

onready var left_hand=$LeftHand
onready var right_hand=$RightHand

onready var clap_center=$ClapCenter

onready var frankenfruits_generator=$FrankenFruitsBase

var fruit_caught_left=[]
var fruit_caught_right=[]

func _ready()->void:
	left_hand.connect("clap_end", self, "on_clap_end")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clap") and can_clap():
		fruit_caught_left = left_hand.on_clap(clap_center.translation)
		fruit_caught_right = right_hand.on_clap(clap_center.translation)

func can_clap()->bool:
	return left_hand.can_clap() and right_hand.can_clap()

func on_clap_end() -> void:
	var fruit_parts:={}
	for fruit in fruit_caught_left:
		add_fruit_part_to_group(fruit, fruit_parts)
		fruit.queue_free()
	for fruit in fruit_caught_right:
		add_fruit_part_to_group(fruit, fruit_parts)
		fruit.queue_free()
	print(fruit_parts)

	# frankenfruits_generator.create_frankenfruits(fruit_parts,clap_center.global_transform.origin)
	frankenfruits_generator.create_frankenfruits(fruit_parts,clap_center)


func add_fruit_part_to_group(part: FruitPart, group:Dictionary)->Dictionary:
	var fruit_name=part.fruit_name
	var current_value=group.get(fruit_name, 0)
	group[fruit_name]=current_value+1
	return group
