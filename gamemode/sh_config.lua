// Allow admins to noclip [0 = No, 1 = Yes] (Default: 0)
ADMIN_NOCLIP = 0


// Give admins the physgun [0 = No, 1 = Yes] (Default: 0)
ADMIN_PHYSGUN = 0


// Range the difficulty scale can be in [{Min, Max}] (Default: {0, 3 })
DIFFICULTY_RANGE = {0, 3}


// If all players die, one of these will be played
// Leave blank to disable
FAILURE_SOUNDS = {}


// Percent of players that need to be in the loading section for the next map to load (Default: 60)
NEXT_MAP_PERCENT = 60


// Seconds before the next map loads (Default: 15)
NEXT_MAP_TIME = 15


// Points to give a player for killing an NPC (if non-one)
NPC_POINT_VALUES = {
	["npc_antlionguard"] = 2,
	["npc_citizen"] = 0,
	["npc_combinedropship"] = 3,
	["npc_combinegunship"] = 2,
	["npc_crow"] = 0,
	["npc_helicopter"] = 3,
	["npc_ministrider"] = 2,
	["npc_pigeon"] = 0,
	["npc_strider"] = 3
}

// Seconds before the map is restarted (Default: 10)
RESTART_MAP_TIME = 10

// Models the player is restricted by
PLAYER_MODELS = {
	"models/player/group01/female_01.mdl",
	"models/player/group01/female_02.mdl",
	"models/player/group01/female_03.mdl",
	"models/player/group01/female_04.mdl",
	"models/player/group01/female_06.mdl",
	"models/player/group01/male_01.mdl",
	"models/player/group01/male_02.mdl",
	"models/player/group01/male_03.mdl",
	"models/player/group01/male_04.mdl",
	"models/player/group01/male_05.mdl",
	"models/player/group01/male_06.mdl",
	"models/player/group01/male_07.mdl",
	"models/player/group01/male_08.mdl",
	"models/player/group01/male_09.mdl",
	"models/player/group03/female_01.mdl",
	"models/player/group03/female_02.mdl",
	"models/player/group03/female_03.mdl",
	"models/player/group03/female_04.mdl",
	"models/player/group03/female_06.mdl",
	"models/player/group03/male_01.mdl",
	"models/player/group03/male_02.mdl",
	"models/player/group03/male_03.mdl",
	"models/player/group03/male_04.mdl",
	"models/player/group03/male_05.mdl",
	"models/player/group03/male_06.mdl",
	"models/player/group03/male_07.mdl",
	"models/player/group03/male_08.mdl",
	"models/player/group03/male_09.mdl",
	"models/player/group03m/female_01.mdl",
	"models/player/group03m/female_02.mdl",
	"models/player/group03m/female_03.mdl",
	"models/player/group03m/female_04.mdl",
	"models/player/group03m/female_06.mdl",
	"models/player/group03m/male_01.mdl",
	"models/player/group03m/male_02.mdl",
	"models/player/group03m/male_03.mdl",
	"models/player/group03m/male_04.mdl",
	"models/player/group03m/male_05.mdl",
	"models/player/group03m/male_06.mdl",
	"models/player/group03m/male_07.mdl",
	"models/player/group03m/male_08.mdl",
	"models/player/group03m/male_09.mdl"
}

// Determine between female or male
PLAYER_MODELS_MALE = {
	"models/player/group01/male_01.mdl",
	"models/player/group01/male_02.mdl",
	"models/player/group01/male_03.mdl",
	"models/player/group01/male_04.mdl",
	"models/player/group01/male_05.mdl",
	"models/player/group01/male_06.mdl",
	"models/player/group01/male_07.mdl",
	"models/player/group01/male_08.mdl",
	"models/player/group01/male_09.mdl",
	"models/player/group03/male_01.mdl",
	"models/player/group03/male_02.mdl",
	"models/player/group03/male_03.mdl",
	"models/player/group03/male_04.mdl",
	"models/player/group03/male_05.mdl",
	"models/player/group03/male_06.mdl",
	"models/player/group03/male_07.mdl",
	"models/player/group03/male_08.mdl",
	"models/player/group03/male_09.mdl",
	"models/player/group03m/male_01.mdl",
	"models/player/group03m/male_02.mdl",
	"models/player/group03m/male_03.mdl",
	"models/player/group03m/male_04.mdl",
	"models/player/group03m/male_05.mdl",
	"models/player/group03m/male_06.mdl",
	"models/player/group03m/male_07.mdl",
	"models/player/group03m/male_08.mdl",
	"models/player/group03m/male_09.mdl"
}

// Determine between female or male
PLAYER_MODELS_FEMALE = {
	"models/player/group01/female_01.mdl",
	"models/player/group01/female_02.mdl",
	"models/player/group01/female_03.mdl",
	"models/player/group01/female_04.mdl",
	"models/player/group01/female_06.mdl",
	"models/player/group03/female_01.mdl",
	"models/player/group03/female_02.mdl",
	"models/player/group03/female_03.mdl",
	"models/player/group03/female_04.mdl",
	"models/player/group03/female_06.mdl",
	"models/player/group03m/female_01.mdl",
	"models/player/group03m/female_02.mdl",
	"models/player/group03m/female_03.mdl",
	"models/player/group03m/female_04.mdl",
	"models/player/group03m/female_06.mdl"
}

