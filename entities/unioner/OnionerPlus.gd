extends Spatial

# var frutas_scenes = {"Manzana":preload("res://entities/fruits/apple/Manzana.tscn"),
#		"Naranja":preload("res://entities/fruits/orange/Naranja.tscn")
#		}

var Frankenfruta=preload("res://entities/fruits/FrankenFruta.tscn")
export var combos={"Manzajabolla":[{"Manzana":2,"Naranja":1,"Cebolla":1},12],
					"Manzaranja":[{"Manzana":2,"Naranja":2},9]}


#Narabolla
#Cebonja
#Manalla
#Ceranzana
#Bananolla
#Bananja
#Manana

#Elena:
#Naramon
#Limonmanzplat

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#test()
	# print(frankenfruits)
func test():
	var ingredientes={"Manzana":6,"Naranja":9,"Cebolla":0}

	var texto="Con"
	for ingrediente in ingredientes:
		texto=texto+" "+str(ingredientes[ingrediente])+" "+ingrediente+","
	texto=texto+" se generan:"
	print(texto)
	
	var frankenfruits=create_franken_fruits(ingredientes)
	
	
func create_franken_fruits(part_list):
	var frankenfruits=[]
	
	var ingredientes=0
	
	for fruta in part_list:
		ingredientes=ingredientes+part_list[fruta]
	
	# Let's find a known full combo
	var posibilidad_de_combos=true
	while ingredientes>=4 and posibilidad_de_combos:
		for combo in combos:
			posibilidad_de_combos=false
			var repetidos=0
			while suficientes_ingredientes_para_combo(combos[combo][0],part_list):
				posibilidad_de_combos=true
				repetidos=repetidos+1
	
				frankenfruits.append(combo)
				
				for ingrediente in combos[combo][0]:
					if ingrediente in part_list:
						var cantidad=combos[combo][0][ingrediente]
						part_list[ingrediente]=part_list[ingrediente]-cantidad
						ingredientes=ingredientes-cantidad

			if repetidos>0:
				print(str(repetidos)+"x"+combo+": ("+str(combos[combo][1])+" puntos)")
	
	# Any fruit part is still available?
	while ingredientes>0:
		var frutilla={}
		var trozos_frutilla=0
		
		for fruta in part_list:
			if trozos_frutilla<4:
				#var trozos=rng.randi_range(0,part_list[fruta])
				var trozos=min(part_list[fruta],max(0,4-trozos_frutilla))
				frutilla[fruta]=trozos
				part_list[fruta]=part_list[fruta]-trozos
				ingredientes=ingredientes-trozos
				trozos_frutilla=trozos_frutilla+trozos
			
#		part_list=ordenar_ingredientes(part_list)
		var frutilla_ordenada=ordenar_ingredientes(frutilla)
		var nombre=generar_nombre(frutilla_ordenada) # añadir si es manzana completa, el nombre completo
		var puntuacion=generar_puntuacion(frutilla_ordenada)
		var frutaa=instanciar_frankenfruta(nombre,frutilla_ordenada)
		frutaa.puntuacion=puntuacion
		frankenfruits.append(frutaa)
		
	return frankenfruits

func generar_puntuacion(frutilla_ordenada): # To complete!
	return 10
	
func ordenar_ingredientes(part_list):
	var ordenado=[]
	
	var mayor
	
	while not part_list.empty():
		mayor=null
		for ingrediente in part_list:
			if mayor==null or (part_list[mayor]<=part_list[ingrediente] and part_list[ingrediente]>0):
				mayor=ingrediente
		
		# ordenado.append(mayor)
		if mayor!=null:
			ordenado.append([mayor,part_list[mayor]])
			
		part_list.erase(mayor)
				
	return ordenado
	
func generar_nombre(part_list):
	var lexi={"Manzana":["man","za","na"],"Naranja":["na","ran","ja"],
		"Cebolla":["ce","bo","lla"],"Platano":["pla","ta","no"],"Banana":["ba","na","na"],
		"Limon":["li","mon"]}
	
	var nombre=""
	
	for ingrediente_ in part_list:
		var ingrediente=ingrediente_[0]
		var silabas=len(lexi[ingrediente])
		nombre=nombre+lexi[ingrediente][rng.randi_range(0,silabas-1)]	# We could use the number of parts to add repeteability
	
	nombre=nombre.substr(0,1).to_upper()+nombre.substr(1)
	
	var sufijo=nombre.substr(len(nombre)-1)
	var fruta_mayor=part_list[0][0]
	var sufijo_fruta_mayor=fruta_mayor.substr(len(part_list[0])-1)
	if sufijo!=sufijo_fruta_mayor:
		nombre=nombre+sufijo_fruta_mayor
		
	return nombre
		
func instanciar_frankenfruta(nombre,part_list):
	var offset=rng.randi_range(0,3)
	offset=0 #### comment to create different combinations
	var frankenfruta=Frankenfruta.instance()
	frankenfruta.nombre=nombre
	
	#print(nombre+" "+str(part_list))
	for fruta_ in part_list:
		var fruta=fruta_[0]
		var cantidad=fruta_[1]
		
		if cantidad>0:
			for i in range(0,cantidad):
				var visible=false
				
				if cantidad>0:
					frankenfruta.visibles_piezas[(i+offset)%4]=frankenfruta.codigo_fruta[fruta]
			
			offset=(offset+cantidad)%4
	
	frankenfruta.mostrar_frankenfruta(frankenfruta.visibles_piezas)
	return frankenfruta

func suficientes_ingredientes_para_combo(combo,part_list):
	var suficientes=true
	
	for ingrediente in combo:
		if ingrediente in part_list:
			if combo[ingrediente]>part_list[ingrediente]:
				suficientes=false
				break
		else:
			suficientes=false
			break
	
	return suficientes
		
func create_franken_fruits_optimal__(part_list):
	
	var combinacion=[]
	combinacion.resize(10)
	combinacion=probar(combinacion,0,part_list)
	
func probar(combinacion,posicion,part_list):

	var fruits=0
	for fruta in part_list:
		if part_list[fruta]>0:		
			fruits=fruits+1
			#if combinacion[posicion]!=fruta:
			var part_list_=part_list.duplicate()
			part_list_[fruta]=part_list_[fruta]-1
		
			combinacion[posicion]=fruta
			probar(combinacion,posicion+1,part_list_)
	
	if fruits==0:
		print(combinacion)
			
func create_franken_fruits_(part_list_):
	var part_list=[]
	
	for fruta in part_list_:
		for i in range(0,part_list_[fruta]):
			part_list.append(fruta)	
	
	var combinacion=[]
	combinacion.resize(7)
	combinacion=probar(combinacion,0,part_list)
	
func probar_(combinacion,posicion,part_list):
	
	if len(part_list)>0:
		for parte in part_list:
			var i=part_list.find(parte)
			var part_list_=part_list.duplicate()
			part_list_.remove(i)
		
			combinacion[posicion]=parte
			probar(combinacion,posicion+1,part_list_)
	else:
		print(combinacion)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
