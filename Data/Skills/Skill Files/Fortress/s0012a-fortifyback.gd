extends SkillActions

var skill_action_id: StringName = &"s0012a"
var mpcost:int = 0

func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0012")
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	if skillowner.MPCheck(skillfile) == false: return 
	else: CombatGUI.QueueAction(skillowner, self)

func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	actionowner.MPCost(mpcost)
	
	var p = actionowner.get_party_targets()
	for n in p:
		if n.row == Entity.row_line.BACK: n.StatMod(Entity.stat.DEF, 1.6, 1)
	
	CombatGUI.BattleLog(actionowner.charname + " guards the back row!")
	actionowner.CloseTurn()
	
