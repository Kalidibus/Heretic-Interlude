extends Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Function receives the ID of character who's equipping an item, the slot, and the item ID.
#Equips it and moves anything already in the slot to inventory space.
#location is not the slot, it's roster / party
func add_equipment(charid, add_eqp :StringName, location) -> void:
	var character = PlayerData.get(location)[str(charid)]
	
	if character["equipment"].get(ItemDict.items_by_id.get(add_eqp).item_slot) != null:
		remove_equipment(charid, add_eqp, location)
	character["equipment"][ItemDict.items_by_id.get(add_eqp).item_slot] = add_eqp
	
	#apply stat bonuses from gear to character in the party. 
	var gear_stats : Dictionary = ItemDict.items_by_id.get(add_eqp).stat_modifiers
	for n in gear_stats:
		character["stats"][n] += gear_stats[n]

	var gear_skills: Dictionary = ItemDict.items_by_id.get(add_eqp).granted_ability_ids
	for skill_id in gear_skills:
		LearnSkill(character, skill_id, gear_skills[skill_id])

func remove_equipment(charid, remove_eqp, location) -> void:
	var character = PlayerData.get(location)[str(charid)]
	character["equipment"].erase(ItemDict.items_by_id.get(remove_eqp).item_slot)

	#remove stat bonuses from gear to character in the party. 
	var gear_stats : Dictionary = ItemDict.items_by_id.get(remove_eqp).stat_modifiers
	for n in gear_stats:
		character["stats"][n] -= gear_stats[n]
	
	var gear_skills: Dictionary = ItemDict.items_by_id.get(remove_eqp).granted_ability_ids
	for n in gear_skills:
		RemoveSkill(character["char_id"], n, gear_skills[n])

func AddtoInventory(item: StringName , qty: int) -> void:
	if not PlayerData.inventory.has(item):
		PlayerData.inventory[item] = qty
	else:
		PlayerData.inventory[item] += qty

func RemovefromInventory(item: StringName , qty: int):
		if PlayerData.inventory.has(item):
			PlayerData.inventory[item] = max(0, PlayerData.inventory[item] - qty)
			if PlayerData.inventory[item] == 0:
				PlayerData.inventory.erase(item)

func GainXP(charid, xp):
	charid = str(charid)
	PlayerData.party[charid]["xp"] += xp
	LevelUpCheck(charid)

func LoseXP(charid, xp):
	charid = str(charid)
	PlayerData.party[charid]["xp"] -= xp

func LevelUpCheck(charid):
	var xp = PlayerData.party[charid]["xp"]
	var xpneeded = PlayerData.party[charid]["xpneeded"]
	var level = PlayerData.party[charid]["level"]

	if xp >= xpneeded:
		LevelUp(charid)
	else:
		return

func LevelUp(charid):
	var stats = PlayerData.party[charid]["stats"]
	var jobid = PlayerData.party[charid]["job_id"]
	
	#increase Level
	PlayerData.party[charid]["level"] += 1 
	#increase XP needed for next level
	PlayerData.party[charid]["xpneeded"] = int(PlayerData.party[charid]["xpneeded"]*1.5)
	
	#increase stats
	for n in stats:
		if n == Entity.stat.CRIT or n == Entity.stat.CRITDMG or n == Entity.stat.HATE: pass
		else: PlayerData.party[charid]["stats"][n] = int(stats[n] * JobDict.StatScaling(jobid, n)) + 1
	
	#Fill up HP / MP
	PlayerData.party[charid]["stats"][Entity.stat.HP] = PlayerData.party[charid]["stats"][Entity.stat.MAXHP]
	PlayerData.party[charid]["stats"][Entity.stat.MP] = PlayerData.party[charid]["stats"][Entity.stat.MAXMP]
	
	#check for multiple level ups in case of huge XP gain
	LevelUpCheck(charid)
	Globals.system_message(PlayerData.party[charid]["name"] + " has reached level " + str(PlayerData.party[charid]["level"]))
	

func LearnSkill(character, skill_id, skill_level: int = 1):
	if not character["known_skills"].has(skill_id):
		character["known_skills"].append(skill_id)
		character["skill_levels"][skill_id] = skill_level
	else:
		character["skill_levels"][skill_id] += skill_level

func RemoveSkill(character: Dictionary, skillid, level: int = 1) -> void:
	if not character["known_skills"].has(skillid):
		return

	character["skill_levels"][skillid] -= level

	if character["skill_levels"][skillid] <= 0:
		character["skill_levels"].erase(skillid)
		character["known_skills"].erase(skillid)
