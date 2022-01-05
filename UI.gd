extends CanvasLayer

var life_bar
var xp_bar
var txt_label
var txt_enemies_quantity

func _ready():
	life_bar = get_node("lifebar")
	xp_bar = get_node("xpbar")
	txt_label = get_node("treasures_found_txt")
	txt_enemies_quantity = get_node("enemies_counter")

func att_quantity_of_life(life):
	if life >= 0 and life <= 100:
		life_bar.value = life
	
func att_quantity_of_exp(xp):
	if xp <= 100:
		xp_bar.value = xp
	
func att_treasures(treasures_quantity):
	txt_label.text = "Tesouros encontrados: " + str(treasures_quantity)
	
func att_quantity_of_enemies(quantity_of_enemies):
	txt_enemies_quantity.text = "Inimigos a combater: "  + str(quantity_of_enemies)
