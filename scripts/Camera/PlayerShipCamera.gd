extends Camera2D

func _ready():
	set_process_input(true)


func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.is_pressed() and not event.is_echo():
			if event.button_index == BUTTON_WHEEL_UP:
				if (get_zoom().x <= 2.0):
					set_zoom( get_zoom() + Vector2( 0.1, 0.1))
			if event.button_index == BUTTON_WHEEL_DOWN:
				if (get_zoom().x >= 1.0):
					set_zoom( get_zoom() - Vector2( 0.1, 0.1))