class_name Item
extends Resource

enum ItemType { ARMOR, WEAPON, POTION }

@export var name: String = ""
@export var type: ItemType
@export var weight: float = 0.0

func max_stack() -> int:
	return 1

func describe() -> String:
	return name
