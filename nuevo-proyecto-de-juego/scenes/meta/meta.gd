
extends Node2D

@export var area2d: Area2D

func _ready() -> void:
	area2d.body_entered.connect(_recogida)


func _recogida(_body: Node2D) -> void:
	area2d.set_deferred("monitoring", false)
	queue_free.call_deferred()
	get_tree().change_scene_to_file.call_deferred("res://scenes/preubas.tscn")
