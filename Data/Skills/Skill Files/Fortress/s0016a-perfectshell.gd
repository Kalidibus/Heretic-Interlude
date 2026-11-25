extends SkillActions

var skill_action_id: StringName = &"s0016a"
var mpcost:int = 0

func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0016")
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	if skillowner.MPCheck(skillfile) == false: return
	else: CombatGUI.QueueAction(skillowner, self)
	
func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	
	actionowner.StatMod(Entity.stat.DEF, 999, 1)
	actionowner.StatMod(Entity.stat.RES, 999, 1)
	actionowner.MPCost(mpcost) 
	
	CombatGUI.BattleLog(actionowner.charname + " uses Perfect Shell!")
	
	#passes to the DEFEND action to close the turn.
	SkillDict.skill_actions_by_id.get(&"DEFEND").execute(actionfromqueue)
