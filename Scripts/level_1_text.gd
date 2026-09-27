extends Area2D


@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	label.visible = false
	label_2.visible = false
	


func _on_body_entered(body: Node2D) -> void:
	collision_shape_2d.set_deferred("disabled",true)
	if body.is_in_group("Player"):
		label.visible = true
		await get_tree().create_timer(4).timeout
		label.visible = false
		label_2.visible = true
