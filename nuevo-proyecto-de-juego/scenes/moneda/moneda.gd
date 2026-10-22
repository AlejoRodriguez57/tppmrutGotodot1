extends Node2D

@export var area2d: Area2D

signal moneda_recogida

func _ready() -> void:
	add_to_group("monedas")
	area2d.body_entered.connect(_recogida)

func _recogida(_body: Node2D) -> void:
	moneda_recogida.emit()
	queue_free()
