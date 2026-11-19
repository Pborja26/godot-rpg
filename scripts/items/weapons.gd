class_name Weapon
extends Item

enum WeaponType { DAGGER, SWORD, BOW, STAFF }

@export var weapon_type: WeaponType
@export var min_damage: int = 1
@export var max_damage: int = 4

func _init() -> void:
	type = ItemType.WEAPON

func roll_damage() -> int:
	return randi_range(min_damage, max_damage)

func describe() -> String:
	return "%s (Damage %d-%d)" % [name, min_damage, max_damage]
