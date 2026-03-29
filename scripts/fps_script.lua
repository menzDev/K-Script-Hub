--[[
    ARSENAL: SUFFERING v14 (JJSPLOIT COMPATIBLE)
    NO usa hookmetamethod, getrawmetatable, ni newcclosure.
    TODO funciona con API basica de Roblox.
]]

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LP:GetMouse()

-- Config
local AimbotOn = true
local ESPOn = true
local FOVRadius = 250
local AimPart = "Head"
local Smoothness = 5

-- ===================== GUI =====================
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

-- Aimbot Toggle
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

-- ESP Toggle
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
    -- Toggle all ESP
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local bb = p.Character:FindFirstChild("ESPBB")
            if bb then bb.Enabled = ESPOn end
        end
    end
end)

-- Aim Part selector
local partBtn = Instance.new("TextButton")
partBtn.Size = UDim2.new(0.9, 0, 0, 45)
partBtn.Position = UDim2.new(0.05, 0, 0, 165)
partBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
partBtn.Text = "AIM PART: Head"
partBtn.TextColor3 = Color3.new(1, 1, 1)
partBtn.Font = Enum.Font.GothamBold
partBtn.TextSize = 14
partBtn.Parent = mainFrame
partBtn.MouseButton1Click:Connect(function()
    if AimPart == "Head" then
        AimPart = "HumanoidRootPart"
    else
        AimPart = "Head"
    end
    partBtn.Text = "AIM PART: " .. AimPart
end)

-- FOV slider info
local fovLabel = Instance.new("TextLabel")
fovLabel.Size = UDim2.new(0.9, 0, 0, 30)
fovLabel.Position = UDim2.new(0.05, 0, 0, 220)
fovLabel.BackgroundTransparency = 1
fovLabel.Text = "FOV: " .. FOVRadius
fovLabel.TextColor3 = Color3.new(1, 1, 1)
fovLabel.Font = Enum.Font.Gotham
fovLabel.TextSize = 13
fovLabel.Parent = mainFrame

local fovUp = Instance.new("TextButton")
fovUp.Size = UDim2.new(0.4, 0, 0, 30)
fovUp.Position = UDim2.new(0.05, 0, 0, 255)
fovUp.Text = "FOV +"; fovUp.BackgroundColor3 = Color3.fromRGB(60, 60, 60); fovUp.TextColor3 = Color3.new(1,1,1)
fovUp.Font = Enum.Font.GothamBold; fovUp.TextSize = 13; fovUp.Parent = mainFrame
fovUp.MouseButton1Click:Connect(function() FOVRadius = FOVRadius + 50; fovLabel.Text = "FOV: " .. FOVRadius end)

local fovDown = Instance.new("TextButton")
fovDown.Size = UDim2.new(0.4, 0, 0, 30)
fovDown.Position = UDim2.new(0.5, 0, 0, 255)
fovDown.Text = "FOV -"; fovDown.BackgroundColor3 = Color3.fromRGB(60, 60, 60); fovDown.TextColor3 = Color3.new(1,1,1)
fovDown.Font = Enum.Font.GothamBold; fovDown.TextSize = 13; fovDown.Parent = mainFrame
fovDown.MouseButton1Click:Connect(function() FOVRadius = math.max(50, FOVRadius - 50); fovLabel.Text = "FOV: " .. FOVRadius end)

-- Status
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
statusLabel.Position = UDim2.new(0.05, 0, 0, 300)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Tecla V = Ocultar | RClick = Aim"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.Font = Enum.Font.Gotham; statusLabel.TextSize = 11
statusLabel.Parent = mainFrame

-- Toggle visibility
UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.V then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- ===================== AIMBOT (CAMERA LOCK) =====================
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
            local goal = CFrame.new(Camera.CFrame.Position, target.Position)
            Camera.CFrame = Camera.CFrame:Lerp(goal, 1 / Smoothness)
        end
    end
end)

-- ===================== ESP (BILLBOARD GUI) =====================
local function addESP(player)
    if player == LP then return end
    local function onChar(char)
        if not char then return end
        local head = char:WaitForChild("Head", 5)
        if not head then return end
        -- Remove old
        local old = char:FindFirstChild("ESPBB")
        if old then old:Destroy() end
        -- Create
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
        name.TextStrokeColor3 = Color3.new(0, 0, 0)
        name.Font = Enum.Font.GothamBold
        name.TextSize = 14

        bb.Enabled = ESPOn
    end
    if player.Character then onChar(player.Character) end
    player.CharacterAdded:Connect(onChar)
end

for _, p in pairs(Players:GetPlayers()) do addESP(p) end
Players.PlayerAdded:Connect(addESP)

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "SUFFERING v14",
    Text = "Aimbot + ESP activos. RClick para apuntar.",
    Duration = 5
})
