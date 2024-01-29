extends Node

signal on_game_over
signal on_score_updated
signal on_enemy_despaw
signal spaw_enemy
signal spaw_enemy_back

const GROUP_PLANE: String = "plane"

var game_scene: PackedScene = preload("res://Game/game.tscn")
var main_scene: PackedScene = preload("res://Main/Main.tscn")

var _is_hardcore = false
var _score: int = 0
var _high_score: int = 0

func get_score():
	return _score
	
func get_high_score():
	return _score
	
func set_score(value: int):
	_score = value
	if _score > _high_score:
		_high_score = _score
	on_score_updated.emit()
	#print(_score, "      " , _high_score)
	
func increment_score():
	set_score(_score + 1)

func load_game_scene():
	get_tree().change_scene_to_packed(game_scene)
	
func load_main_scene():
	get_tree().change_scene_to_packed(main_scene)
