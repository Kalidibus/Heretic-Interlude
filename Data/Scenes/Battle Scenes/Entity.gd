extends Node
class_name Entity

@onready var EventHandler = get_node("/root/Combat")
@onready var CombatGUI = get_node("/root/Combat/CombatGUI")
@onready var party = get_node("/root/Combat/Combatants/Party")
@onready var enemies = get_node("/root/Combat/Combatants/Enemies")
@onready var SignalBus = get_node("/root/Combat/SignalBus")

#enums, to be referenced by anything that needs to see stats etc
enum stat {HP = 0, MAXHP = 1, MP = 2, MAXMP = 3, STR = 4, DEF = 5, DEX = 6, RES = 7, INT = 8, FTH = 9, EVD = 10, ACC = 11, SPD = 12, CRIT = 13, CRITDMG = 14, HATE = 15}
enum stat_scale {F = 0, E = 1, D = 2, C = 3, B = 4, A = 5, S = 6}
enum damage_type {PIERCE = 0, IMPACT = 1, SLASH = 2, INFERNAL = 3, LEVIN = 4, DEEP = 5, ERDE = 6, VIRTUOS = 7, FEL = 8, TRUE = 9}
enum status_effects {POISON = 0, BURN = 1, BLIND = 2, STUN = 3, SEAL = 4, MARKED = 5, REGEN = 6}
enum row_line {FRONT = 0, BACK = 1}
enum skill {name = 0, desc = 1, passive = 2, max_level = 3, current_level = 4, parent_unlock_level = 5}

#Combat Variables
var charid #ties a node to it's owner in the party
var charname #character name (party member or monster common field)
var combatlabel #ties a node to it's label on the GUI
var stats = {} #this is filled in during Combat initiation based on the party member or monster that owns the node
var skill_list
var current_skills: Dictionary[SkillClass, int] = {} #skill known, and level of skill known
var resources: Dictionary[StringName, int] = {} #used for passive currencies like IRE, DECEIT etc

var row
var enemy = false
var dead = false
var HATE #could eventually move this to the stats dictionary if you wanted, but not much value.
var ref_hate
var combo
var weapontype
var queueditem
var target
var sealedskilllist

#Variables related to status effects. These could probably be rolled up into an ENUM and making the ailments Dictionaries in the status array. 
var status:Array
var poison
var burn
var poisoncount
var burncount
var blindcount
var sealcount
var markedamount
var markedcount
var regen
var regencount

#Variables relating to stats and resistances including from gear
var statmods =  {
	stat.MAXHP: 1,
	stat.HP: 1, 
	stat.MAXMP: 1,
	stat.MP: 1,
	stat.STR: 1,
	stat.DEX: 1,
	stat.DEF: 1,
	stat.INT: 1,
	stat.FTH: 1,
	stat.RES: 1,
	stat.SPD: 1,
	stat.ACC: 1,
	stat.EVD: 1,
	stat.CRIT: 1,
	stat.CRITDMG: 1
	}

var statmodtimer = {}
var statres = {
	status_effects.POISON: 40,
	status_effects.STUN: 40,
	status_effects.BURN: 40,
	status_effects.BLIND: 40,
	status_effects.SEAL: 40,
	status_effects.REGEN: 0,
	status_effects.MARKED: 40
	}

var damageres = {
	damage_type.IMPACT: 20,
	damage_type.SLASH: 20,
	damage_type.PIERCE: 20,
	damage_type.FEL: 20,
	damage_type.INFERNAL: 20,
	damage_type.LEVIN: 20,
	damage_type.DEEP: 20,
	damage_type.ERDE: 20,
	damage_type.VIRTUOS: 20,
	damage_type.TRUE: 0
	}

signal turn_complete
#signal dodged(defender, attacker)
signal attacked(defender, attacker)
#signal crit(defender, attacker)
#signal defended(defender, attacker)

var hire_cost = 5

func _ready():
	pass

func ConnectSignals():
	pass

func Turn():
	ConnectSignals()
	StatModCountDown()
	await StatusEffects()
	CombatGUI.StatusLabels(self)
	#this check is to stop the turn if the player dies from DoT damage, but doesn't seem to be working
	if dead:
		CloseTurn("")
	#skip turn if stunned
	if status.has(status_effects.STUN):
		status.erase(status_effects.STUN)
		CloseTurn(charname + " misses their turn...")

func GetSkills():
	var skill_array = PlayerData.KnownSkills(charid)
	for n in skill_array:
		current_skills[n] = skill_list[n]
		skill_list[n][skill.current_level] = PlayerData.party[charid]["skill_levels"][n]

