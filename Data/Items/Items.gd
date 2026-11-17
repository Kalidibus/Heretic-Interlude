class_name ItemClass
extends Resource

enum type {one_handed_weapon, two_handed_weapon, armour, accessory, loot}
enum subtype {sword, shield, axe, polearm, arcana, hammer, stave, glaive, head, body, gloves, pants, ring, necklace, component, consumable, augments, key}
enum slot {none, head, body, main_hand, off_hand, gloves, pants, necklace, ring}
enum rarity {common, uncommon, rare, legendary}

@export var item_id: StringName
@export var item_type: type
@export var item_subtype: subtype
@export var item_slot: slot
@export var item_name: String
@export_multiline var description: String = "placeholder"
@export var sell_value: int = 0
@export var item_rarity: rarity
# Use stat names as keys, such as &"PHY" or &"MAG".
@export var weapon_damage_modifiers: Dictionary[CG.damage_type, int] = {}

# Use stat names as keys, such as &"FTH" or &"STR".
@export var stat_modifiers: Dictionary[CG.stat, int] = {}

# These are IDs for abilities/traits that your game code will resolve.
@export var granted_ability_ids: Array[StringName] = []
@export var passive_trait_ids: Array[StringName] = []
