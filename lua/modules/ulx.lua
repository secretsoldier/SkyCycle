-- Shared
local function ulxCommand(name,func) return ulx.command("Sky Cycle",string.format("ulx %s",name),function() SinglePlayerError() func() end,string.format("!%s",name),false,false,false) end
local function ulxLog(string,ply) ulx.fancyLogAdmin(ply,string.format("#A %s",string)) end -- I don't like ulx's fancyLogAdmin function
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

local disable_cycle = ulxCommand("Disable Cycle",function(ply) EnableCycleTimer(false) ulxLog("Disabled the Sky Cycle",ply) end )
disable_cycle:help"Disables the Sky Cycle timer freezing the sun in place."
disable_cycle:defaultAccess(SUPERADMIN)