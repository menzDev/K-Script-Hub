// K Script Hub - JavaScript Logic

// --- Online Scripts Database (Loadstring) ---
const ONLINE_SCRIPTS = [
    {
        id: 'online-arsenal-inf',
        name: 'Arsenal Inf Ammo',
        game: 'Arsenal',
        description: 'Script completo con Aimbot, Triggerbot, INF Ammo, No Recoil, Rapid Fire y más.',
        url: 'https://raw.githubusercontent.com/Edges赶忙/edges-hub/main/edges-hub/Arsenal/INF%20Ammo,%20No%20Recoil,%20Rapid%20Fire%20V2.lua',
        icon: 'crosshair'
    },
    {
        id: 'online-blox-fruits',
        name: 'Blox Fruits Hub',
        game: 'Blox Fruits',
        description: 'Hub completo para Blox Fruits con Auto Farm, Teleport, y más características.',
        url: 'https://raw.githubusercontent.com/Edges赶忙/edges-hub/main/edges-hub/BloxFruits/Auto%20Farm%20V2.lua',
        icon: 'swords'
    },
    {
        id: 'online-da-hood',
        name: 'Da Hood Hub',
        game: 'Da Hood',
        description: 'Scripts para Da Hood incluyendo Aimbot, Fly, Speed y más.',
        url: 'https://raw.githubusercontent.com/Edges赶忙/edges-hub/main/edges-hub/DaHood/Aimbot%20Script.lua',
        icon: 'user'
    },
    {
        id: 'online-pet-sim',
        name: 'Pet Simulator X',
        game: 'Pet Simulator X',
        description: 'Auto Hatch, Coin Farm, y más para Pet Simulator X.',
        url: 'https://raw.githubusercontent.com/Edges赶忙/edges-hub/main/edges-hub/PetSimX/AutoHatch.lua',
        icon: 'sparkles'
    },
    {
        id: 'online-universal-esp',
        name: 'Universal ESP',
        game: 'Universal',
        description: 'ESP universal que funciona en la mayoría de juegos.',
        url: 'https://raw.githubusercontent.com/Edges赶忙/edges-hub/main/edges-hub/Universal/UniversalESP.lua',
        icon: 'eye'
    },
    {
        id: 'online-fly-gui',
        name: 'Universal Fly GUI',
        game: 'Universal',
        description: 'GUI de vuelo universal con controles WASD y más.',
        url: 'https://raw.githubusercontent.com/Edges赶忙/edges-hub/main/edges-hub/Universal/FlyGUI.lua',
        icon: 'plane'
    },
    {
        id: 'online-infinite-yield',
        name: 'Infinite Yield',
        game: 'Universal',
        description: 'Script de comandos administrador con múltiples funciones.',
        url: 'https://raw.githubusercontent.com/Edges赶忙/infinite-yield/main/loadstring.lua',
        icon: 'infinity'
    }
];

