class_name Attributes
extends RefCounted

const STR := "Strength"
const DEX := "Dexterity"
const CON := "Constitution"
const INT := "Intelligence"
const CHA := "Charisma"

var _values := {
	STR: 10,
	DEX: 10,
	CON: 10,
	INT: 10,
	CHA: 10,
}

func get_value(attr_name: String) -> int:
	assert(_values.has(attr_name), "Atributo inválido: %s" % attr_name)
	return _values[attr_name]

func set_value(attr_name: String, value: int) -> void:
	if not _values.has(attr_name):
		push_error("Atributo inválido: %s" % attr_name)
		return
	_values[attr_name] = value

func keys() -> Array:
	return _values.keys()

func modifier(attr_name: String) -> int:
	return floori((get_value(attr_name) - 10) / 2.0)
