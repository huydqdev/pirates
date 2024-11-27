extends CharacterBody2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimationPlayer
@onready var sprite: Area2D = $Area2D
@onready var hitbox: CollisionShape2D = $AttackArea/CollisionShape2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

@export var SPEED = 200.0
@export var JUMP_VELOCITY = -350.0
@export var attacking = false

var default_hitbox: float

func _ready():
	GameManager.player = self
	default_hitbox = hitbox.position.x

func _process(delta: float):
	if Input.is_action_pressed("attack") && !attacking:
		attack()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		#jump_sound.play()
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false;
		hitbox.position.x = default_hitbox
		
	elif direction < 0:
		animated_sprite.flip_h = true;
		hitbox.position.x = -default_hitbox
		
	# Play animation
	if !attacking:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play('idle')
			else:
				animated_sprite.play('run')
		elif velocity.y > 0:
			animated_sprite.play('fall')
		elif velocity.y < 0:
			animated_sprite.play('jump')
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	

func attack():
	# hitbox cant flip - check that
	var overlaping_object = $AttackArea.get_overlapping_areas()
	var ran_attack = randi_range(1,3)
	for area in overlaping_object:
		if area.get_parent().is_in_group('Enemies'):
			area.get_parent().died()
	attacking = true
	if ran_attack == 1:
		animated_sprite.play('attack2')
	elif ran_attack == 2:
		animated_sprite.play('attack1')
	else:
		animated_sprite.play('attack3')
		

func died():
	GameManager.respawn_player()

func _on_animation_player_animation_finished() -> void:
	if animated_sprite.animation == 'attack2' or  animated_sprite.animation == 'attack1' or  animated_sprite.animation == 'attack3':
		attacking = false
