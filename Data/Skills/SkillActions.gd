class_name SkillActions
extends Node

var skillfile: Resource

#Scripts that are to be called during phases of routine combat
func queue(owner: Node, target: Node): 
	pass
func on_beginning_of_round(owner: Node, target: Node):
	pass
func on_caster_turn_start(owner: Node, target: Node):
	pass
func on_caster_turn_end(owner: Node, target: Node):
	pass
func execute(owner: Node, target: Node):
	pass
func on_end_of_round(owner: Node, target: Node):
	pass


#Scripts that are to be called during conditionals in combat
func on_skill_used(owner: Node, target: Node):
	pass
func on_item_used(owner: Node, target: Node):
	pass
func on_hit(owner: Node, target: Node):
	pass
func on_damaged(owner: Node, target: Node):
	pass
func on_miss(owner: Node, target: Node):
	pass
func on_healed(owner: Node, target: Node):
	pass

#Unique Scripts - Always check if there's a way to incorporate the skill into a standard effect above rather than creating new checks every time anything happens.
#For example: "On crit" should be a subcheck on "on_hit" instead of a whole new thing. 
