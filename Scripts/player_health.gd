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
			die()
			
func die(reason: String = "You were caught!"):
	characterBody.find_child("GameOverLayer").find_child("GameOverScreen").gameOver(reason)


func win():
	characterBody.hide()
	characterBody.find_child("WinLayer").find_child("WinScreen").win()
