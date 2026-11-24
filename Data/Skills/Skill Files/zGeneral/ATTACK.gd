extends SkillActions

var skill_action_id: StringName = &"ATTACK"

func execute(actionfromqueue :ActionforQueue):
	var char :Entity = actionfromqueue.owner
	var target: Entity = actionfromqueue.target
	char.CombatGUI.emit_signal("menuhide")
	
	var action_result = await char.Damage(target, char.Stat(Entity.stat.STR), char.weapontype) 

	if not action_result.missed:
		char.CombatGUI.BattleLog(char.charname + " has attacked " + target.charname + " for " + str(action_result.damage) + " damage!")
		await Combat.AurasCheck(action_result)
		char.CloseTurn()
