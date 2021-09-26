extends Spatial

export(Array, PackedScene) var fruits

export var min_spawn_force=Vector2(-10, 5)
export var max_spawn_force=Vector2(10, 15)
export var torque_force=0.5
export var drop_time_reducer=0.0
export var min_time=0.2

onready var max_torque_force=Vector3(torque_force, torque_force, torque_force)
onready var _min_spawn_force=Vector3(min_spawn_force.x,min_spawn_force.y, 0)
onready var _max_spawn_force=Vector3(max_spawn_force.x,max_spawn_force.y, 0)
onready var timer=$SpawnTimer

func spawn_fruit()->void:
	var fruit=get_fruit()
	var fruit_instance=fruit.instance() as RigidBody
	var spawn_force=Utils.get_random_vector3(_max_spawn_force, _min_spawn_force)

	fruit_instance.add_central_force(spawn_force)
	fruit_instance.add_torque(Utils.get_random_vector3(max_torque_force))
	add_child(fruit_instance)


func _on_spawn_timeout() -> void:
	spawn_fruit()
	timer.wait_time-=drop_time_reducer
	if timer.wait_time<=min_time:
		timer.wait_time=min_time


func get_fruit()->PackedScene:
	return Utils.get_random_item(fruits)
