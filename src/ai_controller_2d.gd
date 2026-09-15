extends AIController2D

var closest_exit_distance = 10000.0

@onready var map = $"../Map"

func _ready():
	reset()


func _physics_process(_delta):
	_update_reward()


func _update_reward():
	reward -= 0.01  # step penalty
	
	var add_reward = 0.0
	var exit_distance = _player.position.distance_to(map.exit_position)
	if exit_distance < closest_exit_distance:
		add_reward += closest_exit_distance - exit_distance
		closest_exit_distance = exit_distance
	
	reward += add_reward/100


func get_reward():
	return reward


func get_obs() -> Dictionary:
	var obs_array := []

	var exit_distance = _player.position.distance_to(map.exit_position)
	obs_array.append(exit_distance)
	
	var raycast_obs = _player.raycast_sensor.get_observation()
	obs_array.append_array(raycast_obs)
	
	# TODO: Add camera view
	
	return { "obs": obs_array }


func get_action_space():
	return {
		"drive": {"size": 2, "action_type": "continuous"}
	}

func set_action(action):
	_player.agent_action.x = action["drive"][0]
	_player.agent_action.y = action["drive"][1]
