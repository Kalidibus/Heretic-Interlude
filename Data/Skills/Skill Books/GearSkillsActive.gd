extends SkillBook

func taunt() -> void:
	pass

func fel_bolt(skill: SkillClass, user: Entity, targets: Array[Entity], level: int) -> void:
	var damage :int = user.Stat(Entity.stat.INT) * 1.4
	for target in targets:
		var dealt :int = target.take_damage(damage, Entity.damage_type.FEL)
		# Use the skill's text/data for the battle log here.
