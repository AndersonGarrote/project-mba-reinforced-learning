extends TileMapLayer

const columns = 8
const lines = 8
const tile_source_ids = {
	"W": 0,
	"E": 1,
	"S": -1,
	" ": -1
}

var start_position = Vector2.ZERO
var exit_position = Vector2.ZERO

func setup_stage(scenario: Array[String], car: CharacterBody2D):
	for i in range(lines):
		for j in range(columns):
			var block = scenario[i+j*columns]
			set_cell(Vector2i(i+1, j+1), 0, Vector2i(0, tile_source_ids[block]))
			if block == 'S':
				start_position = map_to_local(Vector2i(i+1,j+1))
			elif block == 'E':
				exit_position = map_to_local(Vector2i(i+1,j+1))
	
	car.position = start_position
