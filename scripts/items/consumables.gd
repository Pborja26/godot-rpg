class_name Consumable
extends Item

enum ConsumableType { HP, MP }

@export var potion_type: ConsumableType
@export var value: int

func _init(owner: Character) -> void:
	type =  ItemType.POTION

func describe() -> String:
	return ""
