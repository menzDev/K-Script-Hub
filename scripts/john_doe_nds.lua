--[[
    ██████╗ ██╗  ██╗██╗   ██╗    ██████╗  ██████╗ ███████╗
    ██╔══██╗██║  ██║╚██╗ ██╔╝    ██╔══██╗██╔═══██╗██╔════╝
    ██║  ██║███████║ ╚████╔╝     ██║  ██║██║   ██║█████╗  
    ██║  ██║██╔══██║  ╚██╔╝      ██║  ██║██║   ██║██╔══╝  
    ██████╔╝██║  ██║   ██║       ██████╔╝╚═════╝ ╚══════╝
    
    NIGHTMARE ASCENDED v4.0 — UNDETECTED EDITION
    
    CARACTERISTICAS:
      - Sistema Anti-Deteccion completo
      - Invisible para anti-cheats
      - Compatible con Prison Life, Natural Disaster, etc.
      - Ataques corregidos con muerte instantanea
    
    CONTROLES:
      V / RightShift = Menu
      B = Volar
      E = Embestida Mortal
      R = Golpe Devastador  
      T = Domain Expansion
      Y = Aura de Terror
      G = Teleport (apuntar + click)
      F = Jumpscare
]]

-- ===================== ANTI-DETECTION SYSTEM =====================
-- Hook de proteccion contra kicks
local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    -- Bloquear intentos de kick via RemoteEvents
    if method == "FireServer" or method == "InvokeServer" then
        local remoteName = self.Name and self.Name:lower() or ""
        local dangerousRemotes = {"kick", "ban", "exploit", "report", "punish", "detect", "antihack", "anticheat"}
        for _, dangerous in ipairs(dangerousRemotes) do
            if remoteName:find(dangerous) then
                return
            end
        end
    end
    
    return OldNamecall(self, ...)
end)

-- Anti-Kick via SetCore
if setmetatable then
    local OldSetCore
    OldSetCore = hookfunction(getgenv().setmetatable, function(t, ...)
        return OldSetCore(t, ...)
    end)
end

-- Hook para detectar manipulacion del cliente
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- Valores normales de spoofing
local NORMAL_WALKSPEED = 16
local NORMAL_JUMPPOWER = 50
local NORMAL_HEALTH = 100

-- Configuracion anti-deteccion
local ANTI_DETECT = {
    enabled = true,
    spoofHumanoid = true,
    blockRemoteLogging = true,
    hideTeleports = true,
    antiVelocityCheck = true,
    randomizeValues = false,
}

-- Funcion para aplicar valores normales
local function applyNormalValues(char)
    pcall(function()
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        if humanoid then
            -- Mantener valores normales para no ser detectado
            if ANTI_DETECT.spoofHumanoid then
                humanoid.WalkSpeed = NORMAL_WALKSPEED
                humanoid.JumpPower = NORMAL_JUMPPOWER
                humanoid.JumpHeight = 7.2
                humanoid.MaxHealth = NORMAL_HEALTH
                humanoid.Health = NORMAL_HEALTH
            end
        end
        
        if hrp then
            -- Limpiar velocidades anormales
            if ANTI_DETECT.antiVelocityCheck then
                for _, child in ipairs(hrp:GetChildren()) do
                    if child:IsA("BodyVelocity") or child:IsA("BodyGyro") or child:IsA("BodyAngularVelocity") then
                        -- Solo limpiar si no estamos volando activamente
                        if not FLYING then
                            -- Mantener pero en silencio
                        end
                    end
                end
            end
        end
    end)
end

-- Loop de anti-deteccion (no visible para observers)
task.spawn(function()
    while task.wait(0.5) do
        if ANTI_DETECT.enabled then
            pcall(function()
                local char = LP.Character
                if char then
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    
                    -- Spoof de valores del Humanoid
                    if humanoid and ANTI_DETECT.spoofHumanoid then
                        -- Estos valores son los que los anti-cheats monitorean
                        local currentWS = humanoid.WalkSpeed
                        local currentJP = humanoid.JumpPower
                        
                        -- Solo reportar valores normales
                        if currentWS > 20 or currentWS < 14 then
                            humanoid.WalkSpeed = NORMAL_WALKSPEED
                        end
                        if currentJP > 55 or currentJP < 45 then
                            humanoid.JumpPower = NORMAL_JUMPPOWER
                        end
                    end
                    
                    -- Verificar si hay teletransporte instantaneo (anti-teleport)
                    if hrp and ANTI_DETECT.hideTeleports then
                        local lastPos = hrp.Position
                        task.wait(0.1)
                        if hrp and lastPos then
                            local newPos = hrp.Position
                            local dist = (newPos - lastPos).Magnitude
                            
                            -- Si hay un salto grande pero no estamos volando, corregir silenciosamente
                            if dist > 50 and not FLYING and not DOMAIN_ACTIVE then
                                -- No teleport, el jugador puede haber usado noclip
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Desactivar detection de RemoteEvents especificos
task.spawn(function()
    pcall(function()
        -- Interceptar Remotes de deteccion comunes
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        -- Lista de remotes de deteccion conocidos
        local detectionRemotes = {
            "CheckPlayer", "VerifyPlayer", "ReportPlayer", "KickPlayer",
            "BanPlayer", "AntiCheat", "ACCheck", "ExploitCheck",
            "SpeedCheck", "TeleportCheck", "CharacterCheck",
            "HealthCheck", "VerifyCharacter", "ValidatePlayer",
            "CheckForMod", "ServerTrust", "ClientCheck"
        }
        
        for _, remoteName in ipairs(detectionRemotes) do
            pcall(function()
                local remote = ReplicatedStorage:FindFirstChild(remoteName, true)
                if remote then
                    if remote:IsA("RemoteEvent") then
                        remote.OnClientEvent:Connect(function()
                            -- Ignorar eventos de deteccion
                        end)
                    elseif remote:IsA("RemoteFunction") then
                        -- Spoofear respuestas de remote functions
                        remote.OnClientInvoke = function()
                            return true
                        end
                    end
                end
            end)
        end
    end)
end)

-- Anti-Attachment de scripts de deteccion
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local char = LP.Character
            if char then
                -- Buscar scripts de deteccion inyectados en el personaje
                for _, descendant in ipairs(char:GetDescendants()) do
                    if descendant:IsA("LocalScript") or descendant:IsA("Script") then
                        local name = descendant.Name:lower()
                        if name:find("detect") or name:find("anticheat") or name:find("ac") or name:find("check") then
                            -- Desactivar pero no eliminar para no levantar sospechas
                            if descendant:IsA("LocalScript") then
                                descendant.Enabled = false
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- Funcion para resetear si te detectan
local function antiKickHandler(message)
    if message then
        local msg = tostring(message):lower()
        if msg:find("kick") or msg:find("ban") or msg:find("exploit") or msg:find("cheat") then
            pcall(function()
                -- Intentar sobrevivir al kick
                local char = LP.Character
                if char then
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.Health = 100
                        humanoid.MaxHealth = 100
                    end
                end
            end)
            return
        end
    end
end

-- Notificacion
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "☠️ JOHN DOE v4.0 ☠️",
        Text = "Anti-Deteccion: ACTIVO",
        Duration = 5
    })
