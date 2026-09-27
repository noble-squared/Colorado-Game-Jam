extends Area2D

	

func _on_body_entered(body: Node2D) -> void:
	print("Player Collided with guard")
	if body.is_in_group("Player") && body.get_meta("has_loot"):
		
		body.get_node("PlayerHealth").die()
