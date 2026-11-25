extends SkillActions

var skill_action_id: StringName = &"DEFEND"

func _ready() -> void:
	defending = true

func execute(actionfromqueue :ActionforQueue):
	var char = actionfromqueue.owner
	char.current_state = Entity.state.DEFENDING
	
	char.StatMod(char.stat.DEF, 1.5, 0)
	char.CombatGUI.BattleLog(str((char.charname) + " defends herself!"))
	char.CloseTurn()
