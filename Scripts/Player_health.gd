extends Sprite3D

func _ready():
	texture = $SubViewport.get_texture()
	
func update_health(_value, max_value):
	$SubViewport/EnemyHealthBar.update_health(_value, max_value)
