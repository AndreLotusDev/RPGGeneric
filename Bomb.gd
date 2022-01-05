extends Area2D

func _ready():
	pass
	
func enter_bomb(body):
	body.death()
	queue_free()

func _on_Bomb_body_entered(body):
	if body.name != "Player":
		$Exploded.play()
		$AnimatedSprite.hide()
		$Explosion.show()
		$Explosion.play("default")
		$Timer.start()
		$Timer.connect("timeout", self, "enter_bomb", [body])
		
