extends MarginContainer
class_name ItemNode

@onready var button = $Button

func _ready():
	pass

func SetSkill(skill):
	$Button/HBoxContainer/SkillName.text = skill.item_name
	$Button/HBoxContainer/SkillDesc.text = skill.description
