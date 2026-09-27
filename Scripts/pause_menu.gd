extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Pause")):
		toggle_pause()

func toggle_pause():
	if get_tree().paused:
		unpause()
	else: 
		pause()

func unpause():
	self.visible = false
	get_tree().paused = false

func pause():
	get_tree().paused = true
	self.visible = true
