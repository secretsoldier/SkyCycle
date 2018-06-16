-- Shared
local function ulxCommand(name,func) return ulx.command("Sky Cycle",string.format("ulx %s",name),function() SinglePlayerError() func() end,string.format("!%s",name),false,false,false) end
local function ulxLog(string,ply,arg1,arg2,arg3) ulx.fancyLogAdmin(ply,string.format("#A %s",string.format(string,arg1,arg2,arg3))) end
local function ulxError(string,ply) ULib.tsayError(ply,string,false) end
local function SinglePlayerError() if game.SinglePlayer() then Ulib.console(nil,"!Most features of SkyCycle do not work in SinglePlayer!") end
local USER,OPERATOR,ADMIN,SUPERADMIN = "user","operator","admin","superadmin" -- They must of never heard of enums...
local function ulxTable(t,hint)
	return {type=ULib.cmds.StringArg,completes=t,hint=hint,ULib.cmds.restrictToCompletes}
end
local function ulxPercentBar(t,hint)
	return {type=ULib.cmds.NumArg,default=t.default,min=t.min,max=t.max,hint=hint,ULib.cmds.optional}
end

local force_cycle = ulxCommand("Force Cycle",function(ply) RunCycle() ulxLog("Forced a Day Cycle",ply) end)
force_cycle:help"Forces a day cycle."
force_cycle:defaultAccess(ADMIN)

local disable_cycle = ulxCommand("Disable Cycle",function(ply) EnableCycleTimer(false) ulxLog("Disabled the Sky Cycle",ply) end)
disable_cycle:help"Disables the Sky Cycle timer freezing the sun in place."
disable_cycle:defaultAccess(SUPERADMIN)

local cycle_length = ulxCommand("Set Cycle Length",function(ply,seconds) SetCycleLength(seconds) ulxLog("Set the Cycle Length to %s seconds.",ply,seconds) end) -- Will be removed in a later date.
cycle_length:help"Sets the amount of time it takes for a whole cycle to pass in seconds."
cycle_length:addParam{type=ULib.cmds.NumArg,default=600,min=60,hint="seconds",ULib.cmds.round}
cycle_length:defaultAccess(SUPERADMIN)