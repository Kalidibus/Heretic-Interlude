extends SkillActions

var skill_action_id: StringName = &"s0010a"
var mpcost:int = 0

func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0010")
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	if skillowner.MPCheck(skillfile) == false: return 
	elif not skillowner.resources.has(&"IRE") or skillowner.resources[&"IRE"] < 1:
		CombatGUI.BattleLog("Not enough IRE to perform this action!")
		return
	else: CombatGUI.TargetList(self)
	
func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	var target: Entity = actionfromqueue.target
	
	var damage_dealt = await actionowner.Damage(target, actionowner.Stat(Entity.stat.DEF) * 1.5, Entity.damage_type.IMPACT)
	
	actionowner.MPCost(40)
	CombatGUI.BattleLog(actionowner.charname + " unleashes her IRE! Attacked " + target.charname + " for " + str(damage_dealt.damage) + " damage!")
	actionowner.CloseTurn()
	
