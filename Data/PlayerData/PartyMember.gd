extends Node
class_name PartyMember

#Attributes
var char_id : int = 0
var char_class : Entity 
var char_name: String
var char_level: int = 1
var char_xp : int = 0
var char_skills: Dictionary[SkillClass, int] = {}

#Equipment
var char_equipment: Dictionary = {
	ItemClass.slot.none: null,
	ItemClass.slot.head: null,
	ItemClass.slot.body: null,
	ItemClass.slot.main_hand: null,
	ItemClass.slot.off_hand: null,
	ItemClass.slot.gloves: null,
	ItemClass.slot.pants: null,
	ItemClass.slot.necklace: null,
	ItemClass.slot.ring: null
}