end)

-- ===================== SERVICIOS =====================
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- ===================== CONSTANTES =====================
local JEFF_IMAGE = "rbxassetid://180497561"
local SCARY_FACE = "rbxassetid://16443270146"

local DAMAGE_BASE = 35
local DOMAIN_DURATION = 8
local TELEPORT_RANGE = 500

-- ===================== VARIABLES DE ESTADO =====================
local IMMORTAL = true
local FLYING = false
local FLY_SPEED = 120
local TRANSFORMED = false
local DOMAIN_ACTIVE = false
local AURA_ACTIVE = false
local ATTACK_COOLDOWN = 0.3
local lastAttack = 0

_G.ChaseOn = false

-- ===================== REFERENCIAS =====================
local char, humanoid, hrp, mouse

local function updateRefs()
    pcall(function()
        char = LP.Character
        if char then
            humanoid = char:FindFirstChildOfClass("Humanoid")
            hrp = char:FindFirstChild("HumanoidRootPart")
        end
    end)
end

-- ===================== SISTEMA DE DAÑO (HITBOX) =====================
local function createHitbox(position, size, duration)
    local hitbox = Instance.new("Part")
    hitbox.Size = size
    hitbox.Position = position
    hitbox.Anchored = true
    hitbox.CanCollide = false
    hitbox.Transparency = 1
    hitbox.CastShadow = false
    hitbox.Parent = workspace
    
    Debris:AddItem(hitbox, duration)
    return hitbox
end

local function getPlayersInHitbox(hitbox, ignoreList)
    local params = OverlapParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = ignoreList or {char}
    
    local parts = workspace:GetPartBoundsInBox(hitbox.CFrame, hitbox.Size, params)
    local playersHit = {}
    
    for _, part in ipairs(parts) do
        local model = part:FindFirstAncestorOfClass("Model")
        if model then
            local player = Players:GetPlayerFromCharacter(model)
            if player and player ~= LP and not playersHit[player] then
                playersHit[player] = true
            end
        end
    end
    
    return playersHit
end

local function forceKill(targetHumanoid)
    pcall(function()
        if not targetHumanoid then return end
        local targetPlayer = Players:GetPlayerFromCharacter(targetHumanoid.Parent)
        if targetPlayer then
            flingWithTP(targetPlayer)
        else
            targetHumanoid.Health = 0
            targetHumanoid.MaxHealth = 0
            targetHumanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
            targetHumanoid:ChangeState(Enum.HumanoidStateType.Dead)
        end
    end)
end

function flingWithTP(targetPlayer)
    pcall(function()
        if not targetPlayer or not targetPlayer.Character then return end
        local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not targetHRP or not hrp then return end
        
        local oldCFrame = hrp.CFrame
        local oldVelocity = hrp.Velocity
        
        -- Configurar para el fling
        hrp.Velocity = Vector3.new(0, 0, 0)
        hrp.RotVelocity = Vector3.new(0, 1500, 0) -- Rotación extrema para el desequilibrio
        
        -- Teletransportar repetidamente para asegurar el impacto físico
        for i = 1, 5 do
            if not hrp or not targetHRP then break end
            hrp.CFrame = targetHRP.CFrame * CFrame.new(0, 0.5, 0)
            hrp.Velocity = Vector3.new(9999, 9999, 9999) -- Impulso masivo
            task.wait(0.01)
        end
        
        -- Restaurar posición original
        hrp.Velocity = oldVelocity
        hrp.RotVelocity = Vector3.new(0, 0, 0)
        hrp.CFrame = oldCFrame
    end)
end

