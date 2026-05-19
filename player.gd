class_name Player
extends RigidBody3D

@onready var spring_arm_3d: SpringArm3D = $SpringArm3D
@onready var camera_3d: Camera3D = $SpringArm3D/Camera3D

var speed = 0.5
var mouse = 0.01

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		spring_arm_3d.rotation.x -= event.relative.y * mouse
		spring_arm_3d.rotation.y -= event.relative.x * mouse
		
		spring_arm_3d.rotation.x = clamp(
			spring_arm_3d.rotation.x,
			deg_to_rad(-60),
			PI / 4
		)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	spring_arm_3d.top_level = true
	

func _process(delta: float) -> void:
	spring_arm_3d.global_position = self.global_position

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var inputDirection = Vector3(
		Input.get_axis("left", "right"),
		0,
		Input.get_axis("up", "down")
	)

	inputDirection = inputDirection.rotated(
		Vector3.UP,
		spring_arm_3d.rotation.y
	).normalized() * speed

	apply_central_impulse(
		Vector3(inputDirection.x, 0, inputDirection.z)
	)
