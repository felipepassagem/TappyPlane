extends CharacterBody2D

#signal on_plane_died

@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D

const GRAVITY: float  = 1900.0
const POWER: float = -400.0

var _dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	fly()
	if is_on_floor():
		die()
		
	move_and_slide()
	
func fly():
	if Input.is_action_just_pressed("fly"):
		velocity.y = POWER
		animation_player.play("fly")

func die():
	if _dead:
		return
	_dead = true
	animated_sprite_2d.stop()
	GameManager.on_game_over.emit()
	set_physics_process(false)
	#self.queue_free()
