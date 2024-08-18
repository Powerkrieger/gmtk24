extends Control


func ItemPopup(slot : Rect2i, item : Array):
	set_value(item)
	
	var mouse_pos = get_viewport().get_mouse_position()
	var correction
	var padding = 25
	
	if mouse_pos.x <= get_viewport_rect().size.x/2:
		correction = Vector2i(slot.size.x + padding, 0)
	else:
		correction = -Vector2i(%ItemPopup.size.x + padding, 0)
	if %ItemPopup.is_visible() == false:
		%ItemPopup.popup(Rect2i(slot.position + correction, %ItemPopup.size))
	
func HideItemPopup():
	if %ItemPopup.is_visible():
		%ItemPopup.hide()
	
func set_value(item : Array):
	%Name.text = str(item[0])
	%PriceValue.text = str(item[1])
	%SpaceValue.text = str(item[2])
	if item[3] != null:
		%Space.text = str(item[3])
	if item[4] != null:
		%SpaceValue.text = str(item[4])