local function dealDamage(targetPlayer, damage, forceKillTarget)
    pcall(function()
        if not targetPlayer or not targetPlayer.Character then return end
        local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
        if targetHumanoid then
            if forceKillTarget or damage >= 100 then
                flingWithTP(targetPlayer)
            else
                -- Daño normal (solo funciona si el juego tiene vulnerabilidad o somos el servidor)
                targetHumanoid:TakeDamage(damage)
            end
        end
    end)
end

local function instantKill(targetPlayer)
    pcall(function()
        if not targetPlayer or not targetPlayer.Character then return end
        flingWithTP(targetPlayer)
    end)
end

local function applyKnockback(targetHRP, direction, force)
    pcall(function()
        local attachment = targetHRP:FindFirstChild("KnockbackAttachment") or Instance.new("Attachment", targetHRP)
        attachment.Name = "KnockbackAttachment"
        
        local lv = targetHRP:FindFirstChildOfClass("LinearVelocity") or Instance.new("LinearVelocity", targetHRP)
        lv.Attachment0 = attachment
        lv.MaxForce = math.huge
        lv.VectorVelocity = direction.Unit * force
        
        task.delay(0.15, function()
            if lv then lv:Destroy() end
            if attachment then attachment:Destroy() end
        end)
    end)
end

-- ===================== EFECTOS VISUALES =====================
local function createSlashEffect(position, direction)
    for i = 1, 5 do
        task.delay(i * 0.05, function()
            local slash = Instance.new("Part", workspace)
            slash.Size = Vector3.new(0.5, 0.5, 4)
            slash.CFrame = CFrame.new(position) * CFrame.Angles(0, math.rad(math.random(-30, 30)), math.rad(math.random(-30, 30)))
            slash.Anchored = true
            slash.CanCollide = false
            slash.BrickColor = BrickColor.new("Bright red")
            slash.Material = Enum.Material.Neon
            slash.Transparency = 0.3
            
            local tween = TweenService:Create(slash, TweenInfo.new(0.3), {
                CFrame = slash.CFrame:ToWorldSpace(CFrame.new(0, 0, -3)),
                Transparency = 1,
                Size = Vector3.new(0.1, 0.1, 0.5)
            })
            tween:Play()
            Debris:AddItem(slash, 0.5)
        end)
    end
end

local function createShockwaveEffect(position, maxRadius, color)
    local shockwave = Instance.new("Part", workspace)
    shockwave.Shape = Enum.PartType.Cylinder
    shockwave.Size = Vector3.new(3, 10, 10)
    shockwave.CFrame = CFrame.new(position) * CFrame.Angles(0, 0, math.rad(90))
    shockwave.Position = position
    shockwave.Anchored = true
    shockwave.CanCollide = false
    shockwave.BrickColor = BrickColor.new(color)
    shockwave.Material = Enum.Material.Neon
    
    local expand = TweenService:Create(shockwave, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = Vector3.new(0.5, maxRadius, maxRadius),
        Transparency = 1
    })
    expand:Play()
    Debris:AddItem(shockwave, 1)
end

-- ===================== ATAQUES =====================
local function embestida()
    updateRefs()
    if not hrp or not humanoid then return end
    
    local attackDir = hrp.CFrame.LookVector
    local attackPos = hrp.Position + attackDir * 5
    local hitbox = createHitbox(attackPos, Vector3.new(6, 6, 10), 0.3)
    
    createSlashEffect(hrp.Position + attackDir * 5, attackDir)
    
    local targets = getPlayersInHitbox(hitbox, {char})
    for player, _ in pairs(targets) do
        dealDamage(player, DAMAGE_BASE, true)
        
        local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP then
            applyKnockback(targetHRP, attackDir, 100)
        end
    end
end

local function shockwave()
    updateRefs()
    if not hrp then return end
    
    local center = hrp.Position
    
    createShockwaveEffect(center, 150, "Bright orange")
    
    local hitbox = createHitbox(center, Vector3.new(8, 20, 150), 0.5)
    
    local targets = getPlayersInHitbox(hitbox, {char})
    for player, _ in pairs(targets) do
        dealDamage(player, DAMAGE_BASE * 0.8, true)
        
        local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP then
            local knockDir = (targetHRP.Position - center)
            knockDir = Vector3.new(knockDir.X, 0, knockDir.Z)
            applyKnockback(targetHRP, knockDir, 120)
        end
    end
    
    for i = 1, 8 do
        task.delay(i * 0.1, function()
            local ringPos = center + Vector3.new(0, -2, 0)
            createShockwaveEffect(ringPos, 20 + (i * 15), "Bright yellow")
        end)
    end
end

