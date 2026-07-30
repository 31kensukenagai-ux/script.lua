

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

8
pcall(function()
    if CoreGui:FindFirstChild("BloxStrikeKeySystem") then CoreGui.BloxStrikeKeySystem:Destroy() end
    if CoreGui:FindFirstChild("BloxStrikeHub") then CoreGui.BloxStrikeHub:Destroy() end
    if CoreGui:FindFirstChild("Luna") then CoreGui.Luna:Destroy() end
    if CoreGui:FindFirstChild("BloxStrikeFOV") then CoreGui.BloxStrikeFOV:Destroy() end
end)

if gethui and not cloneref then
    pcall(function()
        local coreGui = game:GetService("CoreGui")
    end)
end

local success, Luna = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()
end)

if not success or not Luna then
    warn("Failed to load Luna UI Library.")
    return
end

local Window = Luna:CreateWindow({
    Name = "BloxStrike Ultimate Pro v3.5",
    Subtitle = "Authorized Hub",
    LogoID = nil,
    LoadingEnabled = true,
    LoadingTitle = "BloxStrike Suite v3.5",
    LoadingSubtitle = "Loading Authorized Menu...",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "BloxStrikeProV35"
    },
    KeySystem = false,
    KeySettings = {}
})

Window:CreateHomeTab({
    SupportedExecutors = {},
    DiscordInvite = "",
    Icon = 2,
})

local CombatTab = Window:CreateTab({ Name = "Combat", Icon = "gps_fixed", ImageSource = "Material", ShowTitle = true })
local VisualsTab = Window:CreateTab({ Name = "Visuals", Icon = "visibility", ImageSource = "Material", ShowTitle = true })
local MovementTab = Window:CreateTab({ Name = "Movement", Icon = "flight", ImageSource = "Material", ShowTitle = true })
local MainTab = Window:CreateTab({ Name = "Main Menu", Icon = "home", ImageSource = "Material", ShowTitle = true })
local SettingsTab = Window:CreateTab({ Name = "Settings", Icon = "settings", ImageSource = "Material", ShowTitle = true })


local FlashGui = Instance.new("ScreenGui")
FlashGui.Name = "BloxStrikeRedFlash"
FlashGui.ResetOnSpawn = false
FlashGui.Parent = CoreGui

local FlashFrame = Instance.new("Frame")
FlashFrame.Size = UDim2.new(1, 0, 1, 0)
FlashFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
FlashFrame.BackgroundTransparency = 1
FlashFrame.BorderSizePixel = 0
FlashFrame.ZIndex = 9999
FlashFrame.Parent = FlashGui

local function triggerRedFlash()
    task.spawn(function()
        FlashFrame.BackgroundTransparency = 0.75
        for i = 0.75, 1, 0.05 do
            FlashFrame.BackgroundTransparency = i
            task.wait(0.02)
        end
        FlashFrame.BackgroundTransparency = 1
    end)
end


local S = {
    Aimbot = false,
    AimbotPart = "Head",
    AimKey = Enum.UserInputType.MouseButton2,
    Triggerbot = false,
    TriggerKey = Enum.UserInputType.MouseButton1,
    TriggerAlwaysOn = false,
    TriggerDelay = 0,
    ShowFov = false,
    FovRadius = 100,
    Smoothness = 0,
    AimOffset = 0,
    BoxESP = false,
    SkeletonESP = false,
    AccurateHead = false,
    NormalHead = false,
    BoxCol = Color3.fromRGB(255, 255, 255),
    SkelCol = Color3.fromRGB(255, 255, 255),
    AccCol = Color3.fromRGB(255, 0, 0),
    NormCol = Color3.fromRGB(0, 255, 0),
    HeadSize = 1,
    
    -- Additional ESP / Chams settings
    PlayerChamsEnabled = false,
    WeaponChamsEnabled = false,
    HealthBasedChams = false,
    PlayerFillColor = Color3.fromRGB(255, 0, 0),
    PlayerOutlineColor = Color3.fromRGB(255, 255, 255),
    PlayerFillTransparency = 0.5,
    WeaponFillColor = Color3.fromRGB(0, 255, 255),
    WeaponOutlineColor = Color3.fromRGB(255, 255, 255),
    WeaponFillTransparency = 0.5,
    TeamCheck = true
}

