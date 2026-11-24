extends SkillActions

var skill_action_id: StringName = &"s0001a"
var mpcost:int = 0

func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0001")
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	if skillowner.MPCheck(skillfile) == false: return 
	else: CombatGUI.QueueAction(skillowner, self)
	
func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	
	#add MARKED status effect
	var previousvalue = actionowner.statres[actionowner.status_effects.MARKED] #preserve previous value to ensure that the marked affect goes in at 100% chance successrate.
	actionowner.statres[actionowner.status_effects.MARKED] = 0
	if not actionowner.status.has(actionowner.status_effects.MARKED):
		actionowner.AttemptStatusAilment(actionowner.status_effects.MARKED, 80, 2, 0)
	actionowner.statres[actionowner.status_effects.MARKED] = previousvalue
	
	#increase base aggro
	actionowner.HATE += (25) #update this to use skill level

	#consume MP, post battlelog text, and close turn
	actionowner.MPCost(mpcost) 
	CombatGUI.BattleLog(actionowner.charname + " Taunts the enemy!")
	actionowner.CloseTurn()
