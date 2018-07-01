if SERVER then
	hook.Add("InitPostEntity","SkyCycleInit",function()

		http.Fetch([[https://raw.githubusercontent.com/secretsoldier/SkyCycle/master/version]],function(body)
			if "0.1.1" == body then else
				ErrorNoHalt("SkyCycle is out of date.")
				function TimerFunc()
					for k,v in pairs(player.GetAll()) do
						v:ChatPrint("SkyCycle is out of date, please download the latest version.")
					end
					timer.Simple(1800,TimerFunc)
				end
				timer.Simple(1800,TimerFunc)
			end
		end)

		local IgnoreSinglePlayer = true
		if game.SinglePlayer() then
			if IgnoreSinglePlayer then
				ErrorNoHalt("SkyCycle does not work correctly in SinglePlayer.")
			else
				Error("SkyCycle does not work correctly in SinglePlayer.")
			end
		end

		local cycle_enable,seconds = true,600
		function RunCycle(offset)
			cycle_enable = true offset = offset or 0
			local time,indent = math.floor(CurTime()),2/(seconds*2)
			function TransFunc()
				hook.Run("SkyCycle_Timer",Lerp(indent*((CurTime()+offset)-time),1,-1))
				if CurTime()-time < seconds and cycle_enable then timer.Simple(0.1,TransFunc) end
			end
			timer.Simple(0.1,TransFunc)
		end
		function EnableCycleTimer(b) cycle_enable = b end
		function SetCycleLength(secs) seconds = secs end
		function Percent(a) return 1-((a+1)/2) end

		local time_enable,day = true,true
		local time = 0
		local time_table = 
		{
			{"Sun Rise",6,9,},
			{"Day",9,20,},
			{"Sun Set",20,22,},
			{"Night",22,6,}
		}
		function ReturnTime() return time,day end
		hook.Add("SkyCycle_Timer","SkyCycle_Time",function(per)
			time = math.floor(12*Percent(per))+6
			if !day then time = time + 12 end
			if time > 24 then time = time - 24 end


		end)
		local cyclehopper_enable = true
		hook.Add("SkyCycle_Timer","SkyCycle_CycleHopper",function(per)
			if (per == -1) and cyclehopper_enable then
				day = !day
				RunCycle()
			end
		end)
		function EnableCycleHopper(bool) cyclehopper_enable = bool end
		
		local sun,color = ents.FindByClass("env_sun")[1],"249 249 249"
		if !sun then Error("env_sun isn't present in the map.") return end 
		sun:SetKeyValue("size",30)
		sun:SetKeyValue("overlaysize",30)
		local sun_color,moon_color = string.format("%s %s %s",241,240,199),string.format("%s %s %s",242,242,242)
		function SetSunColor(color)
			sun:SetKeyValue("suncolor",color)
			sun:SetKeyValue("overlaycolor",color)
			--sun:SetKeyValue("HDRColorScale",hdr)
		end
		function SetSunSize(int)
			sun:SetKeyValue("size",int)
			sun:SetKeyValue("overlaysize",int)
		end
		function ReturnSunEntity() return sun end
		hook.Add("SkyCycle_Timer","SkyCycle_SunDir",function(dir)
			sun:SetKeyValue("sun_dir",string.format("%s 0 0",dir))
		end)

		local sky = ents.FindByClass("env_skypaint")[1]
		if !sky then
			sky = ents.Create("env_skypaint")
			if !IsValid(sky) then print("env_skypaint failed to be created.") return end
			sky:Spawn()
			sky:Activate()
		end
		local starfield,clouds = "skybox/starfield","skybox/clouds"
		sky:SetupDataTables()
		sky:SetDrawStars(true)
		if !(sky) then Error("env_skypaint isn't present in the map") end
		function RGB_to_color_vec(r,g,b)
			return Vector(r/255,g/255,b/255)
		end
		function ReturnSkyEntity() return sky end
		--Top Color: 0 0 0
		--Bottom Color: 0 0 0.04
		-- Star Scale: 1.28

		function Day()
			sky:SetTopColor(Vector(0.2,0.5,1.0))
			sky:SetBottomColor(Vector(0.8,1.0,1.0))
			
		end
		function Night()
			sky:SetTopColor(Vector(0,0,0))
			sky:SetBottomColor(Vector(0,0,0.04))
			
		end
		if !ulx then
			concommand.Add("SingleCycle",function() RunCycle() end)
			concommand.Add("SetSunSize",function(ply,cmd,args,argStr) if!(args[1])then print("This command requires an Argument.")return else sun:SetKeyValue("size",args[1])end end)
			concommand.Add("SetSunColor",function(ply,cmd,args,argStr) if!(args)then print("This command requires three Arguments.")return else sun:SetKeyValue("suncolor",string.format("%s %s %s",args[1],args[2],args[3]))end end)
		end
	end)
end