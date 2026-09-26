extends Node2D

var characterBody: CharacterBody2D

@export var maxGracePeriod: float = 1 # Seconds
var spottedTime: float = 0
var isSpotted: bool = false

func _ready() -> void:
	characterBody = get_parent()

func _process(delta: float) -> void:
	if (isSpotted):
		print("SPOTTED!!!: " + str(spottedTime))
		if (spottedTime <= maxGracePeriod):
			spottedTime += delta
		else:
			push_error("SPOTTED")
