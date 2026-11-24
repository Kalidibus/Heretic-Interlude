extends SkillActions

var skill_action_id: StringName = &"s0008a"
var mpcost:int = 0

func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0008")
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	if skillowner.MPCheck(skillfile) == false: return 
	else: CombatGUI.QueueAction(skillowner, self)
	
func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	actionowner.MPCost(mpcost)
	actionowner.StatMod(Entity.stat.DEF, 1.25, 2)
	CombatGUI.BattleLog(actionowner.charname + " takes on a defensive stances! DEF Increased.")
	actionowner.CloseTurn()
