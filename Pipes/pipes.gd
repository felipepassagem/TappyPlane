extends Node2D

var SCROLL_SPEED = 50.0
@onready var score_sound = $ScoreSound
@onready var laser_monitoring_timer = $Laser/LaserMonitoringTimer
@onready var laser = $Laser

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.on_score_updated.connect(on_score_update)
	
func on_score_update():
	laser.monitoring = false
	laser_monitoring_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= (SCROLL_SPEED * delta)

func _on_screen_exited():
	queue_free()

func player_scored():
	GameManager.increment_score()

func _on_pipe_body_entered(body):
	if body.is_in_group(GameManager.GROUP_PLANE):
		body.die()


func _on_laser_body_entered(body):
	player_scored()
	score_sound.play()
	



func _on_laser_monitoring_timer_timeout():
	laser.monitoring = true

