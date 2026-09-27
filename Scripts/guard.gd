extends Area2D

enum Direction {Forward, Backward}
enum State {Standing, Walking}

@export var targetPath: Path2D
@export var moveSpeed: float = 50
@export var stopDuration: float = 3
@export var direction: Direction = Direction.Forward
@export var currPoint: int = 0
@export var loop: bool = true
var currState: State = State.Standing

@onready var waitTimer := $WaitTimer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	print("Player Collided with guard")
	if body.is_in_group("Player") && body.get_meta("has_loot"):
		
		body.get_node("PlayerHealth").die()

func _ready() -> void:
	sprite.play("stationary")
	if (not targetPath or targetPath.curve.point_count <= 1):
		# Stationary guard
		push_warning("Guard will be stationary")
		if (targetPath and targetPath.curve.point_count == 1):
			position = targetPath.curve.get_point_position(currPoint)
		return
	position = targetPath.curve.get_point_position(currPoint)
	waitTimer.one_shot = true
	waitTimer.wait_time = stopDuration
	waitTimer.start()

func _process(delta: float) -> void:
	if (currState == State.Walking):
		var targetpos: Vector2 = (targetPath.curve.get_point_position(currPoint) - position).limit_length(moveSpeed * delta)
		position += targetpos
		
		if (position.is_equal_approx(targetPath.curve.get_point_position(currPoint))):
			sprite.play("stationary")
			currState = State.Standing
			waitTimer.start()

func _on_wait_timer_timeout() -> void:
	currPoint += 1 if (direction == Direction.Forward) else -1
	if (currPoint >= targetPath.curve.point_count):
		if (loop):
			currPoint = 0
		else:
			currPoint = targetPath.curve.point_count - 2
			direction = Direction.Backward
	elif (currPoint < 0):
		if (loop):
			currPoint = targetPath.curve.point_count - 1
		else:
			currPoint = 1
			direction = Direction.Forward
	currState = State.Walking
	sprite.play("moving")
	sprite.flip_h = (targetPath.curve.get_point_position(currPoint) - position).x < 0
	