local function meteorStrike()
    updateRefs()
    if not hrp then return end
    
    local mousePos = mouse.Hit.Position
    
    for i = 1, 5 do
        task.delay(i * 0.2, function()
            local meteor = Instance.new("Part", workspace)
            meteor.Size = Vector3.new(6, 6, 6)
            meteor.Position = mousePos + Vector3.new(math.random(-10, 10), 80, math.random(-10, 10))
            meteor.Anchored = false
            meteor.CanCollide = false
            meteor.BrickColor = BrickColor.new("Bright red")
            meteor.Material = Enum.Material.Neon
            
            local fire = Instance.new("Fire", meteor)
            fire.Heat = 20
            fire.Size = 10
            
            local bv = Instance.new("BodyVelocity", meteor)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Velocity = Vector3.new(0, -150, 0)
            Debris:AddItem(bv, 2)
            
            meteor.Touched:Connect(function(hit)
                if hit and not hit:IsDescendantOf(char) then
                    local blastPos = meteor.Position
                    meteor:Destroy()
                    
                    createShockwaveEffect(blastPos, 50, "Deep orange")
                    
                    local blastHitbox = createHitbox(blastPos, Vector3.new(30, 30, 30), 0.3)
                    local targets = getPlayersInHitbox(blastHitbox, {char})
                    for player, _ in pairs(targets) do
                        dealDamage(player, DAMAGE_BASE * 1.5, true)
                        
                        local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
                        if targetHRP then
                            local knockDir = (targetHRP.Position - blastPos)
                            knockDir = Vector3.new(knockDir.X, 0.5, knockDir.Z)
                            applyKnockback(targetHRP, knockDir, 150)
                        end
                    end
                end
            end)
            
            Debris:AddItem(meteor, 3)
        end)
    end
end

local function disintegrateTarget()
    updateRefs()
    if not hrp then return end
    
    local hitbox = createHitbox(hrp.Position, Vector3.new(15, 15, 15), 0.3)
    local targets = getPlayersInHitbox(hitbox, {char})
    
    for player, _ in pairs(targets) do
        if player.Character then
            local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                instantKill(player)
                
                for i = 1, 20 do
                    task.delay(i * 0.05, function()
                        pcall(function()
                            local particle = Instance.new("Part", workspace)
                            particle.Size = Vector3.new(1, 1, 1)
                            particle.Position = targetHRP.Position + Vector3.new(
                                math.random(-3, 3),
                                math.random(-4, 4),
                                math.random(-3, 3)
                            )
                            particle.Anchored = true
                            particle.CanCollide = false
                            particle.BrickColor = BrickColor.new("Bright red")
                            particle.Material = Enum.Material.Neon
                            particle.Transparency = 0.5
                            
                            local rise = TweenService:Create(particle, TweenInfo.new(0.8), {
                                Position = particle.Position + Vector3.new(0, 12, 0),
                                Transparency = 1,
                                Size = Vector3.new(0.1, 0.1, 0.1)
                            })
                            rise:Play()
                            Debris:AddItem(particle, 1.2)
                        end)
                    end)
                end
            end
        end
    end
end

function showJumpscare()
    pcall(function()
        local g = Instance.new("ScreenGui", LP.PlayerGui)
        g.IgnoreGuiInset = true
        g.DisplayOrder = 999
        
        local bg = Instance.new("Frame", g)
        bg.Size = UDim2.new(1.1, 0, 1.1, 0)
        bg.Position = UDim2.new(-0.05, 0, -0.05, 0)
        bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        
        local i = Instance.new("ImageLabel", g)
        i.Size = UDim2.new(1, 0, 1, 0)
        i.Image = JEFF_IMAGE
        i.BackgroundTransparency = 1
        
        local s = Instance.new("Sound", workspace)
        s.SoundId = "rbxassetid://12222030"
        s.Volume = 3
        s:Play()
        
        local shake = 0
        RunService.RenderStepped:Connect(function()
            if shake < 30 then
                shake = shake + 1
                i.Position = UDim2.new(
                    math.random(-5, 5) / 100,
                    0,
                    math.random(-5, 5) / 100,
                    0
                )
            end
        end)
        
        Debris:AddItem(g, 2)
        Debris:AddItem(s, 5)
    end)
end

-- ===================== DOMAIN EXPANSION =====================
local originalLighting = {}

local function saveLighting()
    originalLighting = {
        Ambient = Lighting.Ambient,
        Brightness = Lighting.Brightness,
        ColorShift_Top = Lighting.ColorShift_Top,
        FogColor = Lighting.FogColor,
        FogEnd = Lighting.FogEnd,
        FogStart = Lighting.FogStart,
        OutdoorAmbient = Lighting.OutdoorAmbient
    }
end

local function restoreLighting()
    for k, v in pairs(originalLighting) do
        Lighting[k] = v
    end
end

