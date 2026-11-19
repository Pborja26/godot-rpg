class_name Character
extends RefCounted

var name: String = ""
var level: int = 1

var attributes := Attributes.new()
var health: HealthPoints
var mana: ManaPoints
var xp: Experience

func _init(p_name: String = "") -> void:
	name = p_name
	health = HealthPoints.new(self)
	mana = ManaPoints.new(self)
	xp = Experience.new(self)
	restore()

func restore() -> void:
	health.health = health.max_health()
	mana.mana = mana.max_mana()
