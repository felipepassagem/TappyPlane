extends CharacterBody2D

@onready var enemy_back_timer = $EnemyBackTimer

# Called when the node enters the scene tree for the first time.
const SPEED = 120
func _ready():
	#GameManager.on_enemy_despaw.connect(on_enemy_despaw)
	GameManager.on_game_over.connect(on_game_over)
	position.x = -600
	position.y = randf_range(300, 450)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += SPEED * delta
	
#func on_enemy_despaw():
	#enemy_back_timer.wait_time = randf_range(2, 3.5)
	#enemy_back_timer.start()
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	self.set_process(false)
	self.queue_free()
	GameManager.spaw_enemy.emit()

func on_game_over():
	self.set_process(false)


func _on_enemy_back_timer_timeout():
	pass
