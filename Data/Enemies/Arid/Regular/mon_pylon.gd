extends Monster

func _ready():
	charname = "Pylon"
	reward_xp = Globals.RNG_range(10, 20)
	loot_table = {
		&"c0001": 55,
		&"c0002": 15,
		&"c0003": 15,
		&"c0004": 15}
	roll_count = Globals.ROLL_COUNT
	
	enemy = true
	row = row_line.FRONT
	stats = {
		stat.MAXHP: 30,
		stat.HP: 30,
		stat.MAXMP: 5,
		stat.MP: 5,
		stat.STR: 10,
		stat.DEF: 10,
		stat.DEX: 5,
		stat.FTH: 5,
		stat.INT: 5,
		stat.SPD: 8,
		stat.RES: 10,
		stat.ACC: 5,
		stat.EVD: 5,
		stat.CRIT: 5,
		stat.CRITDMG: 1.5
		}
	statres = {
		status_effects.POISON: 10,
		status_effects.STUN: 50,
		status_effects.BURN: 20,
		status_effects.BLIND: 20,
		status_effects.SEAL: 10
		}
	damageres = {
		damage_type.IMPACT: 30,
		damage_type.SLASH: 30,
		damage_type.PIERCE: 30,
		damage_type.FEL: 5,
		damage_type.INFERNAL: 5,
		damage_type.LEVIN: -20,
		damage_type.DEEP: -20,
		damage_type.ERDE: 5,
		damage_type.VIRTUOS: -25,
		damage_type.TRUE: 0
		}
	weapontype = damage_type.IMPACT

func AttackList(rng):
	if rng <= 75: return SkillDict.get_skill_action(&"ATTACK")
	elif rng <= 90: return SkillDict.get_skill_action(&"pylon-s01")
	elif rng <= 100: return SkillDict.get_skill_action(&"pylon-s02")
