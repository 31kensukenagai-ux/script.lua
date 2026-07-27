local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local Window = Luna:CreateWindow({
    Name = "! Torrycxn HUB",
    Subtitle = "BloxStrike Ultimate Edition",
    LogoID = nil,
    LoadingEnabled = true,
    LoadingTitle = "! Torrycxn HUB",
    LoadingSubtitle = "by saldı",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "! Torrycxn Hub"
    },
    KeySystem = false,
    KeySettings = {}
})

Window:CreateHomeTab({
    SupportedExecutors = {},
    DiscordInvite = "URFff9DDu",
    Icon = 2,
})

local Plrs = game:GetService("Players")
local lp = Plrs.LocalPlayer
local rs = game:GetService("RunService")
local cam = workspace.CurrentCamera
local workspace = game:GetService("Workspace")
local vim = game:GetService("VirtualInputManager")
local uis = game:GetService("UserInputService")

local currentLang = "TR"
local translations = {
    TR = {
        AimTab = "Aim Bot & Görüş",
        MovementTab = "Gelişmiş Hareket",
        ExpansionTab = "Genişletme & Görsel",
        AnimationTab = "Animasyonlar",
        ChatTab = "Chat Log",
        SettingsTab = "Ayarlar",
        AimToggle = "Akıllı Aim Assist (Kırmızı Çember)",
        AimKey = "Yalnızca Ateş Ederken Kilitlen",
        FovSlider = "Aim Bot Görüş Alanı (FOV)",
        HitboxToggle = "Genişletilmiş İsabet Alanı",
        SkeletonEspToggle = "Detaylı İskelet, Takım, Arkadaş & Mesafe ESP",
        Box3DEspToggle = "3D Kutu & Eşya ESP",
        SpeedHackToggle = "Hareket Hızı Artırıcı",
        SpeedMultiplierSlider = "Hız Çarpanı",
        BhopToggle = "Akıcı BunnyHop",
        SpinBotToggle = "Karakter Çevirme (SpinBot)",
        SpinSpeedSlider = "Dönüş Hızı",
        TriggerBotToggle = "Hassas Tetikleyici (Triggerbot)",
        NoclipToggle = "Duvarlardan Geçiş (Noclip)",
        SniperFixToggle = "Sniper Dürbün Düzeltici (Özel Nişangah)",
        CustomCrosshairToggle = "Özel Sniper Nişangahı (Crosshair)"
    },
    EN = {
        AimTab = "Aim & Vision",
        MovementTab = "Advanced Movement",
        ExpansionTab = "Expansion & Visuals",
        AnimationTab = "Animations",
        ChatTab = "Chat Log",
        SettingsTab = "Settings",
        AimToggle = "Smart Aim Assist (Red Circle)",
        AimKey = "Lock Only When Firing",
        FovSlider = "Aim Bot Field of View (FOV)",
        HitboxToggle = "Expanded Hitbox Assist",
        SkeletonEspToggle = "Detailed Skeleton, Team, Friend & Distance ESP",
        Box3DEspToggle = "3D Box & Item ESP",
        SpeedHackToggle = "Movement Speed Multiplier",
        SpeedMultiplierSlider = "Speed Multiplier",
        BhopToggle = "Fluid BunnyHop",
        SpinBotToggle = "Character SpinBot",
        SpinSpeedSlider = "Spin Speed",
        TriggerBotToggle = "Precision Triggerbot",
        NoclipToggle = "Noclip",
        SniperFixToggle = "Sniper Scope Fixer (Custom Reticle)",
        CustomCrosshairToggle = "Custom Sniper Crosshair"
    }
}

local function t(key)
    return translations[currentLang][key] or key
end

local AimTab = Window:CreateTab({
    Name = t("AimTab"),
    Icon = "gps_fixed",
    ImageSource = "Material",
    ShowTitle = true
})

local MovementTab = Window:CreateTab({
    Name = t("MovementTab"),
    Icon = "directions_run",
    ImageSource = "Material",
    ShowTitle = true
})

local ExpansionTab = Window:CreateTab({
    Name = t("ExpansionTab"),
    Icon = "aspect_ratio",
    ImageSource = "Material",
    ShowTitle = true
})

