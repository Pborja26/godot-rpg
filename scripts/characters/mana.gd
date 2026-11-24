class_name ManaPoints
extends RefCounted

var _owner_ref: WeakRef

var mana: int = 1:
	set(value):
		mana = clampi(value, 0, max_mana())

func _init(owner: Character) -> void:
	_owner_ref = weakref(owner)

func _owner() -> Character:
	return _owner_ref.get_ref()

func max_mana() -> int:
	var o := _owner()
	return maxi(0, 5 + o.level * (3 + o.attributes.modifier(Attributes.INT)))

func use_mana(amount: int) -> void:
	mana -= amount

func recover_mana(amount: int) -> void:
	mana += amount
