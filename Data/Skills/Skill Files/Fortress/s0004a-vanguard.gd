extends SkillActions

var skill_action_id: StringName = &"s0004a"
var mpcost:int = 0

func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0004")
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	if skillowner.MPCheck(skillfile) == false: return 
	else: CombatGUI.TargetList(self)
	
func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	
	var damage = actionowner.stats[Entity.stat.DEF] * actionowner.statmods[Entity.stat.DEF]
	var adjusteddamage = actionfromqueue.target.take_damage(damage, Entity.damage_type.IMPACT)
	actionowner.MPCost(mpcost)
	CombatGUI.BattleLog(actionowner.charname + " has attacked " + actionfromqueue.target.charname + " for " + str(adjusteddamage) + " damage!")
	actionowner.CloseTurn()
