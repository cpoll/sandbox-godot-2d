extends Node2D
class_name BulletManager

# var bullet = load("res://experiments/bullet_spawning/bullet.tscn")
# var bullet = load("res://experiments/bullet_spawning/dumb_bullet.tscn")
var bullet = load("res://experiments/bullet_spawning/cloud_bullet.tscn");
# var bullet = load("res://experiments/bullet_spawning/mesh_bullet.tscn")
@onready var bulletcount: Label = $'%Ui/%BulletCount'
@onready var bullet_container = $'%Bullets'
@onready var player = $'%Player'
@onready var hitboxes = $'%Hitboxes'

const ROWS: int = 10
const BULLET_FREQUENCY = 0.2
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

func _physics_process(delta: float) -> void:
    _move_bullets(delta)
    
    # Spawn bullets
    #timer -= delta
    #if timer < 0:
        #spawn_bullets()
        #timer+= BULLET_FREQUENCY
        
    test_collision()

func _spawn_bullet() -> Bullet:
        var b = pool.pop_back()
        if not b: # Spawn a bullet
            b = bullet.instantiate()
            bullet_container.add_child(b)
        else: # Use a pool bullet
            if b is Bullet:
                b.depool()
            # We move the bullet in the bulletcontainer. We're always rendering bullets in reverse order
            # of spawning, so the most recently-spawned bullet is on top of all other bullets.
            bullet_container.move_child(b, bullet_container.get_child_count()-1)
            
        bullets.append(b)
        return b

func create_bullet(initial_position: Vector2, movement: Callable, radius_pixels: int):
    var b = _spawn_bullet()
    b.create(movement, initial_position, radius_pixels)

#func spawn_bullets() -> void:
    #for row in range(ROWS):
        #var pos = Vector2(row * row_width + row_width, 0)
            #
        ## Set up the parameters specific to these bullets
        ## Later, we move this into separate level logic, triggers, etc.
        ## move function signature: dt, player_pos, returns new_position
        #var movement = func(b, delta):
            ## These two are the same, but the latter can be stateless
            ## b.position.y += delta * 50
            ## b.position = b.initial_position + Vector2(0, 1) * b.lifetime * 50
            #
            #b.position.x = b.initial_position.x + sin(b.lifetime) * 200 * (row % 2 * 2 - 1)
            #b.position.y = b.initial_position.y + b.lifetime * 100
#
        #create_bullet(pos, movement, 5)

    
func _despawn_bullet(b: Node2D):
    b.enpool()
    pool.append(b)
    bullets.erase(b) # probably not very performant
    
func _move_bullets(delta: float):
    for b in bullets:
        
        #b.position.y += delta * BULLET_SPEED/2
        b.move(b, delta)
        
        # TODO: Some bullets may want to disable bounds checking to flitter on-and-off screen
        if b.position.x > bounds.x or b.position.y > bounds.y:
            if b is Bullet:
                _despawn_bullet(b)
            else:
                _despawn_bullet(b)
                
func test_collision():
    var player_radius_pixels = 100
    
    var player_position: Vector2 = player.position
    for b in bullets:
        var collision_distance_squared = (player_radius_pixels + b.radius_pixels)**2
        if player_position.distance_squared_to(b.position) < collision_distance_squared:
            _despawn_bullet(b)
