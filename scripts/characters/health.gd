class_name HealthPoints
extends RefCounted

signal died

var _owner_ref: WeakRef

var health: int = 1:
	set(value):
		var was_alive := health > 0
		health = clampi(value, 0, max_health())
		if was_alive and health == 0:
			died.emit()

func _init(owner: Character) -> void:
	_owner_ref = weakref(owner)

func _owner() -> Character:
	return _owner_ref.get_ref()

func max_health() -> int:
	var o := _owner()
	return maxi(1, 10 + o.level * (4 + o.attributes.modifier(Attributes.CON)))

func take_damage(amount: int) -> void:
	health -= amount

func heal(amount: int) -> void:
	health += amount

func is_dead() -> bool:
	return health == 0
