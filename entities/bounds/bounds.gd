extends Area

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("fruit"):
		despawn(body)


func despawn(node: Node)->void:
	node.queue_free()