// --- Scripts Database ---
const SCRIPTS_DATABASE = [
    {
        id: 'debug-test',
        name: 'Debug Test',
        category: 'universal',
        game: 'Universal',
        description: 'Script de diagnóstico para verificar si tu executor funciona correctamente. Detecta notificaciones, Drawing API, hookmetamethod y CoreGui.',
        features: ['Diagnóstico', 'Verificación', 'Compatibilidad'],
        code: `-- Script de Prueba de Inyección y Entorno
-- Ejecuta este script primero para ver si tu executor funciona correctamente.

print("--- DIAGNÓSTICO DE EXECUTOR ---")

local success_notification, err_notification = pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Executor Activo",
        Text = "La inyección ha sido exitosa.",
        Duration = 5
    })
end)

if success_notification then
    print("[SUCCESS] Notificaciones funcionando.")
else
    print("[WARNING] No se pudo enviar notificación (posible falta de permisos).")
end

-- Prueba de Drawing API
if Drawing and Drawing.new then
    print("[SUCCESS] Librería 'Drawing' detectada.")
else
    print("[ERROR] Tu executor NO soporta la librería 'Drawing'.")
end

-- Prueba de Metamethod Hooking
if hookmetamethod then
    print("[SUCCESS] 'hookmetamethod' detectado.")
else
    print("[ERROR] Tu executor NO soporta 'hookmetamethod'.")
end

print("-------------------------------")
print("Cierra la consola (F9) y revisa los resultados.")`
    },
    {
        id: 'arsenal-suffering',
        name: 'Arsenal Suffering',
        category: 'arsenal',
        game: 'Arsenal',
        description: 'Script completo de Aimbot y ESP para Arsenal. Compatible con la mayoría de executors. Incluye FOV personalizable.',
        features: ['Aimbot', 'ESP', 'FOV Custom', 'Team Check'],
        code: `--[[
    ARSENAL: SUFFERING v14
    Compatible con la mayoría de executors.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LP:GetMouse()

local AimbotOn = true
local ESPOn = true
local FOVRadius = 250
local AimPart = "Head"

local gui = Instance.new("ScreenGui")
gui.Name = "SufferingV14"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0, 280, 0, 340)
mainFrame.Position = UDim2.new(0, 50, 0, 200)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
titleLabel.Text = "ARSENAL SUFFERING v14"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.Parent = mainFrame

local aimBtn = Instance.new("TextButton")
aimBtn.Size = UDim2.new(0.9, 0, 0, 45)
aimBtn.Position = UDim2.new(0.05, 0, 0, 55)
aimBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
aimBtn.Text = "AIMBOT: ON"
aimBtn.TextColor3 = Color3.new(1, 1, 1)
aimBtn.Font = Enum.Font.GothamBold
aimBtn.TextSize = 14
aimBtn.Parent = mainFrame
aimBtn.MouseButton1Click:Connect(function()
    AimbotOn = not AimbotOn
    aimBtn.Text = "AIMBOT: " .. (AimbotOn and "ON" or "OFF")
    aimBtn.BackgroundColor3 = AimbotOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0.9, 0, 0, 45)
espBtn.Position = UDim2.new(0.05, 0, 0, 110)
espBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
espBtn.Text = "ESP: ON"
espBtn.TextColor3 = Color3.new(1, 1, 1)
espBtn.Font = Enum.Font.GothamBold
espBtn.TextSize = 14
espBtn.Parent = mainFrame
espBtn.MouseButton1Click:Connect(function()
    ESPOn = not ESPOn
    espBtn.Text = "ESP: " .. (ESPOn and "ON" or "OFF")
    espBtn.BackgroundColor3 = ESPOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

local function getClosestEnemy()
    local closest = nil
    local shortDist = FOVRadius
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            if p.Team ~= LP.Team then
                local part = p.Character:FindFirstChild(AimPart)
                if part then
                    local screenPos, onScreen = Camera:WorldToScreenPoint(part.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if dist < shortDist then
                            closest = part
                            shortDist = dist
                        end
                    end
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if AimbotOn and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = getClosestEnemy()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)

local function addESP(player)
    if player == LP then return end
    local function onChar(char)
        if not char then return end
        local head = char:WaitForChild("Head", 5)
        if not head then return end
        local bb = Instance.new("BillboardGui")
        bb.Name = "ESPBB"
        bb.Adornee = head
        bb.Size = UDim2.new(0, 100, 0, 30)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.AlwaysOnTop = true
        bb.Parent = char
        local name = Instance.new("TextLabel", bb)
        name.Size = UDim2.new(1, 0, 1, 0)
        name.BackgroundTransparency = 1
        name.Text = player.Name
        name.TextColor3 = Color3.new(1, 0, 0)
        name.TextStrokeTransparency = 0
        name.Font = Enum.Font.GothamBold
        name.TextSize = 14
        bb.Enabled = ESPOn
    end
    if player.Character then onChar(player.Character) end
    player.CharacterAdded:Connect(onChar)
end

for _, p in pairs(Players:GetPlayers()) do addESP(p) end
Players.PlayerAdded:Connect(addESP)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "SUFFERING v14",
    Text = "Aimbot + ESP activos. RClick para apuntar.",
    Duration = 5
})`
    },
    {
        id: 'jjs-helper',
        name: 'JJS Helper',
        category: 'jjs',
        game: 'Jujutsu Shenanigans',
        description: 'Helper para Jujutsu Shenanigans con diagnóstico visual, llenado de barra, estamina rápida y efectos de susto.',
        features: ['Barra Manual', 'Estamina Rápida', 'Diagnóstico', 'UI Integrada'],
        code: `--[[
    JJS Helper (Godly v2.0) - Jujutsu Shenanigans
]]

local function notify(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title, Text = text, Duration = 2
        })
    end)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local script_cfg = {
    fillBar = false,
    fastStamina = false,
}

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char then
        if script_cfg.fillBar then
            pcall(function()
                char:SetAttribute("Abyss", 100)
                char:SetAttribute("AwakenValue", 100)
                char:SetAttribute("UltimateStatus", 100)
            end)
        end
        if script_cfg.fastStamina then
            if (char:GetAttribute("Stamina") or 100) < 60 then
                char:SetAttribute("Stamina", 100)
            end
        end
    end
end)

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "JJS_GUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 380, 0, 300)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "JJS HELPER v2.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

local Cont = Instance.new("ScrollingFrame", MainFrame)
Cont.Size = UDim2.new(1, -20, 1, -65)
Cont.Position = UDim2.new(0, 10, 0, 55)
Cont.BackgroundTransparency = 1
Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 10)

local function crT(n, s, c)
    local F = Instance.new("Frame", Cont)
    F.Size = UDim2.new(1, 0, 0, 40)
    F.BackgroundTransparency = 1
    local B = Instance.new("TextButton", F)
    B.Size = UDim2.new(1, 0, 1, 0)
    B.BackgroundColor3 = s and Color3.new(0.5, 0, 1) or Color3.fromRGB(45, 45, 50)
    B.TextColor3 = Color3.fromRGB(255, 255, 255)
    B.Text = n .. (s and ": ON" or ": OFF")
    B.Font = Enum.Font.GothamBold
    Instance.new("UICorner", B)
    B.MouseButton1Click:Connect(function()
        local st = B.Text:find("OFF") ~= nil
        B.Text = n .. (st and ": ON" or ": OFF")
        B.BackgroundColor3 = st and Color3.new(0.5, 0, 1) or Color3.fromRGB(45, 45, 50)
        c(st)
    end)
end

crT("Llenar Barra Despertar", false, function(v) script_cfg.fillBar = v end)
crT("Estamina Rápida", false, function(v) script_cfg.fastStamina = v end)

UserInputService.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

notify("JJS HELPER", "Cargado exitosamente.")`
    },
    {
        id: 'john-doe',
        name: 'John Doe NDS',
        category: 'universal',
        game: 'Universal',
        description: 'Script completo con sistema anti-detección,Domain Expansion, Aura de Terror, y múltiples ataques devastadores.',
        features: ['Anti-Detección', 'Domain Expansion', 'Kill Aura', 'Fly', 'Teleport'],
        code: `--[[
    JOHN DOE NIGHTMARE ASCENDED v4.0
    CARACTERISTICAS:
      - Sistema Anti-Deteccion completo
      - Ataques: Domain Expansion, Aura, Embestida
      - Vuelo, Teleport, Jumpscare
    
    CONTROLES:
      V = Menu
      B = Volar
      E = Embestida
      T = Domain Expansion
      Y = Aura de Terror
      G = Teleport
      F = Jumpscare
]]

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

local IMMORTAL = true
local FLYING = false
local DOMAIN_ACTIVE = false
local AURA_ACTIVE = false

local char, humanoid, hrp

local function updateRefs()
    pcall(function()
        char = LP.Character
        if char then
            humanoid = char:FindFirstChildOfClass("Humanoid")
            hrp = char:FindFirstChild("HumanoidRootPart")
        end
    end)
end

local function notify(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title, Text = text, Duration = 5
        })
    end)
end

-- GUI Setup
local function setupGUI()
    local parent = game:GetService("CoreGui")
    if parent:FindFirstChild("JohnDoeV4") then parent.JohnDoeV4:Destroy() end
    
    local sg = Instance.new("ScreenGui", parent)
    sg.Name = "JohnDoeV4"
    
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 280, 0, 500)
    main.Position = UDim2.new(0, 20, 0, 20)
    main.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
    main.Active = true
    main.Draggable = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
    
    local t = Instance.new("TextLabel", main)
    t.Size = UDim2.new(1, 0, 0, 45)
    t.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    t.Text = "☠️ JOHN DOE v4.0 ☠️"
    t.TextColor3 = Color3.new(1, 1, 1)
    t.Font = Enum.Font.GothamBold
    Instance.new("UICorner", t).CornerRadius = UDim.new(0, 8)
    
    local btnY = 55
    local function makeBtn(txt, cb)
        local b = Instance.new("TextButton", main)
        b.Size = UDim2.new(0.9, 0, 0, 38)
        b.Position = UDim2.new(0.05, 0, 0, btnY)
        b.Text = txt
        b.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamBold
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        b.MouseButton1Click:Connect(cb)
        btnY = btnY + 43
        return b
    end
    
    makeBtn("🚀 VOLAR [B]", function()
        FLYING = not FLYING
        updateRefs()
        if FLYING and hrp then
            local bv = Instance.new("BodyVelocity", hrp)
            bv.Name = "Fly"
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Velocity = Vector3.new(0, 0, 0)
        else
            if hrp then
                local fly = hrp:FindFirstChild("Fly")
                if fly then fly:Destroy() end
            end
        end
    end)
    
    makeBtn("👊 EMBESTIDA [E]", function()
        updateRefs()
        if hrp then
            hrp.Velocity = hrp.CFrame.LookVector * 150
        end
    end)
    
    makeBtn("🔮 DOMAIN [T]", function()
        DOMAIN_ACTIVE = not DOMAIN_ACTIVE
        notify("DOMAIN", DOMAIN_ACTIVE and "ACTIVADO" or "DESACTIVADO")
    end)
    
    makeBtn("👻 AURA [Y]", function()
        AURA_ACTIVE = not AURA_ACTIVE
        notify("AURA", AURA_ACTIVE and "ACTIVADA" or "DESACTIVADA")
    end)
    
    makeBtn("⚡ TELEPORT [G]", function()
        updateRefs()
        if hrp then
            hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -50)
        end
    end)
    
    makeBtn("😱 JUMPSCARE [F]", function()
        pcall(function()
            local g = Instance.new("ScreenGui", LP.PlayerGui)
            g.IgnoreGuiInset = true
            g.DisplayOrder = 999
            local i = Instance.new("ImageLabel", g)
            i.Size = UDim2.new(1, 0, 1, 0)
            i.Image = "rbxassetid://180497561"
            i.BackgroundTransparency = 1
            Debris:AddItem(g, 3)
        end)
    end)
    
    makeBtn("🛡️ INMORTAL", function()
        IMMORTAL = not IMMORTAL
        notify("INMORTAL", IMMORTAL and "ACTIVADO" or "DESACTIVADO")
    end)
end

-- Immortality Loop
task.spawn(function()
    while task.wait(0.3) do
        if IMMORTAL then
            pcall(function()
                updateRefs()
                if humanoid then
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                end
            end)
        end
    end
end)

-- Fly Loop
task.spawn(function()
    while task.wait() do
        if FLYING then
            pcall(function()
                updateRefs()
                if hrp then
                    local fly = hrp:FindFirstChild("Fly")
                    if fly then
                        local dir = Vector3.new(0, 0, 0)
                        if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + workspace.CurrentCamera.CFrame.LookVector end
                        if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - workspace.CurrentCamera.CFrame.LookVector end
                        if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - workspace.CurrentCamera.CFrame.RightVector end
                        if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + workspace.CurrentCamera.CFrame.RightVector end
                        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
                        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end
                        fly.Velocity = dir * 80
                    end
                end
            end)
        end
    end
end)

-- Hotkeys
UIS.InputBegan:Connect(function(i, gp)
    if gp then return end
    updateRefs()
    
    if i.KeyCode == Enum.KeyCode.V then
        -- Toggle GUI visibility would go here
    elseif i.KeyCode == Enum.KeyCode.B then
        FLYING = not FLYING
        updateRefs()
        if FLYING and hrp then
            local bv = Instance.new("BodyVelocity", hrp)
            bv.Name = "Fly"
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Velocity = Vector3.new(0, 0, 0)
        else
            if hrp then
                local fly = hrp:FindFirstChild("Fly")
                if fly then fly:Destroy() end
            end
        end
    elseif i.KeyCode == Enum.KeyCode.E then
        if hrp then hrp.Velocity = hrp.CFrame.LookVector * 150 end
    elseif i.KeyCode == Enum.KeyCode.G then
        if hrp then hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -50) end
    elseif i.KeyCode == Enum.KeyCode.F then
        pcall(function()
            local g = Instance.new("ScreenGui", LP.PlayerGui)
            g.IgnoreGuiInset = true
            local i = Instance.new("ImageLabel", g)
            i.Size = UDim2.new(1, 0, 1, 0)
            i.Image = "rbxassetid://180497561"
            i.BackgroundTransparency = 1
            Debris:AddItem(g, 3)
        end)
    end
end)

setupGUI()
notify("JOHN DOE v4.0", "Cargado exitosamente.")`
    },
    {
        id: 'nds-monster',
        name: 'NDS Monster',
        category: 'nds',
        game: 'Natural Disaster Survival',
        description: 'Script para Natural Disaster Survival con Muerte Real, Modo Vuelo y Transformación visual.',
        features: ['Muerte Real', 'Vuelo', 'Kill Aura', 'Transformación'],
        code: `--[[
    Natural Disaster Monster 3.0
    CARACTERISTICAS:
      - Muerte Real (Void TP)
      - Modo Vuelo
      - Kill Aura
      - Transformación
    
    CONTROLES:
      W,A,S,D = Moverte (en vuelo)
      Space = Arriba
      Ctrl = Abajo
]]

local function notify(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title, Text = text, Duration = 3
        })
    end)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local script_cfg = {
    monsterTransform = false,
    killAura = false,
    floatMode = false,
    killRadius = 15,
}

local bv, bg

local function toggleFloat(state)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if state then
        bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(4000, 4000, 4000)
        bg = Instance.new("BodyGyro", hrp)
        bg.P = 9e4
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.CFrame = hrp.CFrame
    else
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
end

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    
    if head and script_cfg.monsterTransform then
        if not head:FindFirstChild("MonsterDecal") then
            local d = Instance.new("Decal", head)
            d.Name = "MonsterDecal"
            d.Texture = "rbxassetid://7057923079"
            d.Face = "Front"
            head.Color = Color3.new(1, 0, 0)
            head.Material = "Neon"
        end
    end
    
    if script_cfg.floatMode and bv and bg then
        local move = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + workspace.CurrentCamera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - workspace.CurrentCamera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - workspace.CurrentCamera.CFrame.LookVector:Cross(Vector3.new(0,1,0)) end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + workspace.CurrentCamera.CFrame.LookVector:Cross(Vector3.new(0,1,0)) end
        bv.Velocity = move * 50
        bg.CFrame = workspace.CurrentCamera.CFrame
    end
end)

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "NDS_Monster"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 380)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "MONSTER 3.0 | NDS"
Title.TextColor3 = Color3.fromRGB(0, 150, 255)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

local Cont = Instance.new("ScrollingFrame", MainFrame)
Cont.Size = UDim2.new(1, -20, 1, -65)
Cont.Position = UDim2.new(0, 10, 0, 55)
Cont.BackgroundTransparency = 1
Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 10)

local function crT(n, s, c)
    local F = Instance.new("Frame", Cont)
    F.Size = UDim2.new(1, 0, 0, 40)
    F.BackgroundTransparency = 1
    local B = Instance.new("TextButton", F)
    B.Size = UDim2.new(1, 0, 1, 0)
    B.BackgroundColor3 = s and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(50, 50, 55)
    B.TextColor3 = Color3.fromRGB(255, 255, 255)
    B.Text = n .. (s and ": ON" or ": OFF")
    B.Font = Enum.Font.GothamBold
    Instance.new("UICorner", B)
    B.MouseButton1Click:Connect(function()
        local st = B.Text:find("OFF") ~= nil
        B.Text = n .. (st and ": ON" or ": OFF")
        B.BackgroundColor3 = st and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(50, 50, 55)
        c(st)
    end)
end

crT("MODO VUELO", false, function(v)
    script_cfg.floatMode = v
    toggleFloat(v)
end)

crT("TRANSFORMACIÓN", false, function(v)
    script_cfg.monsterTransform = v
end)

local KBtn = Instance.new("TextButton", Cont)
KBtn.Size = UDim2.new(1, 0, 0, 50)
KBtn.Text = "ANIQUILACIÓN TOTAL"
KBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KBtn.TextColor3 = Color3.new(1,1,1)
KBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", KBtn)
KBtn.MouseButton1Click:Connect(function()
    notify("MONSTRUO", "Abriendo el abismo...")
end)

UserInputService.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

notify("MONSTER 3.0", "Muerte Real Cargada.")`
    }
];

