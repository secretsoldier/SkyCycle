local function ulxCommand(name,func) return ulx.command("SkyCycle",string.format("ulx %s",name),function() SinglePlayerError() func() end,string.format("!%s",name),false,false,false) end
local function ulxLog(string,ply,arg1,arg2,arg3) ulx.fancyLogAdmin(ply,string.format("#A %s",string.format(string,arg1,arg2,arg3))) end
local function ulxError(string,ply) ULib.tsayError(ply,string,false) end
local function ulxParam(enum,hint,optional,restrict,round) optional = optional or nil restrict = restrict or nil round = round or nil
	local t = {{type=ULib.cmds.NumArg},{type=ULib.cmds.BoolArg},{type=ULib.cmds.PlayerArg},{type=ULib.cmds.PlayersArg},{type=ULib.cmds.StringArg}} t[enum].hint = hint 
	if !(t[enum]) then return end if optional then table.Add(t[enum],{ULib.cmds.optional}) end if restrict then table.Add(t[enum],{ULib.cmds.restrictToCompletes}) end
	if round then table.Add(t[enum],{ULib.cmds.round}) end return t[enum] end
local NUM,BOOL,PLAYER,PLAYERS,STRING = 1,2,3,4,5 -- Proper enums
local function SinglePlayerError() if game.SinglePlayer() then ULib.console(nil,"!Most features of SkyCycle do not work in SinglePlayer!") end end
local USER,OPERATOR,ADMIN,SUPERADMIN = "user","operator","admin","superadmin" -- They must of never heard of enums...

local force_cycle = ulxCommand("ForceCycle",function(ply) RunCycle() ulxLog("Forced a Day Cycle",ply) end)
force_cycle:help"Forces a day cycle."
force_cycle:defaultAccess(ADMIN)

local disable_cycle = ulxCommand("DisableCycle",function(ply) EnableCycleTimer(false) ulxLog("Disabled the Sky Cycle",ply) end)
disable_cycle:help"Disables the Sky Cycle timer freezing the sun in place."
disable_cycle:defaultAccess(SUPERADMIN)

local cycle_length = ulxCommand("SetCycleLength",function(ply,seconds) SetCycleLength(seconds) ulxLog("Set the Cycle Length to %s seconds.",ply,seconds) end) -- Will be removed in a later date.
cycle_length:help"Sets the amount of time it takes for a whole cycle to pass in seconds."
cycle_length:addParam{type=ULib.cmds.NumArg,default=600,min=60,hint="seconds",ULib.cmds.round}
cycle_length:defaultAccess(SUPERADMIN)