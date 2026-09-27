extends Node2D

var characterBody: CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

@export var baseWalkSpeed: float = 300
@export var inertia: float = 0.85 ## [0-1): 0 is no inertia and 1 is no change
@export var jumpImpulse: float = 400
@export var wallJumpImpulse: Vector2 = Vector2(900, 300)
var jumpsInARow: int = 0
@export var maxJumpsInARow: int = 2
@export var wallSlideVerticalCurbCurve: Curve
var timeWallRiding: float = 0
var maxTimeWallRiding: float = 0.8

var leftMoveLimit: float = -1
var rightMoveLimit: float = 1
var leftMoveRegen: float = -2.5
var rightMoveRegen: float = 2.5

func _ready() -> void:
	characterBody = get_parent()

func applyNormalGravity(delta: float) -> void:
	characterBody.velocity += characterBody.get_gravity() * delta # Gravity

func _physics_process(delta: float) -> void:
	var horizontalDelta: float = clampf(Input.get_axis("Left", "Right"), leftMoveLimit, rightMoveLimit)
	if (leftMoveLimit > -1):
		leftMoveLimit = clampf(leftMoveLimit + leftMoveRegen * delta, -1, 0)
	if (rightMoveLimit < 1):
		rightMoveLimit = clampf(rightMoveLimit + rightMoveRegen * delta, 0, 1)
		
	horizontalDelta *= baseWalkSpeed
	characterBody.velocity.x = lerpf(characterBody.velocity.x, horizontalDelta, 1-inertia) # Inertia

	#characterBody.velocity += characterBody.get_gravity() * delta # Gravity
	if (horizontalDelta != 0 && characterBody.is_on_wall_only() && sign(horizontalDelta) != sign(characterBody.get_wall_normal().x)): # Wall sliding
		animated_sprite_2d.flip_h = (sign(characterBody.get_wall_normal().x) ==-1)
		if (characterBody.velocity.y < 0): characterBody.velocity.y = 0
		if (timeWallRiding < maxTimeWallRiding):
			#jumpsInARow = 0
			timeWallRiding += delta
			characterBody.velocity = characterBody.get_gravity() * delta * wallSlideVerticalCurbCurve.sample(timeWallRiding / maxTimeWallRiding)
		else:
			applyNormalGravity(delta)
		if (Input.is_action_just_pressed("Jump") && jumpsInARow < maxJumpsInARow && sign(horizontalDelta) != 0):
			jumpsInARow += 1
			characterBody.velocity.y = -wallJumpImpulse.y
			characterBody.velocity.x -= wallJumpImpulse.x * sign(horizontalDelta)
			if (sign(horizontalDelta)):
				leftMoveLimit = 0
			else:
				rightMoveLimit = 0
	else:
		applyNormalGravity(delta)
		if (Input.is_action_just_pressed("Jump") && jumpsInARow < maxJumpsInARow): # Jumping
			characterBody.velocity.y = -jumpImpulse
			jumpsInARow += 1
			print(jumpsInARow)
		elif (characterBody.is_on_floor()):
			timeWallRiding = 0
			jumpsInARow = 0
	
	if(horizontalDelta <0 && !characterBody.is_on_wall_only()):
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.offset.x = -4
		
	elif(horizontalDelta >0 && !characterBody.is_on_wall_only()):
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.offset.x = 4
	else:
		animated_sprite_2d.play("default")
		
	if(characterBody.is_on_floor()):
		if(horizontalDelta <0):
			animated_sprite_2d.play("Walk")
		
		elif(horizontalDelta >0):
			animated_sprite_2d.play("Walk")
	elif(characterBody.is_on_wall_only()):
		animated_sprite_2d.play("Wall Slide")
		
	else:
		animated_sprite_2d.play("Jump")
	
	characterBody.move_and_slide() # Move and slide
