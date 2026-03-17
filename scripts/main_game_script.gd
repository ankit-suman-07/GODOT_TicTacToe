extends Node2D

const CELL_EMPTY = ""
const CELL_X = "X"
const CELL_0 = "0"

@onready var buttons = $GridContainer.get_children()

var current_player
var board

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var button_index = 0
	for button in buttons:
		button.connect("pressed", _on_button_click.bind(button_index, button))
		button_index += 1
	reset_game()
		
func _on_button_click(idx, button):
	var y = idx / 3
	var x = idx % 3
	button.text = current_player
	if board[y][x] == CELL_EMPTY:
		board[y][x] = current_player
	
		current_player = CELL_X if current_player == CELL_0 else CELL_0
		button.disabled = true
		print(board)

func reset_game():
	current_player = CELL_X
	board = [
		[CELL_EMPTY, CELL_EMPTY, CELL_EMPTY],
		[CELL_EMPTY, CELL_EMPTY, CELL_EMPTY],
		[CELL_EMPTY, CELL_EMPTY, CELL_EMPTY]
	]