local AnimationTab = Window:CreateTab({
    Name = t("AnimationTab"),
    Icon = "accessibility",
    ImageSource = "Material",
    ShowTitle = true
})

local ChatTab = Window:CreateTab({
    Name = t("ChatTab"),
    Icon = "forum",
    ImageSource = "Material",
    ShowTitle = true
})

local SettingsTab = Window:CreateTab({
    Name = t("SettingsTab"),
    Icon = "settings",
    ImageSource = "Material",
    ShowTitle = true
})

SettingsTab:CreateDropdown({
    Name = "Dil / Language",
    Description = "Arayüz dilini seçin / Select interface language",
    Options = {"Türkçe", "English"},
    CurrentOption = {"Türkçe"},
    MultipleOptions = false,
    Callback = function(Option)
        local opt = type(Option) == "table" and (Option.Value or Option[1]) or Option
        if opt == "English" or opt == "EN" then
            currentLang = "EN"
        else
            currentLang = "TR"
        end
    end
}, "LangDropdown")

local ae, he, skeletonEspEnabled, box3dEspEnabled = false, false, false, false
local aimOnFireOnly = false
local fs = 150 
local speedHackEnabled = false
local speedMultiplier = 3.5
local spinbotEnabled = false
local spinSpeed = 50.0
local triggerbotEnabled = false
local noclipEnabled = false
local bunnyhopEnabled = false
local sniperFixEnabled = true
local customCrosshairEnabled = true

local activeSkeletons = {}
local active3dBoxes = {}

local fovGui = Instance.new("ScreenGui")
fovGui.Name = "!TorrycxnHubFOVRed"
fovGui.ResetOnSpawn = false
fovGui.Parent = game:GetService("CoreGui")

local fovFrame = Instance.new("Frame")
fovFrame.Size = UDim2.new(0, fs, 0, fs)
fovFrame.Position = UDim2.new(0.5, -fs/2, 0.5, -fs/2)
fovFrame.BackgroundTransparency = 1
fovFrame.BorderSizePixel = 0
fovFrame.Visible = false
fovFrame.Parent = fovGui

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255, 0, 0)
stroke.Transparency = 0.2
stroke.Parent = fovFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = fovFrame

local crosshairGui = Instance.new("ScreenGui")
crosshairGui.Name = "! TorrycxnHubCustomCrosshair"
crosshairGui.ResetOnSpawn = false
crosshairGui.Parent = game:GetService("CoreGui")

local crosshairDot = Instance.new("Frame")
crosshairDot.Size = UDim2.new(0, 6, 0, 6)
crosshairDot.Position = UDim2.new(0.5, -3, 0.5, -3)
crosshairDot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
crosshairDot.BorderSizePixel = 0
crosshairDot.Visible = false
crosshairDot.Parent = crosshairGui

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = crosshairDot

local crossHLine = Instance.new("Frame")
crossHLine.Size = UDim2.new(0, 16, 0, 2)
crossHLine.Position = UDim2.new(0.5, -8, 0.5, -1)
crossHLine.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
crossHLine.BorderSizePixel = 0
crossHLine.Visible = false
crossHLine.Parent = crosshairGui

local crossVLine = Instance.new("Frame")
crossVLine.Size = UDim2.new(0, 2, 0, 16)
crossVLine.Position = UDim2.new(0.5, -1, 0.5, -8)
crossVLine.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
crossVLine.BorderSizePixel = 0
crossVLine.Visible = false
crossVLine.Parent = crosshairGui

local function isTeammate(targetPlayer)
    if not targetPlayer or targetPlayer == lp then return true end
    
    if lp.Team and targetPlayer.Team then
        if lp.Team == targetPlayer.Team then return true end
        return false
    end
    
    local char = targetPlayer.Character
    local lpChar = lp.Character
    if char and lpChar then
        local teamVal = char:FindFirstChild("Team") or char:FindFirstChild("TeamColor") or char:FindFirstChild("TeamValue")
        local lpTeamVal = lpChar:FindFirstChild("Team") or lpChar:FindFirstChild("TeamColor") or lpChar:FindFirstChild("TeamValue")
        if teamVal and lpTeamVal then
            if teamVal.Value == lpTeamVal.Value then return true end
            return false
        end
    end
    
    if targetPlayer.TeamColor and lp.TeamColor then
        if targetPlayer.TeamColor == lp.TeamColor then return true end
        return false
    end
    
    if lp.Team == nil and targetPlayer.Team == nil then
        return false
    end
    
    return false
