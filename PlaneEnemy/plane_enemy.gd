extends CharacterBody2D

const SPEED_X = 200
const SPEED_Y = 300
const MIN_Y = 50
const MAX_Y = 800

#var y_direction = 1
#var amplitude = 50
#var frequency = 2
#var rotation_speed = 360

#
#var horizontal_radius = 20  # Ajuste o raio horizontal
var vertical_radius = 150  # Ajuste o raio vertical
var angular_speed = .8 # Ajuste a velocidade angular
var contador_y = 0
var contador_x = 300

var ref_x
var ref_y


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var loop_timer = $LoopTimer
@onready var stop_loop_timer = $StopLoopTimer

var flip_sprite = true
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.on_game_over.connect(on_game_over)
	
	position.x = 1500
	position.y = randf_range(200, 500)
	ref_x = position.x
	ref_y = position.y
	
	loop_timer.start()
	animated_sprite_2d.flip_h = flip_sprite
	print(ref_y)


func _process(delta):
	
	position.x += SPEED_X * delta * -1
	update_wave_movement(delta)

	
func update_wave_movement(delta):

	var angle_y = contador_y * angular_speed
	if ref_y >= 350:
		contador_y += .05
	else:
		contador_y -= .05
	var new_y = ref_y + vertical_radius * sin(angle_y)

	position.y = new_y 

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	GameManager.spaw_enemy_back.emit()
	
	
func on_game_over():
	animated_sprite_2d.stop()
	set_process(false)

func _on_collision_body_entered(body):
	if body.is_in_group(GameManager.GROUP_PLANE):
		body.die()

