extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var rng = RandomNumberGenerator.new()
var downwardOffset: int = 26
var sprite_frame : int

func _ready():
	Globals.connect("DaySwapped", _on_day_swapped)
	sprite_frame = randi_range(1,6)
	animated_sprite_2d.frame = sprite_frame


func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		if Globals.current_state == Globals.States.NIGHT:
			print("loot grabbed")
			body.set_meta("has_loot", true)
			for child in get_tree().root.get_children():
				if (child is Level):
					print(child.name)
					child.gotGem = true
					break
			animated_sprite_2d.frame = sprite_frame
			print(sprite_frame)
			reparent.call_deferred(body)
			set_deferred("position",Vector2(0,-25))
			
			Globals.playSound("pickup")
			#animated_sprite_2d.play("bag") # TBD See if we want to keep
			collision_shape_2d.set_deferred("disabled",true)
		
		
		
func _on_day_swapped():
	if (get_tree().get_first_node_in_group("Player").get_meta("has_loot", false)):
		get_tree().get_first_node_in_group("Player").set_meta("has_loot", false)
		var new_position = global_position
		reparent(get_tree().root)
		global_position = new_position - Vector2(0, -downwardOffset)
		#animated_sprite_2d.play("bag")
		
		#await get_tree().create_timer(1).timeout
		#collision_shape_2d.disabled = false
		animated_sprite_2d.frame = 0
		collision_shape_2d.set_deferred("disabled", false)
	
