extends MarginContainer
class_name SkillNode

@onready var button = $Button

func _ready():
	pass

func SetSkill(skill):
	$Button/HBoxContainer/SkillName.text = skill.skill_name
	$Button/HBoxContainer/SkillDesc.text = skill.skill_description
