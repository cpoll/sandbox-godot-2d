extends Node2D

var bullet = load("res://experiments/naive_bullet_spawning/bullet.tscn")

const ROWS: int = 25
const BULLET_FREQUENCY = 0.1

var timer = 0
var screen_size
var row_width

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # We'll calculate row width as if there's one extra row so that we can shift the rows a half-step to the right
    screen_size = get_viewport().size
    row_width = get_viewport().size.x / (ROWS + 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    timer -= delta
    if timer < 0:
        spawn_bullets()
        timer+= BULLET_FREQUENCY

func spawn_bullets() -> void:
    for row in range(ROWS):
        var b = bullet.instantiate()
        b.set_bounds(Vector2(screen_size.x - 50, screen_size.y - 50))
        add_child(b)
        b.position.x = row * row_width + row_width
        
        
    
