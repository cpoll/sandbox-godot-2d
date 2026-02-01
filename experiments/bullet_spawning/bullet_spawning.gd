extends Node2D
class_name BulletManager

# var bullet = load("res://experiments/bullet_spawning/bullet.tscn")
var bullet = load("res://experiments/bullet_spawning/dumb_bullet.tscn")
@onready var bulletcount: Label = $'%Ui/%BulletCount'
@onready var bullet_container = $'%Bullets'
@onready var player = $'%Player'

const ROWS: int = 50
const BULLET_FREQUENCY = 0.1
const BULLET_SPEED = 100

var timer = 0
var screen_size
var row_width
var bounds: Vector2

var pool
var bullets

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # We'll calculate row width as if there's one extra row so that we can shift the rows a half-step to the right
    screen_size = get_viewport().size
    row_width = get_viewport().size.x / (ROWS + 1)
    pool = []
    bullets = []
    bounds = Vector2(screen_size.x - 50, screen_size.y - 50)

func _process(_delta: float) -> void:
    bulletcount.text = "Bullets: %s\nFPS: %s" % [len(bullets), Engine.get_frames_per_second()]
    pass

func _physics_process(delta: float) -> void:
    move_bullets(delta)
    
    # Spawn bullets
    timer -= delta
    if timer < 0:
        spawn_bullets()
        timer+= BULLET_FREQUENCY
        
    test_collision()

func spawn_bullets() -> void:
    for row in range(ROWS):
        spawn_bullet(bounds, Vector2(row * row_width + row_width, 0))
        
func spawn_bullet(bounds: Vector2, pos: Vector2) -> void:
    var b = pool.pop_back()
    if not b:
        b = bullet.instantiate()
        bullet_container.add_child(b)
        
        if b is Bullet:
            b.despawn_callback = despawn_bullet
            # b.set_bounds(bounds)
    else:
        if b is Bullet:
            b.process_mode = 0
        b.show()
        print("depooled bullet")
        
    b.position = pos
    bullets.append(b)
    
        
func despawn_bullet(b: Bullet):
    '''This function is passed to bullets when the pool instantiates them. Bullets will use this
    as a callback when they're ready to re-enter the pool'''
    
    b.process_mode = 4
    b.hide()
    pool.append(b)
    bullets.erase(b) # probably not very performant
    
func despawn_dumb_bullet(b: Node2D):
    b.hide()
    pool.append(b)
    bullets.erase(b) # probably not very performant
    
func move_bullets(delta: float):
    for b in bullets:
        b.position.y += delta * BULLET_SPEED
        if b.position.x > bounds.x or b.position.y > bounds.y:
            if b is Bullet:
                despawn_bullet(b)
            else:
                despawn_dumb_bullet(b)
                
func test_collision():
    var bullet_radius_pixels = 12
    var player_radius_pixels = 100
    
    # Optimization: distance_squared_to is cheaper because we don't need to sqrt (an expensive computation)
    # TODO: Profile this, how much worse is regular distance_to?
    var collision_distance_squared = (bullet_radius_pixels + player_radius_pixels) ** 2
    var player_position: Vector2 = player.position
    for b in bullets:
        if player_position.distance_squared_to(b.position) < collision_distance_squared:
            despawn_dumb_bullet(b)
