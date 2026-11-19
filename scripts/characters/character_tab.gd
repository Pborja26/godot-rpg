class_name CharacterInfoTab
extends Control

@onready var charname: Label = %CharacterName
@onready var charlvl: Label = %CharacterLevel
@onready var charstatus: VBoxContainer = %CharacterStatus

var hero := GameState.player

func _ready() -> void:
	charname.text = hero.name
	charlvl.text = "Level: %d" % hero.level
	var label = Label.new()
	label.text = "HP: %d / %d || MP: %d / %d" % [
		hero.health.health, 
		hero.health.max_health(),
		hero.mana.mana,
		hero.mana.max_mana()
	]
	label.add_theme_font_override("font", preload("res://assets/fonts/PixelOperator8.ttf"))
	label.add_theme_font_size_override("font_size", 8)
	charstatus.add_child(label)
	for attr in hero.attributes.keys():
		_build_row(attr)

func _build_row(attr: String) -> void:
	var label = Label.new()
	label.text = "%s: %d (%+d)" % [attr, hero.attributes.get_value(attr), hero.attributes.modifier(attr)]
	label.add_theme_font_size_override("font_size", 8)
	label.add_theme_font_override("font", preload("res://assets/fonts/PixelOperator8.ttf"))
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	charstatus.add_child(label)
