AddCSLuaFile()
local function ulxCommand(name,func) return ulx.command("SkyCycle",string.format("ulx %s",name),func,string.format("!%s",name),false,false,false) end
local function ulxLog(string,ply,arg1,arg2,arg3) ulx.fancyLogAdmin(ply,string.format("#A %s",string.format(string,arg1,arg2,arg3))) end
local function ulxError(string,ply) ULib.tsayError(ply,string,false) end
local function ulxParam(enum,hint,optional,restrict,round) optional = optional or nil restrict = restrict or nil round = round or nil
	local t = {{type=ULib.cmds.NumArg},{type=ULib.cmds.BoolArg},{type=ULib.cmds.PlayerArg},{type=ULib.cmds.PlayersArg},{type=ULib.cmds.StringArg}} t[enum].hint = hint 
	if !(t[enum]) then return end if optional then table.Add(t[enum],{ULib.cmds.optional}) end if restrict then table.Add(t[enum],{ULib.cmds.restrictToCompletes}) end
	if round then table.Add(t[enum],{ULib.cmds.round}) end return t[enum] end
local NUM,BOOL,PLAYER,PLAYERS,STRING = 1,2,3,4,5 -- Proper enums
local function SinglePlayerError() if game.SinglePlayer() then ULib.console(nil,"!Most features of SkyCycle do not work in SinglePlayer!") end end
local USER,OPERATOR,ADMIN,SUPERADMIN = "user","operator","admin","superadmin" -- They must of never heard of enums...

local force_cycle = ulxCommand("forcecycle",function(ply) RunCycle() ulxLog("Forced a Cycle",ply) end)
force_cycle:help"Forces a cycle."
force_cycle:defaultAccess(ADMIN)
force_cycle:addParam{type=ULib.cmds.BoolArg, invisible=true}

local disable_cycle = ulxCommand("disablecycle",function(ply) EnableCycleTimer(false) ulxLog("Disabled the Sky Cycle",ply) end)
disable_cycle:help"Disables the Sky Cycle timer freezing the sun in place."
disable_cycle:defaultAccess(SUPERADMIN)
local disable_cycle_param = ulxParam(BOOL)
disable_cycle_param.invisible = true
force_cycle:addParam(disable_cycle_param)

local cycle_length = ulxCommand("setcyclelength",function(ply,seconds) SetCycleLength(seconds) ulxLog("Set the Cycle Length to %s seconds.",ply,seconds) end) -- Will be removed in a later date.
cycle_length:help"Sets the amount of time it takes for a whole cycle to pass in seconds."
cycle_length:addParam{type=ULib.cmds.NumArg,default=600,min=60,hint="seconds",ULib.cmds.round}
cycle_length:defaultAccess(SUPERADMIN)
local cycle_length_param = ulxParam(BOOL)
cycle_length_param.invisible = true
cycle_length:addParam(cycle_length_param)

local night_sky = ulxCommand("nightsky",function(ply) Night() ulxLog("Made it night.",ply) end)
night_sky:help"Test command to make the sky night."
night_sky:defaultAccess(ADMIN)
local night_sky_param = ulxParam(BOOL)
night_sky_param.invisible = true
night_sky:addParam(night_sky_param)