extends SkillActions
var skill_action_id: StringName = &"misalign-s02"

func queue():
	CombatGUI.QueueAction(skillowner, self)

func execute(actionfromqueue):
	var target = actionfromqueue.target
	var owner = actionfromqueue.owner
	owner.BattleLog(owner.charname + " infuses the enemy party with vigor!")

	#gives it back to enemies
	for e in owner.get_enemy_targets():
		if e == self: pass
		e.StatMod(Entity.stat.STR, 25, 3)
		e.StatMod(Entity.stat.DEX, 25, 3)
		e.StatMod(Entity.stat.DEF, 25, 3)
		owner.CombatGUI.BattleLog(owner.charname + " invigorates " + e.charname + "! Physical damage and defenses bolstered!")
		await owner.get_tree().create_timer(0.5).timeout
	owner.CloseTurn()
