extends Area2D

@export var speed = 600

#this is creating a reference, also lines 6-9 and func _on_screen_exited is the same as the "connect"
@onready var visable_notifier = $VisableNotifier

func _ready():
	visable_notifier.connect("screen_exited", _on_screen_exited)

func _physics_process(delta):
	#global_position.x += speed distance traveled = framrate * speed (in other words, bad)
	global_position.x += speed*delta # distance traveled = speed pixels per second
	#120px at 120 fps = 1 pixel each frame
	# 120px at 60 fps = 2 pixels each frame
	#120px at 30 fps = 4 pixles each frame
	#120px at 10 fps = 12 pixles each frame

func _on_screen_exited():
	queue_free()


func _on_area_entered(area):
	queue_free()
	area.die()
