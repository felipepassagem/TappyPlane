extends Control

@onready var high_score_value = $MarginContainer/HBoxContainer/HighScoreValue

# Called when the node enters the scene tree for the first time.
func _ready():
	high_score_value.text = str(GameManager.get_high_score())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fly"):
		GameManager.load_game_scene()


func _on_hard_core_btn_toggled(toggled_on):
	GameManager._is_hardcore = !GameManager._is_hardcore
	print(GameManager._is_hardcore)
	
