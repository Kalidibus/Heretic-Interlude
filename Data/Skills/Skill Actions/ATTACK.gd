extends SkillActions

var skill_action_id: StringName = &"ATTACK"
@onready var CombatGUI: CGUI 
@onready var Combat: Node

func execute(actionfromqueue :ActionforQueue):
	CombatGUI.emit_signal("menuhide")
	var char :Entity = actionfromqueue.owner
	var target: Entity = actionfromqueue.target
	
	var action_result = await char.Damage(target, char.Stat(Entity.stat.STR), char.weapontype) 

	if not action_result.missed:
		CombatGUI.BattleLog(char.charname + " has attacked " + target.charname + " for " + str(action_result.damage) + " damage!")
		await Combat.AurasCheck(action_result)
		char.CloseTurn()
