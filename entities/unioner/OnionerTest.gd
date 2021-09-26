extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var ingredientes={"Manzana":5,"Cebolla":2,"Limon":2,"Platano":2}
	var frankenfruits=$OnionerPlus.create_franken_fruits(ingredientes)

	for frankenfruta in frankenfruits:
		if typeof(frankenfruta)==TYPE_STRING:
			pass
		else:
			self.add_child(frankenfruta)
			frankenfruta.transform.origin=$Position.transform.origin
			frankenfruta.rotate(Vector3.UP,90.0)
			$Position.transform.origin.x=$Position.transform.origin.x+4
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
