extends Area3D

@export var speed := 0.01

signal coinCollected

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(speed)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Players"):
		print("Colision por grupo")
		
	if body is Player:
		print("Colision por clase")
		
		
	print("Colision por layer")
	emit_signal("coinCollected")
	GameManager.addPoint()
	print(GameManager.getPoint())
	queue_free()
	
