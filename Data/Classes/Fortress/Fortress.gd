extends Entity

enum skillid {Fort00, Fort01, Fort02, Fort03, Fort04, Fort05, Fort06, Fort07, Fort08, Fort09, Fort10, Fort11, Fort12, Fort13, Fort14, Fort15, Fort16, Fort17, Fort18, Fort19, Fort20, Fort21, Fort22, Fort23, Fort24, Fort25}

var skill_book: SkillDict.books = SkillDict.books.FORTRESS

#PASSIVES
var PASSIVE_accumulate_ire = true
var ire = 0
var passive_check = false

#STATS
var starting_stats = {
		stat.HP: 24,
		stat.MAXHP: 24,
		stat.MP: 50,
		stat.MAXMP: 50,
		stat.STR: 8,
		stat.DEX: 6,
		stat.DEF: 10,
		stat.INT: 7,
		stat.FTH: 7,
		stat.RES: 6,
		stat.EVD: 6,
		stat.ACC: 20,
		stat.SPD: 25,
		stat.CRIT: 10,
		stat.CRITDMG: 1.5
		}
var stat_scaling = {
		stat.HP: stat_scale.A,
		stat.MP: stat_scale.C,
		stat.MAXHP: stat_scale.A,
		stat.MAXMP: stat_scale.C,
		stat.STR: stat_scale.B,
		stat.DEX: stat_scale.D,
		stat.DEF: stat_scale.S,
		stat.INT: stat_scale.C,
		stat.FTH: stat_scale.C,
		stat.RES: stat_scale.B,
		stat.EVD: stat_scale.D,
		stat.ACC: stat_scale.C,
		stat.SPD: stat_scale.D,
		stat.CRIT: stat_scale.F,
		stat.CRITDMG: stat_scale.F,
		stat.HATE: stat_scale.S
	}
var job_description = "An iron wall to keep Lamentations at bay. \n\nThe Fortress vocation excels at defending the party from physical attacks. Taking hits from enemies repeatedly will also accumulate a resource called [b]Ire[/b] which can be used to trigger powerful counter-attacks. \n\nWhile the Fortresses' shields can protect against magic attacks to some degree, they are not as well suited for foes that deal elemental damage."

func _ready():
	HATE = 100
	weapontype = damage_type.IMPACT
	
	skill_list = {
		skillid.Fort10: {skill.name: "Shrapnel Burst",
			skill.desc: "COST '2 Ire' - An explosive blast of rubble that damages the entire enemy front line.",
			skill.max_level: 5,
			skill.parent_unlock_level: 1,
			skill.current_level: 0},
		skillid.Fort12: {skill.name: "Perfect Shell",
			skill.desc: "Defend and massively increase damage resistance this turn.",
			skill.max_level: 5,
			skill.parent_unlock_level: 1,
			skill.current_level: 0}
		}

#SKILLS




func ShrapnelBurst():
	if ire < 2:
		CombatGUI.BattleLog("Not enough Ire to perform this action!")
		return
	else: CombatGUI.QueueAction(self, "ShrapnelBurst2")
func ShrapnelBurst2():
	var e = get_enemy_targets()
	ire -= 2
	CombatGUI.BattleLog(str(charname) + " unleashes a burst of Shrapnel to the enemy front line!")
	
	for target in e:
		if target.stats[stat.HP] != 0 and target.row == row_line.FRONT:
			var damage_dealt = await Damage(target, Stat(stat.DEF) * 1.2, damage_type.IMPACT)
			CombatGUI.BattleLog(str(target.charname) + " is hit for " + str(damage_dealt) + " damage!")
			await get_tree().create_timer(0.5).timeout
	#CloseTurn("")
	CloseTurn()




	
func PerfectShell():
	if MPCheck(50) == false: return
	else: CombatGUI.QueueAction(self, "PerfectShell2")
func PerfectShell2():
		StatMod(stat.DEF, 999, 1)
		StatMod(stat.RES, 999, 1)
		CombatGUI.BattleLog(str(charname) + " uses Perfect Shell!")
#		super.Defend()
		#CloseTurn("")
		CloseTurn()
