extends SkillActions

var skill_action_id: StringName = &"s0009a"
var mpcost:int = 0


func combat_start(passive_owner:Entity, party:Array, enemies:Array):
	var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0009")
	Combat.auras.append(self)
	skillowner = passive_owner

func on_hit(action:ActionResult):
	if action.target == skillowner:
		if skillowner.current_state == Entity.state.DEFENDING:
			skillowner.resources[&"IRE"] = skillowner.resources.get(&"IRE", 0) + 1 #checks IRE and increments by 1
			skillowner.CombatGUI.BattleLog(skillowner.charname + "'s Ire rises... Current Ire is " + str(skillowner.resources[&"IRE"]))
