extends RigidBody

var puntuacion=1
var variedad=0
var completitud=0
var acidez=0

var nombre="Frankenfruta"
var frutas=["Manzana","Limon","Naranja","Cebolla","Platano"]
var codigo_fruta={"Manzana":0,"Limon":1,"Naranja":2,"Cebolla":3,"Platano":4}
onready var nodos_frutas={"Manzana":$Manzana,"Limon":$Limon,"Naranja":$Naranja,
	"Cebolla":$Cebolla,"Platano":$Platano}
var visibles_piezas=[null,null,null,null] setget mostrar_frankenfruta, get_visible

var gritos = {"feliz": ["vitaminas1", "vitaminas2", "wiiii1", "wiiii2",
	"yuhu1", "yuhu2", "wohohoho", "wohohoho2"],
	"decente": ["aaaah", "ooooh", "ooooh2"],
	"triste": ["horrible1", "horrible2", "memuero1", "memuero2"] }

var sfx = AudioStreamPlayer.new()
var timer_sound = Timer.new()

func get_visible():
	return visibles_piezas

#TODO: mejorar usando los puntos para "asignar_sonido"
func fraccion_piezas_iguales():
	
	var npiezas = 4
	var iguales = 0
	var nonnull = 0
	for i in range(npiezas):
		var pieza1 = visibles_piezas[i]
		nonnull += int(pieza1 != null)
		for j in range(i+1, npiezas-1):
			var pieza2 = visibles_piezas[j]
			iguales += int(pieza1 == pieza2 and pieza1 != null)
	
	return iguales / (1.0 * nonnull) + nonnull / 4.0

func asignar_sonido():
	var fraccion = fraccion_piezas_iguales()
	
	print(fraccion)
	
	var gritoarray = null
	if fraccion > 0.8:
		gritoarray = gritos["feliz"]
	elif fraccion > 0.4: 
		gritoarray = gritos["decente"]
	else:
		gritoarray = gritos["triste"]
	
	var randindex = randi() % len(gritoarray)
	var grito = load("res://assets/Sonido/SFX/" + gritoarray[randindex] + ".wav")
	
	sfx.stream = grito
	sfx.bus = "sfx"
	sfx.pitch_scale = rand_range(0.7,1.4)
	timer_sound.wait_time = rand_range(0.3, 2.0)
	timer_sound.connect("timeout", self, "scream")
	timer_sound.one_shot = true
	add_child(timer_sound)
	add_child(sfx)

func scream():
	sfx.play()

func start_timer_2_scream():
	timer_sound.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	# limpiar()
	#mostrar_frankenfruta(visibles)
	asignar_sonido()
	pass

func limpiar():
	for fruta in frutas:
		for nodo in nodos_frutas[fruta].get_children():
			nodo.visible=false
		# nodos_frutas[fruta].visible=false
		
func mostrar_frankenfruta(visibles_):
	var cuadrantes=["1_4AA","1_4A","1_4B","1_4BB"]
	
	for i in range(0,len(visibles_)):
		if visibles_[i]!=null:
			var visible=frutas[visibles_[i]]
			if visible!=null:
				var nodo=get_node(visible+"/"+visible+"-"+cuadrantes[i])
				nodo.visible=true
				nodo=get_node(visible)
				nodo.visible=true
				# print(visible+"/"+visible+"-"+cuadrantes[i])
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	pass
	#move_and_slide()
