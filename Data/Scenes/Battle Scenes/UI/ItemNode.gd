extends MarginContainer
class_name ItemNode

@onready var button = $Button

func _ready():
	pass

func SetSkill(item):
	$Button/HBoxContainer/SkillName.text = item.item_name
	$Button/HBoxContainer/SkillDesc.text = item.description
	$Button/HBoxContainer/Label.text = " - (" +  str(PlayerData.inventory[item.item_id])+ ")"
