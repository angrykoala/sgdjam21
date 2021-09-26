extends Node

var frankenfruits_list={}
var score=0

var rng = RandomNumberGenerator.new()
var music = AudioStreamPlayer.new()
var click = AudioStreamPlayer.new()

var current_scene = "menu"

func _ready() -> void:
	rng.randomize()
	music.bus = "Master"
	music.stream = preload("res://assets/Sonido/intro.ogg")
	#music.connect("finished", self, "end_game")
	add_child(music)
	music.play()
	
	click.bus = "sfx"
	click.stream= load("res://assets/Sonido/SFX/menu.wav")
	add_child(click)

func change_music(new_music):
		music.stop()
		music.stream = load("res://assets/Sonido/" + new_music + ".ogg")
		music.play()

func get_random_vector3(max_value:Vector3, min_value:Vector3=Vector3.ZERO) -> Vector3:
	var randx=rng.randf_range(min_value.x, max_value.x)
	var randy=rng.randf_range(min_value.y, max_value.y)
	var randz=rng.randf_range(min_value.z, max_value.z)
	return Vector3(randx,randy,randz)

func get_random_displacement(disp:float) -> Vector3:
	var randdisp = rng.randf_range(-disp, disp)
	return Vector3(randdisp, 0.0, 0.0)
	

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

