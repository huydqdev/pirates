extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_area_entered(area: Area2D) -> void:
	GameManager.gained_coins(1)
	animation_player.play('pickup')
