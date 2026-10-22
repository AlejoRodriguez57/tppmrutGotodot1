extends Node2D

signal todas_monedas_recogidas

var monedas_totales: int = 0
var monedas_recogidas: int = 0

func _ready() -> void:
	var monedas = get_tree().get_nodes_in_group("monedas")
	monedas_totales = monedas.size()

	for moneda in monedas:
		moneda.moneda_recogida.connect(_al_recoger_moneda)

	if monedas_totales == 0:
		todas_monedas_recogidas.emit()

func _al_recoger_moneda() -> void:
	monedas_recogidas += 1

	if monedas_recogidas >= monedas_totales:
		todas_monedas_recogidas.emit()
