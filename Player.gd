extends KinematicBody2D

var speed_of_player = 250
var lifes = 100
var treasures = 0
var interact_distance = 80
var velocity = Vector2()
var facing_direction = Vector2()
onready var raycast = $RayCast2D
onready var animation_of_player = $AnimatedSprite
var experience = 50
onready var ui = get_node("/root/Main/UI")
var delay_to_put_bomb_in_seconds = 1.0
var status_die = false

signal create_bomb

func _ready():
	$MainTheme.play()
	ui.att_quantity_of_exp(experience)
	ui.att_quantity_of_life(lifes)
	ui.att_treasures(treasures)

func _physics_process(delta):
	velocity = Vector2()
	
	make_calc_about_vector_2d_move()
		
	velocity = velocity.normalized()
	move_and_slide(velocity * speed_of_player, Vector2.ZERO)
	
	moves()
	
	put_bomb(delta)
	
	
func put_bomb(delta):
	if Input.is_action_pressed("PutBomb") and experience >= 10 and delay_to_put_bomb_in_seconds == 1:
		experience -= 10
		delay_to_put_bomb_in_seconds = 0
		ui.att_quantity_of_exp(experience)
		$PutBomb.play()
		emit_signal("create_bomb")
	elif delay_to_put_bomb_in_seconds < 1.0:
		delay_to_put_bomb_in_seconds += delta
	elif delay_to_put_bomb_in_seconds > 1.0:
		delay_to_put_bomb_in_seconds = 1
	
func make_calc_about_vector_2d_move():
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		facing_direction = Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		facing_direction = Vector2(0, 1)
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		facing_direction = Vector2(1, 0)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		facing_direction = Vector2(-1, 0)
		
func moves():
	if velocity.y < 0:
		play_animation("up")
	elif velocity.y > 0:
		play_animation("down")
	elif velocity.x > 0:
		play_animation("right")
	elif velocity.x < 0:
		play_animation("left")
	elif facing_direction.y < 0:
		play_animation("sup")
	elif facing_direction.y > 0:
		play_animation("sdown")
	elif facing_direction.x > 0:
		play_animation("sright")
	elif facing_direction.x < 0:
		play_animation("sleft")
		
func play_animation(name_of_animation):
	if animation_of_player.animation != name_of_animation:
		animation_of_player.animation = name_of_animation
		
func take_damage(damage):
	$TakeDamage.play()
	lifes -= damage
	ui.att_quantity_of_life(lifes)
	
	if lifes <= 0:
		death()
	
func receives_xp(xp):
	experience += xp
	ui.att_quantity_of_exp(experience)
	
func receives_treasure():
	treasures += 1
	ui.att_treasures(treasures)
	
	if treasures == 6 :
		$OnWin.play()
		$Timer.start()
		$Timer.connect("timeout", self, "wait_to_reset")
		
func wait_to_reset():
	get_tree().reload_current_scene()
	
func death():
	if status_die == false:
		status_die = true
		$Death.play()
		$Timer.start()
		$Timer.connect("timeout", self, "wait_to_reset")
	
func play_collected_coin_sound():
	$CollectedCoin.play()
	
func position_in_y():
	return position.y
	
func position_in_x():
	return position.x
