#extends Control
#
#@onready var bullet_spawner = $".."
#
## Called when the node enters the scene tree for the first time.
#
#func _process(_delta: float):
    #queue_redraw()
#
## This tanks performance down to 18fps from 200.
#func _draw():
    #draw_circle(Vector2(500, 500), 10, Color.BLUE);
    #
    ## Hitbox debugging
    #for bullet in bullet_spawner.bullets:
        #draw_circle(bullet.position, 10, Color.GREEN)
