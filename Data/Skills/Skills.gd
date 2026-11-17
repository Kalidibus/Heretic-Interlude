class_name SkillClass
extends Resource

enum type{PASSIVE, ACTIVE}
enum target {
	SELF = 0,
	SINGLE_ENEMY = 1,
	SINGLE_ALLY = 2,
	ALL_ENEMIES = 3,
	ALL_ALLIES = 4,
	FRONT_ENEMIES = 5,
	FRONT_ALLIES = 6,
	BACK_ENEMIES = 7,
	BACK_ALLIES = 8
}


@export var skill_id: StringName
@export var skill_name: String
@export_multiline var skill_description: String = "placeholder"
@export var skill_target: target
@export var skill_trigger: StringName
@export var skill_max_level: int = 1
@export var skill_book: SkillBook.books

var skill_level: int

func ready():
	pass
func Attack():
	pass
