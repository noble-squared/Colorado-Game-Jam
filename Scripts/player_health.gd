extends Node2D

var characterBody: CharacterBody2D

@export var maxGracePeriod: float = 1 # Seconds
var spottedTime: float = 0
var isSpotted: bool = false

func _ready() -> void:
	characterBody = get_parent()

func _process(delta: float) -> void:
	if (isSpotted):
		if (spottedTime <= maxGracePeriod):
			spottedTime += delta
		else:
			# TODO Maybe change this to be better
			die()
			
func die():
	characterBody.get_parent().find_child("GameOverLayer").find_child("GameOverScreen").gameOver()
