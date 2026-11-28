extends MarginContainer

var node_item
var slot 
var matching_items: Array[ItemClass] = []
var charid

signal equipment_changed
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func SetSkill(item : ItemClass):
	slot = item.item_slot
	
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



func _on_eqp_button_pressed() -> void:
	var item_popup = %PopupMenu

	item_popup.clear()
	matching_items.clear()

	print(PlayerData.inventory)
	for item in PlayerData.inventory:
	

		if ItemDict.items_by_id.get(item).item_slot != slot:
			continue
		var index := matching_items.size()
		matching_items.append(ItemDict.items_by_id.get(item))

		item_popup.add_item(ItemDict.items_by_id.get(item).item_name, index)

	if matching_items.is_empty():
		item_popup.add_item("No other items to equip...", 0)
		item_popup.set_item_disabled(0, true)
		#return
	
	# Open the menu near the clicked EquipButton.
	item_popup.position = Vector2i(%EqpButton.global_position)
	item_popup.popup()


func _on_popup_menu_id_pressed(item_id: int) -> void:
	var item: ItemClass = matching_items[item_id]
	CharacterChanges.add_equipment(charid, item.item_id, "party")
	SetSkill(item)
	equipment_changed.emit()
