extends SkillActions
var skill_action_id: StringName = &"misalign-s01"

func queue():
	CombatGUI.QueueAction(skillowner, self)

func execute(actionfromqueue):
	var target = actionfromqueue.target
	var owner = actionfromqueue.owner
	
	var total_leech:int = 0
	
	owner.CombatGUI.BattleLog(owner.charname + " realigns the battlefield!")

	#leeches health from party
	for n in owner.get_party_targets():
		if await owner.CheckMiss(n): 
			owner.BattleLog(n.charname + " evades!")
			await owner.get_tree().create_timer(0.5).timeout
		else: 
			var damage_dealt = await owner.Damage(n, 0.8 * owner.Stat(Entity.stat.FTH), Entity.damage_type.FEL)
			owner.CombatGUI.BattleLog(owner.charname + " leeches " + str(damage_dealt.damage) + " health from " + n.charname + "!")
			total_leech += int(damage_dealt.damage)
			await owner.get_tree().create_timer(0.5).timeout

	#calculates the total amount leeched, and how much to give back to enemies
	var enemy_array = owner.get_enemy_targets()
	var amount_healed: int = int(total_leech / float(enemy_array.size()))

	#gives it back to enemies
	for e in enemy_array:
		e.get_healed(amount_healed)
		owner.BattleLog(owner.charname + " transfers " + str(amount_healed) + " health to " + e.charname + "!")
		await owner.get_tree().create_timer(0.5).timeout
	owner.CloseTurn()
