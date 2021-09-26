extends Node

var frankenfruits_list={}
var score=0

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()


func get_random_vector3(max_value:Vector3, min_value:Vector3=Vector3.ZERO) -> Vector3:
	var randx=rng.randf_range(min_value.x, max_value.x)
	var randy=rng.randf_range(min_value.y, max_value.y)
	var randz=rng.randf_range(min_value.z, max_value.z)
	return Vector3(randx,randy,randz)

func get_random_item(items:Array):
	return items[rng.randi_range(0, items.size()-1)]

func reset_score():
	score=0

func reset_frankenfruits():
	frankenfruits_list={}

func set_score(score_):
	score=score_

func add_frankenfruit(frankenfruit):
	if frankenfruits_list.has(frankenfruit.nombre):
		frankenfruits_list[frankenfruit.nombre][1]=frankenfruits_list[frankenfruit.nombre][1]+1
	else:
		frankenfruits_list[frankenfruit.nombre]=[frankenfruit,1]

