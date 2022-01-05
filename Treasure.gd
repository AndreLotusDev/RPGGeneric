extends Area2D

onready var player_reference = get_node("/root/Main/Player")
onready var animation_treasure = $AnimatedSprite
const quantity_of_exp = 10

func _ready():
	var type_treasure = animation_treasure.frames.get_animation_names()
	animation_treasure.animation = type_treasure[randi() % type_treasure.size()]

func _on_Treasure_body_entered(body):
	if body.name == "Player":
		player_reference.play_collected_coin_sound()
		player_reference.receives_treasure()
		player_reference.receives_xp(quantity_of_exp)
		queue_free()
