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
	BACK_ALLIES = 8,
	EVERYONE = 9, 
	RANDOM = 10, 
	RANDOM_ENEMY = 11,
	RANDOM_ALLY = 12, 
	RANDOM_FRONT_ENEMY = 13, 
	RANDOM_FRONT_ALLY = 14, 
	RANDOM_BACK_ENEMY = 15, 
	RANDOM_BACK_ALLY = 16,
	SINGLE_ANYONE = 17,
	SINGLE_DEAD_ALLY = 18, 
	FRONT_DEAD_ALLIES = 19,
	BACK_DEAD_ALLIES = 20,
	ALL_DEAD_ALLIES = 21
}
enum tags {RAISE = 0}


@export var skill_id: StringName
@export var skill_name: String
@export_multiline var skill_description: String = "placeholder"
@export var skill_target: target
@export var skill_trigger: StringName
@export var skill_max_level: int = 1
@export var skill_mp_cost: int = 10
@export var skill_mp_level_scaling: float = 1.1
@export var skill_book: SkillDict.books
@export var skill_tags: Array [tags]  

var skill_level: int

func ready():
	pass
func Attack():
	pass
