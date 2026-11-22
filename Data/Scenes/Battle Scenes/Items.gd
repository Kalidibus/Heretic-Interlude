extends Node2D

var enemies
var partylist

@onready var EventHandler = get_node("/root/Combat")
@onready var CombatGUI = get_node("/root/Combat/CombatGUI")
@onready var Combat = get_node("/root/Combat")


func ready():
	pass

func GetEnemies(): #check this every time an item is used for the current list
	enemies = $Enemies.get_children()

func GetParty(): #check this every time an item is used for the current list
	partylist = $Party.get_children()

func GetScenes(): #delete
	pass

func Consume(string):
	PlayerData.inventory[string] -= 1
	if PlayerData.inventory[string] == 0:
		PlayerData.inventory.erase(string)

func CloseTurn(active_character):
	active_character.CloseTurn()
