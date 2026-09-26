extends Area2D
class_name Spotlight2D

@export var targetPathPos: PathFollow2D
@export var moveSpeed: float = 100

var smoothingFactor: float = 0.01

func _ready() -> void:
	global_position = targetPathPos.global_position

func _process(delta: float) -> void:
	targetPathPos.progress += delta * moveSpeed
	global_position = lerp(global_position, targetPathPos.global_position, smoothingFactor)



func _on_body_entered(body: Node2D) -> void:
	if (body is CharacterBody2D):
		var playerHealthNode = body.find_child("PlayerHealth")
		if (playerHealthNode):
			playerHealthNode.isSpotted = true


func _on_body_exited(body: Node2D) -> void:
	if (body is CharacterBody2D):
		var playerHealthNode = body.find_child("PlayerHealth")
		if (playerHealthNode):
			playerHealthNode.isSpotted = false
