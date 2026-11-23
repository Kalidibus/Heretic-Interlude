extends SkillActions

var skill_action_id: StringName = &"DEFEND"
@onready var CombatGUI: CGUI 
@onready var Combat: Node

func execute(actionfromqueue :ActionforQueue):
	var char = actionfromqueue.owner
	
	char.StatMod(char.stat.DEF, 1.5, 0)
	CombatGUI.BattleLog(str((char.charname) + " defends herself!"))
	char.CloseTurn()
