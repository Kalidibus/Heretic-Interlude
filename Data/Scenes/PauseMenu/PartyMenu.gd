extends MarginContainer

@onready var partyblock = preload("res://Scenes/PauseMenu/PartyBlock.tscn")
@onready var skills_menu = preload("res://Scenes/PauseMenu/SkillsMenu.tscn")
@onready var equip_menu = preload("res://Scenes/PauseMenu/EquipMenu.tscn")
@onready var equip_node = preload("res://Scenes/PauseMenu/EquipmentBlock.tscn")
var skills_or_equip = "skills"
var first_check: bool = true
var current_char: String 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await AddBlocks()
	await LoadSkillsMenu()

	%SkillsButton.disabled = true
	%EquipmentButton.disabled = false

	FillCharInfo(PlayerData.party_order.front())
	current_char = PlayerData.party_order.front()

func AddBlocks():
	for n in %PartyBlockHolder.get_children():
		n.queue_free()

	for n in PlayerData.party_order:
		var char = PlayerData.party[n]
		var block = partyblock.instantiate()
		block.charid = n
		block.get_node("%Name").text = char["name"]
		block.get_node("%Class").text = char["job_name"]
		block.get_node("%XP").text = "XP: " + str(char["xp"]) + "/" + str(char["xpneeded"])
		block.get_node("%Lv").text = "Lv. " + str(char["level"])
		block.get_node("%TextureRect").texture = load(JobDict.JobProfile(char["job_id"])) 
		
		
		var HP = PlayerData.GetStat(n, Entity.stat.HP)
		var HPmax = PlayerData.GetStat(n, Entity.stat.MAXHP)
		var MP = PlayerData.GetStat(n, Entity.stat.MP)
		var MPmax = PlayerData.GetStat(n, Entity.stat.MAXMP)
		
		block.get_node("%HP").text = str(HP) + "/" + str(HPmax)
		block.get_node("%MP").text = str(MP) + "/" + str(MPmax)
		block.get_node("%HPBar").max_value = HPmax
		block.get_node("%HPBar").value = HP
		block.get_node("%MPBar").max_value = MPmax
		block.get_node("%MPBar").value = MP
		
		block.get_node("%STR_stat").text = str(PlayerData.GetStat(n, Entity.stat.STR))
		block.get_node("%DEF_stat").text = str(PlayerData.GetStat(n, Entity.stat.DEF))
		block.get_node("%INT_stat").text = str(PlayerData.GetStat(n, Entity.stat.INT))
		block.get_node("%RES_stat").text = str(PlayerData.GetStat(n, Entity.stat.RES))
		block.get_node("%FTH_stat").text = str(PlayerData.GetStat(n, Entity.stat.FTH))
		block.get_node("%EVD_stat").text = str(PlayerData.GetStat(n, Entity.stat.EVD))
		block.get_node("%SPD_stat").text = str(PlayerData.GetStat(n, Entity.stat.SPD))
		
		var button = block.get_node("%PositionButton")
		if char.row == Entity.row_line.FRONT: button.text = "FRONT"
		if char.row == Entity.row_line.BACK: button.text = "BACK"
		
		if first_check == true:
			block.get_node("%CharSelectButton").visible = false
			first_check = false
			
		
		%PartyBlockHolder.add_child(block)
	return

func _on_skills_button_pressed() -> void:
	%SkillsButton.disabled = true
	%EquipmentButton.disabled = false
	await LoadSkillsMenu()
	FillCharInfo(current_char)

func LoadSkillsMenu():
	var menu = skills_menu.instantiate()
	for n in %Holder.get_children(): n.queue_free()
	%Holder.add_child(menu)
	skills_or_equip = "skills"

func FillCharInfo(charid):
	current_char = charid
	if skills_or_equip == "skills": FillCharInfo_Skills(current_char)
	elif skills_or_equip == "equip": FillCharInfo_Equip(current_char)
	
func FillCharInfo_Skills(current_char):
	var skills_node = %Holder.get_node_or_null("SkillsMenu/VBoxContainer/Skills")
	if not skills_node.get_children().is_empty(): 
		for i in skills_node.get_children(): 
			i.queue_free()
	
	#move to Passives or regular
	for n :SkillClass in PlayerData.KnownSkills(current_char):
		if n.skill_type == SkillClass.type.PASSIVE: 
			skills_node = %Holder.get_node("SkillsMenu/VBoxContainer/Passives")
		else: skills_node = %Holder.get_node("SkillsMenu/VBoxContainer/Skills")
		
		var jobid = PlayerData.party[current_char]["job_id"]
		var node = JobDict.JobNode(jobid)

		var label = Label.new()
		label.text = n.skill_name

		
		var label2 = Label.new()
		label2.text = n.skill_description
		skills_node.add_child(label)
		skills_node.add_child(label2)

func FillCharInfo_Equip(current_char):

	var node = %Holder.get_node_or_null("EquipMenu").get_node_or_null("%Weaponholder")
	if not node.get_children().is_empty(): 
		for i in node.get_children(): 
			i.queue_free()
	var node2 = %Holder.get_node_or_null("EquipMenu").get_node_or_null("%Armourholder")
	if not node2.get_children().is_empty(): 
		for i in node2.get_children(): 
			i.queue_free()

	var equipment = PlayerData.GetEquipment(current_char)
	
	for n in equipment:
		var item :ItemClass = ItemDict.get_item(equipment[n])
		
		var equip_menu_wep = %Holder.get_node_or_null("EquipMenu/MarginContainer/V/Weaponholder")
		var equip_menu_arm = %Holder.get_node_or_null("EquipMenu/MarginContainer/V/Armourholder")
		var equipnode = equip_node.instantiate()
		equipnode.SetSkill(item)
		
		if item.item_slot == ItemClass.slot.main_hand or item.item_slot == ItemClass.slot.off_hand:
			equip_menu_wep.add_child(equipnode)
		else:
			equip_menu_arm.add_child(equipnode)


func GetLastPushed(pushed_charid, button:String):
	for n in %PartyBlockHolder.get_children():
		if n.charid == pushed_charid:
			if button == "up":
				n.get_node("%UpButton").grab_focus()
			elif button == "down":
				n.get_node("%DownButton").grab_focus()


func _on_equipment_button_pressed() -> void:
	%SkillsButton.disabled = false
	%EquipmentButton.disabled = true
	
	var menu = equip_menu.instantiate()
	for n in %Holder.get_children(): n.queue_free()
	%Holder.add_child(menu)
	skills_or_equip = "equip"
	
	FillCharInfo(current_char)

func disable_clicked_character(node:Node) -> void:
	for n in %PartyBlockHolder.get_children():
		var other_node = n.get_node("%CharSelectButton")
		other_node.visible = true
	node.get_node("%CharSelectButton").visible = false