end

local function isFriend(targetPlayer)
    local success, result = pcall(function()
        return lp:IsFriendsWith(targetPlayer.UserId)
    end)
    return success and result
end

local function isVisible(targetPart)
    if not targetPart or not lp.Character then return false end
    local head = lp.Character:FindFirstChild("Head") or cam
    local origin = head.Position
    local direction = (targetPart.Position - origin)
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {lp.Character, cam}
    raycastParams.IgnoreWater = true
    
    local result = workspace:Raycast(origin, direction, raycastParams)
    if result then
        local hitPart = result.Instance
        if hitPart:IsDescendantOf(targetPart.Parent) then
            return true
        end
        return false
    end
    return true
end

local isFiring = false
uis.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isFiring = true
    end
end)
uis.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isFiring = false
    end
end)

AimTab:CreateToggle({
    Name = t("AimToggle"),
    Description = "High precision lock system with visual tracking",
    CurrentValue = false,
    Callback = function(Value)
        ae = Value
        fovFrame.Visible = ae
    end
}, "AimToggle")

AimTab:CreateToggle({
    Name = t("AimKey"),
    Description = "Engages only during active firing states",
    CurrentValue = false,
    Callback = function(Value)
        aimOnFireOnly = Value
    end
}, "AimFireToggle")

AimTab:CreateSlider({
    Name = t("FovSlider"),
    Range = {50, 400},
    Increment = 5,
    CurrentValue = 150,
    Callback = function(Value)
        fs = Value
        fovFrame.Size = UDim2.new(0, fs, 0, fs)
        fovFrame.Position = UDim2.new(0.5, -fs/2, 0.5, -fs/2)
    end
}, "FovSlider")

AimTab:CreateToggle({
    Name = t("HitboxToggle"),
    Description = "Refines interaction bounds cleanly",
    CurrentValue = false,
    Callback = function(Value)
        he = Value
        for _, pl in ipairs(Plrs:GetPlayers()) do
            if not isTeammate(pl) and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                pl.Character.HumanoidRootPart.Size = he and Vector3.new(15,15,15) or Vector3.new(2,2,1)
                pl.Character.HumanoidRootPart.Transparency = he and 0.95 or 1
            end
        end
    end
}, "HitboxToggle")

AimTab:CreateToggle({
    Name = t("SniperFixToggle"),
    Description = "Removes full-screen overlay and keeps custom reticle visible",
    CurrentValue = true,
    Callback = function(Value)
        sniperFixEnabled = Value
    end
}, "SniperFixToggle")

AimTab:CreateToggle({
    Name = t("CustomCrosshairToggle"),
    Description = "Shows a fixed center crosshair when scoped in",
    CurrentValue = true,
    Callback = function(Value)
        customCrosshairEnabled = Value
    end
}, "CustomCrosshairToggle")

ExpansionTab:CreateToggle({
    Name = t("SkeletonEspToggle"),
    Description = "Clean mapping of structural elements, inventory items, and relationship statuses",
    CurrentValue = false,
    Callback = function(Value)
        skeletonEspEnabled = Value
        if not skeletonEspEnabled then
            for _, data in pairs(activeSkeletons) do
                pcall(function()
                    for _, line in pairs(data.lines) do line:Remove() end
                    if data.nameText then data.nameText:Remove() end
                    if data.healthText then data.healthText:Remove() end
                    if data.itemText then data.itemText:Remove() end
                end)
            end
            activeSkeletons = {}
        end
    end
}, "SkeletonEspToggle")

