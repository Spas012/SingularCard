extends Label

var card_pos
var mouse_pos
var pressed
var info_string

func _ready():
	pass

func _process(delta):
	mouse_pos = get_global_mouse_position()
	info_string = ("card position:\n%s\nmouse position\n%s\nflipped\n%s")
	info_string = info_string % [card_pos, mouse_pos, pressed]
	text = info_string


func _on_card_position_changed(position):
	card_pos = position


func _on_card_card_flipped(flipped):
	pressed = flipped
