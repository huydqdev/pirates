extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed = -60.0

var facing_right = false
var dead = false

func _ready() -> void:
	animated_sprite.play('run')

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if !$RayCastDown.is_colliding() && is_on_floor() || $RayCastDirect.is_colliding():
		flip()
	
	velocity.x = speed
	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player && !dead:
		area.get_parent().died()

func died():
	dead = true
	speed = 0
	animated_sprite.play('dead_hit')
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == 'dead_hit' && dead:
		queue_free()
