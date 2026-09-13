extends Node2D

@onready var map = $Map
@onready var car = $Car

var DEFAULT_SCENARIO: Array[String] = [
	"W","W","W","W","W","W","W","W",
	"W"," "," "," "," "," "," ","W",
	"W"," ","W","W","W","W"," ","W",
	"W"," ","W"," "," ","W"," ","W",
	"W"," ","W"," "," ","W"," ","W",
	"W"," ","W"," "," ","W"," ","W",
	"W"," ","W"," "," ","W"," ","W",
	"W","S","W","W","W","W","E","W",
]

func _ready():
	map.setup_stage(DEFAULT_SCENARIO, car)


func reset_stage():
	set_process(false)
	
	DEFAULT_SCENARIO.reverse()
	map.setup_stage(DEFAULT_SCENARIO, car)
	
	set_process(true)

func _physics_process(_delta):
	var car_coords = map.local_to_map(car.position)
	var non_empty_cell = map.get_cell_atlas_coords(car_coords).y != -1
	if non_empty_cell:
		if map.get_cell_tile_data(car_coords).get_custom_data('block_type') == 'exit':
			print("You Win!")
			reset_stage()
