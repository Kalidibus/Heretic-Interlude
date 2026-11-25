extends SkillActions

var skill_action_id: StringName = &"felmage-s06"
var mpcost:int = 0


func queue():
	var skillfile: SkillClass = SkillDict.skills_by_id.get(skill_action_id)
	MODIFIER = skillfile.skill_general_modifier
	mpcost = skillfile.skill_mp_cost #saves for execute()
	
	if skillowner.MPCheck(skillfile) == false: return 
	else: CombatGUI.QueueAction(skillowner, self)
	
func execute(actionfromqueue :ActionforQueue):
	var actionowner :Entity = actionfromqueue.owner
	#var target :Entity = actionfromqueue.target
	
	var e = actionowner.get_enemy_targets()
	actionowner.MPCost(mpcost)
	actionowner.CombatGUI.BattleLog(actionowner.charname + " unleashes a Deep Storm!")
	for target in e:
		if target.stats[Entity.stat.HP] != 0:
			var adjusteddamage = await actionowner.Damage(target, actionowner.Stat(Entity.stat.INT) * MODIFIER, Entity.damage_type.DEEP)
			actionowner.CombatGUI.BattleLog(target.charname + " is hit for " + str(adjusteddamage.damage) + " damage!")
			await actionowner.get_tree().create_timer(0.5).timeout
	actionowner.CombatGUI.BattleLog("The storm abates...")
	actionowner.CloseTurn()
