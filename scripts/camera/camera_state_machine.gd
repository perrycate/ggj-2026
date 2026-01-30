extends StateMachine
class_name CameraStateMachine

# CT: just a slightly altered state transitioning function
func transition_mask(new_mask_name):
	var new_mask = states.get(new_mask_name)
	if !new_mask:
		return false

	# CT: no need to transition to the same state
	if new_mask == current_state:
		return false

	if current_state:
		current_state.exit()

	new_mask.enter("")

	current_state = new_mask
	return true

