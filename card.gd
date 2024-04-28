extends StaticBody2D

signal position_changed(position)
signal card_flipped(flipped)

var flipped = false
var held = false
var mouse_offset
var initial_position
var mouse_vector = Vector2()

func _ready():
	position_changed.emit(position)
	card_flipped.emit(flipped)

func _process(delta):
	if held:
		dragging()
		position_changed.emit(position)

func dragging():
	position = get_global_mouse_position() + mouse_offset
	
	position.x = wrapf(position.x, 0, 480)
	position.y = wrapf(position.y, 0, 480)
	
	mouse_vector.x = wrapf(get_global_mouse_position().x, 0, 480)
	mouse_vector.y = wrapf(get_global_mouse_position().y, 0, 480)
	
	Input.warp_mouse(mouse_vector)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			initial_position = position
			mouse_offset = position - get_global_mouse_position()
			held = true
			
		else:
			held = false
	
	if event is InputEventMouseButton and not event.pressed\
	and event.button_index == MOUSE_BUTTON_LEFT and position == initial_position:
		if not flipped:
			$AnimatedSprite2D.frame = 1
			flipped = true
			
		else:
			$AnimatedSprite2D.frame = 0
			flipped = false
		
		card_flipped.emit(flipped)
