class_name ActionResult
extends RefCounted

var damage: int = 0
var damage_type: Entity.damage_type
var crit: bool = false
var crit_damage: float = 1
var missed: bool = false
var revived: bool = false
var multiplier: float = 1

var attacker: Entity = null
var defender: Entity = null

var target: Entity = null