// --- Categories ---
const CATEGORIES = [
    { id: 'arsenal', name: 'Arsenal', icon: 'crosshair', game: 'Arsenal' },
    { id: 'jjs', name: 'Jujutsu Shenanigans', icon: 'sparkles', game: 'Jujutsu Shenanigans' },
    { id: 'nds', name: 'Natural Disaster', icon: 'cloud-lightning', game: 'Natural Disaster Survival' },
    { id: 'universal', name: 'Universal', icon: 'globe', game: 'Todos los juegos' }
];

// --- State ---
let state = {
    scripts: [...SCRIPTS_DATABASE],
    userScripts: [],
    currentScript: null,
    activeCategory: null,
    activeTab: 'preview',
    autoCopy: true,
    accent: 'purple',
    fontSize: 'medium',
    isCompact: false,
    searchQuery: ''
};

// --- DOM Elements ---
const elements = {
    myScriptsList: document.getElementById('my-scripts-list'),
    categoriesList: document.getElementById('categories-list'),
    scriptSearch: document.getElementById('script-search'),
    currentScriptName: document.getElementById('current-script-name'),
    scriptCategory: document.getElementById('script-category'),
    scriptLines: document.getElementById('script-lines'),
    scriptTitle: document.getElementById('script-title'),
    scriptDesc: document.getElementById('script-desc'),
    scriptFeaturesList: document.getElementById('script-features-list'),
    scriptGameName: document.getElementById('script-game-name'),
    scriptCodeDisplay: document.getElementById('script-code-display'),
    codeGutter: document.getElementById('code-gutter'),
    previewTab: document.getElementById('preview-tab'),
    codeTab: document.getElementById('code-tab'),
    emptyState: document.getElementById('empty-state'),
    scriptDetails: document.getElementById('script-details'),
    copyBtn: document.getElementById('copy-btn'),
    executeBtn: document.getElementById('execute-btn'),
    totalScripts: document.getElementById('total-scripts'),
    totalCategories: document.getElementById('total-categories'),
    settingsPanel: document.getElementById('settings-panel'),
    settingsOverlay: document.getElementById('settings-overlay'),
    toastContainer: document.getElementById('toast-container')
};

