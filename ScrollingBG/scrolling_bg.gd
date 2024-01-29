extends ParallaxBackground

const SPEED: float = -120.0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.on_game_over.connect(on_game_over)

func on_game_over():
	set_process(false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset.x += SPEED * delta
