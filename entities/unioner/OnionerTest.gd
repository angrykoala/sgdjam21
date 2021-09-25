extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var ingredientes={"Manzana":6,"Naranja":9,"Cebolla":4}
	var frankenfruits=$OnionerPlus.create_franken_fruits(ingredientes)

	for frankenfruta in frankenfruits:
		if typeof(frankenfruta)==TYPE_STRING:
			pass
		else:
			self.add_child(frankenfruta)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
