extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func SetSkill(item : ItemClass):
	%item_slot.text = str(ItemClass.slot.find_key(item.item_slot))
	%item_name.text = item.item_name
	#%item_stats.text = str(item.item_stats)
	%item_rarity.text = str(ItemClass.rarity.find_key(item.item_rarity))
	%item_description.text = item.description