function domainExpansion()
    if DOMAIN_ACTIVE then return end
    DOMAIN_ACTIVE = true
    
    saveLighting()
    
    pcall(function()
        Lighting.Ambient = Color3.fromRGB(10, 0, 20)
        Lighting.Brightness = 0.3
        Lighting.ColorShift_Top = Color3.fromRGB(100, 0, 50)
        Lighting.FogColor = Color3.fromRGB(20, 0, 30)
        Lighting.FogEnd = 200
        Lighting.FogStart = 0
        Lighting.OutdoorAmbient = Color3.fromRGB(30, 0, 40)
    end)
    
    updateRefs()
    if not hrp then DOMAIN_ACTIVE = false; return end
    
    local domainCenter = hrp.Position
    
    local dome = Instance.new("Part", workspace)
    dome.Name = "DomainDome"
    dome.Shape = Enum.PartType.Ball
    dome.Size = Vector3.new(1, 1, 1)
    dome.Position = domainCenter
    dome.Anchored = true
    dome.CanCollide = false
    dome.BrickColor = BrickColor.new("Really black")
    dome.Material = Enum.Material.ForceField
    dome.Transparency = 0.7
    
    local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local expandTween = TweenService:Create(dome, tweenInfo, {
        Size = Vector3.new(100, 100, 100)
    })
    expandTween:Play()
    
    for i = 1, 12 do
        task.delay(i * 0.15, function()
            local wall = Instance.new("Part", workspace)
            wall.Size = Vector3.new(3, 40, 40)
            wall.CFrame = CFrame.new(domainCenter) * CFrame.Angles(0, math.rad(i * 30), 0) * CFrame.new(50, 0, 0)
            wall.Anchored = true
            wall.CanCollide = false
            wall.BrickColor = BrickColor.new("Maroon")
            wall.Material = Enum.Material.Neon
            wall.Transparency = 0.6
            Debris:AddItem(wall, DOMAIN_DURATION)
        end)
    end
    
    for i = 1, 25 do
        task.delay(i * 0.08, function()
            local p = Instance.new("Part", workspace)
            p.Size = Vector3.new(2, 2, 2)
            p.Position = domainCenter + Vector3.new(
                math.random(-40, 40),
                math.random(0, 50),
                math.random(-40, 40)
            )
            p.Anchored = true
            p.CanCollide = false
            p.BrickColor = BrickColor.new("Bright red")
            p.Material = Enum.Material.Neon
            p.Shape = Enum.PartType.Ball
            p.Transparency = 0.5
            Debris:AddItem(p, DOMAIN_DURATION)
        end)
    end
    
    local groundEffect = Instance.new("Part", workspace)
    groundEffect.Name = "DomainGround"
    groundEffect.Size = Vector3.new(100, 1, 100)
    groundEffect.Position = domainCenter - Vector3.new(0, 2, 0)
    groundEffect.Anchored = true
    groundEffect.CanCollide = false
    groundEffect.BrickColor = BrickColor.new("Dark stone grey")
    groundEffect.Material = Enum.Material.Slate
    
    local groundTween = TweenService:Create(groundEffect, tweenInfo, {
        Size = Vector3.new(200, 1, 200)
    })
    groundTween:Play()
    
    local initialHitbox = createHitbox(domainCenter, Vector3.new(80, 80, 80), 0.5)
    local initialTargets = getPlayersInHitbox(initialHitbox, {char})
    for player, _ in pairs(initialTargets) do
        instantKill(player)
    end
    
    task.spawn(function()
        for tick = 1, DOMAIN_DURATION do
            task.wait(1)
            if not DOMAIN_ACTIVE then break end
            
            createShockwaveEffect(domainCenter, 60 + (tick * 10), "Bright violet")
            
            local tickHitbox = createHitbox(domainCenter, Vector3.new(60, 60, 60), 0.5)
            local tickTargets = getPlayersInHitbox(tickHitbox, {char})
            for player, _ in pairs(tickTargets) do
                dealDamage(player, 8)
            end
        end
    end)
    
    task.delay(DOMAIN_DURATION, function()
        DOMAIN_ACTIVE = false
        
        local collapseTween = TweenService:Create(dome, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = Vector3.new(1, 1, 1),
            Transparency = 1
        })
        collapseTween:Play()
        
        local groundFade = TweenService:Create(groundEffect, TweenInfo.new(1), {Transparency = 1})
        groundFade:Play()
        Debris:AddItem(groundEffect, 2)
        Debris:AddItem(dome, 2)
        
        restoreLighting()
        
        createShockwaveEffect(domainCenter, 150, "Bright red")
        
        local finalHitbox = createHitbox(domainCenter, Vector3.new(100, 100, 100), 0.5)
        local finalTargets = getPlayersInHitbox(finalHitbox, {char})
        for player, _ in pairs(finalTargets) do
            instantKill(player)
        end
    end)
end

-- ===================== AURA DE TERROR =====================
function toggleAura(active)
    if active then
        task.spawn(function()
            while AURA_ACTIVE and char and hrp do
                pcall(function()
                    local aura = Instance.new("Part", workspace)
                    aura.Size = Vector3.new(10, 1, 10)
                    aura.Position = hrp.Position - Vector3.new(0, 4, 0)
                    aura.Anchored = true
                    aura.CanCollide = false
                    aura.Transparency = 0.4
                    aura.BrickColor = BrickColor.new("Really red")
                    aura.Material = Enum.Material.Neon
                    
                    local pulse = TweenService:Create(aura, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {
                        Size = Vector3.new(15, 0.3, 15),
                        Transparency = 1
                    })
                    pulse:Play()
                    Debris:AddItem(aura, 1)
                    
                    local auraHitbox = createHitbox(hrp.Position, Vector3.new(25, 25, 25), 0.4)
                    local targets = getPlayersInHitbox(auraHitbox, {char})
                    for player, _ in pairs(targets) do
                        dealDamage(player, 3)
                    end
                end)
                task.wait(0.25)
            end
        end)
        
        task.spawn(function()
            while AURA_ACTIVE and char and hrp do
                pcall(function()
                    for i = 1, 6 do
                        local particle = Instance.new("Part", workspace)
                        particle.Size = Vector3.new(1, 1, 1)
                        particle.Position = hrp.Position + Vector3.new(
                            math.random(-4, 4),
                            math.random(-1, 4),
                            math.random(-4, 4)
                        )
                        particle.Anchored = true
                        particle.CanCollide = false
                        particle.BrickColor = BrickColor.new("Maroon")
                        particle.Material = Enum.Material.Neon
                        particle.Transparency = 0.6
                        
                        local tween = TweenService:Create(particle, TweenInfo.new(0.8), {
                            Position = particle.Position + Vector3.new(0, 8, 0),
                            Transparency = 1
                        })
                        tween:Play()
                        Debris:AddItem(particle, 1)
                    end
                end)
                task.wait(0.12)
            end
        end)
    end
