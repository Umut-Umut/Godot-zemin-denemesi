extends KinematicBody2D

onready var global = get_tree().get_current_scene()
onready var animations = get_node("AnimatedSprite")

var gravity = -50

var vel = Vector2(0, 0)
var acc = 10
var max_speed = 150

func _ready():
	pass


func _process(_delta):
	control()
	animation_manager()
	
	vel.y -= gravity
	
	vel = move_and_slide(vel)

var is_walk = 0
func control():
	if is_on_wall():
		if Input.is_action_pressed("ui_right"):
			vel.x = min(vel.x+acc, max_speed)
			is_walk = 1
		elif Input.is_action_pressed("ui_left"):
			vel.x = max(vel.x-acc, -max_speed)
			is_walk = 2
		else: 
			vel.x = lerp(vel.x, 0, 0.2)
			is_walk = 0
	else: is_walk = 0


func animation_manager():
	if is_walk:
		animations.play("walk")
		if is_walk == 1:	animations.flip_h = false
		elif is_walk == 2:	animations.flip_h = true
	else:
		animations.play("idle")


func _on_foot_body_entered(body):
	if body.collision_layer == 4:
		global.flag = 1
	elif body.collision_layer == 8:
		global.flag = 2
	elif body.collision_layer == 16:
		global.flag = 3
