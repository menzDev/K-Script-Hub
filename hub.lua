-- K-Script-Hub Raw UI Version (Super Compatible)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local existingHub = CoreGui:FindFirstChild("KScriptHub")
if existingHub then
    existingHub:Destroy()
end

local KScriptHub = Instance.new("ScreenGui")
KScriptHub.Name = "KScriptHub"
KScriptHub.Parent = CoreGui
KScriptHub.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = KScriptHub
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BorderSizePixel = 0

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 10)
TopBarCorner.Parent = TopBar

local TopBarFix = Instance.new("Frame")
TopBarFix.Parent = TopBar
TopBarFix.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TopBarFix.Position = UDim2.new(0, 0, 1, -10)
TopBarFix.Size = UDim2.new(1, 0, 0, 10)
TopBarFix.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "K-Script-Hub | Universal Version"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.Size = UDim2.new(0, 40, 1, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextSize = 18
CloseBtn.MouseButton1Click:Connect(function()
    KScriptHub:Destroy()
end)

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = MainFrame
ScrollFrame.Active = true
ScrollFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollFrame.Size = UDim2.new(1, -20, 1, -60)
ScrollFrame.ScrollBarThickness = 5

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local UIPadding = Instance.new("UIPadding")
UIPadding.Parent = ScrollFrame
UIPadding.PaddingTop = UDim.new(0, 5)

local function CreateButton(text, url)
    local Btn = Instance.new("TextButton")
    Btn.Parent = ScrollFrame
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Btn.Size = UDim2.new(1, -10, 0, 40)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 14
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function()
        local success, result = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Error loading K-Script-Hub script: " .. tostring(result))
            Btn.Text = "Error ❌"
            task.wait(2)
            Btn.Text = text
        else
            Btn.Text = "Cargado ✅"
            task.wait(1)
            Btn.Text = text
        end
    end)
    return Btn
end

CreateButton("Cargar John Doe NDS", "https://raw.githubusercontent.com/menzDev/K-Script-Hub/main/scripts/john_doe_nds.lua")
CreateButton("Cargar NDS Script (General)", "https://raw.githubusercontent.com/menzDev/K-Script-Hub/main/scripts/nds_script.lua")
CreateButton("Cargar JJS Script", "https://raw.githubusercontent.com/menzDev/K-Script-Hub/main/scripts/jjs_script.lua")
CreateButton("Cargar Aimbot/ESP (FPS)", "https://raw.githubusercontent.com/menzDev/K-Script-Hub/main/scripts/fps_script.lua")

ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)
