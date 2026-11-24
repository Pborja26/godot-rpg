class_name Armor
extends Item

enum ArmorType { HEAVY, LIGHT, SHIELD }
enum SlotFor { HEAD, BODY, ARMS, LEGS, FEET, HAND }

@export var armor_type: ArmorType
@export var defense: int = 0
@export var slot_for: SlotFor

func _init() -> void:
	type = ItemType.ARMOR

func describe() -> String:
	return "%s (Defense: %d) - %d" % [name, defense, armor_type]
