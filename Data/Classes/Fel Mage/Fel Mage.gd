extends Entity

enum skillid {FelM00, FelM01, FelM02, FelM03, FelM04, FelM05, FelM06, FelM07, FelM08, FelM09, FelM10, FelM11, FelM12, FelM13, FelM14, FelM15, FelM16, FelM17, FelM18, FelM19, FelM20}

const BOLT_MODIFIER = 1.4
const STORM_MODIFIER = 0.7

#PASSIVES
 
#STATS
var starting_stats = {
		stat.HP: 50,
		stat.MP: 175,
		stat.MAXHP: 50,
		stat.MAXMP: 175,
		stat.STR: 5,
		stat.DEX: 10,
		stat.DEF: 20,
		stat.INT: 60,
		stat.FTH: 30,
		stat.RES: 50,
		stat.EVD: 20,
		stat.ACC: 30,
		stat.SPD: 25,
		stat.CRIT: 10,
		stat.CRITDMG: 1.5
		}
var stat_scaling = {
		stat.HP: stat_scale.B,
		stat.MP: stat_scale.S,
		stat.MAXHP: stat_scale.B,
		stat.MAXMP: stat_scale.S,
		stat.STR: stat_scale.D,
		stat.DEX: stat_scale.D,
		stat.DEF: stat_scale.C,
		stat.INT: stat_scale.S,
		stat.FTH: stat_scale.A,
		stat.RES: stat_scale.A,
		stat.EVD: stat_scale.B,
		stat.ACC: stat_scale.B,
		stat.SPD: stat_scale.B,
		stat.CRIT: stat_scale.F,
		stat.CRITDMG: stat_scale.F,
		stat.HATE: stat_scale.C
	}
var job_description = "The Fel Mage is destruction incarnate. \n\nMaster of all elements, and capable of raining massive damage down upon foes regardless of their resistances or position. Their ability to recover MP also makes them excellent sustainers for long journies. \n\nHowever Fel Mage's lack much in the way of defenses, and must be protected. "

func _ready():
	HATE = 30
	weapontype = damage_type.IMPACT
	
	skill_list = {

		}
#SKILLS
