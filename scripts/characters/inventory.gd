class_name CharacterInventory
extends RefCounted

signal  changed

var slots: Array = []
var max_weight := 50.0

func add(item: Item, amount := 1) -> bool:
	if current_weight() + item.weight * amount > max_weight:
		return false

	for slot in slots:
		if slot.item == item and slot.amount < item.max_stack():
			var put := mini(item.max_stack() - slot.amount, amount)
			slot.amount += put
			amount -= put
			if amount == 0:
				break

	while amount > 0:
		var put := mini(item.max_stack(), amount)
		slots.append({"item": item, "amount": put})
		amount -= put
	
	changed.emit()
	return true

func remove(item: Item, amount := 1) -> bool:
	if count(item) < amount:
		return false
	for i in range(slots.size() -1, -1, -1):
		var slot = slots[i]
		if slot.item != item:
			continue
		var take := mini(slot.amount, amount)
		slot.amount -= take
		amount -= take
		if slot.amount == 0:
			slots.remove_at(i)
		if amount == 0:
			break
	changed.emit()
	return true

func count(item: Item) -> int:
	var total := 0
	for slot in slots:
		if slot.item == item:
			total += slot.amount
	return total

func current_weight() -> float:
	var total := 0.0
	for slot in slots:
		total += slot.item.weight * slot.amount
	return total
