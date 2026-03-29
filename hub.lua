local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "K-Script-Hub", HidePremium = false, SaveConfig = false, IntroText = "K-Script-Hub by menzDev"})

local NdzTab = Window:MakeTab({
	Name = "Natural Disaster",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

NdzTab:AddButton({
	Name = "Cargar John Doe NDS",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/menzDev/K-Script-Hub/main/scripts/john_doe_nds.lua"))()
  	end    
})

NdzTab:AddButton({
	Name = "Cargar NDS Script (General)",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/menzDev/K-Script-Hub/main/scripts/nds_script.lua"))()
  	end    
})


local JjsTab = Window:MakeTab({
	Name = "Jujutsu Shenanigans",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

JjsTab:AddButton({
	Name = "Cargar JJS Script",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/menzDev/K-Script-Hub/main/scripts/jjs_script.lua"))()
  	end    
})


local FpsTab = Window:MakeTab({
	Name = "FPS Script",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

FpsTab:AddButton({
	Name = "Cargar Aimbot/ESP (FPS)",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/menzDev/K-Script-Hub/main/scripts/fps_script.lua"))()
  	end    
})

OrionLib:Init()
