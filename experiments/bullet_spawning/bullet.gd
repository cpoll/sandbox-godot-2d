class_name Bullet
extends Sprite2D

var movement: Callable
var radius_pixels: int
var lifetime: float

func move(delta):
    movement.call(delta)
    lifetime += delta

func create(_movement: Callable, initial_position: Vector2, _radius_pixels: int):
    movement = _movement
    position = initial_position
    radius_pixels = _radius_pixels
    lifetime = 0

func enpool():
    self.process_mode = Node.PROCESS_MODE_DISABLED
    self.hide()
    
func depool():
    self.process_mode = Node.PROCESS_MODE_INHERIT
    self.show()
