AddCSLuaFile()
local function ulxCommand(name,func) return ulx.command("SkyCycle",string.format("ulx %s",name),func,string.format("!%s",name),false,false,false) end
local function ulxLog(string,ply,arg1,arg2,arg3) ulx.fancyLogAdmin(ply,string.format("#A %s",string.format(string,arg1,arg2,arg3))) end
local function ulxError(string,ply) ULib.tsayError(ply,string,false) end
local function ulxParam(enum,hint,optional,restrict,round,restofline) optional = optional or nil restrict = restrict or nil round = round or nil restofline = restofline or nil
	local t = {{type=ULib.cmds.NumArg},{type=ULib.cmds.BoolArg},{type=ULib.cmds.PlayerArg},{type=ULib.cmds.PlayersArg},{type=ULib.cmds.StringArg}} t[enum].hint = hint 
	if !(t[enum]) then return end if optional then table.Add(t[enum],{ULib.cmds.optional}) end if restrict then table.Add(t[enum],{ULib.cmds.restrictToCompletes}) end
	if restofline then table.Add(t[enum],{ULib.cmds.takeRestOfLine}) end if round then table.Add(t[enum],{ULib.cmds.round}) end return t[enum] end
local NUM,BOOL,PLAYER,PLAYERS,STRING = 1,2,3,4,5 -- Proper enums
local ALL,OPERATOR,ADMIN,SUPERADMIN = "user","operator","admin","superadmin" -- They must of never heard of enums...

local force_cycle = ulxCommand("forcecycle",function(ply) EnableCycleHopper(false) RunCycle() ulxLog("Forced a Cycle",ply) end)
force_cycle:help"Forces a cycle."
force_cycle:defaultAccess(ADMIN)
force_cycle:addParam{type=ULib.cmds.BoolArg, invisible=true}

local disable_cycle = ulxCommand("disablecycle",function(ply) EnableCycleTimer(false) ulxLog("Disabled the Sky Cycle",ply) end)
disable_cycle:help"Disables the Sky Cycle timer freezing the sun in place."
disable_cycle:defaultAccess(SUPERADMIN)
local disable_cycle_param = ulxParam(BOOL)
disable_cycle_param.invisible = true
force_cycle:addParam(disable_cycle_param)

local cycle_length = ulxCommand("setcyclelength",function(ply,minutes) SetCycleLength(minutes*60) ulxLog("Set the Cycle Length to %s minutes.",ply,minutes) end) -- Will be removed in a later date.
cycle_length:help"Sets the amount of time it takes for a whole cycle to pass in minutes."
cycle_length:defaultAccess(SUPERADMIN)
local cycle_length_param1 = ulxParam(NUM,"minutes",false,false,true)
cycle_length_param1.default = 10
cycle_length_param1.min = 1
cycle_length:addParam(cycle_length_param1)
local cycle_length_param2 = ulxParam(BOOL)
cycle_length_param2.invisible = true
cycle_length:addParam(cycle_length_param2)

local night_sky = ulxCommand("nightsky",function(ply) Night() ulxLog("Made it night.",ply) end)
night_sky:help"Test command to make the sky night."
night_sky:defaultAccess(ADMIN)
local night_sky_param = ulxParam(BOOL)
night_sky_param.invisible = true
night_sky:addParam(night_sky_param)

local day_sky = ulxCommand("daysky",function(ply) Day() ulxLog("Made it day.",ply) end)
day_sky:help"Test command to make the sky day."
day_sky:defaultAccess(ADMIN)
local day_sky_param = ulxParam(BOOL)
day_sky_param.invisible = true
day_sky:addParam(day_sky_param)

local get_time = ulxCommand("gettime",function(ply,format) local x,z = ReturnTime() if format == "24 Hour" then  else if !(z) then if x > 12 then x=x-12 end x = string.format("%s pm",x) else x = string.format("%s am",x) end end ULib.tsay(ply,string.format("The time is: %s",x)) end)
get_time:help"Command that gets the time in-game."
get_time:defaultAccess(ALL)
local get_time_param1 = ulxParam(STRING,"Time Format",true,true,false,true)
get_time_param1.completes = {"24 Hour","AM-PM"} -- Format doesn't work properly right now.
get_time_param1.error = "Please choose a format"
get_time:addParam(get_time_param1)
local get_time_param2 = ulxParam(BOOL)
get_time_param2.invisible = true
get_time:addParam(get_time_param2)