// Combine Playermodels are also given a hurt sound so they're not left out.
PLAYER_MODELS_COMBINE = {
	"models/player/combine_soldier.mdl",
	"models/player/combine_soldier_prisonguard.mdl",
	"models/player/combine_super_soldier.mdl",
	
	-- Metrocop playermodels are going to be in the same catergory because I'm too lazy to add more.
	"models/player/police.mdl"
}

// Male hurt sounds
MALE_HURT_SOUNDS = {
	"vo/npc/male01/imhurt01.wav",
	"vo/npc/male01/imhurt02.wav",
	"vo/npc/male01/myarm01.wav",
	"vo/npc/male01/myarm02.wav",
	"vo/npc/male01/mygut02.wav",
	"vo/npc/male01/myleg01.wav",
	"vo/npc/male01/myleg02.wav",
	"vo/npc/male01/ow01.wav",
	"vo/npc/male01/ow02.wav",
	"vo/npc/male01/pain01.wav",
	"vo/npc/male01/pain02.wav",
	"vo/npc/male01/pain03.wav",
	"vo/npc/male01/pain04.wav",
	"vo/npc/male01/pain05.wav",
	"vo/npc/male01/pain06.wav",
	"vo/npc/male01/pain07.wav",
	"vo/npc/male01/pain08.wav",
	"vo/npc/male01/pain09.wav"
}

// Male sounds called when someone dies
MALE_HEISDEAD_SOUNDS = {
	"vo/npc/male01/gordead_ans01.wav",
	"vo/npc/male01/gordead_ans02.wav",
	"vo/npc/male01/gordead_ans03.wav",
	"vo/npc/male01/gordead_ans04.wav",
	"vo/npc/male01/gordead_ans05.wav",
	"vo/npc/male01/gordead_ans06.wav",
	"vo/npc/male01/gordead_ans07.wav",
	"vo/npc/male01/gordead_ans10.wav",
	"vo/npc/male01/gordead_ans11.wav",
	"vo/npc/male01/gordead_ans12.wav",
	"vo/npc/male01/gordead_ans13.wav",
	"vo/npc/male01/gordead_ans14.wav",
	"vo/npc/male01/gordead_ans15.wav",
	"vo/npc/male01/gordead_ans16.wav",
	"vo/npc/male01/gordead_ans19.wav",
	"vo/npc/male01/gordead_ans20.wav",
	"vo/npc/male01/gordead_ques02.wav",
	"vo/npc/male01/gordead_ques01.wav",
	"vo/npc/male01/gordead_ques10.wav",
	"vo/npc/male01/gordead_ques13.wav",
	"vo/npc/male01/gordead_ques14.wav",
	"vo/npc/male01/gordead_ques16.wav"
}

// Female hurt sounds
FEMALE_HURT_SOUNDS = {
	"vo/npc/female01/imhurt01.wav",
	"vo/npc/female01/imhurt02.wav",
	"vo/npc/female01/myarm01.wav",
	"vo/npc/female01/myarm02.wav",
	"vo/npc/female01/mygut02.wav",
	"vo/npc/female01/myleg01.wav",
	"vo/npc/female01/myleg02.wav",
	"vo/npc/female01/ow01.wav",
	"vo/npc/female01/ow02.wav",
	"vo/npc/female01/pain01.wav",
	"vo/npc/female01/pain02.wav",
	"vo/npc/female01/pain03.wav",
	"vo/npc/female01/pain04.wav",
	"vo/npc/female01/pain05.wav",
	"vo/npc/female01/pain06.wav",
	"vo/npc/female01/pain07.wav",
	"vo/npc/female01/pain08.wav",
	"vo/npc/female01/pain09.wav"
}

// Female sounds called when someone dies
FEMALE_HEISDEAD_SOUNDS = {
	"vo/npc/female01/gordead_ans01.wav",
	"vo/npc/female01/gordead_ans02.wav",
	"vo/npc/female01/gordead_ans03.wav",
	"vo/npc/female01/gordead_ans04.wav",
	"vo/npc/female01/gordead_ans05.wav",
	"vo/npc/female01/gordead_ans06.wav",
	"vo/npc/female01/gordead_ans07.wav",
	"vo/npc/female01/gordead_ans10.wav",
	"vo/npc/female01/gordead_ans11.wav",
	"vo/npc/female01/gordead_ans12.wav",
	"vo/npc/female01/gordead_ans13.wav",
	"vo/npc/female01/gordead_ans14.wav",
	"vo/npc/female01/gordead_ans15.wav",
	"vo/npc/female01/gordead_ans16.wav",
	"vo/npc/female01/gordead_ans19.wav",
	"vo/npc/female01/gordead_ans20.wav",
	"vo/npc/female01/gordead_ques02.wav",
	"vo/npc/female01/gordead_ques01.wav",
	"vo/npc/female01/gordead_ques10.wav",
	"vo/npc/female01/gordead_ques13.wav",
	"vo/npc/female01/gordead_ques14.wav",
	"vo/npc/female01/gordead_ques16.wav"
}