local connections = {}
local isAiming, isTriggering, cTarget = false, false, nil
local tbDelay = 0
local rX, rY = 0, 0
local eD, aD = {}, {}
local BONES = {}

local Chams = {}
local WeaponChams = {}
local espObjects = {}
local espEnabled = false
local teamCheckEnabled = true
local MyTeam = nil

local CharactersFolder = Workspace:FindFirstChild("Characters") or Workspace

local mouse = LocalPlayer:GetMouse()

local fovGui = Instance.new("ScreenGui")
fovGui.Name = "BloxStrikeFOV"
fovGui.ResetOnSpawn = false
fovGui.Parent = CoreGui

local fovFrame = Instance.new("Frame")
fovFrame.Size = UDim2.new(0, 200, 0, 200)
fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
fovFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
fovFrame.BackgroundTransparency = 1
fovFrame.Visible = false
fovFrame.Parent = fovGui

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovFrame

local fovStroke = Instance.new("UIStroke")
fovStroke.Color = Color3.fromRGB(255, 0, 0)
fovStroke.Thickness = 1.5
fovStroke.Parent = fovFrame

local function isValid(t)
    if not t or not t.Character then return false end
    if t == LocalPlayer then return false end
    if LocalPlayer:IsFriendsWith(t.UserId) then return false end
    local h = t.Character:FindFirstChildOfClass("Humanoid")
    return h and h.Health > 0 and t.Character:FindFirstChild(S.AimbotPart) ~= nil
end


local function UpdateMyTeam()
    if not LocalPlayer.Character then return end
    local charName = LocalPlayer.Character.Name
    for _, teamFolder in ipairs(CharactersFolder:GetChildren()) do
        if teamFolder:IsA("Folder") and teamFolder:FindFirstChild(charName) then
            if MyTeam ~= teamFolder.Name then
                MyTeam = teamFolder.Name
            end
            return MyTeam
        end
    end
end

task.spawn(function()
    task.wait(1)
    while true do
        UpdateMyTeam()
        task.wait(3)
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.8)
    UpdateMyTeam()
end)

local function IsSameTeam(plr)
    if not S.TeamCheck or not MyTeam then return false end
    if not plr.Character then return false end
    local charName = plr.Character.Name
    for _, teamFolder in ipairs(CharactersFolder:GetChildren()) do
        if teamFolder:IsA("Folder") and teamFolder:FindFirstChild(charName) then
            return teamFolder.Name == MyTeam
        end
    end
    return false
end

local function isEnemy(plr)
    if plr == LocalPlayer then return false end
    if not teamCheckEnabled then return true end
    return not IsSameTeam(plr)
end

local function CreateHighlight(fill, outline, trans)
    local h = Instance.new("Highlight")
    h.FillColor = fill
    h.OutlineColor = outline
    h.FillTransparency = trans
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Enabled = true
    h.Parent = CoreGui
    return h
end

local function GetHealthColor(health, maxhealth)
    local p = math.clamp(health / maxhealth, 0, 1)
    return Color3.fromRGB((1-p)*255, p*255, 50)
end

local function clearESP()
    for player, data in pairs(espObjects) do
        if data then
            if data.boxOutline then data.boxOutline:Remove() end
            if data.boxFill then data.boxFill:Remove() end
            if data.nameTag then data.nameTag:Remove() end
            if data.distanceTag then data.distanceTag:Remove() end
            if data.healthBarBg then data.healthBarBg:Remove() end
            if data.healthBarFill then data.healthBarFill:Remove() end
        end
    end
    espObjects = {}
end