func get_enemy_targets():
	var list = enemies.get_children()
	var enemy_array = []
	for n in list:
		if n.stats[stat.HP] > 0: enemy_array.append(n)
	return enemy_array
	
func SwitchRows():
	if row == row_line.FRONT:
		row = row_line.BACK
		HATE = HATE*0.5
	elif row == row_line.BACK:
		row = row_line.FRONT
		HATE = HATE*2

func StatModCountDown():
	#this function below checks how many turns a statmod has left
	#if the amount of turns was 0 (meaning expires on next turn) reset the stat bonus
	for n in statmods:
		if statmods[n] != 1:
			var statint = statmodtimer[n]
			if statint == 0:
				statmods[n] = 1
				statmodtimer.erase(n)
			else:
				statmodtimer[n] -= 1

func StatusEffects():
	if status_effects.STUN in status: 
		CombatGUI.BattleLog(charname + " is stunned!")
		statres[status_effects.STUN] = statres[status_effects.STUN] * 1.5
	if status_effects.POISON in status:
		CombatGUI.BattleLog(charname + " takes " + str(poison) + " damage from poison!")
		await take_damage(poison, damage_type.TRUE)
		poisoncount -= 1
		if poisoncount == 0:
			status.erase(status_effects.POISON)
			statres[status_effects.POISON] = statres[status_effects.POISON] * 1.5
	if status_effects.BURN in status:
		CombatGUI.BattleLog(charname + " takes " + str(burn) + " burn damage!")
		await take_damage(burn, damage_type.INFERNAL)
		burncount -= 1
		if burncount == 0:
			status.erase(status_effects.BURN)
			statres[status_effects.BURN] = statres[status_effects.BURN] * 1.5
	if status_effects.BLIND in status:
		CombatGUI.BattleLog(charname + " is blinded!")
		blindcount -= 1
		if blindcount == 0:
			statmods[stat.ACC] = 1
			status.erase(status_effects.BLIND)
			statres[status_effects.BLIND] = statres[status_effects.BLIND] * 1.5
	if status_effects.SEAL in status:
		CombatGUI.BattleLog(charname + "'s Skills are sealed!")
		sealedskilllist = skill_list
		skill_list = {}
		sealcount -= 1
		if sealcount == 0:
			status.erase(status_effects.SEAL)
			skill_list = sealedskilllist
			statres[status_effects.SEAL] = statres[status_effects.SEAL] * 1.5
	if status_effects.MARKED in status:
		CombatGUI.BattleLog(charname + " has drawn the enemies ire!")
		markedcount -= 1
		if markedcount == 0:
			status.erase(status_effects.MARKED)
	if status_effects.REGEN in status:
		await get_healed(regen)
		CombatGUI.BattleLog("Regen restores " + charname + "'s health!")
		regencount -= 1
		if regencount == 0:
			status.erase(status_effects.REGEN)

func Stat(stat_to_check: Entity.stat):
	return (stats[stat_to_check] * statmods[stat_to_check])

func Attack(target: Entity):
	CombatGUI.emit_signal("menuhide")
	if not await CheckMiss(target): return
	#var damage_dealt = Damage(target, Stat(stat.STR), weapontype) 
	var damage_dealt = target.take_damage(Stat(stat.STR), weapontype)
	CloseTurn(charname + " has attacked " + target.charname + " for " + str(damage_dealt) + " damage!")

func Defend():
	StatMod(stat.DEF, 1.5, 0)
	CloseTurn(str((charname) + " defends herself!"))

func CheckMiss(target):
	var ratio : float = float(stats[stat.ACC]) / float(target.stats[stat.EVD])
	var rng = Globals.RNG()
	var result = ratio * rng
	
	if result >= Globals.BASE_MISS_CHANCE : return true
	else: 
		CloseTurn(target.charname + " evades " + charname + "'s attack!")
		for n in %Combat.auras: await n.on_miss(self, target) #inform waiting skills of a miss
		return false

func CheckCrit(): #return modifier of crit damage (usually 1.5 but can be changed in stats) if crit, otherwise 1
	if Stat(stat.CRIT) >= Globals.RNG(): return (float(stat.CRITDMG) / 100)
	else: return 1

