extends SkillActions
var skill_action_id: StringName = &"pylon-s01"

func queue():
	CombatGUI.QueueAction(skillowner, self)

func execute(actionfromqueue):
	var target = actionfromqueue.target
	var owner = actionfromqueue.owner
	
	if await owner.CheckMiss(target): return
	var result = await owner.Damage(target, 1.5 * owner.Stat(Entity.stat.STR), Entity.damage_type.IMPACT)
	owner.BattleLog("The " + owner.charname + " emits a bloodcurdling shriek and bludgeons " + target.charname + " fiercly for " + str(result.damage) + " damage!!!")
	target.AttemptStatusAilment(Entity.status_effects.STUN, 0, 0, 0)
	owner.CloseTurn()
