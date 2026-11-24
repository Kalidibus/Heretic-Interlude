extends SkillActions
var skill_action_id: StringName = &"brainrot-s01"

func queue():
	CombatGUI.QueueAction(skillowner, self)

func execute(actionfromqueue):
	var target = actionfromqueue.target
	var owner = actionfromqueue.owner

	if await owner.CheckMiss(target): return
	var dealt_damage = await owner.Damage(target, owner.Stat(Entity.stat.DEX), Entity.damage_type.PIERCE) 
	owner.BattleLog("The " + owner.charname + " pierces " + target.charname + " with venomous needles for " + str(dealt_damage.damage) + " damage!")
	target.AttemptStatusAilment(Entity.status_effects.POISON, 10, 3, -30)
	owner.CloseTurn()