local function removeESP(player)
    if espObjects[player] then
        local data = espObjects[player]
        if data.boxOutline then data.boxOutline:Remove() end
        if data.boxFill then data.boxFill:Remove() end
        if data.nameTag then data.nameTag:Remove() end
        if data.distanceTag then data.distanceTag:Remove() end
        if data.healthBarBg then data.healthBarBg:Remove() end
        if data.healthBarFill then data.healthBarFill:Remove() end
        espObjects[player] = nil
    end
    if Chams[player] then Chams[player]:Destroy() Chams[player] = nil end
    if WeaponChams[player] then WeaponChams[player]:Destroy() WeaponChams[player] = nil end
end

local function createESPForPlayer(player)
    if player == LocalPlayer then return end
    if espObjects[player] then return end

    local boxOutline = Drawing.new("Square")
    boxOutline.Visible = false
    boxOutline.Color = Color3.new(0, 0, 0)
    boxOutline.Thickness = 3
    boxOutline.Filled = false

    local boxFill = Drawing.new("Square")
    boxFill.Visible = false
    boxFill.Color = Color3.new(1, 1, 1)
    boxFill.Thickness = 1
    boxFill.Filled = false

    local nameTag = Drawing.new("Text")
    nameTag.Visible = false
    nameTag.Color = Color3.new(1, 1, 1)
    nameTag.Size = 13
    nameTag.Center = true
    nameTag.Outline = true

    local distanceTag = Drawing.new("Text")
    distanceTag.Visible = false
    distanceTag.Color = Color3.new(0.8, 0.8, 0.8)
    distanceTag.Size = 12
    distanceTag.Center = true
    distanceTag.Outline = true

    local healthBarBg = Drawing.new("Square")
    healthBarBg.Visible = false
    healthBarBg.Color = Color3.new(0, 0, 0)
    healthBarBg.Thickness = 1
    healthBarBg.Filled = true

    local healthBarFill = Drawing.new("Square")
    healthBarFill.Visible = false
    healthBarFill.Thickness = 1
    healthBarFill.Filled = true

    espObjects[player] = {
        boxOutline = boxOutline,
        boxFill = boxFill,
        nameTag = nameTag,
        distanceTag = distanceTag,
        healthBarBg = healthBarBg,
        healthBarFill = healthBarFill
    }
end


table.insert(connections, UserInputService.InputBegan:Connect(function(i, gp)
    local k = i.UserInputType == Enum.UserInputType.Keyboard and i.KeyCode or i.UserInputType
    if k == S.AimKey and (not gp or k ~= i.KeyCode) then 
        isAiming = true 
        triggerRedFlash()
    end
    if k == S.TriggerKey and (not gp or k ~= i.KeyCode) then 
        isTriggering = true 
    end
    if not gp and i.KeyCode == Enum.KeyCode.K then
        espEnabled = not espEnabled
        if not espEnabled then clearESP() end
    end
end))

table.insert(connections, UserInputService.InputEnded:Connect(function(i)
    local k = i.UserInputType == Enum.UserInputType.Keyboard and i.KeyCode or i.UserInputType
    if k == S.AimKey then isAiming = false; cTarget = nil end
    if k == S.TriggerKey then isTriggering = false end
end))

