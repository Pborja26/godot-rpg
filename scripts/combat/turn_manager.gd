class_name TurnManager
extends Node

enum Team { PLAYERS, ENEMIES }

signal round_started(round_number: int)
signal turn_started(actor: Character, team: Team)
signal action_performed(actor: Character, target: Character, damage: int)
signal combat_ended(winner: Team)

signal _player_target_chosen(target: Character)

var _teams := {}
var _order : Array = []
var _round := 0
var _running := false

func start_combat(players: Array, enemies: Array) -> void:
	_teams.clear()
	for c in players:
		_teams[c] = Team.PLAYERS
	for c in enemies:
		_teams[c] = Team.ENEMIES
	_roll_initiative()
	_round = 0
	_running = true
	_combat_loop()
	
func choose_target(target: Character) -> void:
	_player_target_chosen.emit(target)

func alive_of(team: Team) -> Array:
	return []

func team_of(c: Character) -> Team:
	return _teams[c]

func _roll_initiative() -> void:
	var rolls := {}
	for c in _teams:
		rolls[c] = randi_range(1, 20) + c.attributes.modifier(Attributes.DEX)
	_order = _teams.keys()
	_order.sort_custom(func(a, b): return rolls[a] > rolls[b])

func _combat_loop() -> void:
	while _running:
		_round += 1
		round_started.emit(_round)
		for actor in _order:
			if actor.health.is_dead():
				continue
			turn_started.emit(actor, _teams[actor])
			if _teams[actor] == Team.PLAYERS:
				await _player_turn(actor)
			else:
				await _enemy_turn(actor)
			var winner := _check_winner()
			if winner!= -1:
				_running = false
				combat_ended.emit(winner)
				return

func _player_turn(actor: Character) -> void:
	var target: Character = await _player_target_chosen
	while target.health.is_dead() or _teams[target] == _teams[actor]:
		target = await _player_target_chosen
	_attack(actor, target)

func _enemy_turn(actor: Character) -> void:
	await get_tree().create_timer(0.6).timeout
	var targets := alive_of(Team.PLAYERS)
	_attack(actor, targets.pick_random())

func _attack(actor: Character, target: Character) -> void:
	var damage := maxi(1, randi_range(1, 4) + 
actor.attributes.modifier(Attributes.STR))
	target.health.take_damage(damage)
	action_performed.emit(actor, target, damage)

func _check_winner() -> int:
	if alive_of(Team.ENEMIES).is_empty():
		return Team.PLAYERS
	if alive_of(Team.PLAYERS).is_empty():
		return Team.ENEMIES
	return -1
