class_name Character
extends RefCounted

var name: String = ""
var level: int = 1

var attributes := Attributes.new()
var health: HealthPoints
var mana: ManaPoints
var xp: Experience
var inventory := CharacterInventory.new()
var equipement := CharacterEquips.new()

func _init(p_name: String = "") -> void:
	name = p_name
	health = HealthPoints.new(self)
	mana = ManaPoints.new(self)
	xp = Experience.new(self)
	restore()

func restore() -> void:
	health.health = health.max_health()
	mana.mana = mana.max_mana()

func equip(item: Item) -> bool:
	if equipement.slot_for(item) == -1:
		return false
	if not inventory.remove(item):
		return false
	var old := equipement.equip(item)
	if old:
		inventory.add(old)
	return true

func unequip(slot: CharacterEquips.Slot) -> bool:
	var old := equipement.get_item(slot)
	if old == null or not inventory.add(old):
		return false
	equipement.unequip(slot)
	return true

func use_item(item: Item) -> bool:
	if inventory.count(item) == 0:
		return false
	if not item.use(self):
		return false
	inventory.remove(item)
	return true

func attack_damage() -> int:
	var w := equipement.weapon()
	var base: int = w.roll_damage() if w else randi_range(1, 2)
	return maxi(1, base + attributes.modifier(Attributes.STR))
