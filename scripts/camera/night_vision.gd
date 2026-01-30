extends CameraState

func enter(_message):
	super(_message)
	night_vision_spotlight.show()

func exit():
	super()
	night_vision_spotlight.hide()
