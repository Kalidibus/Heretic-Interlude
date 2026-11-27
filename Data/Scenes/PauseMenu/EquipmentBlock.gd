extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func SetSkill(item : ItemClass):
	%item_slot.text = str(ItemClass.slot.find_key(item.item_slot))
	%item_name.text = item.item_name
	%item_stats.text = format_stat_modifiers(item)
	%item_rarity.text = str(ItemClass.rarity.find_key(item.item_rarity))
	%item_description.text = item.description


func format_stat_modifiers(item: ItemClass) -> String:
	var parts: Array[String] = []
	
	if item.stat_modifiers.is_empty(): return "None"
	
	for stat in item.stat_modifiers:
		var stat_name := str(Entity.stat.find_key(stat))
		var value: int = item.stat_modifiers[stat]
		var sign := "+" if value >= 0 else ""

		parts.append("%s (%s%s)" % [stat_name, sign, value])

	return " / ".join(parts)
