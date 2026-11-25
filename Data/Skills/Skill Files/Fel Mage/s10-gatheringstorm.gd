extends SkillActions

var skill_action_id: StringName = &"felmage-s10"
var mpcost:int = 0

var round_count = 0

func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(skill_action_id)
	MODIFIER = skillfile.skill_general_modifier
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	if skillowner.MPCheck(skillfile) == false: return 
	else: CombatGUI.QueueAction(skillowner, self)

func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	#var target :Entity = actionfromqueue.target
	
	actionowner.MPCost(mpcost)
	actionowner.Combat.auras.append(self)
	
	actionowner.CombatGUI.BattleLog(actionowner.charname + " calls forth a monstrous thunderhead. It roils above, lashing out with bursts")
	round_count = 3
	actionowner.CloseTurn()

#count down each round then remove.
func on_beginning_of_round():
	round_count -= 1
	print(round_count)
	if round_count == 0: 
		skillowner.CombatGUI.BattleLog("The thundercloud from " + skillowner.charname + " dissapates...")
		skillowner.Combat.auras.erase(self)
		print(skillowner.Combat.auras)

#check damage type and allegiance, and throw a thunderbolt if everything matches
func on_damaged(action: ActionResult):
	print("made it")
	var actionowner :Entity = action.attacker
	var target :Entity = action.defender
	
	#if on the same side, then skip
	if actionowner.enemy == skillowner.enemy: 
		print("skipping")
		return
	
	if action.damage_type == Entity.damage_type.INFERNAL or action.damage_type == Entity.damage_type.LEVIN:
			var adjusteddamage = await skillowner.Damage(target, skillowner.Stat(Entity.stat.INT) * MODIFIER, Entity.damage_type.LEVIN)
			actionowner.CombatGUI.BattleLog("A bolt from the thunderhead hits "+target.charname + " for " + str(adjusteddamage.damage) + " damage!")
			await actionowner.get_tree().create_timer(0.5).timeout
	else: print("mismatch")
