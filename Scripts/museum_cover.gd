extends TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.connect("KeyHitDoor", _self_destruct)

func _self_destruct():
	self.queue_free()
