extends Node2D

var characterBody: CharacterBody2D

@export var baseWalkSpeed: float = 300
@export var inertia: float = 0.7 ## [0-1): 0 is no inertia and 1 is no change
@export var jumpImpuplse: float = 300
var jumpsInARow: int = 0
@export var maxJumpsInARow: int = 2

func _ready() -> void:
	characterBody = get_parent()

func _physics_process(delta: float) -> void:
	var horizontalDelta: float = Input.get_axis("Left", "Right")
	
	horizontalDelta *= baseWalkSpeed
	characterBody.velocity.x = lerpf(characterBody.velocity.x, horizontalDelta, 1-inertia) # Inertia
	characterBody.velocity += characterBody.get_gravity() * delta # Gravity
	if (Input.is_action_just_pressed("Jump") && jumpsInARow < maxJumpsInARow): # Jumping
		characterBody.velocity.y -= jumpImpuplse
		jumpsInARow += 1
		print(jumpsInARow)
	elif (jumpsInARow != 0 && characterBody.is_on_floor()):
		jumpsInARow = 0
	
	
	characterBody.move_and_slide() # Move and slide