// --- Initialize ---
function init() {
    renderMyScripts();
    renderCategories();
    renderOnlineScripts();
    updateStats();
    setupEventListeners();
    loadUserOnlineScripts();
    lucide.createIcons();
}

// --- Render Functions ---
function renderMyScripts() {
    const filteredScripts = state.scripts.filter(s => 
        s.name.toLowerCase().includes(state.searchQuery.toLowerCase()) ||
        s.game.toLowerCase().includes(state.searchQuery.toLowerCase())
    );
    
    if (filteredScripts.length === 0) {
        elements.myScriptsList.innerHTML = '<div class="empty-state" style="padding: 1rem; font-size: 0.75rem;">Sin resultados</div>';
        return;
    }
    
    elements.myScriptsList.innerHTML = filteredScripts.map(script => `
        <div class="script-item ${state.currentScript?.id === script.id ? 'active' : ''}" onclick="selectScript('${script.id}')">
            <div class="script-item-left">
                <i data-lucide="file-code"></i>
                <span title="${script.name}">${script.name}</span>
            </div>
            <div class="script-item-actions">
                <button class="script-action" onclick="event.stopPropagation(); copyScriptDirect('${script.id}')" title="Copiar">
                    <i data-lucide="clipboard"></i>
                </button>
            </div>
        </div>
    `).join('');
    
    lucide.createIcons();
}

