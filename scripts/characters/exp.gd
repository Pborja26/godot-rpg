class_name Experience
extends RefCounted

signal leveled_up(new_level: int)

var _owner_ref: WeakRef

var xp: int = 0:
	set(value):
		xp = maxi(0, value)
		var owner := _owner()
		if owner == null:
			return
		while xp >= next_level_at():
			owner.level += 1
			leveled_up.emit(owner.level)

func _init(owner: Character) -> void:
	_owner_ref = weakref(owner)

func _owner() -> Character:
	return _owner_ref.get_ref()

func next_level_at() -> int:
	return _owner().level * 300

func add(amount: int) -> void:
	xp += amount
