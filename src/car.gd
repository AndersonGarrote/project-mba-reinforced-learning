extends CharacterBody2D

const SPEED = 3000.0


@onready var car_sprite = $CarSprite2D

@onready var ai_controller = $"../AgentController2D"
@onready var raycast_sensor = $"RaycastSensor2D"
# TODO: Add camera sensor


func _ready():
	ai_controller.init(self)
	raycast_sensor.activate()

func _process(_delta):
	if get_real_velocity().abs():
		car_sprite.flip_h = get_real_velocity().x < 0
		car_sprite.rotation_degrees = 90 * int(clamp(get_real_velocity().y, -1, 1))
		if not car_sprite.is_playing():
			car_sprite.play("default")
	else:
		car_sprite.pause()


func _physics_process(delta):
	var direction = Vector2(
			Input.get_axis("ui_left", "ui_right"),
			Input.get_axis("ui_up", "ui_down"),
			)
	if direction.abs():
		velocity = direction * SPEED * delta
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED * delta)

	move_and_slide()