ExpansionTab:CreateToggle({
    Name = t("Box3DEspToggle"),
    Description = "Renders precise structural boundary boxes with equipment details",
    CurrentValue = false,
    Callback = function(Value)
        box3dEspEnabled = Value
        if not box3dEspEnabled then
            for _, boxObj in pairs(active3dBoxes) do
                pcall(function() boxObj:Destroy() end)
            end
            active3dBoxes = {}
        end
    end
}, "Box3DEspToggle")

MovementTab:CreateToggle({
    Name = t("SpeedHackToggle"),
    Description = "Optimized velocity adjustments",
    CurrentValue = false,
    Callback = function(Value)
        speedHackEnabled = Value
    end
}, "SpeedHackToggle")

MovementTab:CreateSlider({
    Name = t("SpeedMultiplierSlider"),
    Range = {1, 10},
    Increment = 0.5,
    CurrentValue = 3.5,
    Callback = function(Value)
        speedMultiplier = Value
    end
}, "SpeedMultiplierSlider")

MovementTab:CreateToggle({
    Name = t("BhopToggle"),
    Description = "Maintains smooth momentum on surface contact",
    CurrentValue = false,
    Callback = function(Value)
        bunnyhopEnabled = Value
    end
}, "BhopToggle")

MovementTab:CreateToggle({
    Name = t("SpinBotToggle"),
    Description = "Rotates character orientation smoothly",
    CurrentValue = false,
    Callback = function(Value)
        spinbotEnabled = Value
    end
}, "SpinBotToggle")

MovementTab:CreateSlider({
    Name = t("SpinSpeedSlider"),
    Range = {10, 200},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value)
        spinSpeed = Value
    end
}, "SpinSpeedSlider")

MovementTab:CreateToggle({
    Name = t("TriggerBotToggle"),
    Description = "Responds precisely to target visibility",
    CurrentValue = false,
    Callback = function(Value)
        triggerbotEnabled = Value
    end
}, "TriggerBotToggle")

MovementTab:CreateToggle({
    Name = t("NoclipToggle"),
    Description = "Traverse environmental colliders fluidly",
    CurrentValue = false,
    Callback = function(Value)
        noclipEnabled = Value
    end
}, "NoclipToggle")

local currentAnimTrack = nil
local function playAnimation(animId)
    pcall(function()
        if currentAnimTrack then
            currentAnimTrack:Stop()
            currentAnimTrack = nil
        end
        local char = lp.Character
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. tostring(animId)
        currentAnimTrack = humanoid:LoadAnimation(anim)
        currentAnimTrack:Play()
    end)
end

AnimationTab:CreateButton({
    Name = "Kutlama Dansı (Dance)",
    Description = "Eğlenceli dans animasyonu",
    Callback = function()
        playAnimation(507710273)
    end
})

AnimationTab:CreateButton({
    Name = "Selamlama (Wave)",
    Description = "El sallama animasyonu",
    Callback = function()
        playAnimation(507770677)
    end
})

AnimationTab:CreateButton({
    Name = "Kahkaha (Laugh)",
    Description = "Gülme animasyonu",
    Callback = function()
        playAnimation(507771019)
    end
})

AnimationTab:CreateButton({
    Name = "Animasyonları Durdur",
    Description = "Aktif olan animasyonu iptal eder",
    Callback = function()
        if currentAnimTrack then
            currentAnimTrack:Stop()
            currentAnimTrack = nil
        end
    end
})

local function getEquippedItem(char, player)
    if not char then return "None" end
    
    for _, item in ipairs(char:GetChildren()) do
        if item:IsA("Tool") then
            return item.Name
        end
    end
    
    local backpack = player:FindFirstChildOfClass("Backpack")
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                return item.Name .. " (Backpack)"
            end
        end
    end
    
    return "Fists/None"
end

local function cleanESPData(pl)
    if activeSkeletons[pl] then
        pcall(function()
            for _, line in pairs(activeSkeletons[pl].lines) do line:Remove() end
            if activeSkeletons[pl].nameText then activeSkeletons[pl].nameText:Remove() end
            if activeSkeletons[pl].healthText then activeSkeletons[pl].healthText:Remove() end
            if activeSkeletons[pl].itemText then activeSkeletons[pl].itemText:Remove() end
        end)
        activeSkeletons[pl] = nil
    end
    if active3dBoxes[pl] then
        pcall(function() active3dBoxes[pl]:Destroy() end)
        active3dBoxes[pl] = nil
    end
