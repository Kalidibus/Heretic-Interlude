extends Monster

func _ready():
	charname = "Brain Rot"
	reward_xp = Globals.RNG_range(20, 35)
	loot_table = {
		&"c0001": 15,
		&"c0002": 15,
		&"c0003": 15,
		&"c0004": 15}
	roll_count = Globals.ROLL_COUNT
	
	enemy = true
	row = row_line.BACK
	stats = {
		stat.MAXHP: 30,
		stat.HP: 30,
		stat.MAXMP: 5,
		stat.MP: 5,
		stat.STR: 6,
		stat.DEF: 8,
		stat.DEX: 10,
		stat.FTH: 5,
		stat.INT: 5,
		stat.SPD: 8,
		stat.RES: 10,
		stat.ACC: 5,
		stat.EVD: 7,
		stat.CRIT: 10,
		stat.CRITDMG: 1.5
		}
	statres = {
		status_effects.POISON: 90,
		status_effects.STUN: 20,
		status_effects.BURN: 5,
		status_effects.BLIND: 20,
		status_effects.SEAL: 10
		}
	damageres = {
		damage_type.IMPACT: 45,
		damage_type.SLASH: 5,
		damage_type.PIERCE: 5,
		damage_type.FEL: 20,
		damage_type.INFERNAL: -35,
		damage_type.LEVIN: 20,
		damage_type.DEEP: 20,
		damage_type.ERDE: 20,
		damage_type.VIRTUOS: 20,
		damage_type.TRUE: 0
		}

func AttackList(rng):
	if rng <= 100: return SkillDict.get_skill_action(&"brainrot-s01")
