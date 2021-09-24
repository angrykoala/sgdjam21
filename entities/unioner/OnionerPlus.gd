extends Spatial


export var combos={"Manzajabolla":[{"Manzana":2,"Naranja":1,"Cebolla":1},12],
					"Manzaranja":[{"Manzana":2,"Naranja":2},9]}


#Narabolla
#Cebonja
#Manalla
#Ceranzana
#Bananolla
#Bananja
#Manana

# Called when the node enters the scene tree for the first time.
func _ready():
	var ingredientes={"Manzana":6,"Naranja":7,"Cebolla":2}

	var texto="Con"
	for ingrediente in ingredientes:
		texto=texto+" "+str(ingredientes[ingrediente])+" "+ingrediente+","
	texto=texto+" se generan:"
	print(texto)
	
	var frankenfruits=create_franken_fruits(ingredientes)
	print(frankenfruits)

func create_franken_fruits(part_list):
	var frankenfruits=[]
	
	var ingredientes=0
	
	for fruta in part_list:
		ingredientes=ingredientes+part_list[fruta]
		
	while ingredientes>=4:
		for combo in combos:
			var repetidos=0
			while suficientes_ingredientes_para_combo(combos[combo][0],part_list):
				repetidos=repetidos+1
	
				frankenfruits.append(combo)
				
				for ingrediente in combos[combo][0]:
					var cantidad=combos[combo][0][ingrediente]
					part_list[ingrediente]=part_list[ingrediente]-cantidad
					ingredientes=ingredientes-cantidad
			if repetidos>0:
				print(str(repetidos)+"x"+combo+": ("+str(combos[combo][1])+" puntos)")
	return frankenfruits
	
func suficientes_ingredientes_para_combo(combo,part_list):
	var suficientes=true
	
	for ingrediente in combo:
		if combo[ingrediente]>part_list[ingrediente]:
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
