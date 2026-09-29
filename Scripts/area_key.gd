extends Area2D

@onready var KeySprite = $KeySprites
@onready var Collision = $CollisionShape2D
var player

var isKey = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.connect("DaySwapped", _on_day_swapped)
	Globals.connect("NightSwapped", _on_night_swapped)
	Globals.connect("KeyHitDoor", _self_destruct)
	Collision.set_deferred("disabled", true)
	#self.monitoring = false
	

func _on_day_swapped():
	KeySprite.frame = 0
	if player:
		self.position = player.position
		player = null
	self.visible = true
	Collision.set_deferred("disabled", true)
	#self.monitoring = false

func _on_night_swapped():
	KeySprite.frame = 1
	Collision.set_deferred("disabled", false)
	#self.monitoring = true

func _on_body_entered(body: Node) -> void:
	print("body collided")
	if body.hasKey != null:
		player = body
		player.pickUpKey()
		Globals.playSound("pickup")
		self.visible = false
		Collision.set_deferred("disabled", true)

func _self_destruct():
	self.queue_free()