// Combine hurt sounds
COMBINE_HURT_SOUNDS = {
	"npc/combine_soldier/pain1.wav",
	"npc/combine_soldier/pain2.wav",
	"npc/combine_soldier/pain3.wav"
}

// Female sounds called when someone dies
COMBINE_HEISDEAD_SOUNDS = {
	"npc/combine_soldier/vo/contactconfim.wav",
	"npc/combine_soldier/vo/contactconfirmprosecuting.wav",
	"npc/combine_soldier/vo/overwatchrequestreinforcement.wav",
	"npc/overwatch/radiovoice/allunitsapplyforwardpressure.wav",
	"npc/overwatch/radiovoice/assault243.wav"
}

// Alyx hurt sounds
ALYX_HURT_SOUNDS = {
	"vo/npc/alyx/gasp02.wav",
	"vo/npc/alyx/gasp03.wav",
	"vo/npc/alyx/hurt04.wav",
	"vo/npc/alyx/hurt05.wav",
	"vo/npc/alyx/hurt06.wav",
	"vo/npc/alyx/hurt08.wav",
	"vo/npc/alyx/uggh01.wav",
	"vo/npc/alyx/uggh02.wav"
}

// Barney hurt sounds
BARNEY_HURT_SOUNDS = {
	"vo/npc/barney/ba_pain01.wav",
	"vo/npc/barney/ba_pain02.wav",
	"vo/npc/barney/ba_pain03.wav",
	"vo/npc/barney/ba_pain04.wav",
	"vo/npc/barney/ba_pain05.wav",
	"vo/npc/barney/ba_pain06.wav",
	"vo/npc/barney/ba_pain07.wav",
	"vo/npc/barney/ba_pain08.wav",
	"vo/npc/barney/ba_pain09.wav",
	"vo/npc/barney/ba_pain10.wav",
	"vo/npc/barney/ba_wounded01.wav",
	"vo/npc/barney/ba_wounded02.wav",
	"vo/npc/barney/ba_wounded03.wav"
}

// Custom Player hurt sounds
PLAYER_HURT_SOUNDS = {
	"player/pl_pain5.wav",
	"player/pl_pain6.wav",
	"player/pl_pain7.wav"
}

// If everyone beats the level, one of these will be played
// Leave blank to disable
SUCCESS_SOUNDS = {}


// Number of seconds before a player is vulnerable after they spawn (Default: 10)
VULNERABLE_TIME = 0

// Names for the dummy bots that can be added via "bot" or "bot_add"
// Just visually change the nicknames for the dummy bots so they're no longer shown to be Bot*
// Includes normal names, Steam Usernames, Youtube names and extras
// Find what names you know
BOT_NAMES = {
	"Rodrick",
	"James",
	"Lisa",
	"Bart",
	"Jordan",
	"Uchi",
	"Mario",
	"Garry",
	"Bob",
	"Steve",
	"Andy",
	"Anna",
	"Homer",
	"Sandra",
	"Nick",
	"Luigi",
	"Peach",
	"Drew",
	"Tony",
	"0102uʍouʞunɐp",
	"Maestro Fénix",
	"Vanoss",
	"Felix",
	"Mark",
	"Adam",
	"[YaS] Neico",
	"Shana",
	"TESLA-X4",
	"Rubat",
	"Nafrayu",
	"Venturian",
	"Dr. Speggle",
	"ILOVEPIE",
	"VOSK",
	"Cheeseh",
	"Adambean",
	"Sniper",
	"VEER™",
	"paulj",
	"KillerB -=THC=-",
	"DaftMink",
	"Krazy Kasrkin",
	"Brainles5",
	"Captain Foxer",
	"cartman-2000",
	"Barney",
	"Alyx",
	"Eli Vance",
	"Vortigaunt",
	"Mossman",
	"Gordon Freeman",
	"Freddy Fazbear",
	"Bonnie",
	"Chica",
	"Foxy",
	"Chell",
	"GLaDOS",
	"Wheatley",
	"Danny",
	"Fluffo",
	"garry :D",
	"Sam Fisher",
	"I_AM_WILDCAT",
	"ErrolLiamP",
	"Bill Gates",
	"Gabe Newell",
	"Alfred",
	"1337Espeon",
	"Obsidian Conflict",
	"Synergy",
	"Follow Freeman",
	"Sven Co-Op",
	"SwikCoder",
	"AMT",
	"Magenta",
	"CSPSpy",
	"PewDiePie",
	"Markiplier",
	"SeaNanners",
	"VanossGaming",
	"Yamimash",
	"dlive22891",
	"TheRPGMinx",
	"Tysn",
	"z33ky",
	"SniperInTheWoods",
	"Axipixel",
	"Plasma HeadCrabD",
	"Lucky9Two",
	"ViralHatred",
	"Spike Wess",
	"Shadow",
	"Hean",
	"Sass Patrol",
	"Barley"
}