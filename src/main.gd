extends Node2D

const columns = 8
const lines = 8
var DEFAULT_SCENARIO: Array[String] = [
	"W", "W", "W", "W", "W", "W", "W", "W",
	"W", " ", " ", " ", " ", " ", " ", "W",
	"W", " ", "W", "W", "W", "W", " ", "W",
	"W", " ", "W", " ", " ", "W", " ", "W",
	"W", " ", "W", " ", " ", "W", " ", "W",
	"W", " ", "W", " ", " ", "W", " ", "W",
	"W", " ", "W", " ", " ", "W", " ", "W",
	"W", "S", "W", "W", "W", "W", "E", "W",
]

const tile_source_ids = {
	"W": 0,
	"E": 1,
	"S": -1,
	" ": -1
}

func _ready():
	setup_stage(DEFAULT_SCENARIO)


func reset_stage():
	set_process(false)
	DEFAULT_SCENARIO.reverse()
	setup_stage(DEFAULT_SCENARIO)
	set_process(true)


func setup_stage(scenario: Array[String]):
	for i in range(lines):
		for j in range(columns):
			var block = scenario[i+j*columns]
			$Map.set_cell(Vector2i(i+1, j+1), 0, Vector2i(0, tile_source_ids[block]))
			if block == 'S':
				$Car.position = $Map.map_to_local(Vector2i(i+1,j+1))
