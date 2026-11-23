extends Node

const SKILLS_DIR := "res://Skills/Skill Files"
var skills_by_id: Dictionary [StringName, SkillClass] = {}

const SKILL_ACTIONS_DIR := "res://Skills/Skill Actions"
var skill_actions_by_id: Dictionary [StringName, SkillActions] = {}

enum books {
	ITEMS = 0,
	AUGMENTS = 1,
	GEAR = 2,
	FORTRESS = 3,
	FEL_MAGE = 4,
	BASTARD_FIST = 5,
	REDEEMER = 6,
	SHADE_HUNTER = 7,
	DANCER = 8,
	SAMURAI = 9,
	ILLUSIONIST = 10,
	WAR_MAGE = 11
	}

func _ready() -> void:
	#populate skills by ID variable
	for file_name in DirAccess.get_files_at(SKILLS_DIR):
		if file_name.get_extension() != "tres":
			continue
		var path := SKILLS_DIR.path_join(file_name)
		var skill := load(path) as SkillClass
		skills_by_id[skill.skill_id] = skill

	#populate skill actions by ID variable
	for file_name in DirAccess.get_files_at(SKILL_ACTIONS_DIR):
		if file_name.get_extension() != "gd":
			continue
		var path := SKILL_ACTIONS_DIR.path_join(file_name)
		var action_script := load(path) as GDScript
		var skill_action := action_script.new() as SkillActions
		skill_actions_by_id[skill_action.skill_action_id] = skill_action

func get_skill(id: StringName) -> SkillClass:
	return skills_by_id.get(id)

func get_skill_action(id: StringName) -> SkillActions:
	return skill_actions_by_id.get(id)

func get_skill_name(id: StringName) -> String:
	return skills_by_id.get(id).skill_name
