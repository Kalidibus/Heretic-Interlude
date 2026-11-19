extends SkillActions
var skill: SkillClass = SkillDict.skills_by_id.get(&"s0001")


func start(caster):
	if caster.MPCheck(skill) == false: return #change MPCheck to check the skill details for the amount of MP it needs, using a formula of skill base cost * level * scaling
	else: CombatGUI.QueueAction(caster, self) #queue this script, or the skill resource file, whatever makes more sense. 

func execute(caster):
	var previousvalue = statres[status_effects.MARKED] #change this to adding the affect MARKED, although may be same as what you've done here. 
	statres[status_effects.MARKED] = 0
	if not status.has(status_effects.MARKED):
		AttemptStatusAilment(status_effects.MARKED, 80, 2, 0)
	statres[status_effects.MARKED] = previousvalue
	
	HATE += (25 + (25 * skill_list[skillid.Fort01][skill.current_level])) #This is a stat mod using the skill id and skill level. Look into broader way to do stat mods on Entity

	MPCost(10) #reference resolved MP cost above, not a flat number that you have to update in multiple places that's stupid. 
	CloseTurn(str(charname) + " Taunts the enemy!") #find a better way to do this as well so that Battlelog text can be added at any stage in combat. 
