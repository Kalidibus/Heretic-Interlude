class_name SkillBook
extends Node

const SKILLS_DIR := "res://Skills/Skill Files"
var skills_by_id: Dictionary = {}

enum books {FORTRESS = 0, FELMAGE = 1}

func _ready() -> void:
	#populate skills by ID variable
	for file_name in DirAccess.get_files_at(SKILLS_DIR):
		if file_name.get_extension() != "tres":
			continue
		var path := SKILLS_DIR.path_join(file_name)
		var skill := load(path) as ItemClass
		skills_by_id[skill.skill_id] = skill
		

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
