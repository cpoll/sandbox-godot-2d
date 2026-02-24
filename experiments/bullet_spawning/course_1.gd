extends Node

@onready var bullet_spawner = $".."
var time_elapsed = 0
var state = 0
var timer = 0


# Coroutines might be nice here for the bullet spawning. Or some sort of stack.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    time_elapsed += delta
    timer -= delta
    
    if timer < 0:
        timer+= 0.1
        for row in range(10):
            var pos = Vector2(row * bullet_spawner.row_width, 0)
                
            # Set up the parameters specific to these bullets
            # Later, we move this into separate level logic, triggers, etc.
            # move function signature: dt, player_pos, returns new_position
            var movement = func(b, delta):
                # These two are the same, but the latter can be stateless
                b.position.x = b.initial_position.x + sin(b.lifetime) * 200 * (row % 2 * 2 - 1)
                b.position.y = b.initial_position.y + b.lifetime * 100

            bullet_spawner.create_bullet(pos, movement, 5)
