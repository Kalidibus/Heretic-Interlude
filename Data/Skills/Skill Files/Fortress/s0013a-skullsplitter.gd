extends SkillActions

var skill_action_id: StringName = &"s0013a"
var mpcost:int = 0

func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0013")
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	if skillowner.MPCheck(skillfile) == false: return 
	elif not skillowner.resources.has(&"IRE") or skillowner.resources[&"IRE"] < 1:
		CombatGUI.BattleLog("Not enough IRE to perform this action!")
		return
	else: CombatGUI.TargetList(self)
	
func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	var target :Entity = actionfromqueue.target
	
	var damage = actionowner.stats[Entity.stat.DEF] * actionowner.statmods[Entity.stat.DEF] + actionowner.stats[Entity.stat.STR] * actionowner.statmods[Entity.stat.STR]
	var adjusteddamage = actionfromqueue.target.take_damage(damage, Entity.damage_type.IMPACT)
	actionowner.MPCost(mpcost)

	if skillowner.resources[&"IRE"] == 1: 
		skillowner.resources.erase(&"IRE")
	else:
		skillowner.resources[&"IRE"] -= 1

	CombatGUI.BattleLog(actionowner.charname + " uses Ire to perform a crushing overhead blow! to " + target.charname + ", dealing " + str(adjusteddamage) + " damage!")
	target.AttemptStatusAilment(Entity.status_effects.STUN, 0, 0, 20)
	actionowner.CloseTurn()
