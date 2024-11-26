extends CanvasLayer

func _ready() -> void:
	GameManager.gained_coin.connect(update_coin_display)

func update_coin_display():
	$CoinDisplay.text = str(GameManager.coins)
