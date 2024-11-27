extends Node

signal gained_coin()

var coins : int

var current_checkpoint : Checkpoint
var player : Player


func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func gained_coins(coin_gained:int):
	coins += coin_gained
	emit_signal("gained_coin")
	
