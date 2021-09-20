extends Area

func _on_body_exited(body: Node) -> void:
	despawn(body)


func despawn(node: Node)->void:
	node.queue_free()
