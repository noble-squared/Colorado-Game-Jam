extends Area2D

@onready var objectiveText: Label = $Label

func _on_body_entered(body: Node2D) -> void:
	if (body is CharacterBody2D):
		var playerHealthNode = body.find_child("PlayerHealth")
		if (playerHealthNode):
			if (body.get_meta("has_loot", false)):
				playerHealthNode.win()
			else:
				objectiveText.visible = true

func _on_body_exited(body: Node2D) -> void:
	if (body is CharacterBody2D):
		var playerHealthNode = body.find_child("PlayerHealth")
		if (playerHealthNode):
			objectiveText.visible = false
