extends KinematicBody2D

var speed_enemy = 125
var xp = 20
var damage_can_inflict = 20
export var time_between_atacks = 1.0
var distance_of_atack = 100
var persecution_distance = 600
onready var timer = $Timer
onready var target = get_node("/root/Main/Player")
onready var main = get_node("/root/Main")

func _ready():
	timer.wait_time = time_between_atacks 
	timer.start()

func _physics_process(delta):
	var distance = position.distance_to(target.position)
	if distance > distance_of_atack and distance < persecution_distance:
		var vector_to_walk = (target.position - position).normalized()
		move_and_slide(vector_to_walk * speed_enemy)

func _on_Timer_timeout():
	if position.distance_to(target.position) <= distance_of_atack:
		target.take_damage(damage_can_inflict)

func death():
	target.receives_xp(xp)
	main.delete_one_enemy()
	queue_free()
