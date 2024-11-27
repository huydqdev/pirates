extends Node2D
class_name Checkpoint

@export var spawn_point = false
@onready var checked_sound: AudioStreamPlayer2D = $CheckedSound

var activated = false

func _ready():
		if spawn_point:
			activate()

func activate():
	GameManager.current_checkpoint = self
	activated = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player && !activated:
		checked_sound.play()
		activate()