end

local function UpdateSkeletonEsp(pl, char)
    if not skeletonEspEnabled or not char then
        cleanESPData(pl)
        return
    end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or humanoid.Health <= 0 or not rootPart then
        cleanESPData(pl)
        return
    end

    local head = char:FindFirstChild("Head")
    local upperTorso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    local lowerTorso = char:FindFirstChild("LowerTorso") or upperTorso
    local leftUpperArm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm")
    local leftLowerArm = char:FindFirstChild("LeftLowerArm") or char:FindFirstChild("Left Arm")
    local rightUpperArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
    local rightLowerArm = char:FindFirstChild("RightLowerArm") or char:FindFirstChild("Right Arm")
    local leftUpperLeg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg")
    local leftLowerLeg = char:FindFirstChild("LeftLowerLeg") or char:FindFirstChild("Left Leg")
    local rightUpperLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
    local rightLowerLeg = char:FindFirstChild("RightLowerLeg") or char:FindFirstChild("Right Leg")

    if not head or not upperTorso then return end

    if not activeSkeletons[pl] then
        local lines = {}
        for i = 1, 10 do
            local l = Drawing.new("Line")
            l.Thickness = 1
            l.Color = isTeammate(pl) and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(0, 255, 120)
            l.Visible = false
            table.insert(lines, l)
        end
        
        local nameTxt = Drawing.new("Text")
        nameTxt.Size = 12
        nameTxt.Center = true
        nameTxt.Outline = true
        nameTxt.Color = Color3.fromRGB(255, 255, 255)
        nameTxt.Visible = false

        local healthTxt = Drawing.new("Text")
        healthTxt.Size = 12
        healthTxt.Center = true
        healthTxt.Outline = true
        healthTxt.Color = Color3.fromRGB(0, 255, 0)
        healthTxt.Visible = false

        local itemTxt = Drawing.new("Text")
        itemTxt.Size = 12
        itemTxt.Center = true
        itemTxt.Outline = true
        itemTxt.Color = Color3.fromRGB(255, 200, 0)
        itemTxt.Visible = false

        activeSkeletons[pl] = {lines = lines, nameText = nameTxt, healthText = healthTxt, itemText = itemTxt}
    end

    local data = activeSkeletons[pl]
    local lines = data.lines
    local nameTxt = data.nameText
    local healthTxt = data.healthText
    local itemTxt = data.itemText

    local lineColor = isTeammate(pl) and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(0, 255, 120)
    for _, line in pairs(lines) do
        line.Color = lineColor
    end

    local bonePairs = {
        {head, upperTorso},
        {upperTorso, lowerTorso},
        {upperTorso, leftUpperArm},
        {leftUpperArm, leftLowerArm},
        {upperTorso, rightUpperArm},
        {rightUpperArm, rightLowerArm},
        {lowerTorso, leftUpperLeg},
        {leftUpperLeg, leftLowerLeg},
        {lowerTorso, rightUpperLeg},
        {rightUpperLeg, rightLowerLeg}
    }

    for i, pair in ipairs(bonePairs) do
        local p1, p2 = pair[1], pair[2]
        if p1 and p2 and lines[i] then
            local pos1, vis1 = cam:WorldToViewportPoint(p1.Position)
            local pos2, vis2 = cam:WorldToViewportPoint(p2.Position)
            if vis1 and vis2 then
                lines[i].From = Vector2.new(pos1.X, pos1.Y)
                lines[i].To = Vector2.new(pos2.X, pos2.Y)
                lines[i].Visible = true
            else
                lines[i].Visible = false
            end
        elseif lines[i] then
            lines[i].Visible = false
        end
    end

    local headPos, headVis = cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.6, 0))
    if headVis and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local distance = math.floor((lp.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude)
        local itemHolding = getEquippedItem(char, pl)
        local statusText = isTeammate(pl) and "[TEAM]" or "[ENEMY]"
        if isFriend(pl) then
            statusText = statusText .. " [FRIEND]"
        end
        
        nameTxt.Text = string.format("%s %s [%dm]", pl.Name, statusText, distance)
        nameTxt.Position = Vector2.new(headPos.X, headPos.Y - 45)
        nameTxt.Visible = true

        healthTxt.Text = string.format("HP: %d", math.floor(humanoid.Health))
        healthTxt.Position = Vector2.new(headPos.X, headPos.Y - 30)
        healthTxt.Visible = true

        itemTxt.Text = string.format("Item: %s", itemHolding)
        itemTxt.Position = Vector2.new(headPos.X, headPos.Y - 15)
        itemTxt.Visible = true
    else
        nameTxt.Visible = false
        healthTxt.Visible = false
        itemTxt.Visible = false
    end
end

local function Update3DBoxEsp(pl, char)
    if not box3dEspEnabled or not char then
        if active3dBoxes[pl] then
            pcall(function() active3dBoxes[pl]:Destroy() end)
            active3dBoxes[pl] = nil
        end
        return
    end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        if active3dBoxes[pl] then
            pcall(function() active3dBoxes[pl]:Destroy() end)
            active3dBoxes[pl] = nil
        end
        return
    end

    local rootPart = char:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    local boxAdornment = active3dBoxes[pl]
    if not boxAdornment then
        boxAdornment = Instance.new("BoxHandleAdornment")
        boxAdornment.Name = "3DBoxESP"
        boxAdornment.Adornee = rootPart
        boxAdornment.AlwaysOnTop = true
        boxAdornment.ZIndex = 5
        boxAdornment.Transparency = 0.6
        boxAdornment.Size = Vector3.new(4, 5, 2)
        boxAdornment.Parent = rootPart
        active3dBoxes[pl] = boxAdornment
    end
    
    boxAdornment.Color3 = isTeammate(pl) and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(0, 255, 120)
end

local trackedPlayerHealth = {}

local function setupPlayerHealthListener(pl)
    if pl == lp then return end
    local function connectCharacter(char)
        local humanoid = char:WaitForChild("Humanoid", 5)
        if humanoid then
            trackedPlayerHealth[pl] = humanoid.Health
            humanoid.HealthChanged:Connect(function(newHealth)
                if newHealth <= 0 then
                    cleanESPData(pl)
                    trackedPlayerHealth[pl] = -999 
                else
                    trackedPlayerHealth[pl] = newHealth
                end
            end)
        end
    end
    
    pl.CharacterAdded:Connect(function(char)
        trackedPlayerHealth[pl] = nil
        cleanESPData(pl)
        connectCharacter(char)
    end)
    if pl.Character then
        connectCharacter(pl.Character)
    end
end

for _, pl in ipairs(Plrs:GetPlayers()) do
    setupPlayerHealthListener(pl)
end
Plrs.PlayerAdded:Connect(function(pl)
    setupPlayerHealthListener(pl)
end)

rs.RenderStepped:Connect(function(dt)
    if sniperFixEnabled then
        pcall(function()
            local gui = lp:FindFirstChild("PlayerGui")
            if gui then
                for _, ui in ipairs(gui:GetChildren()) do
                    if ui.Name == "ScopeGui" or ui.Name == "Scope" or ui.Name == "SniperScope" then
                        for _, desc in ipairs(ui:GetDescendants()) do
                            if desc:IsA("Frame") or desc:IsA("ImageLabel") then
                                if desc.Name == "Scope" or desc.Name == "Frame" or desc.Name == "Overlay" or desc.BackgroundTransparency < 1 or desc:IsA("ImageLabel") then
                                    desc.Visible = false
                                end
                            end
                        end
                    end
                end
            end
        end)
    end

    crosshairDot.Visible = customCrosshairEnabled
    crossHLine.Visible = customCrosshairEnabled
    crossVLine.Visible = customCrosshairEnabled

    if ae then
        local canLock = true
        if aimOnFireOnly then
            canLock = isFiring
        end

        if canLock then
            local targetPartObj, shortestDistance = nil, math.huge
            local centerScreen = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)

            for _, pl in ipairs(Plrs:GetPlayers()) do
                if not isTeammate(pl) and trackedPlayerHealth[pl] ~= -999 and pl.Character then
                    local targetNode = pl.Character:FindFirstChild("Head")
                    local humanoid = pl.Character:FindFirstChildOfClass("Humanoid")
                    if targetNode and humanoid and humanoid.Health > 0 then
                        local screenPos, onScreen = cam:WorldToViewportPoint(targetNode.Position)
                        if onScreen then
                            local screenVector = Vector2.new(screenPos.X, screenPos.Y)
                            local distanceFromCenter = (screenVector - centerScreen).Magnitude
                            if distanceFromCenter <= (fs / 2) and distanceFromCenter < shortestDistance then
                                shortestDistance = distanceFromCenter
                                targetPartObj = targetNode
                            end
                        end
                    end
                end
            end

            if targetPartObj then
                cam.CFrame = CFrame.new(cam.CFrame.Position, targetPartObj.Position)
            end
        end
    end

    if bunnyhopEnabled then
        local character = lp.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.FloorMaterial ~= Enum.Material.Air then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
    
    if spinbotEnabled then
        local character = lp.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local currentCF = humanoidRootPart.CFrame
                local rotationDelta = dt * spinSpeed
                humanoidRootPart.CFrame = currentCF * CFrame.Angles(0, rotationDelta, 0)
            end
        end
    end

    if triggerbotEnabled then
        local mouse = lp:GetMouse()
        local target = mouse.Target
        if target and target.Parent then
            local enemyPlr = Plrs:GetPlayerFromCharacter(target.Parent)
            if enemyPlr and not isTeammate(enemyPlr) and trackedPlayerHealth[enemyPlr] ~= -999 then
                local head = enemyPlr.Character and enemyPlr.Character:FindFirstChild("Head")
                if head and isVisible(head) then
                    pcall(function()
                        vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.wait()
                        vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    end)
                end
            end
        end
    end

    if noclipEnabled then
        local character = lp.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
    
    if skeletonEspEnabled or box3dEspEnabled then
        for _, pl in ipairs(Plrs:GetPlayers()) do
            if pl ~= lp then
                if trackedPlayerHealth[pl] == -999 then
                    cleanESPData(pl)
                else
                    UpdateSkeletonEsp(pl, pl.Character)
                    Update3DBoxEsp(pl, pl.Character)
                end
            end
        end
    end
end)

