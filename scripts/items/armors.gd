class_name Armor
extends Item

enum ArmorType { HEAVY, LIGHT, SHIELD }

@export var armor_type: ArmorType
@export var defense: int = 0

func _init(owner: Character) -> void:
	type = ItemType.ARMOR

func describe() -> String:
	return "%s (Defense: %d) - %d" % [name, defense, armor_type]
