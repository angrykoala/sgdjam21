extends RigidBody


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

export var nombre="Fruit"
export var visibles=[true,true,true,true]

#export var init_arc=0.0 setget set_init_arc, get_init_arc
#export var end_arc=360.0 setget set_end_arc, get_end_arc
#
#func set_init_arc(valor):
#	init_arc=valor
#
#func get_init_arc():
#	return init_arc
#
#func set_end_arc(valor):
#	end_arc=valor
#
#func get_end_arc():
#	return end_arc
#
#func show_fruit_arc(init_arc_,end_arc_):
#	if init_arc_>end_arc_:
#		var tmp=end_arc_
#		end_arc_=init_arc_
#		init_arc_=tmp
#
#	var node=get_node("1-4")
#	if node!=null and init_arc_>=0 and init_arc_<90:
#		node.visible=true
#	else:
#		node.visible=false
#
#	node=get_node("2-4")
#	if node!=null and init_arc_>=90 and init_arc_<=180:
#		node.visible=true
#	else:
#		node.visible=false
#
#	node=get_node("3-4")
#	if node!=null and init_arc_>180 and end_arc_<=270:
#		node.visible=true
#	else:
#		node.visible=false
#
#	node=get_node("4-4")
#	if node!=null and init_arc_>270 and end_arc_<=360:
#		node.visible=true
#	else:
#		node.visible=false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# show_fruit_arc(init_arc,end_arc)
	show_fruit_quadrant(visibles)

func show_fruit_quadrant(visibles_):

	for cuarto in range(1,5):
		var node=get_node(str(cuarto)+"-4")
		if node!=null:
			node.visible=visibles_[cuarto-1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