pcall(function() RunService:BindToRenderStep("DXAimbotLock", 205, function(deltaTime)
    local Cam = Workspace.CurrentCamera; if not Cam then return end

    pcall(function()
        fovFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        fovFrame.Size = UDim2.new(0, S.FovRadius * 2, 0, S.FovRadius * 2)
        fovFrame.Visible = S.ShowFov
        fovStroke.Color = Color3.fromRGB(255, 0, 0)
    end)

    pcall(function()
        if S.HeadSize and S.HeadSize > 1 then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and isEnemy(p) and p.Character then
                    local head = p.Character:FindFirstChild("Head")
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if head and hum and hum.Health > 0 then
                        head.Size = Vector3.new(S.HeadSize, S.HeadSize, S.HeadSize)
                        head.CanCollide = false
                        head.Transparency = 0.5
                    end
                end
            end
        end
    end)

    -- Chams Update
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if IsSameTeam(plr) then
                if Chams[plr] then Chams[plr]:Destroy() Chams[plr] = nil end
                if WeaponChams[plr] then WeaponChams[plr]:Destroy() WeaponChams[plr] = nil end
            else
                local char = plr.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health > 0 then
                        if S.PlayerChamsEnabled then
                            if not Chams[plr] then
                                Chams[plr] = CreateHighlight(S.PlayerFillColor, S.PlayerOutlineColor, S.PlayerFillTransparency)
                            end
                            if S.HealthBasedChams then
                                Chams[plr].FillColor = GetHealthColor(hum.Health, hum.MaxHealth)
                            else
                                Chams[plr].FillColor = S.PlayerFillColor
                            end
                            Chams[plr].Adornee = char
                        else
                            if Chams[plr] then Chams[plr]:Destroy() Chams[plr] = nil end
                        end

                        if S.WeaponChamsEnabled then
                            local debris = Workspace:FindFirstChild("Debris")
                            local weapon = debris and debris:FindFirstChild(plr.Name .. "_Weapon")
                            if weapon then
                                if not WeaponChams[plr] then
                                    WeaponChams[plr] = CreateHighlight(S.WeaponFillColor, S.WeaponOutlineColor, S.WeaponFillTransparency)
                                end
                                WeaponChams[plr].Adornee = weapon
                            end
                        else
                            if WeaponChams[plr] then WeaponChams[plr]:Destroy() WeaponChams[plr] = nil end
                        end
                    else
                        if Chams[plr] then Chams[plr]:Destroy() Chams[plr] = nil end
                        if WeaponChams[plr] then WeaponChams[plr]:Destroy() WeaponChams[plr] = nil end
                    end
                else
                    if Chams[plr] then Chams[plr]:Destroy() Chams[plr] = nil end
                    if WeaponChams[plr] then WeaponChams[plr]:Destroy() WeaponChams[plr] = nil end
                end
            end
        end
    end

    -- Box & Tag ESP Loop
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if isEnemy(player) then
                    local char = player.Character
                    local root = char and char:FindFirstChild("HumanoidRootPart")
                    local head = char and char:FindFirstChild("Head")
                    local humanoid = char and char:FindFirstChildOfClass("Humanoid")

                    if root and head and humanoid and humanoid.Health > 0 then
                        if not espObjects[player] then
                            createESPForPlayer(player)
                        end

                        local data = espObjects[player]
                        if data then
                            local rootPos, rootOnScreen = Cam:WorldToViewportPoint(root.Position)
                            local headPos, headOnScreen = Cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))

                            if not rootOnScreen and not headOnScreen then
                                data.boxOutline.Visible = false
                                data.boxFill.Visible = false
                                data.nameTag.Visible = false
                                data.distanceTag.Visible = false
                                data.healthBarBg.Visible = false
                                data.healthBarFill.Visible = false
                            else
                                local height = math.abs(headPos.Y - rootPos.Y)
                                local width = height / 2
                                local boxX = rootPos.X - width / 2
                                local boxY = rootPos.Y

                                data.boxOutline.Visible = true
                                data.boxOutline.Position = Vector2.new(boxX, boxY)
                                data.boxOutline.Size = Vector2.new(width, height)

                                data.boxFill.Visible = true
                                data.boxFill.Position = Vector2.new(boxX, boxY)
                                data.boxFill.Size = Vector2.new(width, height)

                                data.nameTag.Visible = true
                                data.nameTag.Text = player.Name
                                data.nameTag.Position = Vector2.new(rootPos.X, boxY - 14)

                                local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
                                    and (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude
                                    or 0
                                data.distanceTag.Visible = true
                                data.distanceTag.Text = string.format("%.0f m", dist)
                                data.distanceTag.Position = Vector2.new(rootPos.X, boxY + height + 2)

                                local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                                local barWidth = 2
                                local barHeight = height
                                local barX = boxX - barWidth - 2
                                local barY = boxY

                                data.healthBarBg.Visible = true
                                data.healthBarBg.Position = Vector2.new(barX, barY)
                                data.healthBarBg.Size = Vector2.new(barWidth, barHeight)

                                data.healthBarFill.Visible = true
                                data.healthBarFill.Position = Vector2.new(barX, barY + barHeight * (1 - healthPercent))
                                data.healthBarFill.Size = Vector2.new(barWidth, barHeight * barHeight * (healthPercent / barHeight)) -- safe size calculation
                                data.healthBarFill.Size = Vector2.new(barWidth, barHeight * healthPercent)
                                data.healthBarFill.Color = Color3.new(1 - healthPercent, healthPercent, 0)
                            end
                        end
                    else
                        removeESP(player)
                    end
                else
                    removeESP(player)
                end
            end
        end
    end

    if S.Triggerbot and (S.TriggerAlwaysOn or isTriggering) and tick()-tbDelay>(S.TriggerDelay/1000) then
        local target=mouse.Target
        if target then
            local char=target.Parent
            if char and not char:FindFirstChildOfClass("Humanoid") then char=char.Parent end
            if char and char:IsA("Model") and char:FindFirstChildOfClass("Humanoid") then
                local p=Players:GetPlayerFromCharacter(char)
                if p and p~=LocalPlayer and isValid(p) then
                    if mouse1click then mouse1click(); tbDelay=tick() end
                end
            end
        end
    end

    if S.Aimbot and isAiming then
        if not isValid(cTarget) then
            local sDist,cCen=S.FovRadius,Cam.ViewportSize/2
            for _,p in pairs(Players:GetPlayers()) do
                if p~=LocalPlayer and isValid(p) then
                    local pS,oS=Cam:WorldToViewportPoint(p.Character[S.AimbotPart].Position)
                    if oS then local dist=(Vector2.new(pS.X,pS.Y)-cCen).Magnitude; if dist<=sDist then cTarget,sDist=p,dist end end
                end
            end
        end
        if cTarget then
            local tPos=cTarget.Character[S.AimbotPart].Position+Vector3.new(0,S.AimOffset,0)
            local sPos,onScreen=Cam:WorldToViewportPoint(tPos)
            if onScreen then
                if mousemoverel then
                    local sm=(1.1-S.Smoothness)*20*deltaTime
                    local rawX=(sPos.X-Cam.ViewportSize.X/2)*sm+rX; local rawY=(sPos.Y-Cam.ViewportSize.Y/2)*sm+rY
                    local mX,mY=math.floor(rawX),math.floor(rawY); rX,rY=rawX-mX,rawY-mY
                    if mX~=0 or mY~=0 then mousemoverel(mX,mY) end
                else Cam.CFrame=Cam.CFrame:Lerp(CFrame.lookAt(Cam.CFrame.Position,tPos),(1.1-S.Smoothness)*10*deltaTime) end
            end
        end
    else rX,rY=0,0 end
end) end)