rs.Heartbeat:Connect(function()
    if not speedHackEnabled then return end
    local character = lp.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoidRootPart or not humanoid then return end

    local currentVelocity = humanoidRootPart.AssemblyLinearVelocity
    local moveDirection = humanoid.MoveDirection
    
    if moveDirection.Magnitude > 0 then
        local targetSpeed = humanoid.WalkSpeed * speedMultiplier
        humanoidRootPart.AssemblyLinearVelocity = Vector3.new(
            moveDirection.X * targetSpeed,
            currentVelocity.Y,
            moveDirection.Z * targetSpeed
        )
    end
end)

Plrs.PlayerRemoving:Connect(function(pl)
    cleanESPData(pl)
    trackedPlayerHealth[pl] = nil
end)

local chatLabels = {}
local function addChatMsg(text, sender)
    if not text or text == "" then return end
    local lbl = ChatTab:CreateLabel({
        Text = string.format("[%s]: %s", sender or "?", text),
        Style = 1
    })
    table.insert(chatLabels, lbl)
end

ChatTab:CreateButton({
    Name = "Chat'i Temizle",
    Description = nil,
    Callback = function()
        for _, lbl in ipairs(chatLabels) do
            pcall(function() lbl:Destroy() end)
        end
        chatLabels = {}
    end
})

for _, pl in ipairs(Plrs:GetPlayers()) do
    pl.Chatted:Connect(function(m) addChatMsg(m, pl.Name) end)
end
Plrs.PlayerAdded:Connect(function(pl)
    pl.Chatted:Connect(function(m) addChatMsg(m, pl.Name) end)
end)
