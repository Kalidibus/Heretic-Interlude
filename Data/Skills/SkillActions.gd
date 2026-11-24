class_name SkillActions
extends Node

var skillowner: Entity
@onready var CombatGUI: CGUI 
@onready var Combat: Node

#Scripts that are to be called during phases of routine combat
func queue(): 
	pass
func combat_start(passive_owner:Entity, party:Array, enemies:Array):
	pass
func on_beginning_of_round():
	pass
func on_turn_start(actionfromqueue: ActionforQueue):
	pass
func on_caster_turn_end(owner: Node, target: Node):
	pass
func execute(actionfromqueue):
	pass
func on_end_of_round(owner: Node, target: Node):
	pass


#Scripts that are to be called during conditionals in combat
func on_skill_used(owner: Node, target: Node):
	pass
func on_item_used(owner: Node, target: Node):
	pass
func on_hit(action:ActionResult):
	pass
func on_crit(action:ActionResult):
	pass
func on_damaged(action: ActionResult):
	pass
func on_miss(action: ActionResult):
	pass
func on_healed(owner: Node, target: Node):
	pass
func on_revived(action: ActionResult):
	pass

#Unique Scripts - Always check if there's a way to incorporate the skill into a standard effect above rather than creating new checks every time anything happens.
#For example: "On crit" should be a subcheck on "on_hit" instead of a whole new thing. 
