extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready():
	Globals.connect("DaySwapped", _on_day_swapped)

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		if Globals.current_state == Globals.States.NIGHT:
			print("loot grabbed")
			reparent.call_deferred(body)
			set_deferred("position",Vector2(0,-40))
			collision_shape_2d.set_deferred("disabled",true)
		
		
		
func _on_day_swapped():
	var new_position = global_position
	reparent(get_tree().root)
	global_position = new_position
	
	await get_tree().create_timer(1).timeout
	collision_shape_2d.disabled = false
	
