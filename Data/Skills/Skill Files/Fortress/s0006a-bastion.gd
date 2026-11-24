extends SkillActions

var skill_action_id: StringName = &"s0006a"
var mpcost:int = 0

func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0006")
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	if skillowner.MPCheck(skillfile) == false: return 
	CombatGUI.AllyTargetList(self)

func execute(actionfromqueue :ActionforQueue):
	var heal = 2 * actionfromqueue.owner.stats[Entity.stat.DEF]
	
	actionfromqueue.target.get_healed(heal)
	CombatGUI.BattleLog(actionfromqueue.owner.charname + " provides shelter behind her shields to " + actionfromqueue.target.charname + ", healing her for " + str(heal) + " HP!")
	
	actionfromqueue.owner.CloseTurn()
