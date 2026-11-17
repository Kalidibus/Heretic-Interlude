extends Node

enum stat {
	HP = 0,
	MAXHP = 1,
	MP = 2,
	MAXMP = 3,
	STR = 4,
	DEF = 5,
	DEX = 6,
	RES = 7,
	INT = 8,
	FTH = 9,
	EVD = 10,
	ACC = 11,
	SPD = 12,
	CRIT = 13,
	CRITDMG = 14,
	HATE = 15,
}

enum stat_scale {
	F = 0,
	E = 1,
	D = 2,
	C = 3,
	B = 4,
	A = 5,
	S = 6,
}

enum damage_type {
	PIERCE = 0,
	IMPACT = 1,
	SLASH = 2,
	INFERNAL = 3,
	LEVIN = 4,
	DEEP = 5,
	ERDE = 6,
	VIRTUOS = 7,
	FEL = 8,
	TRUE = 9,
}

enum status_effects {
	POISON = 0,
	BURN = 1,
	BLIND = 2,
	STUN = 3,
	SEAL = 4,
	MARKED = 5,
	REGEN = 6,
}

enum row_line {
	FRONT = 0,
	BACK = 1,
}

enum skill {
	name = 0,
	desc = 1,
	passive = 2,
	max_level = 3,
	current_level = 4,
	parent_unlock_level = 5,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