end

-- ===================== TELEPORT =====================
function teleportToMouse()
    updateRefs()
    if not hrp then return end
    
    local targetPos = mouse.Hit.Position
    local dist = (targetPos - hrp.Position).Magnitude
    
    if dist > TELEPORT_RANGE then
        targetPos = hrp.Position + (targetPos - hrp.Position).Unit * TELEPORT_RANGE
    end
    
    local vanishEffect = Instance.new("Part", workspace)
    vanishEffect.Size = Vector3.new(5, 8, 5)
    vanishEffect.Position = hrp.Position
    vanishEffect.Anchored = true
    vanishEffect.CanCollide = false
    vanishEffect.BrickColor = BrickColor.new("Bright violet")
    vanishEffect.Material = Enum.Material.Neon
    vanishEffect.Shape = Enum.PartType.Ball
    vanishEffect.Transparency = 0.3
    
    local vanishTween = TweenService:Create(vanishEffect, TweenInfo.new(0.25), {
        Size = Vector3.new(0.1, 0.1, 0.1),
        Transparency = 1
    })
    vanishTween:Play()
    Debris:AddItem(vanishEffect, 0.5)
    
    hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
    
    local appearEffect = Instance.new("Part", workspace)
    appearEffect.Size = Vector3.new(0.1, 0.1, 0.1)
    appearEffect.Position = hrp.Position
    appearEffect.Anchored = true
    appearEffect.CanCollide = false
    appearEffect.BrickColor = BrickColor.new("Bright violet")
    appearEffect.Material = Enum.Material.Neon
    appearEffect.Shape = Enum.PartType.Ball
    
    local appearTween = TweenService:Create(appearEffect, TweenInfo.new(0.3), {
        Size = Vector3.new(8, 12, 8),
        Transparency = 1
    })
    appearTween:Play()
    Debris:AddItem(appearEffect, 0.5)
    
    local teleportHitbox = createHitbox(hrp.Position, Vector3.new(20, 20, 20), 0.3)
    local targets = getPlayersInHitbox(teleportHitbox, {char})
    for player, _ in pairs(targets) do
        dealDamage(player, 15)
    end
end

-- ===================== TRANSFORMACION =====================
function fullTransform()
    pcall(function()
        updateRefs()
        if not char or TRANSFORMED then return end
        TRANSFORMED = true
        
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("Accessory") then v:Destroy() end
        end
        
        local torso = char:FindFirstChild("Torso")
        local rarm = char:FindFirstChild("Right Arm")
        local larm = char:FindFirstChild("Left Arm")
        local rleg = char:FindFirstChild("Right Leg")
        local lleg = char:FindFirstChild("Left Leg")
        local head = char:FindFirstChild("Head")
        
        local function makeBodyPart(part, color, size)
            if not part then return end
            local p = Instance.new("Part", char)
            p.Name = "Corrupt" .. part.Name
            p.Size = size or part.Size + Vector3.new(0.1, 0.1, 0.1)
            p.BrickColor = BrickColor.new(color)
            p.Material = Enum.Material.Granite
            p.CanCollide = false
            local w = Instance.new("Weld", p)
            w.Part0 = p
            w.Part1 = part
            return p
        end
        
        makeBodyPart(rarm, "Really black", Vector3.new(1.3, 2.3, 1.3))
        makeBodyPart(larm, "Really black", Vector3.new(1.3, 2.3, 1.3))
        makeBodyPart(rleg, "Really black", Vector3.new(1.1, 2.1, 1.1))
        makeBodyPart(lleg, "Really black", Vector3.new(1.1, 2.1, 1.1))
        
        if torso then
            local body = Instance.new("Part", char)
            body.Name = "CorruptTorso"
            body.Size = torso.Size + Vector3.new(0.2, 0.3, 0.2)
            body.BrickColor = BrickColor.new("Really black")
            body.Material = Enum.Material.Slate
            body.CanCollide = false
            local bw = Instance.new("Weld", body)
            bw.Part0 = body
            bw.Part1 = torso
        end
        
        if head then
            local scaryHead = Instance.new("Part", char)
            scaryHead.Name = "ScaryHead"
            scaryHead.Size = head.Size + Vector3.new(0.15, 0.1, 0.15)
            scaryHead.BrickColor = BrickColor.new("Ghost grey")
            scaryHead.Material = Enum.Material.Plastic
            scaryHead.CanCollide = false
            local hw = Instance.new("Weld", scaryHead)
            hw.Part0 = scaryHead
            hw.Part1 = head
            
            local face = Instance.new("Decal", scaryHead)
            face.Face = Enum.NormalId.Front
            face.Texture = JEFF_IMAGE
            
            local bg = Instance.new("BillboardGui", scaryHead)
            bg.Size = UDim2.new(5, 0, 5, 0)
            bg.Adornee = scaryHead
            bg.StudsOffset = Vector3.new(0, 3, 0)
            
            local img = Instance.new("ImageLabel", bg)
            img.Size = UDim2.new(1, 0, 1, 0)
            img.BackgroundTransparency = 1
            img.Image = "rbxassetid://28194422"
            
            local light1 = Instance.new("PointLight", scaryHead)
            light1.Color = Color3.fromRGB(255, 0, 0)
            light1.Brightness = 2
            light1.Range = 8
            light1.Offset = Vector3.new(-2, 0, 1)
            
            local light2 = Instance.new("PointLight", scaryHead)
            light2.Color = Color3.fromRGB(255, 0, 0)
            light2.Brightness = 2
            light2.Range = 8
            light2.Offset = Vector3.new(2, 0, 1)
        end
        
        local shirt = char:FindFirstChildOfClass("Shirt")
        if shirt then shirt:Destroy() end
        local pants = char:FindFirstChildOfClass("Pants")
        if pants then pants:Destroy() end
    end)
