class_name JobsClass
extends Resource

enum type {player = 0, monster = 1}

@export_group("Identity")
@export var job_id: StringName
@export var job_name: String
@export var job_type: type
@export_multiline var job_description: String = "Job description placeholder"

@export_group("Assets")
@export var job_splash_image: Texture2D
@export var job_profile_image: Texture2D
@export var job_label_image: Texture2D
@export var job_skill_tree: PackedScene

@export_group("Creation")
@export var job_unlock_requirements: Dictionary[StringName, int] = {
		&"c0001":20,
		&"c0002":20,
		&"c0003":20,
		&"c0004":20
}

@export var job_starting_eqp: Dictionary[StringName, int] = {
		&"w0001":1,
		&"h0001":1,
		&"b0001":1
	
}
@export_group("Stats")
@export var starting_stats: Dictionary[JobDict.stats, int]= {
	JobDict.stats.HP: 25,
	JobDict.stats.MAXHP: 25,
	JobDict.stats.MP: 50,
	JobDict.stats.MAXMP: 50,
	JobDict.stats.STR: 8,
	JobDict.stats.DEF: 8,
	JobDict.stats.DEX: 8,
	JobDict.stats.RES: 8,
	JobDict.stats.INT: 8,
	JobDict.stats.FTH: 8,
	JobDict.stats.EVD: 8,
	JobDict.stats.ACC: 8,
	JobDict.stats.SPD: 8,
	JobDict.stats.CRIT: 10,
	JobDict.stats.CRITDMG: 150,
	JobDict.stats.HATE: 10,
}

@export var stat_scaling: Dictionary[JobDict.stats, JobDict.stat_scale] = {
	JobDict.stats.HP: JobDict.stat_scale.C,
	JobDict.stats.MAXHP: JobDict.stat_scale.C,
	JobDict.stats.MP: JobDict.stat_scale.C,
	JobDict.stats.MAXMP: JobDict.stat_scale.C,
	JobDict.stats.STR: JobDict.stat_scale.C,
	JobDict.stats.DEF: JobDict.stat_scale.C,
	JobDict.stats.DEX: JobDict.stat_scale.C,
	JobDict.stats.RES: JobDict.stat_scale.C,
	JobDict.stats.INT: JobDict.stat_scale.C,
	JobDict.stats.FTH: JobDict.stat_scale.C,
	JobDict.stats.EVD: JobDict.stat_scale.C,
	JobDict.stats.ACC: JobDict.stat_scale.C,
	JobDict.stats.SPD: JobDict.stat_scale.C,
	JobDict.stats.CRIT: JobDict.stat_scale.C,
	JobDict.stats.CRITDMG: JobDict.stat_scale.C,
	JobDict.stats.HATE: JobDict.stat_scale.C,
	}
