extends CharacterBody2D


const SPEED = 2000.0

func _process(_delta):
	if get_real_velocity().abs():
		$CarSprite2D.flip_h = get_real_velocity().x < 0
		$CarSprite2D.rotation_degrees = 90 * int(clamp(get_real_velocity().y, -1, 1))
		if not $CarSprite2D.is_playing():
			$CarSprite2D.play("default")
	else:
		$CarSprite2D.pause()


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
	
	var coords = $"../Map".local_to_map(position)
	var non_empty_cell = $"../Map".get_cell_atlas_coords(coords).y != -1
	if non_empty_cell:
		if $"../Map".get_cell_tile_data(coords).get_custom_data('block_type') == 'exit':
			print("You Win!")
			get_parent().reset_stage()
