extends ParallaxBackground

var scrollSpeed = 100

func _process(delta):
	scroll_offset.x -= scrollSpeed * delta
