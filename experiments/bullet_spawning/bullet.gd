class_name Bullet
extends Sprite2D

var movement: Callable
var radius_pixels: int
var lifetime: float
var initial_position: Vector2

func move(b, delta):
    movement.call(b, delta)
    lifetime += delta

func create(_movement: Callable, _initial_position: Vector2, _radius_pixels: int):
    movement = _movement
    position = _initial_position
    initial_position = _initial_position
    radius_pixels = _radius_pixels
    lifetime = 0

func enpool():
    self.process_mode = Node.PROCESS_MODE_DISABLED
    self.hide()
    
func depool():
    self.process_mode = Node.PROCESS_MODE_INHERIT
    self.show()
