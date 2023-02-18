extends Label


func _process(delta):
	if SceneController.travelled == true:
		self.text = " i in PAST"
	else:
		self.text = "i in Future"
