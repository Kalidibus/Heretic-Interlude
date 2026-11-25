extends SkillActions

var skill_action_id: StringName = &"felmage-s11"
var mpcost:int = 0

func combat_start(passive_owner:Entity, party:Array, enemies:Array):
	print("triggered")
	var skillfile: SkillClass = SkillDict.skills_by_id.get(skill_action_id)
	MODIFIER = skillfile.skill_general_modifier


	passive_owner.stats[Entity.stat.INT] = int(passive_owner.stats[Entity.stat.INT] * (1 + 0.1 * MODIFIER)) #include scaling from level
	passive_owner.stats[Entity.stat.MP] = int(passive_owner.stats[Entity.stat.MP] * (1 + 0.1 * MODIFIER)) #* skill_list[skillid.Fort01][skill.current_level])
	passive_owner.stats[Entity.stat.MAXMP] = int(passive_owner.stats[Entity.stat.MAXMP] * (1 + 0.1 * MODIFIER)) #* skill_list[skillid.Fort01][skill.current_level])
