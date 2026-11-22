extends SkillActions

func _ready() -> void:
	skillfile =  SkillDict.skills_by_id.get(&"S0003")

func on_miss(attacker: Node, defender: Node):
	if defender == skillowner: 
		skillowner.resources.get(&"DECEIT", 0) + 1
		%CombatGUI.BattleLog(skillowner.charname + " accumulates Deceit! Current Deceit is " + str(skillowner.resources.get(&"DECEIT")))
		#if skillowner.auras.has(&"SHAPESINTHEFOG") == true and CheckMiss(attacker) == true:
		#		var damage = Damage(attacker, Stat(stat.INT), damage_type.DEEP)
		#		CombatGUI.BattleLog(charname + " counter-attacks " + attacker.charname + " for " + str(damage) + "!" )
	else: pass #can add a check here to see if passive is enabled to allow countering for whole party.
