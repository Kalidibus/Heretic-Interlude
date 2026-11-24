extends SkillActions
var skill_action_id: StringName = &"pylon-s02"

func _ready() -> void:
	defending = true
	
func queue():
	CombatGUI.QueueAction(skillowner, self)

func execute(actionfromqueue):
	var target = actionfromqueue.target
	var owner = actionfromqueue.owner
	
	owner.StatMod(Entity.stat.DEF, 1.5, 0)
	owner.BattleLog("The " + owner.charname + " folds it's body up defensively...")
	owner.CloseTurn()
