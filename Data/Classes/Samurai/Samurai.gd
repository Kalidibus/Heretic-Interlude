extends Entity

var starting_stats = {
		stat.HP: 100,
		stat.MP: 80,
		stat.STR: 70,
		stat.DEF: 20,
		stat.INT: 20,
		stat.FTH: 30,
		stat.RES: 50,
		stat.EVD: 20,
		stat.ACC: 40,
		stat.SPD: 40,
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

var job_description = "The Samurai Vocation readies a single strike for perfect execution. \n\nBy steadying ones mind through the chaos of battle, the perfect moment to draw your sword and strike arrives. A unique vocation that rewards carefully buffing individual devastating attacks. \n\nVery low ranged utility, and if vulnerable while charging it's strike."

func _ready():
	charname = "Samurai"
	HATE = 50
	enemy = false
	weapontype = damage_type.SLASH
	
