extends Node

const SKILLS_DIR := "res://Skills/Skill Files"
var skills_by_id: Dictionary [StringName, SkillClass] = {}
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
	for path in _get_files_recursive(SKILLS_DIR):
		if path.get_extension() == "tres":
			var skill := load(path) as SkillClass
			skills_by_id[skill.skill_id] = skill
		elif path.get_extension() == "gd":
			var action_script := load(path) as GDScript
			var skill_action := action_script.new() as SkillActions
			skill_actions_by_id[skill_action.skill_action_id] = skill_action


func _get_files_recursive(directory_path: String) -> Array[String]:
	var paths: Array[String] = []
	var directory := DirAccess.open(directory_path)

	for file_name in directory.get_files():
		paths.append(directory_path.path_join(file_name))
	for subdirectory in directory.get_directories():
		paths.append_array(
			_get_files_recursive(directory_path.path_join(subdirectory))
		)
	return paths


func get_skill(id: StringName) -> SkillClass:
	return skills_by_id.get(id)

func get_skill_action(id: StringName) -> SkillActions:
	return skill_actions_by_id.get(id)

func get_skill_name(id: StringName) -> String:
	return skills_by_id.get(id).skill_name
