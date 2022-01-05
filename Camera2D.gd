extends Camera2D

onready var player = get_node("/root/Main/Player")

func _ready():
	pass

func _process(delta):
	position = player.position

