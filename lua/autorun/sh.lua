if SERVER then
	hook.Add("InitPostEntity","SkyCycleInit",function()
		local IgnoreSinglePlayer = true
		if game.SinglePlayer() then
			if IgnoreSinglePlayer then
				ErrorNoHalt("SkyCycle does not work correctly in SinglePlayer.")
			else
				Error("SkyCycle does not work correctly in SinglePlayer.")
			end
		end
		local sun,color = ents.FindByClass("env_sun")[1],"249 249 249"
		if !(sun) then print("A sun isn't present in the map.") return end 
		sun:SetKeyValue("size",30)
		sun:SetKeyValue("overlaysize",30)
		
		--[[function Cycle(enum,cycle_len)
			if enum == 1 then
				sun:SetKeyValue("suncolor",moon_color)
				sun:SetKeyValue("overlaycolor",moon_color)
				sun:SetKeyValue("HDRColorScale","0.8")
			elseif enum == 0 or !(enum) then
				sun:SetKeyValue("suncolor",sun_color)
				sun:SetKeyValue("overlaycolor",sun_color)
				sun:SetKeyValue("HDRColorScale","2")
			end
			local time,seconds,enable = math.floor(CurTime()),cycle_len or 600,true
			local indent = 2/(seconds*2)
			function TransFunc()
				local trans = Lerp(indent*(CurTime()-time),-1,1)
				sun:SetKeyValue("sun_dir",string.format("%s 0 0",trans))
				if CurTime()-time < seconds and enable then
					timer.Simple(0.1,TransFunc)
				end
			end
			timer.Simple(0.1,TransFunc)
		end--]]
		local enable,seconds = true,600
		local sun_color,moon_color = string.format("%s %s %s",241,240,199),string.format("%s %s %s",242,242,242)
		function SetSunColor(color,hdr)
			sun:SetKeyValue("suncolor",color)
			sun:SetKeyValue("overlaycolor",color)
			sun:SetKeyValue("HDRColorScale",hdr)
		end
		function RunCycle(offset)
			enable = true
			local time,indent = math.floor(CurTime()),2/(seconds*2)
			function TransFunc()
				local trans = Lerp(indent*((CurTime()+offset)-time),-1,1)
				sun:SetKeyValue("sun_dir",string.format("%s 0 0",trans))
				if CurTime()-time < seconds and enable then
					timer.Simple(0.1,TransFunc)
				end
			end
			timer.Simple(0.1,TransFunc)
		end
		function EnableCycleTimer(b) enable = b end
		function SetCycleLength(secs) seconds = secs end
		function ReturnSunEntity() return sun end

		local sky = ents.FindByClass("env_skypaint")[1]
		function RGB_to_SkyEntityRGB(r,g,b)
			return string.format("%s %s %s",r/255,g/255,b/255)
		end
		if !(ulx) then
			concommand.Add("SingleCycle",function() RunCycle() end)
			concommand.Add("SetSunSize",function(ply,cmd,args,argStr) if!(args[1])then print("This command requires an Argument.")return else sun:SetKeyValue("size",args[1])end end)
			concommand.Add("SetSunColor",function(ply,cmd,args,argStr) if!(args)then print("This command requires three Arguments.")return else sun:SetKeyValue("suncolor",string.format("%s %s %s",args[1],args[2],args[3]))end end)
		end
	end)
end