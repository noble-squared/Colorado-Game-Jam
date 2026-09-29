extends Area2D

@onready var objectiveText: Label = $Label
var isEntered
var speed
func _ready() -> void:
	isEntered = false
	position.x -= 30
	speed = 30

func _on_body_entered(body: Node2D) -> void:
	if (body is CharacterBody2D):
		
		var playerHealthNode = body.find_child("PlayerHealth")
		if (playerHealthNode):
			if (body.get_meta("has_loot", false)):
				isEntered = true
				playerHealthNode.win()
				
			else:
				
				objectiveText.visible = true
				
				

func _on_body_exited(body: Node2D) -> void:
	if (body is CharacterBody2D):
		var playerHealthNode = body.find_child("PlayerHealth")
		if (playerHealthNode):
			objectiveText.visible = false

func _physics_process(delta: float) -> void:
	if(isEntered && position.x > -500):
		position.x += -1 * speed * delta
		speed += 5
		print("dribing")
