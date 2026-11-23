class_name CharacterActions
extends RefCounted

var _owner_ref: WeakRef

enum ActionsList { Attack, Magic, Bag, Flee }

func _init(owner: Character) -> void:
	_owner_ref = weakref(owner)

func _owner() -> Character:
	return _owner_ref.get_ref()

func _use_attack() -> void:
	var o = _owner()
	
