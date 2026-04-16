extends Node

@onready var bullet_spawner = $".."
var time_elapsed = 0
var state = 0
var timer = 0


# Coroutines might be nice here for the bullet spawning. Or some sort of stack.
# The trouble with coroutines, and in fact also dt is: If a bullet spawns a bit late, it'll permanently be
# behind if it's only using dt. dt alone isn't deterministic. In other words, if something spawns 0.3s later than
# it did on the previous run, you need to give it 0.3s more on its first _process loop.
# In reality, is it a big enough difference? Do I care? Should I do everything in terms of frames?
# Do everything in _physics_process, and instead of delta use sec/framerate.

# Alternate way to do this, awaits make bullet spawning pretty easy
# I do worry it's not quite deterministic, because it might not line up with physics frames...
# Testing some more: Sure enough, when the framerate drops, the await is delayed.
func wave():
    await get_tree().create_timer(0.3).timeout # Hack because the bullet_spawner _ready hasn't been called yet.
    for i in range(1000):
        for row in range(10):
            var pos = Vector2(row * bullet_spawner.row_width, 0)
                
            # Set up the parameters specific to these bullets
            # Later, we move this into separate level logic, triggers, etc.
            # move function signature: dt, player_pos, returns new_position
            var movement = func(b, _delta):
                # These two are the same, but the latter can be stateless
                b.position.x = b.initial_position.x + sin(b.lifetime) * 200 * (row % 2 * 2 - 1)
                b.position.y = b.initial_position.y + b.lifetime * 100

            bullet_spawner.create_bullet(pos, movement, 5)
        
        await get_tree().create_timer(0.01).timeout


func _ready():
    wave();


#func _process(delta: float) -> void:
    #time_elapsed += delta
    #timer -= delta
    #
    #if timer < 0:
        #timer+= 0.1
        #for row in range(10):
            #var pos = Vector2(row * bullet_spawner.row_width, 0)
                #
            ## Set up the parameters specific to these bullets
            ## Later, we move this into separate level logic, triggers, etc.
            ## move function signature: dt, player_pos, returns new_position
            #var movement = func(b, delta):
                ## These two are the same, but the latter can be stateless
                #b.position.x = b.initial_position.x + sin(b.lifetime) * 200 * (row % 2 * 2 - 1)
                #b.position.y = b.initial_position.y + b.lifetime * 100
#
            #bullet_spawner.create_bullet(pos, movement, 5)
