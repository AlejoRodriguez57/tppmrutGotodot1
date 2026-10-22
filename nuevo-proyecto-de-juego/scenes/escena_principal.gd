extends Node2D

@export var niveles: Array[PackedScene]

var _nivel_actual: int = 1
var _nivel_instanciado: Node
var _reiniciando: bool = false


func _ready() -> void:
	_crear_nivel(_nivel_actual)


func _crear_nivel(numero_nivel: int) -> void:
	_nivel_instanciado = niveles[numero_nivel - 1].instantiate()
	add_child(_nivel_instanciado)

	var personajes = get_tree().get_nodes_in_group("personajes")

	if personajes.size() > 0:
		var personaje = personajes[0]
		if not personaje.personaje_muerto.is_connected(_reiniciar_nivel):
			personaje.personaje_muerto.connect(_reiniciar_nivel)


func _reiniciar_nivel() -> void:
	if _reiniciando:
		return

	_reiniciando = true

	_nivel_instanciado.queue_free()
	await get_tree().process_frame

	_crear_nivel(_nivel_actual)

	_reiniciando = false
