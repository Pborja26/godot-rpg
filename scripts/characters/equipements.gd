class_name CharacterEquips
extends RefCounted

signal changed

enum Slot { MAIN_HAND, OFF_HAND, BODY }

var _slots := {}

func slot_for(item: Item) -> int:
	if item is Weapon:
		return Slot.MAIN_HAND
	if item is Armor:
		return Slot.OFF_HAND if item.armor_type == Armor.ArmorType.SHIELD else Slot.BODY
	return -1

func equip(item: Item) -> Item:
	var slot := slot_for(item)
	var old: Item = _slots.get(slot)
	_slots[slot] = item
	changed.emit()
	return old

func unequip(slot: Slot) -> Item:
	var old: Item = _slots.get(slot)
	_slots.erase(slot)
	changed.emit()
	return old

func get_item(slot: Slot) -> Item:
	return _slots.get(slot)

func weapon() -> Weapon:
	return _slots.get(Slot.MAIN_HAND)

func total_defense() -> int:
	var total := 0
	for item in _slots.values():
		if item is Armor:
			total += item.defense
	return total
