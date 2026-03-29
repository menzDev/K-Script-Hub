local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "K-Script-Hub",
   LoadingTitle = "K-Script-Hub Loading...",
   LoadingSubtitle = "by menzDev",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, 
      FileName = "KScriptHub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", 
      RememberJoins = true 
   },
   KeySystem = false 
})

local NdzTab = Window:CreateTab("Natural Disaster", nil)
local JjsTab = Window:CreateTab("Jujutsu Shenanigans", nil)
local FpsTab = Window:CreateTab("FPS Script", nil)

NdzTab:CreateSection("Scripts de NDS")

NdzTab:CreateButton({
   Name = "Cargar John Doe NDS",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/menzDev/K-Script-Hub/main/scripts/john_doe_nds.lua"))()
   end,
})

NdzTab:CreateButton({
   Name = "Cargar NDS Script (General)",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/menzDev/K-Script-Hub/main/scripts/nds_script.lua"))()
   end,
})


JjsTab:CreateSection("Scripts de JJS")

JjsTab:CreateButton({
   Name = "Cargar JJS Script",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/menzDev/K-Script-Hub/main/scripts/jjs_script.lua"))()
   end,
})


FpsTab:CreateSection("Scripts para Shooters")

FpsTab:CreateButton({
   Name = "Cargar Aimbot/ESP (FPS)",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/menzDev/K-Script-Hub/main/scripts/fps_script.lua"))()
   end,
})

Rayfield:LoadConfiguration()