LocalPlayer.Chatted:Connect(function(msg)
    local cmd = string.lower(msg)
    if cmd == "/espon" then
        espEnabled = true
    elseif cmd == "/espoff" then
        espEnabled = false
        clearESP()
    elseif cmd == "/teamcheck on" then
        teamCheckEnabled = true
        clearESP()
    elseif cmd == "/teamcheck off" then
        teamCheckEnabled = false
        clearESP()
    end
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        if espEnabled and isEnemy(player) then
            createESPForPlayer(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(removeESP)


CombatTab:CreateToggle({
   Name = "Silent Aim",
   CurrentValue = false,
   Flag = "SilentAimFlag",
   Callback = function(Value)
      _G.SilentAim = Value
      if Value then
          pcall(function()
              Luna:Notification({
                  Title = "Xeditio",
                  Content = "Silent Aim Activated!",
                  Duration = 2
              })
          end)
      end
   end,
})

CombatTab:CreateToggle({
   Name = "No Recoil",
   CurrentValue = false,
   Flag = "NoRecoilFlag",
   Callback = function(Value)
      _G.NoRecoil = Value
   end,
})

CombatTab:CreateToggle({
   Name = "Triggerbot",
   CurrentValue = false,
   Flag = "TriggerbotFlag",
   Callback = function(Value)
      S.Triggerbot = Value
   end,
})

CombatTab:CreateButton({
   Name = "Triggerbot Mode: Always On / Hold",
   Callback = function()
      S.TriggerAlwaysOn = not S.TriggerAlwaysOn
      pcall(function()
          Luna:Notification({
              Title = "Triggerbot Mode",
              Content = "Current Mode: " .. (S.TriggerAlwaysOn and "Always On" or "Hold Key"),
              Duration = 2
          })
      end)
   end,
})

CombatTab:CreateKeybind({
   Name = "Trigger Key",
   CurrentKeybind = "MouseButton1",
   HoldToInteract = false,
   Flag = "TriggerKeyFlag",
   Callback = function(Keybind)
      S.TriggerKey = Keybind
   end,
})

CombatTab:CreateSlider({
   Name = "Trigger Delay (ms)",
   Range = {0, 1000},
   Increment = 10,
   CurrentValue = 0,
   Flag = "TriggerDelayFlag",
   Callback = function(Value)
      S.TriggerDelay = Value
   end,
})

CombatTab:CreateToggle({
   Name = "Show FOV Circle",
   CurrentValue = false,
   Flag = "ShowFovFlag",
   Callback = function(Value)
      S.ShowFov = Value
   end,
})

CombatTab:CreateSlider({
   Name = "FOV Radius",
   Range = {20, 500},
   Increment = 5,
   CurrentValue = 100,
   Flag = "FovRadiusFlag",
   Callback = function(Value)
      S.FovRadius = Value
   end,
})

CombatTab:CreateSlider({
   Name = "Head Size",
   Range = {1, 10},
   Increment = 0.5,
   CurrentValue = 1,
   Flag = "HeadSizeFlag",
   Callback = function(Value)
      S.HeadSize = Value
      pcall(function()
          Luna:Notification({
              Title = "Head Size",
              Content = "Size set to " .. tostring(Value),
              Duration = 1.5
          })
      end)
   end,
})


VisualsTab:CreateToggle({
   Name = "Box & Info ESP (Press K)",
   CurrentValue = false,
   Flag = "EspToggleFlag",
   Callback = function(Value)
      espEnabled = Value
      if not espEnabled then clearESP() end
   end,
})

VisualsTab:CreateToggle({
   Name = "Player Chams",
   CurrentValue = false,
   Flag = "PlayerChamsFlag",
   Callback = function(Value)
      S.PlayerChamsEnabled = Value
   end,
})

VisualsTab:CreateToggle({
   Name = "Weapon Chams",
   CurrentValue = false,
   Flag = "WeaponChamsFlag",
   Callback = function(Value)
      S.WeaponChamsEnabled = Value
   end,
})

VisualsTab:CreateToggle({
   Name = "Health-Based Chams",
   CurrentValue = false,
   Flag = "HealthChamsFlag",
   Callback = function(Value)
      S.HealthBasedChams = Value
   end,
})

VisualsTab:CreateToggle({
   Name = "Team Check",
   CurrentValue = true,
   Flag = "TeamCheckFlag",
   Callback = function(Value)
      S.TeamCheck = Value
      teamCheckEnabled = Value
      clearESP()
   end,
})


MovementTab:CreateToggle({
   Name = "Auto BunnyHop",
   CurrentValue = false,
   Flag = "BhopFlag",
   Callback = function(Value)
      _G.Bhop = Value
      UserInputService.JumpRequest:Connect(function()
         if _G.Bhop then
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
               char:FindFirstChildOfClass("Humanoid").Jump = true
            end
         end
      end)
   end,
})