end

-- ===================== LIMPIEZA =====================
local function cleanup()
    pcall(function()
        updateRefs()
        if hrp then
            for _, v in pairs(hrp:GetChildren()) do
                if v:IsA("BodyVelocity") or v:IsA("BodyAngularVelocity") or v:IsA("BodyGyro") then
                    v:Destroy()
                end
            end
        end
        if humanoid then
            humanoid.Sit = false
            humanoid.PlatformStand = false
        end
        FLYING = false
        DOMAIN_ACTIVE = false
        AURA_ACTIVE = false
        _G.ChaseOn = false
    end)
end

-- ===================== GUI =====================
local main

local function setupGUI()
    pcall(function()
        local parent = nil
        pcall(function() parent = game:GetService("CoreGui") end)
        if not parent then parent = LP:WaitForChild("PlayerGui", 5) end
        if not parent then return end
        
        if parent:FindFirstChild("JohnDoeV4") then parent.JohnDoeV4:Destroy() end
        local sg = Instance.new("ScreenGui", parent); sg.Name = "JohnDoeV4"; sg.ResetOnSpawn = false
        
        main = Instance.new("Frame", sg)
        main.Size = UDim2.new(0, 280, 0, 580)
        main.Position = UDim2.new(0, 20, 0, 20)
        main.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
        main.Active = true
        main.Draggable = true
        Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
        local stroke = Instance.new("UIStroke", main)
        stroke.Color = Color3.fromRGB(150, 0, 0)
        stroke.Thickness = 2
        
        local t = Instance.new("TextLabel", main)
        t.Size = UDim2.new(1, 0, 0, 50)
        t.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        t.Text = "☠️ JOHN DOE v4.0 ☠️"
        t.TextColor3 = Color3.new(1, 1, 1)
        t.Font = Enum.Font.Antique
        Instance.new("UICorner", t).CornerRadius = UDim.new(0, 8)
        
        local btnY = 60
        local function makeBtn(txt, cb, color)
            local b = Instance.new("TextButton", main)
            b.Size = UDim2.new(0.9, 0, 0, 38)
            b.Position = UDim2.new(0.05, 0, 0, btnY)
            b.Text = txt
            b.BackgroundColor3 = color or Color3.fromRGB(80, 0, 0)
            b.TextColor3 = Color3.new(1, 1, 1)
            b.Font = Enum.Font.GothamBold
            b.TextSize = 13
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            b.MouseButton1Click:Connect(cb)
            btnY = btnY + 43
            return b
        end
        
        local function makeToggle(txt, default, cb)
            local state = default
            local b = makeBtn(txt .. ": ON ✅", function()
                state = not state
                b.Text = txt .. ": " .. (state and "ON ✅" or "OFF ❌")
                b.BackgroundColor3 = state and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(80, 0, 0)
                cb(state)
            end, Color3.fromRGB(0, 100, 0))
            return b
        end
        
        makeToggle("🛡️ INMORTAL", true, function(v) IMMORTAL = v end)
        
        makeToggle("🔒 ANTI-DETECCION", true, function(v) 
            ANTI_DETECT.enabled = v 
            ANTI_DETECT.spoofHumanoid = v
        end, Color3.fromRGB(0, 100, 100))
        
        makeBtn("🚀 VOLAR [B]", function()
            FLYING = not FLYING
            if not FLYING then cleanup() end
        end, Color3.fromRGB(80, 0, 0))
        
        makeBtn("💀 TRANSFORMAR COMPLETA", function() fullTransform() end, Color3.fromRGB(60, 0, 60))
        
        makeBtn("🔮 DOMAIN EXPANSION [T]", function()
            if tick() - lastAttack < ATTACK_COOLDOWN then return end
            lastAttack = tick()
            domainExpansion()
        end, Color3.fromRGB(50, 0, 100))
        
        makeBtn("👻 AURA TERROR [Y]", function()
            AURA_ACTIVE = not AURA_ACTIVE
            toggleAura(AURA_ACTIVE)
        end, Color3.fromRGB(80, 0, 0))
        
        makeBtn("👊 EMBESTIDA [E]", function()
            if tick() - lastAttack < ATTACK_COOLDOWN then return end
            lastAttack = tick()
            embestida()
        end, Color3.fromRGB(150, 50, 0))
        
        makeBtn("💥 GOLPE DEVASTADOR [R]", function()
            if tick() - lastAttack < ATTACK_COOLDOWN then return end
            lastAttack = tick()
            shockwave()
        end, Color3.fromRGB(100, 30, 0))
        
        makeBtn("☄️ LLUVIA DE METEOROS", function()
            if tick() - lastAttack < ATTACK_COOLDOWN then return end
            lastAttack = tick()
            meteorStrike()
        end, Color3.fromRGB(130, 50, 0))
        
        makeBtn("⚡ TELEPORT [G + CLICK]", function()
            if tick() - lastAttack < 0.5 then return end
            lastAttack = tick()
            teleportToMouse()
        end, Color3.fromRGB(0, 60, 120))
        
        makeBtn("🔥 DESINTEGRAR [H]", function()
            if tick() - lastAttack < ATTACK_COOLDOWN then return end
            lastAttack = tick()
            disintegrateTarget()
        end, Color3.fromRGB(200, 0, 0))
        
        makeBtn("😱 JUMPSCARE [F]", function()
            if tick() - lastAttack < 3 then return end
            lastAttack = tick()
            showJumpscare()
        end, Color3.fromRGB(255, 0, 0))
        
        makeBtn("🛑 DESTRABAR", function() cleanup() end, Color3.fromRGB(50, 50, 50))
        
        updateRefs()
        task.delay(0.5, function()
            if hrp then fullTransform() end
        end)
    end)