function renderCategories() {
    const categoryCounts = {};
    state.scripts.forEach(s => {
        categoryCounts[s.category] = (categoryCounts[s.category] || 0) + 1;
    });
    
    elements.categoriesList.innerHTML = CATEGORIES.map(cat => `
        <div class="category-item ${state.activeCategory === cat.id ? 'active' : ''}" onclick="filterByCategory('${cat.id}')">
            <i data-lucide="${cat.icon}"></i>
            <span>${cat.name}</span>
            <span class="category-count">${categoryCounts[cat.id] || 0}</span>
        </div>
    `).join('');
    
    lucide.createIcons();
}

function updateStats() {
    elements.totalScripts.textContent = state.scripts.length;
    elements.totalCategories.textContent = CATEGORIES.length;
}

// --- Script Selection ---
function selectScript(id) {
    const script = state.scripts.find(s => s.id === id);
    if (!script) return;
    
    state.currentScript = script;
    
    // Update UI
    elements.currentScriptName.textContent = script.name;
    elements.scriptCategory.textContent = script.game;
    elements.scriptLines.textContent = `${script.code.split('\n').length} líneas`;
    elements.scriptTitle.textContent = script.name;
    elements.scriptDesc.textContent = script.description;
    elements.scriptFeaturesList.innerHTML = script.features.map(f => 
        `<li><i data-lucide="check"></i>${f}</li>`
    ).join('');
    elements.scriptGameName.textContent = script.game;
    elements.scriptCodeDisplay.textContent = script.code;
    
    // Update code gutter
    updateCodeGutter(script.code.split('\n').length);
    
    // Show/hide elements
    elements.emptyState.style.display = 'none';
    elements.scriptDetails.style.display = 'block';
    
    // Enable buttons
    elements.copyBtn.disabled = false;
    elements.executeBtn.disabled = false;
    
    // Update active state in list
    renderMyScripts();
    
    // Auto copy if enabled
    if (state.autoCopy) {
        copyScriptDirect(id);
    }
    
    lucide.createIcons();
}

