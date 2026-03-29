--[[
    Natural Disaster Monster 3.0 (v1.2)
    Desarrollado para: script blox
    Características: MUERTE REAL (Void TP), FLOAT MODE (Vuelo), No Self-Explode.
    Especial: Los enemigos mueren al instante bajo el mapa.
]]

--// Notificación
local function notify(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title, Text = text, Duration = 3
        })
    end)
end

--// Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

--// Configuración
local script_cfg = {
    monsterTransform = false,
    killAura = false,
    floatMode = false,
    killRadius = 15,
}

local scaryImg = "rbxassetid://7057923079"

--// Muerte Real (ENVIAR AL VACÍO)
local function killReal(player)
    if player == LocalPlayer or not player.Character then return end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local pos = hrp.Position
        -- 1. Crear explosión en su sitio (Sin dañar al local si está lejos)
        local e = Instance.new("Explosion", workspace)
        e.Position = pos; e.BlastRadius = 5; e.BlastPressure = 100
        
        -- 2. ENVIAR AL VACÍO (Muerte Instantánea en NDS)
        hrp.CFrame = CFrame.new(0, -1000, 0)
    end
end

--// Sistema de Vuelo (Float)
local bv, bg
local function toggleFloat(state)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if state then
        bv = Instance.new("BodyVelocity", hrp); bv.Velocity = Vector3.new(0, 0, 0); bv.MaxForce = Vector3.new(4000, 4000, 4000)
        bg = Instance.new("BodyGyro", hrp); bg.P = 9e4; bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9); bg.CFrame = hrp.CFrame
    else
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
end

--// Loop JJS v1.2
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    
    -- 1. Transformación
    local head = char:FindFirstChild("Head")
    if head and script_cfg.monsterTransform then
        if not head:FindFirstChild("MonsterDecal") then
            local d = Instance.new("Decal", head); d.Name = "MonsterDecal"; d.Texture = scaryImg; d.Face = "Front"
            head.Color = Color3.new(1, 0, 0); head.Material = "Neon"
        end
    end
    
    -- 2. Kill Aura (Muerte Real)
    if script_cfg.killAura then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (v.Character.HumanoidRootPart.Position - char.Head.Position).Magnitude
                if dist < script_cfg.killRadius then
                    killReal(v)
                end
            end
        end
    end
    
    -- 3. Control de Vuelo
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

--// UI v1.2 (Float Edition)
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "NDS_Monster_v12"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 380); MainFrame.Position = UDim2.new(0.5, -200, 0.5, -190); MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25); Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Text = "MONSTER 3.0 | NDS"; Title.TextColor3 = Color3.fromRGB(0, 150, 255); Title.Font = Enum.Font.GothamBold; Title.BackgroundTransparency = 1

-- Dragging
do local d, s, p, iM Title.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true s = i.Position p = MainFrame.Position end end) UserInputService.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement then iM = i end end) RunService.RenderStepped:Connect(function() if d and iM then local del = iM.Position - s MainFrame.Position = UDim2.new(p.X.Scale, p.X.Offset + del.X, p.Y.Scale, p.Y.Offset + del.Y) end end) UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end) end

local Cont = Instance.new("ScrollingFrame", MainFrame)
Cont.Size = UDim2.new(1, -20, 1, -65); Cont.Position = UDim2.new(0, 10, 0, 55); Cont.BackgroundTransparency = 1; Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 10)

local function crT(n, s, c)
    local F = Instance.new("Frame", Cont); F.Size = UDim2.new(1, 0, 0, 40); F.BackgroundTransparency = 1
    local B = Instance.new("TextButton", F); B.Size = UDim2.new(1, 0, 1, 0); B.BackgroundColor3 = s and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(50, 50, 55); B.TextColor3 = Color3.fromRGB(255, 255, 255); B.Text = n .. (s and ": ON" or ": OFF"); B.Font = Enum.Font.GothamBold; Instance.new("UICorner", B)
    B.MouseButton1Click:Connect(function() 
        local st = B.Text:find("OFF") ~= nil; B.Text = n .. (st and ": ON" or ": OFF"); B.BackgroundColor3 = st and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(50, 50, 55); c(st)
    end)
end

crT("MODO VUELO (Float)", false, function(v) script_cfg.floatMode = v; toggleFloat(v) end)
crT("AURA DE MUERTE REAL", false, function(v) script_cfg.killAura = v end)
crT("TRANSFORMACIÓN (Eyes)", false, function(v) script_cfg.monsterTransform = v end)

local KBtn = Instance.new("TextButton", Cont)
KBtn.Size = UDim2.new(1, 0, 0, 50); KBtn.Text = "ANIQUILACIÓN TOTAL (VOID)"; KBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); KBtn.TextColor3 = Color3.new(1,1,1); KBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", KBtn)
KBtn.MouseButton1Click:Connect(function()
    notify("MONSTRUO", "Abriendo el abismo...")
    for _, v in pairs(Players:GetPlayers()) do if v ~= LocalPlayer then killReal(v); task.wait(0.1) end end
end)

-- INSERT
UserInputService.InputBegan:Connect(function(i, g) if not g and i.KeyCode == Enum.KeyCode.Insert then MainFrame.Visible = not MainFrame.Visible end end)

notify("MONSTER 3.0", "Muerte Real Cargada.")
print("[SYSTEM] NDS Monster 3.0 Fixed.")
