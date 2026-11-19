extends MarginContainer

var filternode
var label 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func ClearItems():
	var array = %Items.get_children()
	for n in array:
		%Items.remove_child(n)
#	RemoveFilter()

	if label != null:
		label.queue_free()


func FillItems(type):
	var itemblock = load("res://Scenes/PauseMenu/ItemBlock.tscn")
	var count = 0
	
	for item in PlayerData.inventory:
		var n = ItemDict.get_item(item)
		if n.item_subtype == type:
			%Items.add_child(itemblock.instantiate())
			%Items.get_child(count).get_node("%Name").text = n.item_name
			%Items.get_child(count).get_node("%Qty").text = str(PlayerData.GetInvItemQty(item))
			%Items.get_child(count).get_node("%Description").text = n.description
			count += 1
	if count == 0:
		label = Label.new()
		$VBoxContainer.add_child(label)
		label.text = "None"

func _on_crafting_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.component)

func _on_head_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.head)

func _on_body_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.body)

func _on_gloves_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.gloves)

func _on_pants_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.pants)

func _on_rings_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.ring)

func _on_necklaces_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.necklace)

func _on_hand_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.gloves)

func _on_two_handed_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.component)

func _on_shields_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.shield)

func _on_arcana_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.arcana)

func _on_augments_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.augments)

func _on_key_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.key)

func _on_items_pressed() -> void:
	ClearItems()
	FillItems(ItemClass.subtype.consumable)