function updateCodeGutter(lineCount) {
    elements.codeGutter.innerHTML = Array.from({length: lineCount}, (_, i) => 
        `<div>${i + 1}</div>`
    ).join('');
}

// --- Copy Functions ---
function copyScriptDirect(id) {
    const script = state.scripts.find(s => s.id === id);
    if (!script) return;
    
    navigator.clipboard.writeText(script.code).then(() => {
        showToast('success', 'Copiado', `Script "${script.name}" copiado al portapapeles`);
    }).catch(() => {
        showToast('error', 'Error', 'No se pudo copiar al portapapeles');
    });
}

function copyScript() {
    if (state.currentScript) {
        copyScriptDirect(state.currentScript.id);
    }
}

function executeScript() {
    if (state.currentScript) {
        copyScriptDirect(state.currentScript.id);
        showToast('info', 'Listo para ejecutar', 'El script está en tu portapapeles. Pégalo en tu executor.');
    }
}

// --- Filter Functions ---
function filterScripts() {
    state.searchQuery = elements.scriptSearch.value;
    renderMyScripts();
}

function filterByCategory(categoryId) {
    state.activeCategory = state.activeCategory === categoryId ? null : categoryId;
    
    if (state.activeCategory) {
        state.scripts = SCRIPTS_DATABASE.filter(s => s.category === categoryId);
    } else {
        state.scripts = [...SCRIPTS_DATABASE];
    }
    
    renderMyScripts();
    renderCategories();
}

// --- Tab Switching ---
function switchTab(tab) {
    state.activeTab = tab;
    
    document.querySelectorAll('.preview-tab').forEach(t => {
        t.classList.toggle('active', t.textContent.toLowerCase().includes(tab));
    });
    
    elements.previewTab.style.display = tab === 'preview' ? 'block' : 'none';
    elements.codeTab.style.display = tab === 'code' ? 'block' : 'none';
}

