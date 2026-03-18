extends Node2D

const CELL_EMPTY = ""
const CELL_X = "X"
const CELL_0 = "0"

@onready var buttons = $GridContainer.get_children()
@onready var strikes = $strike_lines.get_children()
@onready var display = $display

var current_player
var board


func _ready() -> void:
	for strike in strikes:
		strike.visible = false
	var button_index = 0
	for button in buttons:
		button.connect("pressed", _on_button_click.bind(button_index, button))
		button_index += 1
	
	
	reset_game()


func _on_button_click(idx, button):
	var y = idx / 3
	var x = idx % 3
	
	# Prevent overwriting moves
	if board[y][x] != CELL_EMPTY:
		return
	
	# Update logic
	board[y][x] = current_player
	
	# Update UI
	button.text = current_player
	button.disabled = true
	
	# Check winner
	var winner = get_winner(button)
	if winner != null:
		print("Winner is:", winner)
		display.text = winner + " WON"
		disable_all_buttons()
		return
	
	# Check draw
	if is_draw():
		print("Draw!")
		disable_all_buttons()
		return
	
	# Switch player
	current_player = CELL_X if current_player == CELL_0 else CELL_0
	
	print(board)


func get_winner(button):
	# Check rows
	for i in range(3):
		var v = board[i][0]
		if v != "" and v == board[i][1] and v == board[i][2]:
			strikes[i].visible = true
			return v
	
	# Check columns
	for j in range(3):
		var v = board[0][j]
		if v != "" and v == board[1][j] and v == board[2][j]:
			strikes[j+3].visible = true
			return v
	
	# Check diagonals
	var center = board[1][1]
	
	if center != "":
		# Main diagonal
		if center == board[0][0] and center == board[2][2]:
			strikes[6].visible = true
			return center
		
		# Anti-diagonal
		if center == board[0][2] and center == board[2][0]:
			strikes[7].visible = true
			return center
	
	return null


func is_draw():
	for row in board:
		for cell in row:
			if cell == CELL_EMPTY:
				return false
	return true


func disable_all_buttons():
	for button in buttons:
		button.disabled = true


func reset_game():
	current_player = CELL_X
	
	board = [
		[CELL_EMPTY, CELL_EMPTY, CELL_EMPTY],
		[CELL_EMPTY, CELL_EMPTY, CELL_EMPTY],
		[CELL_EMPTY, CELL_EMPTY, CELL_EMPTY]
	]
	
	for button in buttons:
		button.text = ""
		button.disabled = false
