extends Spatial

export(Array, PackedScene) var fruits

export var min_spawn_force=Vector2(-10, 5)
export var max_spawn_force=Vector2(10, 15)
export var torque_force=0.5

var stage = 0
var accumulated_time = 0.0
var hit_stage = 0
var hit_times = [60+10.957, 60+11.285, 60+12.029, 60+46.07, 60+46.7, 60+47.48, 60+48.88, 60+55.1, 60+55.73, 60+56.46, 60+57.02, 60+57.6, 60+58.3, 60+59.02, 60+59.65, 120.0, 120 + 0.98, 120+1.6]
var amount_hit = [3,        3,         6,         3,        3,       2,        2,        2,       2,        2,         2,       2,       2,       3,        3,        3,     3,          3]
var stage_time = [0.0, 23.43, 46.395, 53.06, 60+12.174, 60+41, 60+50.30]
var drop_rates = [0.8, 2.2,   3.0,    3.5,   5.5,       6.2,   7.0]

var delay_fruitafall = 0.7

var random_spawner = Timer.new()

var next_hit
var next_stage

onready var max_torque_force=Vector3(torque_force, torque_force, torque_force)
onready var _min_spawn_force=Vector3(min_spawn_force.x,min_spawn_force.y, 0)
onready var _max_spawn_force=Vector3(max_spawn_force.x,max_spawn_force.y, 0)

func _ready():
	random_spawner.one_shot = false
	random_spawner.wait_time = poisson(drop_rates[0])
	random_spawner.connect("timeout", self, "timer_spawn")
	
	next_stage = stage_time[1] - delay_fruitafall
	next_hit = hit_times[0] - delay_fruitafall
	
	add_child(random_spawner)
	random_spawner.start()
	

#Genera numeros aleatorios segun una distribucion de Poisson
func poisson(rate):
	return -log(randf())/rate


func spawn_fruit(use_random_force:bool)->void:
	
	#Create the fruit
	var fruit=get_fruit()
	var fruit_instance=fruit.instance() as RigidBody
	var spawn_force=Utils.get_random_vector3(_max_spawn_force, _min_spawn_force)
	
	if use_random_force:
		fruit_instance.add_central_force(spawn_force)
	else:
		fruit_instance.translate(Vector3(0,-2.0,0))
	
	fruit_instance.add_torque(Utils.get_random_vector3(max_torque_force))
	fruit_instance.translate(Utils.get_random_displacement(1.0)) 
	add_child(fruit_instance)

func timer_spawn():
	spawn_fruit(true)
	if Utils.current_scene == "game":
		random_spawner.wait_time = poisson(drop_rates[stage])
	else:
		random_spawner.wait_time = poisson(drop_rates[0])

func _process(delta):
	var musicpos = Utils.music.get_playback_position() 
	
	if musicpos >= next_hit and hit_stage+1 < len(hit_times):
		for j in range(amount_hit[hit_stage]):
			spawn_fruit(false)
		hit_stage += 1
		next_hit = hit_times[hit_stage] - delay_fruitafall
		print("hit hit")
	
	if musicpos >= next_stage and stage+2 < len(stage_time):
		next_stage = stage_time[stage+2] - delay_fruitafall
		stage += 1
		print("next stage " + str(stage))
	



func get_fruit()->PackedScene:
	return Utils.get_random_item(fruits)
