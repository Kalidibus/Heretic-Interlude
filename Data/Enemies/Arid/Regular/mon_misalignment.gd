extends Monster

func _ready():
	charname = "Misalignment"
	reward_xp = Globals.RNG_range(10, 20)
	loot_table = {
		&"c0001": 55,
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
		stat.DEX: 5,
		stat.FTH: 10,
		stat.INT: 10,
		stat.SPD: 8,
		stat.RES: 10,
		stat.ACC: 5,
		stat.EVD: 7,
		stat.CRIT: 10,
		stat.CRITDMG: 1.5
		}
	statres = {
		status_effects.POISON: 10,
		status_effects.STUN: 20,
		status_effects.BURN: 20,
		status_effects.BLIND: 20,
		status_effects.SEAL: 10
		}
	damageres = {
		damage_type.IMPACT: 30,
		damage_type.SLASH: -30,
		damage_type.PIERCE: 30,
		damage_type.FEL: 5,
		damage_type.INFERNAL: 5,
		damage_type.LEVIN: 20,
		damage_type.DEEP: 20,
		damage_type.ERDE: 5,
		damage_type.VIRTUOS: -25,
		damage_type.TRUE: 0
		}
	weapontype = damage_type.SLASH

func AttackList(rng):
	if rng <= 50: return SkillDict.get_skill_action(&"ATTACK")
	if rng <= 90: return SkillDict.get_skill_action(&"misalign-s01")
	if rng <= 100: return SkillDict.get_skill_action(&"misalign-s02")
