extends Node2D

var bomb_to_put = preload("res://Scenes/Bomb.tscn")
var enemy_to_spawn = preload("res://Scenes/Enemy.tscn")
var treasure_to_spawn = preload("res://Scenes/Treasure.tscn")

onready var ui_handler = get_node("UI")

var map_max_size_x = 0
var map_min_size_x = 0
var map_max_size_y = 0
var map_min_size_y = 0

var quantity_of_enemies = 1
var number_treasures_on_map = 20

func _ready():
	ui_handler.att_quantity_of_enemies(quantity_of_enemies)
	set_camera_limits()
	
	for i in number_treasures_on_map:
		var treasure_spawned = treasure_to_spawn.instance()
		treasure_spawned.position.x = rand_range(map_min_size_x + 100, map_max_size_x - 100)
		treasure_spawned.position.y = rand_range(map_min_size_y + 100, map_max_size_y - 100)
		add_child(treasure_spawned)

func _on_Player_create_bomb():
	var new_bomb = bomb_to_put.instance()
	new_bomb.position.x = $Player.position_in_x()
	new_bomb.position.y = $Player.position_in_y()
	add_child(new_bomb)
	
func set_camera_limits():
	var map_size = $ground.get_used_rect()
	var cell_size = $ground.cell_size
	
	map_min_size_x = map_size.position.x * cell_size.x
	$Camera2D.limit_left = map_min_size_x
	map_max_size_x = map_size.end.x * cell_size.x
	$Camera2D.limit_right = map_max_size_x
	
	map_min_size_y = map_size.position.y * cell_size.y
	$Camera2D.limit_top = map_min_size_y
	map_max_size_y = map_size.end.y * cell_size.y
	$Camera2D.limit_bottom = map_max_size_y
	
func create_enemies():
	if quantity_of_enemies < 20:
		var enemy_spawned = enemy_to_spawn.instance()
		enemy_spawned.position.x = rand_range(map_min_size_x + 100, map_max_size_x - 100)
		enemy_spawned.position.y = rand_range(map_min_size_y + 100, map_max_size_y - 100)
		add_child(enemy_spawned)
		quantity_of_enemies += 1
		ui_handler.att_quantity_of_enemies(quantity_of_enemies)
		
func delete_one_enemy():
	quantity_of_enemies -= 1
	ui_handler.att_quantity_of_enemies(quantity_of_enemies)

func _on_SpawnTickerEnemies_timeout():
	create_enemies()
