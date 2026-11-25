extends SkillActions

var skill_action_id: StringName = &"felmage-s09"
var mpcost:int = 0


func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(skill_action_id)
	MODIFIER = skillfile.skill_general_modifier
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	#requires different logic to spend HP instead of MP
	if skillowner.Stat(Entity.stat.HP) <= mpcost: 
		skillowner.BattleLog(skillowner.charname + " doesn't have enough remaining life for this exchange!")
		return 
	else: CombatGUI.QueueAction(skillowner, self)
	
func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	
	actionowner.take_damage(mpcost, Entity.damage_type.TRUE)
	actionowner.MPCost(-mpcost)
	actionowner.BattleLog(actionowner.charname + " exchanges blood for power. MP restored!")
	actionowner.CloseTurn()
