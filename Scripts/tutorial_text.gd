extends Node

@onready var textObj = $TutorialText
@export var text : String = ""

func _ready() -> void:
	textObj.visible = false
	textObj.text = text

func _on_open_text_body_entered(body: Node2D) -> void:
	print("happened")
	textObj.visible = true
	await get_tree().create_timer(10).timeout
	textObj.visible = false
	self.queue_free()
