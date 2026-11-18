extends Node

const SKILLS_DIR := "res://Skills/Skill Files"
var skills_by_id: Dictionary = {}

const SKILL_ACTIONS_DIR := "res://Skills/Skill Actions"
var skill_actions_by_id: Dictionary = {}

enum books {ITEMS = 0, AUGMENTS = 1, GEAR = 2, FORTRESS = 3, FEL_MAGE = 4}

func _ready() -> void:
	#populate skills by ID variable
	for file_name in DirAccess.get_files_at(SKILLS_DIR):
		if file_name.get_extension() != "tres":
			continue
		var path := SKILLS_DIR.path_join(file_name)
		var skill := load(path) as SkillClass
		skills_by_id[skill.skill_id] = skill

	#populate skill actions by ID variable
#	for file_name in DirAccess.get_files_at(SKILL_ACTIONS_DIR):
#		if file_name.get_extension() != "gd":
#			continue
#		var path := SKILL_ACTIONS_DIR.path_join(file_name)
#		var skill_action := load(path) as Script
#		skill_actions_by_id[skill_action.skill_action_id] = skill_action

func execute(skill: SkillClass, user: Entity, targets: Array[Entity], level: int) -> void:
	var action := Callable(self, skill.skill_trigger)
	if not action.is_valid():
		push_error("Unknown skill behavior: " + str(skill.skill_trigger))
		return
	action.call(skill, user, targets, level)

func get_skill(id: StringName) -> ItemClass:
	return skills_by_id.get(id)

func get_skill_name(id: StringName) -> ItemClass:
	return skills_by_id.get(id).skill_name
