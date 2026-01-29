extends CameraState

func enter(_message):
	super(_message)
	acoustic_spotlight.show()

func exit():
	super()
	acoustic_spotlight.hide()

