extends CameraState

func enter(_message):
	super(_message)
	infrared_spotlight.show()

func exit():
	super()
	infrared_spotlight.hide()
