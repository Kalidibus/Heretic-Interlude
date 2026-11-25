extends Entity

var starting_stats = {
		stat.HP: 80,
		stat.MP: 125,
		stat.STR: 80,
		stat.DEF: 50,
		stat.INT: 60,
		stat.FTH: 30,
		stat.RES: 50,
		stat.EVD: 20,
		stat.ACC: 40,
		stat.SPD: 25,
		stat.CRIT: 10,
		stat.CRITDMG: 1.5
		}

var stat_scaling = {
		stat.MAXHP: stat_scale.A,
		stat.MAXMP: stat_scale.C,
		stat.STR: stat_scale.B,
		stat.DEF: stat_scale.S,
		stat.INT: stat_scale.C,
		stat.FTH: stat_scale.C,
		stat.RES: stat_scale.B,
		stat.EVD: stat_scale.D,
		stat.SPD: stat_scale.D,
		stat.ACC: stat_scale.B,
		stat.CRIT: stat_scale.F,
		stat.CRITDMG: stat_scale.F
}

var job_description = "The War Mage is a frontline caster with explosive capabilities. \n\nSpecializing in close-range Levin and Infernal damage, they are monsters against groups of enemies that fight in the front-line. Hitting enemies with Infernal or Levin damage also accumulates a resource called [b]Overheat[/b] which can be used to fuel explosive attacks that hit the whole enemy party. \n\nThier capabilities against single enemies, or ranged enemies can be found lacking."

func _ready():
	charname = "War Mage"
	HATE = 30
	enemy = false
	weapontype = damage_type.IMPACT
