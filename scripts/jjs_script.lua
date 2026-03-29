--[[
    JJS Helper (Godly v2.0) - Jujutsu Shenanigans
    Desarrollado para: script blox
    Características: Susto (Diagnosis Mode), Troll Faces, Simple Hacks.
    Novedad: Diagnóstico visual (Fondo Negro) para verificar renderizado.
]]

--// Notificación
local function notify(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title, Text = text, Duration = 2
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
    fillBar = false,
    fastStamina = false,
    trollFaces = false,
}

--// IDs DE PRUEBA (Máxima compatibilidad)
local IMG_FALLBACK = "rbxassetid://16443270146" -- Cara de Terror 1
local SND_FALLBACK = "rbxassetid://4761405021" -- SFX Potente

--// Función SUSTO (Diagnosis v2.0)
local function playJumpscare()
    notify("DIAGNÓSTICO", "Verificando UI...")
    
    local gui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if not gui then notify("ERROR", "No PlayerGui"); return end
    
    local sg = Instance.new("ScreenGui", gui)
    sg.Name = "JJS_Diagnosis_v2"
    sg.DisplayOrder = 9999
    sg.IgnoreGuiInset = true
    
    -- FONDO DE PRUEBA (Si ves esto en negro pero no la cara, el problema es el ID)
    local testBg = Instance.new("Frame", sg)
    testBg.Size = UDim2.new(1.1, 0, 1.1, 0); testBg.Position = UDim2.new(-0.05, 0, -0.05, 0)
    testBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0); testBg.ZIndex = 9998; testBg.Visible = true
    
    local img = Instance.new("ImageLabel", sg)
    img.Size = UDim2.new(1, 0, 1, 0); img.Position = UDim2.new(0, 0, 0, 0)
    img.Image = IMG_FALLBACK; img.BackgroundTransparency = 1; img.ZIndex = 9999
    
    local snd = Instance.new("Sound", game:GetService("SoundService"))
    snd.SoundId = SND_FALLBACK; snd.Volume = 8; snd:Play()
    
    task.delay(5, function() sg:Destroy(); snd:Destroy() end)
end

--// Bucle v2.0
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char then
        -- 1. Barra Manual
        if script_cfg.fillBar then
            pcall(function()
                char:SetAttribute("Abyss", 100); char:SetAttribute("AwakenValue", 100); char:SetAttribute("UltimateStatus", 100)
                LocalPlayer:SetAttribute("Abyss", 100)
            end)
        end
        -- 2. Estamina (Recarga 60%)
        if script_cfg.fastStamina then
            if (char:GetAttribute("Stamina") or 100) < 60 then char:SetAttribute("Stamina", 100) end
        end
    end
end)

--// UI v2.0
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "JJS_Diagnostic_GUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 380, 0, 300); MainFrame.Position = UDim2.new(0.5, -190, 0.5, -150); MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Text = "JJS DIAGNOSTIC v2.0"; Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.Font = Enum.Font.GothamBold; Title.BackgroundTransparency = 1

-- Dragging
do local d, s, p, iM Title.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true s = i.Position p = MainFrame.Position end end) UserInputService.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement then iM = i end end) RunService.RenderStepped:Connect(function() if d and iM then local del = iM.Position - s MainFrame.Position = UDim2.new(p.X.Scale, p.X.Offset + del.X, p.Y.Scale, p.Y.Offset + del.Y) end end) UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end) end

local Cont = Instance.new("ScrollingFrame", MainFrame)
Cont.Size = UDim2.new(1, -20, 1, -65); Cont.Position = UDim2.new(0, 10, 0, 55); Cont.BackgroundTransparency = 1; Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 10)

-- Botón SUSTO
local SBtn = Instance.new("TextButton", Cont)
SBtn.Size = UDim2.new(1, 0, 0, 45); SBtn.Text = "TEST SUSTO (VER FONDO NEGRO)"; SBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0); SBtn.TextColor3 = Color3.new(1,1,1); SBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", SBtn)
SBtn.MouseButton1Click:Connect(playJumpscare)

local function crT(n, s, c)
    local F = Instance.new("Frame", Cont); F.Size = UDim2.new(1, 0, 0, 40); F.BackgroundTransparency = 1
    local B = Instance.new("TextButton", F); B.Size = UDim2.new(1, 0, 1, 0); B.BackgroundColor3 = s and Color3.new(0.5, 0, 1) or Color3.fromRGB(45, 45, 50); B.TextColor3 = Color3.fromRGB(255, 255, 255); B.Text = n .. (s and ": ON" or ": OFF"); B.Font = Enum.Font.GothamBold; Instance.new("UICorner", B)
    B.MouseButton1Click:Connect(function() 
        local st = B.Text:find("OFF") ~= nil; B.Text = n .. (st and ": ON" or ": OFF"); B.BackgroundColor3 = st and Color3.new(0.5, 0, 1) or Color3.fromRGB(45, 45, 50); c(st)
    end)
end

crT("Llenar Barra Despertar", false, function(v) script_cfg.fillBar = v end)
crT("Estamina Rápida", false, function(v) script_cfg.fastStamina = v end)

-- Key INSERT
UserInputService.InputBegan:Connect(function(i, g) if not g and i.KeyCode == Enum.KeyCode.Insert then MainFrame.Visible = not MainFrame.Visible end end)

notify("DIAGNOSTIC v2.0", "Iniciando prueba de renderizado.")
print("[SYSTEM] JJS Diagnostic v2.0 Loaded.")
