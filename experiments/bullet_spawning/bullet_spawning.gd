extends Node2D

var bullet = load("res://experiments/bullet_spawning/bullet.tscn")

const ROWS: int = 50
const BULLET_FREQUENCY = 0.1

var timer = 0
var screen_size
var row_width

var pool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # We'll calculate row width as if there's one extra row so that we can shift the rows a half-step to the right
    screen_size = get_viewport().size
    row_width = get_viewport().size.x / (ROWS + 1)
    pool = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    timer -= delta
    if timer < 0:
        spawn_bullets()
        timer+= BULLET_FREQUENCY

func spawn_bullets() -> void:
    for row in range(ROWS):
        spawn_bullet(Vector2(screen_size.x - 50, screen_size.y - 50), Vector2(row * row_width + row_width, 0))
        
func spawn_bullet(bounds: Vector2, pos: Vector2) -> void:
    var b = pool.pop_back()
    if not b:
        b = bullet.instantiate()
        add_child(b)
        b.despawn_callback = despawn_bullet
        b.set_bounds(bounds)
    else:
        b.process_mode = 0
        b.show()
        print("depooled bullet")
        
    b.position = pos
    
        
func despawn_bullet(b: Bullet):
    '''This function is passed to bullets when the pool instantiates them. Bullets will use this
    as a callback when they're ready to re-enter the pool'''
    b.process_mode = 4
    b.hide()
    pool.append(b)
    
