extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_unlock_gui(jobid):
	var dict = JobDict.GetUnlocks(jobid)
	var itemid
	var needed
	
	%PVTexture.texture = load(JobDict.JobProfile(jobid))
	
	#resource 1
	var resource1 = ItemDict.items_by_id.get(&"c0001")
	var resource2 = ItemDict.items_by_id.get(&"c0002")
	var resource3 = ItemDict.items_by_id.get(&"c0003")
	var resource4 = ItemDict.items_by_id.get(&"c0004")
	itemid = dict["0"]["itemid"]
	needed = dict["0"]["needed"]
	#%res1icon = ItemDict.GetIcon(itemid)
	%res1name.text = resource1.item_name
	%res1current.text = str(PlayerData.GetInvItemQty(resource1))
	%res1need.text = str(needed)

	#resource 2
	itemid = dict["1"]["itemid"]
	needed = dict["1"]["needed"]
	#%res2icon = ItemDict.GetIcon(itemid)
	%res2name.text = resource2.item_name
	%res2current.text = str(PlayerData.GetInvItemQty(resource2))
	%res2need.text = str(needed)
	
	#resource 3
	itemid = dict["2"]["itemid"]
	needed = dict["2"]["needed"]
	#%res3icon = ItemDict.GetIcon(itemid)
	%res3name.text = resource3.item_name
	%res3current.text = str(PlayerData.GetInvItemQty(resource3))
	%res3need.text = str(needed)
	
	#resource 4
	itemid = dict["3"]["itemid"]
	needed = dict["3"]["needed"]
	#%res4icon = ItemDict.GetIcon(itemid)
	%res4name.text = resource4.item_name
	%res4current.text = str(PlayerData.GetInvItemQty(resource4))
	%res4need.text = str(needed)


func _on_unlock_button_pressed() -> void:
	var jobid = self.get_index()
	
	if PaythePrice(jobid):

		PlayerData.UnlockClass(jobid)
		%UnlockButton.disabled = true
	
		%unlockstatus.text = "Unlocked!"
		%ResourceContainer.visible = false
		%UnlockButton.disabled = true
		
		$/root/CharUnlocks.get_tree().reload_current_scene()

func PaythePrice(jobid):
	var costarray = JobDict.GetUnlocks(str(jobid))
	var count = 0

	for n in costarray:
		var cost = costarray[n]["needed"]
		var item = costarray[n]["itemid"]


		if PlayerData.GetInvItemQty(item) >= cost:
			count += 1
	if count == 4:
		for n in costarray:
			var item = costarray[n]["itemid"]
			var cost = costarray[n]["needed"]
			
			CharacterChanges.RemovefromInventory(item, cost)
			
			Globals.system_message(JobDict.JobName(jobid) + " has been unlocked!")
		return 1
	else:
		Globals.system_message("Inadequate Resources")
		return 0
	

	
