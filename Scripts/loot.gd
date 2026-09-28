extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var rng = RandomNumberGenerator.new()

func _ready():
	Globals.connect("DaySwapped", _on_day_swapped)
	animated_sprite_2d.frame = randi_range(0,5)


func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		if Globals.current_state == Globals.States.NIGHT:
			#print("loot grabbed")
			body.set_meta("has_loot", true)
			for child in get_tree().root.get_children():
				if (child is Level):
					print(child.name)
					child.gotGem = true
					break
			reparent.call_deferred(body)
			set_deferred("position",Vector2(0,-25))
			collision_shape_2d.set_deferred("disabled",true)
		
		
		
func _on_day_swapped():
	get_tree().get_first_node_in_group("Player").set_meta("has_loot", false)
	var new_position = global_position
	reparent(get_tree().root)
	global_position = new_position
	
	await get_tree().create_timer(1).timeout
	collision_shape_2d.disabled = false
	
