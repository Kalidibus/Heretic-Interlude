extends SkillActions
var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0002")
@onready var CombatGUI = %CombatGUI

func queue(owner: Node, target: Node):
	CombatGUI.TargetList(self)
func execute(owner: Node, target: Node):
	print("success")
	skillowner.CloseTurn()
