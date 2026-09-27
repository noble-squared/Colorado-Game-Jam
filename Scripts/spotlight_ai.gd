extends Area2D
class_name Spotlight2D

@export var targetPathPos: PathFollow2D
@export var moveSpeed: float = 100
@onready var light: Sprite2D = $light

var smoothingFactor: float = 1

var chaseGlobalPosition: Vector2 = Vector2.INF: set = setChasePos
var spotlightMinDistance: float = 10
var spotlightChaseTime: float = 5
var spotlightCurrentChaseTime: float = 0

func _ready() -> void:
	global_position = targetPathPos.global_position
	light.modulate.a = 1
func _process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if (body is CharacterBody2D):
			if (body.find_child("PlayerHealth")):
				chaseGlobalPosition = body.global_position
	
	if (chaseGlobalPosition.is_finite()): # Move towards chase location
		var deltaVector = (chaseGlobalPosition - global_position)
		if (deltaVector.length() < spotlightMinDistance):
			if (spotlightCurrentChaseTime < spotlightChaseTime):
				spotlightCurrentChaseTime += delta
			else:
				spotlightCurrentChaseTime = 0
				chaseGlobalPosition = Vector2.INF
				return
		
		elif (deltaVector.length() > moveSpeed):
			deltaVector = deltaVector.normalized() * moveSpeed
		global_position = lerp(global_position, global_position + deltaVector, smoothingFactor * delta)
	else: # Otherwise, follow path
		targetPathPos.progress += delta * moveSpeed
		global_position = lerp(global_position, targetPathPos.global_position, smoothingFactor * delta)

func _on_body_entered(body: Node2D) -> void:
	if (body is CharacterBody2D):
		light.modulate.a = 1
		var playerHealthNode = body.find_child("PlayerHealth")
		if (playerHealthNode):
			playerHealthNode.isSpotted = true

func _on_body_exited(body: Node2D) -> void:
	if (body is CharacterBody2D):
		var playerHealthNode = body.find_child("PlayerHealth")
		if (playerHealthNode):
			playerHealthNode.isSpotted = false
			
func setChasePos(pos: Vector2):
	chaseGlobalPosition = pos
	if (pos.is_finite()):
		spotlightCurrentChaseTime = 0
