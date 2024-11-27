extends Node2D

@export var force = -500.0;
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		jump_sound.play()
		area.get_parent().velocity.y = force
