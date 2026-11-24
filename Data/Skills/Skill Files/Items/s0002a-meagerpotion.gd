extends SkillActions
@onready var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0002")
var skill_action_id: StringName = &"s0002a"

const HEALAMOUNT = 35

func queue():
	CombatGUI.AllyTargetList(self)

func execute(actionfromqueue :ActionforQueue):
	var file = SkillDict.skills_by_id.get(&"s0002")
	
	actionfromqueue.target.get_healed(HEALAMOUNT)
	CombatGUI.BattleLog("The " + file.skill_name + " heals " + actionfromqueue.target.charname + " for " + str(HEALAMOUNT) + " HP!")
	
	CharacterChanges.RemovefromInventory(&"i0001",1)
	
	actionfromqueue.owner.CloseTurn()
