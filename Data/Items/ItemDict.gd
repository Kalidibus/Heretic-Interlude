extends Node

@export var items: Array[ItemClass]
const ITEMS_DIR := "res://Items/Item Files"

var items_by_id: Dictionary = {}

func _ready() -> void:
	for file_name in DirAccess.get_files_at(ITEMS_DIR):
		if file_name.get_extension() != "tres":
			continue
		var path := ITEMS_DIR.path_join(file_name)
		var item := load(path) as ItemClass
		items_by_id[item.item_id] = item
	print(str(items_by_id))

func get_item(id: StringName) -> ItemClass:
	return items_by_id.get(id)

func get_item_name(id: StringName) -> ItemClass:
	return items_by_id.get(id).item_name
