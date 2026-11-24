class_name Potion
extends Item

enum PotionType { HP, MP }

@export var potion_type: PotionType
@export var value: int

func _init() -> void:
	type =  ItemType.POTION

func max_stack() -> int:
	return 10

func use(user: Character) -> bool:
	match potion_type:
		PotionType.HP:
			user.health.heal(value)
		PotionType.MP:
			user.mana.recover_mana(value)
	return true

func describe() -> String:
	return "%s (+%d %s)" % [name, value, "HP" if potion_type == PotionType.HP else "MP"]
