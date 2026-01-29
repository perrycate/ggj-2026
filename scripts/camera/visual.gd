extends CameraState

func enter(_message):
	super(_message)
	visual_spotlight.show()

func exit():
	super()
	visual_spotlight.hide()


