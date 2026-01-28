extends Sprite2D
class_name Bullet

const SPEED = 100
var bounds

func _ready() -> void:
    pass # Replace with function body.

func set_bounds(_bounds: Vector2):
    bounds = _bounds

func _process(delta: float) -> void:
    position.y += delta * SPEED
    if position.x > bounds.x or position.y > bounds.y:
        explode()

func explode() -> void:
    print("self destructing")
    queue_free()
