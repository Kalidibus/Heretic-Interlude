extends SkillActions
var skill_action_id: StringName = &"gear-s0001"

const HEALAMOUNT = 35

func queue():
	CombatGUI.AllyTargetList(self)

func execute(actionfromqueue :ActionforQueue):
	var file: SkillClass = SkillDict.skills_by_id.get(skill_action_id)
	
	var amount: int = int(HEALAMOUNT * file.skill_general_modifier)
	
	actionfromqueue.target.get_healed(amount)
	CombatGUI.BattleLog("With a meager light, " + actionfromqueue.target.charname + " is healed for " + str(amount) + " HP.")
	
	actionfromqueue.owner.CloseTurn()
