extends Node2D

@export var pipes_scene: PackedScene

@onready var engine_sound = $EngineSound
@onready var game_over_sound = $GameOverSound
@onready var pipes_holder = $PipesHolder
@onready var spawn_u = $SpawnU
@onready var spawn_l = $SpawnL
@onready var spawn_timer = $SpawnTimer
@onready var plane_enemy = preload("res://PlaneEnemy/plane_enemy.tscn")
@onready var enemy_timer = $EnemyTimer
const PLANE_ENEMY_BACK = preload("res://PlaneEnemyBack/plane_enemy_back.tscn")
var PIPES_SPEED: float = 120
var CONT: float = 1
var wait_time: float = 2
var hardcore: bool
var pipes_conter = 0

func _ready():
	GameManager.set_score(0)
	GameManager.on_game_over.connect(on_game_over)
	GameManager.spaw_enemy.connect(spaw_enemy)
	GameManager.spaw_enemy_back.connect(spaw_enemy_back)
	hardcore = GameManager._is_hardcore
	
	if hardcore:
		spawn_timer.wait_time = 1.6
		spaw_enemy_back()
	spawn_pipes()
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(spawn_timer.wait_time)
	pass

func spawn_pipes():
	
	var y_pos = randf_range(spawn_u.position.y, spawn_l.position.y) if !hardcore else randf_range(spawn_u.position.y - 30, spawn_l.position.y + 30)
	var new_pipes = pipes_scene.instantiate()
	
	new_pipes.position = Vector2(spawn_l.position.x, y_pos)
	
	
	if spawn_timer.wait_time > .6 and pipes_conter % 5 == 0 and pipes_conter != 0:
		spawn_timer.wait_time -= .02 if !hardcore else .02
		PIPES_SPEED += .1 if !hardcore else .2
		
	elif spawn_timer.wait_time <= .6:
		spawn_timer.wait_time = .6
	new_pipes.SCROLL_SPEED = PIPES_SPEED
	pipes_holder.add_child(new_pipes)
	#CONT += .1 if !hardcore else .2
	pipes_conter += 1

func _on_spawn_timer_timeout():
	spawn_pipes()

func stop_pipes():
	spawn_timer.stop()
	for pipe in pipes_holder.get_children():
		pipe.set_process(false)

func spaw_enemy():
	var enemy = plane_enemy.instantiate()
	add_child(enemy)
	
	#var y_pos = 400
	
func spaw_enemy_back():
	var enemy_back = PLANE_ENEMY_BACK.instantiate()
	add_child(enemy_back)
	
	

func on_game_over():
	#GameManager.load_main_scene()
	stop_pipes()
	enemy_timer.stop()
	engine_sound.stop()
	game_over_sound.play()


func _on_enemy_timer_timeout():
	spaw_enemy()

