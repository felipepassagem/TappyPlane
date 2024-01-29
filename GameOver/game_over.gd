extends Control

@onready var press_space_label = $PressSpaceLabel
@onready var timer = $Timer
@onready var game_over_label = $GameOverLabel

var _can_press_space = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.on_game_over.connect(on_game_over)
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _can_press_space:
		if Input.is_action_just_pressed("fly"):
			GameManager.load_main_scene()
	

func on_game_over():
	show()
	GameManager._is_hardcore = false
	timer.start()
	
func run_sequence():
	game_over_label.hide()
	press_space_label.show()
	_can_press_space = true

func _on_timer_timeout():
	run_sequence()
