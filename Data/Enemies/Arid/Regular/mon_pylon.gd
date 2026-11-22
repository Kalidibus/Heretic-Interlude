extends Monster

func _ready():
	charname = "Pylon"
	reward_xp = Globals.RNG_range(10, 20)
	loot_table = {
		ItemDict.get_item(&"c00001"): 55,
		ItemDict.get_item(&"c00002"): 15,
		ItemDict.get_item(&"c00003"): 15,
		ItemDict.get_item(&"c00004"): 15}
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

func AttackList(mtarget, rng):
	if rng <= 75: mAttack(mtarget)
	elif rng <= 90: Bludgeon(mtarget)
	elif rng <= 100: mDefend()

func mAttack(mtarget):
	if not CheckMiss(mtarget): return
	var result = Damage(mtarget, 1.2 * Stat(stat.STR), damage_type.SLASH)
	%CombatGUI.BattleLog("The " + charname + " slashes at " + mtarget.charname + " for " + str(result.damage) + " damage!")
	CloseTurn(result)
	
func Bludgeon(mtarget):
	if not CheckMiss(mtarget): return
	var result = Damage(mtarget, 1.5 * Stat(stat.STR), damage_type.IMPACT)
	%CombatGUI.BattleLog("The " + charname + " emits a bloodcurdling shriek and bludgeons " + mtarget.charname + " fiercly for " + str(result.damage) + " damage!!!")
	target.AttemptStatusAilment(status_effects.STUN, 0, 0, 0)
	CloseTurn(result)

func mDefend():
	StatMod(stat.DEF, 1.5, 0)
	%CombatGUI.BattleLog("The " + str(charname) + " folds it's body up defensively...")
	CloseTurn(ActionResult.new())