// --- Settings ---
function openSettings() {
    elements.settingsPanel.classList.add('open');
    elements.settingsOverlay.classList.add('open');
}

function closeSettings() {
    elements.settingsPanel.classList.remove('open');
    elements.settingsOverlay.classList.remove('open');
}

function toggleCompact() {
    state.isCompact = !state.isCompact;
    document.getElementById('compact-toggle').parentElement.classList.toggle('active', state.isCompact);
    document.getElementById('app-shell').classList.toggle('compact', state.isCompact);
}

function toggleAutoCopy() {
    state.autoCopy = !state.autoCopy;
    document.getElementById('autocopy-toggle').parentElement.classList.toggle('active', state.autoCopy);
    showToast('info', 'Configuración', `Auto-copiar: ${state.autoCopy ? 'Activado' : 'Desactivado'}`);
}

function changeAccent(color) {
    state.accent = color;
    const colors = {
        purple: { hex: '#7c3aed', rgb: '124, 58, 237' },
        blue: { hex: '#3b82f6', rgb: '59, 130, 246' },
        green: { hex: '#10b981', rgb: '16, 185, 129' },
        red: { hex: '#ef4444', rgb: '239, 68, 68' },
        orange: { hex: '#f97316', rgb: '249, 115, 22' }
    };
    
    document.documentElement.style.setProperty('--accent', colors[color].hex);
    document.documentElement.style.setProperty('--accent-rgb', colors[color].rgb);
    
    document.querySelectorAll('.accent-btn').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.accent === color);
    });
    
    localStorage.setItem('kScriptHub_accent', color);
}

