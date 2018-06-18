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

		local enable,seconds = true,600
		function RunCycle(offset)
			enable = true offset = offset or 0
			local time,indent = math.floor(CurTime()),2/(seconds*2)
			function TransFunc()
				hook.Run("SkyCycle_Timer",Lerp(indent*((CurTime()+offset)-time),1,-1))
				if CurTime()-time < seconds and enable then timer.Simple(0.1,TransFunc) end
			end
			timer.Simple(0.1,TransFunc)
		end
		function EnableCycleTimer(b) enable = b end
		function SetCycleLength(secs) seconds = secs end
		function Percent(a,b) return (a/b)*100 end
		
		local sun,color = ents.FindByClass("env_sun")[1],"249 249 249"
		if !(sun) then ErrorNoHalt("env_sun isn't present in the map.") return end 
		sun:SetKeyValue("size",30)
		sun:SetKeyValue("overlaysize",30)
		local sun_color,moon_color = string.format("%s %s %s",241,240,199),string.format("%s %s %s",242,242,242)
		function SetSunColor(color,hdr)
			sun:SetKeyValue("suncolor",color)
			sun:SetKeyValue("overlaycolor",color)
			sun:SetKeyValue("HDRColorScale",hdr)
		end
		function ReturnSunEntity() return sun end
		hook.Add("SkyCycle_Timer","SkyCycle_SunDir",function(dir)
			sun:SetKeyValue("sun_dir",string.format("%s 0 0",dir))
		end)


		local sky = ents.FindByClass("env_skypaint")[1]
		sky:SetupDataTables()
		if !(sky) then ErrorNoHalt("env_skypaint isn't present in the map") end
		function RGB_to_color_vec(r,g,b)
			return Vector(r/255,g/255,b/255)
		end
		function Night()
			sky:SetTopColor(Vector(0,0,0))
			sky:SetBottomColor(Vector(0,0,0.04))
		end
		--Top Color: 0 0 0
		--Bottom Color: 0 0 0.04
		-- Star Scale: 1.28

		
			
		if !(ulx) then
			concommand.Add("SingleCycle",function() RunCycle() end)
			concommand.Add("SetSunSize",function(ply,cmd,args,argStr) if!(args[1])then print("This command requires an Argument.")return else sun:SetKeyValue("size",args[1])end end)
			concommand.Add("SetSunColor",function(ply,cmd,args,argStr) if!(args)then print("This command requires three Arguments.")return else sun:SetKeyValue("suncolor",string.format("%s %s %s",args[1],args[2],args[3]))end end)
		end
	end)
end