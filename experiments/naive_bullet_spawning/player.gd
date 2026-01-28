extends Sprite2D

func _ready() -> void:
    get_node(^"Area2D").area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
    pass
    
func _on_area_entered(n: Node):
    if n.owner is Bullet:
        n.owner.explode()
