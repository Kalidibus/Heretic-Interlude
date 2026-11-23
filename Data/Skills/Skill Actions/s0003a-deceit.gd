extends SkillActions
@onready var skillfile: SkillClass = SkillDict.skills_by_id.get(&"S0003")
@onready var CombatGUI: CGUI #will be populated with button setup in CombatGUI I guess
var skill_action_id: StringName = &"s0003a"

func combat_start():
	%Combat.auras.append(self)

func on_miss(action: ActionResult):
	if action.defender == skillowner: 
		skillowner.resources.get(&"DECEIT", 0) + 1
		%CombatGUI.BattleLog(skillowner.charname + " accumulates Deceit! Current Deceit is " + str(skillowner.resources.get(&"DECEIT")))
		#if skillowner.auras.has(&"SHAPESINTHEFOG") == true and CheckMiss(attacker) == true:
		#		var damage = Damage(attacker, Stat(stat.INT), damage_type.DEEP)
		#		CombatGUI.BattleLog(charname + " counter-attacks " + attacker.charname + " for " + str(damage) + "!" )
	else: pass #can add a check here to see if passive is enabled to allow countering for whole party.
