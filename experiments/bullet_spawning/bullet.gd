extends Sprite2D
class_name Bullet

const SPEED = 100
var bounds
var despawn_callback: Callable

func _ready() -> void:
    pass # Replace with function body.

#func set_bounds(_bounds: Vector2):
    #bounds = _bounds
#
#func _process(delta: float) -> void:
    #pass
    ##position.y += delta * SPEED
    ##if position.x > bounds.x or position.y > bounds.y:
        ##explode()
#
func explode() -> void:
    # queue_free()
    despawn_callback.call(self)
