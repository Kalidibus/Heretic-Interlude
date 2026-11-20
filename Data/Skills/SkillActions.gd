class_name SkillActions
extends Node

var skillfile: Resource

#Scripts that are to be called during phases of routine combat
func queue():
	pass
func on_beginning_of_round():
	pass
func on_caster_turn_start():
	pass
func on_caster_turn_end():
	pass
func execute():
	pass
func on_end_of_round():
	pass


#Scripts that are to be called during conditionals in combat
func on_skill_used():
	pass
func on_item_used():
	pass
func on_hit():
	pass
func on_damaged():
	pass
func on_miss():
	pass
func on_healed():
	pass

#Unique Scripts - Always check if there's a way to incorporate the skill into a standard effect above rather than creating new checks every time anything happens.
#For example: "On crit" should be a subcheck on "on_hit" instead of a whole new thing. 
