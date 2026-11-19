class_name CharacterCreation
extends Control

const BASE_VALUE:= 8
const MAX_VALUE:= 15
const TOTAL_POINTS:= 10
const ATTRIBUTES_LIST := [
	Attributes.STR,
	Attributes.DEX,
	Attributes.CON,
	Attributes.INT,
	Attributes.CHA
]

@onready var name_edit: LineEdit = %NameEdit
@onready var points_label: Label = %PointsLabel
@onready var attributes_list: VBoxContainer = %AttributesList
@onready var create_button: Button = %CreateButton

var _values := {}
var _values_labels := {}
var _minus_buttons := {}
var _plus_buttons := {}

func _ready() -> void:
	for attr in ATTRIBUTES_LIST:
		_values[attr] = BASE_VALUE
		_build_row(attr)
	name_edit.text_changed.connect(func(_t): _refresh())
	create_button.pressed.connect(_on_create_pressed)
	_refresh()

func _build_row(attr: String) -> void:
	var row := HBoxContainer.new()
	
	var label := Label.new()
	label.text = attr
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	var minus := _make_button("-")
	minus.pressed.connect(_change.bind(attr, -1))
	
	var value := Label.new()
	value.custom_maximum_size.x = 64
	value.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	var plus := _make_button("+")
	plus.pressed.connect(_change.bind(attr, 1))
	
	for node in [label, minus, value, plus]:
		row.add_child(node)
	attributes_list.add_child(row)
	
	_values_labels[attr] = value
	_minus_buttons[attr] = minus
	_plus_buttons[attr] = plus
	
	
func _make_button(text: String) -> Button:
	var b := Button.new()
	b.text = text
	b.custom_maximum_size = Vector2(88, 88)
	return b
	
func _points_left() -> int:
	var spent := 0
	for attr in _values:
		spent += _values[attr] - BASE_VALUE
	return TOTAL_POINTS - spent

func _change(attr: String, delta: int) -> void:
	var new_value: int = _values[attr] + delta
	if new_value < BASE_VALUE or new_value > MAX_VALUE:
		return
	if delta > 0 and _points_left() == 0:
		return
	_values[attr] = new_value
	_refresh()
	
func _refresh() -> void:
	var left := _points_left()
	points_label.text = "Remaining points: %d" % left
	for attr in _values:
		_values_labels[attr].text = str(_values[attr])
		_minus_buttons[attr].disabled = _values[attr] <= BASE_VALUE
		_plus_buttons[attr].disabled = left == 0 or _values[attr] >= MAX_VALUE
		create_button.disabled = name_edit.text.strip_edges().is_empty() or left > 0

func _on_create_pressed() -> void:
	var hero := Character.new(name_edit.text.strip_edges())
	for attr in _values:
		hero.attributes.set_value(attr, _values[attr])
	hero.restore()
	GameState.player = hero
	get_tree().change_scene_to_file("res://scenes/character_tab.tscn")
