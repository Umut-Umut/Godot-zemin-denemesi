extends Node2D

onready var powders = preload("res://powder.tscn")
onready var player = get_node("player")

var flag = 0
var powder
func place_powder():
	powder = powders.instance()
	powder.position = $player/foot.global_position
	if player.is_walk:
		powder.visible = true
		if flag == 1:
			powder.play("grass")
		elif flag == 2:
			powder.play("stone")
		elif flag == 3:
			powder.play("sand")
	else:
		powder.visible = false
	add_child(powder)


func _on_Timer_timeout():
	place_powder()
