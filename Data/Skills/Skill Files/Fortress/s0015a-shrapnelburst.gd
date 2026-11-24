extends SkillActions

var skill_action_id: StringName = &"s0015a"
var mpcost:int = 0

func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0015")
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	#MP + Ire Check
	if skillowner.MPCheck(skillfile) == false: return 
	elif not skillowner.resources.has(&"IRE") or skillowner.resources[&"IRE"] < 2:
		CombatGUI.BattleLog("Not enough IRE to perform this action!")
		return
	else: CombatGUI.QueueAction(skillowner, self)

func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	var e = actionowner.get_enemy_targets()
	
	CombatGUI.BattleLog(actionowner.charname + " unleashes a burst of Shrapnel to the enemy front line!")
	
	for target in e:
		if target.stats[Entity.stat.HP] != 0 and target.row == Entity.row_line.FRONT:
			var damage_dealt = await actionowner.Damage(target, actionowner.Stat(Entity.stat.DEF) * 1.2, Entity.damage_type.IMPACT)
			CombatGUI.BattleLog(target.charname + " is hit for " + str(damage_dealt.damage) + " damage!")
			await actionowner.get_tree().create_timer(0.5).timeout
	
	actionowner.CloseTurn()
