extends Control

@export var menuScene: PackedScene

func _ready() -> void:
	position.y = -get_viewport_rect().size.y
	visible = false

func gameOver() -> void:
	visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(0, 0), 1.0)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	get_tree().paused = true

func _on_restart_button_pressed() -> void:
	Globals.setDayNight(Globals.States.DAY)
	get_tree().paused = false
	get_tree().reload_current_scene()
