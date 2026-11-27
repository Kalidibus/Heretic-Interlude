extends Entity

var skill_book: SkillDict.books = SkillDict.books.FORTRESS

#STATS
var starting_stats = {
		stat.HP: 24,
		stat.MAXHP: 24,
		stat.MP: 50,
		stat.MAXMP: 50,
		stat.STR: 8,
		stat.DEX: 6,
		stat.DEF: 10,
		stat.INT: 7,
		stat.FTH: 7,
		stat.RES: 6,
		stat.EVD: 6,
		stat.ACC: 20,
		stat.SPD: 25,
		stat.CRIT: 10,
		stat.CRITDMG: 1.5
		}
var stat_scaling = {
		stat.HP: stat_scale.A,
		stat.MP: stat_scale.C,
		stat.MAXHP: stat_scale.A,
		stat.MAXMP: stat_scale.C,
		stat.STR: stat_scale.B,
		stat.DEX: stat_scale.D,
		stat.DEF: stat_scale.S,
		stat.INT: stat_scale.C,
		stat.FTH: stat_scale.C,
		stat.RES: stat_scale.B,
		stat.EVD: stat_scale.D,
		stat.ACC: stat_scale.C,
		stat.SPD: stat_scale.D,
		stat.CRIT: stat_scale.F,
		stat.CRITDMG: stat_scale.F,
		stat.HATE: stat_scale.S
	}
var job_description = "An iron wall to keep Lamentations at bay. \n\nThe Fortress vocation excels at defending the party from physical attacks. Taking hits from enemies repeatedly will also accumulate a resource called [b]Ire[/b] which can be used to trigger powerful counter-attacks. \n\nWhile the Fortresses' shields can protect against magic attacks to some degree, they are not as well suited for foes that deal elemental damage."
