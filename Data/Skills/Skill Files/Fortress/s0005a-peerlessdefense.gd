extends SkillActions

var skill_action_id: StringName = &"s0005a"
var mpcost:int = 0

func combat_start(passive_owner:Entity, party:Array, enemies:Array):
	var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0005")

	passive_owner.stats[Entity.stat.DEF] = int(passive_owner.stats[Entity.stat.DEF] * (1 + 0.1)) #include scaling from level
	passive_owner.stats[Entity.stat.HATE] = int(passive_owner.stats[Entity.stat.HATE] * (1 + 0.1 )) #* skill_list[skillid.Fort01][skill.current_level])
