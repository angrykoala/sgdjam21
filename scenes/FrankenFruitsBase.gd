extends Spatial

signal fruta_creada(nodo_fruta)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var default_position =  $Table/Corners/Center.global_transform.origin
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func create_frankenfruits(ingredients,parent):
	var ingredientes={}
	var translation_={"onion":"Cebolla","apple":"Manzana","lemon":"Limon","orange":"Naranja","banana":"Platano"}
	for ingredient in ingredients:
		ingredientes[translation_[ingredient]]=ingredients[ingredient]
	
	var frankenfruits=$OnionerPlus.create_franken_fruits(ingredientes)

	for frankenfruta in frankenfruits:
		if typeof(frankenfruta)==TYPE_STRING:
			pass
		else:
			parent.add_child(frankenfruta)
			frankenfruta.global_transform.origin=parent.global_transform.origin
			frankenfruta.rotate(Vector3.UP,90.0) # hack para que mirten las frutas...
			emit_signal("fruta_creada",frankenfruta)
			#$Position.transform.origin.x=position_.transform.origin.x+4
