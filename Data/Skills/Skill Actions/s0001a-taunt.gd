extends SkillActions
@onready var skillfile: SkillClass = SkillDict.skills_by_id.get(&"s0001")
@onready var CombatGUI: Node #will be populated with button setup in CombatGUI I guess
var skill_action_id: StringName = &"s0001a"


func queue():
	if skillowner.MPCheck(skillfile) == false: return 
	else: CombatGUI.QueueAction(skillowner, self) #queue this script, or the skill resource file, whatever makes more sense. 
	pass
	
func execute(actionfromqueue):
	var owner = actionfromqueue.owner
	
	var previousvalue = owner.statres[owner.status_effects.MARKED] #change this to adding the affect MARKED, although may be same as what you've done here. 
	owner.statres[owner.status_effects.MARKED] = 0
	if not owner.status.has(owner.status_effects.MARKED):
		owner.AttemptStatusAilment(owner.status_effects.MARKED, 80, 2, 0)
	owner.statres[owner.status_effects.MARKED] = previousvalue
	
#	owner.HATE += (25 + (25 * skill_list[skillid.Fort01][skill.current_level])) #This is a stat mod using the skill id and skill level. Look into broader way to do stat mods on Entity

	#MPCost(10) #reference resolved MP cost above, not a flat number that you have to update in multiple places that's stupid. 
	CombatGUI.BattleLog(owner.charname + " Taunts the enemy!")
	owner.CloseTurn() #find a better way to do this as well so that Battlelog text can be added at any stage in combat. 
