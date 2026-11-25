extends SkillActions

var skill_action_id: StringName = &"felmage-s01"
var mpcost:int = 0


func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(skill_action_id)
	MODIFIER = skillfile.skill_general_modifier
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	if skillowner.MPCheck(skillfile) == false: return 
	else: CombatGUI.TargetList(self)
	
func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	var target :Entity = actionfromqueue.target

	var adjusteddamage = await actionowner.Damage(target, (actionowner.Stat(Entity.stat.INT) * MODIFIER), Entity.damage_type.FEL)
	
	actionowner.MPCost(mpcost)
	actionowner.CombatGUI.BattleLog(actionowner.charname + " launches an eldritch bolt of ink black Fel at " + target.charname + ", hitting it for " + str(adjusteddamage.damage) + " damage!")
	actionowner.CloseTurn()