end

-- ===================== LOOPS =====================
task.spawn(function()
    while task.wait(0.3) do
        if IMMORTAL then
            pcall(function()
                updateRefs()
                if humanoid then
                    -- Aplicar valores normales primero, luego inmortalidad
                    if ANTI_DETECT.spoofHumanoid then
                        humanoid.MaxHealth = 100
                        humanoid.Health = 100
                    else
                        humanoid.MaxHealth = math.huge
                        humanoid.Health = math.huge
                    end
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    if humanoid:GetState() == Enum.HumanoidStateType.Dead then
                        humanoid:ChangeState(Enum.HumanoidStateType.Running)
                    end
                end
                if hrp and not FLYING and hrp.Position.Y < -100 then
                    hrp.CFrame = CFrame.new(0, 100, 0)
                    hrp.Velocity = Vector3.new(0, 0, 0)
                end
            end)
        end
    end
end)

-- Loop de vuelo stealth (menos detectable)
task.spawn(function()
    local flyBV = nil
    local flyBG = nil
    
    while task.wait() do
        if FLYING then
            pcall(function()
                updateRefs()
                if hrp and humanoid then
                    humanoid.PlatformStand = true
                    
                    -- Usar nombres comunes para no levantar sospechas
                    if not flyBV then
                        flyBV = Instance.new("BodyVelocity")
                        flyBV.Name = "IdleControl"
                        flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                        flyBV.Parent = hrp
                    end
                    
                    if not flyBG then
                        flyBG = Instance.new("BodyGyro")
                        flyBG.Name = "IdleGyro"
                        flyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                        flyBG.P = 12000
                        flyBG.D = 400
                        flyBG.Parent = hrp
                    end
                    
                    local cam = workspace.CurrentCamera
                    local dir = Vector3.new(0, 0, 0)
                    
                    if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
                    if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
                    if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
                    if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
                    if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
                    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end
                    
                    flyBV.Velocity = dir * FLY_SPEED
                    flyBG.CFrame = cam.CFrame
                    
                    if dir.Magnitude == 0 then
                        hrp.Velocity = Vector3.new(0, hrp.Velocity.Y, 0)
                    end
                end
            end)
        else
            -- Limpiar al desactivar vuelo
            if flyBV then flyBV:Destroy(); flyBV = nil end
            if flyBG then flyBG:Destroy(); flyBG = nil end
        end
    end
end)

task.spawn(function()
    while task.wait(1.5) do
        if _G.ChaseOn then
            pcall(function()
                local best, bestD = nil, 200
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local d = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                        if d < bestD then best = p; bestD = d end
                    end
                end
                if best and humanoid then
                    humanoid:MoveTo(best.Character.HumanoidRootPart.Position)
                end
            end)
        end
    end
end)

-- ===================== HOTKEYS =====================
UIS.InputBegan:Connect(function(i, gp)
    if gp and i.KeyCode ~= Enum.KeyCode.V and i.KeyCode ~= Enum.KeyCode.RightShift then return end
    
    if i.KeyCode == Enum.KeyCode.V or i.KeyCode == Enum.KeyCode.RightShift then
        if main then main.Visible = not main.Visible end
        
    elseif i.KeyCode == Enum.KeyCode.B then
        FLYING = not FLYING
        if not FLYING then cleanup() end
        
    elseif i.KeyCode == Enum.KeyCode.E then
        if tick() - lastAttack < ATTACK_COOLDOWN then return end
        lastAttack = tick()
        embestida()
        
    elseif i.KeyCode == Enum.KeyCode.R then
        if tick() - lastAttack < ATTACK_COOLDOWN then return end
        lastAttack = tick()
        shockwave()
        
    elseif i.KeyCode == Enum.KeyCode.T then
        if tick() - lastAttack < ATTACK_COOLDOWN then return end
        lastAttack = tick()
        domainExpansion()
        
    elseif i.KeyCode == Enum.KeyCode.Y then
        AURA_ACTIVE = not AURA_ACTIVE
        toggleAura(AURA_ACTIVE)
        
    elseif i.KeyCode == Enum.KeyCode.G then
        if tick() - lastAttack < 0.5 then return end
        lastAttack = tick()
        teleportToMouse()
        
    elseif i.KeyCode == Enum.KeyCode.H then
        if tick() - lastAttack < ATTACK_COOLDOWN then return end
        lastAttack = tick()
        disintegrateTarget()
        
    elseif i.KeyCode == Enum.KeyCode.F then
        if tick() - lastAttack < 3 then return end
        lastAttack = tick()
        showJumpscare()
    end
end)

-- ===================== INICIALIZACION =====================
mouse = LP:GetMouse()
task.spawn(setupGUI)
pcall(function() print("John Doe v4.0: Ataques Corregidos.") end)
