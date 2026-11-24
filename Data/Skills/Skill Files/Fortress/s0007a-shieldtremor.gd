extends SkillActions

var skill_action_id: StringName = &"s0007a"
var mpcost:int = 0

func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0007")
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	if skillowner.MPCheck(skillfile) == false: return 
	else: CombatGUI.QueueAction(skillowner, self)

func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	actionowner.MPCost(mpcost)
	
	var e = actionowner.get_enemy_targets()
	CombatGUI.BattleLog(actionowner.charname + " smashes her shields into the ground, destabilizing enemy lines!")
	
	for target in e:
		if target.stats[Entity.stat.HP] != 0:
			var damage_dealt :ActionResult = await actionowner.Damage(target, actionowner.Stat(Entity.stat.DEF)/0.5, Entity.damage_type.IMPACT)
			target.StatMod(Entity.stat.STR, 30, 1)
			CombatGUI.BattleLog(target.charname + " is hit for " + str(damage_dealt.damage) + " damage! STR Decreased!")
			await actionowner.get_tree().create_timer(0.5).timeout
	actionowner.CloseTurn()