func take_damage (damage, type):
	var adjusteddamage
	#var crit = CheckCrit()
	
	if stats[stat.HP] == 0: return #to prevent multi-attacks from triggering die() multiple times
	if type == damage_type.IMPACT or type == damage_type.SLASH or type == damage_type.PIERCE:
		adjusteddamage = max(1, damage * (100 / (100+(float(Stat(stat.DEF))))))
		adjusteddamage = max(0, adjusteddamage * (1 - (float(damageres[type]) / 100.00)))
	if type == damage_type.FEL or type == damage_type.VIRTUOS or type == damage_type.INFERNAL or type == damage_type.LEVIN or type == damage_type.ERDE or type == damage_type.DEEP:
		adjusteddamage = max(1, damage * (100 / (100+(float(Stat(stat.RES))))))
		adjusteddamage = max(0, adjusteddamage * (1 - (float(damageres[type]) / 100.00)))

	if type == damage_type.TRUE:
		adjusteddamage = damage
	stats[stat.HP] -= int(adjusteddamage)
	stats[stat.HP] = max(0, stats[stat.HP])
	
	#emit_signal("attacked", target, self, adjusteddamage, type) # used for UI shake etc

	CombatGUI.TakeDamageGUI(self)
	CombatGUI.UpdateStats(self, stats[stat.HP], stats[stat.MP])
	
	if stats[stat.HP] <= 0: 
		dies()
	return int(adjusteddamage,)

func get_healed (heal_amount:int):
	stats[stat.HP] += heal_amount
	stats[stat.HP] = min(stats[stat.MAXHP], stats[stat.HP])
	
	CombatGUI.UpdateStats(self, stats[stat.HP], stats[stat.MP])

#bonus to inflict is a percent chance advantage at inflicting the ailment.
func AttemptStatusAilment(type, amount, time, bonus_to_inflict):
	var rng = Globals.RNG()
	if rng + bonus_to_inflict > statres[type]: 
		status.append(type)
		if type == status_effects.POISON:
			poison = amount
			poisoncount = time
			CombatGUI.BattleLog(charname + " has been inflicted with poison!")
		elif type == status_effects.BURN:
			burn = amount
			burncount = time
			CombatGUI.BattleLog(charname + " has been blinded!")
		elif type == status_effects.REGEN:
			regen = amount
			regencount = time
		elif type == status_effects.MARKED:
			markedamount = amount
			markedcount = time
			CombatGUI.BattleLog(charname + " has been marked!")
		elif type == status_effects.BLIND:
			blindcount = time
			StatMod(stat.ACC, 0.3, time)
			CombatGUI.BattleLog(charname + " has been blinded!")
		elif type == status_effects.SEAL:
			sealcount = time
			CombatGUI.BattleLog(charname + "'s Skills are sealed!")

		CombatGUI.StatusLabels(self)

#returns the actual amount of damage that was dealt, and also triggers the damage on the target node.
func Damage(target, damage_calc, damage_type):
	var damage_dealt
	var crit = CheckCrit()

	damage_dealt = target.take_damage(damage_calc * crit, damage_type)
	emit_signal("attacked", target, self, damage_dealt, damage_type) # used for UI shake etc

	if crit > 1:
		#self.resources[&"CRIT"] = 1 #How the fuck to queue a response to a crit after it's happened.
		return str(damage_dealt) + "!!"
	else: 
		return str(damage_dealt)

func Revive(target, heal):
	target.get_healed(heal)
	target.dead = false
	CombatGUI.ReviveLabel(target)

func UseItem():
	queueditem.call_func(self)

func get_party_targets():
	return party.get_children()

#used to apply stat modifiers (buffs or debuffs) for a set period of time
func StatMod(stat, amount, timer):
	statmods[stat] = amount
	statmodtimer[stat] = timer

func MPCheck(MPcost):
	if stats[stat.MP] < MPcost: 
		CombatGUI.BattleLog("Not enough MP!")
		return false
	else: return true

func MPCost(MPcost):
	stats[stat.MP] -= MPcost
	stats[stat.MP] = max(0, stats[stat.MP])
	stats[stat.MP] = min(stats[stat.MAXMP], stats[stat.MP])
	CombatGUI.UpdateStats(self, stats[stat.HP], stats[stat.MP])

func CloseTurn(string=""):
	CombatGUI.ClearSecondMenu()
	CombatGUI.BattleLog(string)
	await get_tree().create_timer(0.5).timeout
	emit_signal("turn_complete")

func dies():
	if enemy == true:
		dead = true
		combatlabel.visible = false
	else:
		dead = true
		status = []
		for n in statmods:
			if statmods[n] != 1:
					statmods[n] = 1
					statmodtimer.erase(n)