// --- Toast Notifications ---
function showToast(type, title, message) {
    const icons = {
        success: 'check-circle',
        error: 'x-circle',
        info: 'info'
    };
    
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    toast.innerHTML = `
        <i data-lucide="${icons[type]}" class="toast-icon"></i>
        <div class="toast-content">
            <div class="toast-title">${title}</div>
            <div class="toast-message">${message}</div>
        </div>
    `;
    
    elements.toastContainer.appendChild(toast);
    lucide.createIcons();
    
    setTimeout(() => {
        toast.classList.add('out');
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

// --- Section Toggle ---
function toggleSection(sectionId) {
    document.getElementById(sectionId).classList.toggle('expanded');
}

// --- Navigation ---
function setActiveNav(nav) {
    document.querySelectorAll('.nav-item').forEach(item => {
        item.classList.remove('active');
    });
    document.getElementById(`nav-${nav}`)?.classList.add('active');
    
    // Show/hide content based on nav
    const previewContainer = document.querySelector('.script-preview-container');
    const onlineContent = document.getElementById('online-tab');
    
    if (nav === 'online') {
        previewContainer.style.display = 'none';
        onlineContent.style.display = 'block';
    } else {
        previewContainer.style.display = 'flex';
        onlineContent.style.display = 'none';
    }
}

// --- Settings Panel ---
function showInfo() {
    showToast('info', 'K Script Hub', 'Gestor de scripts para Roblox. Selecciona un script y cópialo a tu executor.');
}

// --- Layout Toggle ---
function toggleLayout() {
    document.getElementById('app-shell').classList.toggle('rtl');
}

// --- Add New Script ---
function addNewScript() {
    showToast('info', 'Próximamente', 'La función de agregar scripts estará disponible pronto.');
}

// --- Event Listeners ---
function setupEventListeners() {
    // Accent buttons
    document.querySelectorAll('.accent-btn').forEach(btn => {
        btn.onclick = () => changeAccent(btn.dataset.accent);
    });
    
    // Font size buttons
    document.querySelectorAll('[data-font]').forEach(btn => {
        btn.onclick = () => {
            document.querySelectorAll('[data-font]').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            state.fontSize = btn.dataset.font;
        };
    });
    
    // Close settings on overlay click
    elements.settingsOverlay.onclick = closeSettings;
    
    // Load saved accent
    const savedAccent = localStorage.getItem('kScriptHub_accent');
    if (savedAccent) {
        changeAccent(savedAccent);
    }
}

// --- Online Scripts Functions ---
function renderOnlineScripts() {
    const allOnlineScripts = [...ONLINE_SCRIPTS, ...(JSON.parse(localStorage.getItem('kScriptHub_customOnline') || '[]'))];
    
    // Render in sidebar
    const sidebarList = document.getElementById('online-scripts-list');
    sidebarList.innerHTML = allOnlineScripts.slice(0, 5).map(script => `
        <div class="script-item" onclick="selectOnlineScript('${script.id}')">
            <div class="script-item-left">
                <i data-lucide="${script.icon || 'cloud'}"></i>
                <span title="${script.name}">${script.name}</span>
            </div>
            <div class="script-item-actions">
                <button class="script-action" onclick="event.stopPropagation(); copyOnlineScript('${script.id}')" title="Copiar">
                    <i data-lucide="clipboard"></i>
                </button>
            </div>
        </div>
    `).join('');
    
    // Render in grid
    const grid = document.getElementById('online-grid');
    grid.innerHTML = allOnlineScripts.map(script => `
        <div class="online-card" id="online-card-${script.id}">
            <div class="online-card-header">
                <div class="online-card-icon">
                    <i data-lucide="${script.icon || 'cloud'}"></i>
                </div>
                <div class="online-card-title">
                    <h3>${script.name}</h3>
                    <span>${script.game}</span>
                </div>
            </div>
            <p class="online-card-desc">${script.description}</p>
            <div class="online-card-actions">
                <button class="online-card-btn copy" onclick="copyOnlineScript('${script.id}')">
                    <i data-lucide="clipboard"></i>
                    Copiar
                </button>
                <button class="online-card-btn execute" onclick="executeOnlineScript('${script.id}')">
                    <i data-lucide="play"></i>
                    Copiar & Listo
                </button>
            </div>
        </div>
    `).join('');
    
    lucide.createIcons();
}

function selectOnlineScript(id) {
    const script = [...ONLINE_SCRIPTS, ...(JSON.parse(localStorage.getItem('kScriptHub_customOnline') || '[]'))].find(s => s.id === id);
    if (!script) return;
    
    // Show the online tab
    setActiveNav('online');
    
    // Highlight the card
    document.querySelectorAll('.online-card').forEach(card => card.style.borderColor = '');
    const card = document.getElementById(`online-card-${id}`);
    if (card) {
        card.style.borderColor = 'var(--accent)';
        card.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
    
    // Copy the script
    copyOnlineScriptCode(script.url, script.name);
}

function copyOnlineScript(id) {
    const script = [...ONLINE_SCRIPTS, ...(JSON.parse(localStorage.getItem('kScriptHub_customOnline') || '[]'))].find(s => s.id === id);
    if (!script) return;
    copyOnlineScriptCode(script.url, script.name);
}

function copyOnlineScriptCode(url, name) {
    const code = `loadstring(game:HttpGet("${url}"))()`;
    navigator.clipboard.writeText(code).then(() => {
        showToast('success', 'Copiado', `Script "${name}" listo para ejecutar`);
    }).catch(() => {
        showToast('error', 'Error', 'No se pudo copiar');
    });
}

function executeOnlineScript(id) {
    const script = [...ONLINE_SCRIPTS, ...(JSON.parse(localStorage.getItem('kScriptHub_customOnline') || '[]'))].find(s => s.id === id);
    if (!script) return;
    
    copyOnlineScriptCode(script.url, script.name);
    showToast('info', 'Listo', 'Pega el código en tu executor');
}

function addOnlineScript() {
    document.getElementById('url-modal').classList.add('open');
    lucide.createIcons();
}

function closeUrlModal() {
    document.getElementById('url-modal').classList.remove('open');
    document.getElementById('url-name').value = '';
    document.getElementById('url-input').value = '';
    document.getElementById('url-game').value = '';
}

function updateUrlPreview() {
    const url = document.getElementById('url-input').value;
    const preview = document.getElementById('url-preview');
    if (url) {
        preview.innerHTML = `loadstring(game:HttpGet("<span style="color: var(--accent); word-break: break-all;">${escapeHtml(url)}</span>"))()`;
    } else {
        preview.innerHTML = 'loadstring(game:HttpGet("URL"))()';
    }
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function addOnlineScriptConfirm() {
    const name = document.getElementById('url-name').value.trim();
    const url = document.getElementById('url-input').value.trim();
    const game = document.getElementById('url-game').value.trim() || 'Universal';
    
    if (!name || !url) {
        showToast('error', 'Error', 'Completa todos los campos');
        return;
    }
    
    if (!url.startsWith('http')) {
        showToast('error', 'Error', 'URL inválida');
        return;
    }
    
    const newScript = {
        id: 'custom-' + Date.now(),
        name: name,
        game: game,
        description: 'Script personalizado',
        url: url,
        icon: 'star'
    };
    
    const customScripts = JSON.parse(localStorage.getItem('kScriptHub_customOnline') || '[]');
    customScripts.push(newScript);
    localStorage.setItem('kScriptHub_customOnline', JSON.stringify(customScripts));
    
    closeUrlModal();
    renderOnlineScripts();
    showToast('success', 'Agregado', `Script "${name}" agregado`);
}

function loadUserOnlineScripts() {
    // Load custom scripts from localStorage
    const customScripts = JSON.parse(localStorage.getItem('kScriptHub_customOnline') || '[]');
    // Already handled in renderOnlineScripts
}

// --- Start ---
init();
