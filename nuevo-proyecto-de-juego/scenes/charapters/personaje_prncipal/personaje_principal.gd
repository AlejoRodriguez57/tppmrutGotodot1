extends CharacterBody2D

signal personaje_muerto

@export var area2d: Area2D
@export var animacion: AnimatedSprite2D

const _velocidad = 100.0
const _jump_velocity = -205.0
var _muerto = false

func _ready():
	add_to_group("personajes")
	area2d.body_entered.connect(_on_area_2d_body_entered)

func _physics_process(delta: float) -> void:
	if _muerto:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#  jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = _jump_velocity
		
	#  run.
	if Input.is_action_pressed("ui_right"):
		velocity.x = _velocidad
		animacion.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -_velocidad
		animacion.flip_h = true
	else:
		velocity.x = 0
		
	# 
	
	if !is_on_floor():
		animacion.play("saltar")
	elif velocity.x > 0:
		animacion.play("correr")
	elif velocity.x < 0:
		animacion.play("correr")
	else:
		animacion.play("idle")

	move_and_slide()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	animacion.modulate = Color.RED
	_muerto = true
	animacion.stop()
	personaje_muerto.emit()
