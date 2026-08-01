local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local Window = Luna:CreateWindow({
	Name = "Torrycxn&Clooter",
	Subtitle = nil,
	LogoID = nil,
	LoadingEnabled = true,
	LoadingTitle = "Torrycxn&Clooter HUB",
	LoadingSubtitle = "by Torrycxn",
	ConfigSettings = {
		RootFolder = nil,
		ConfigFolder = "Torrycxn&Clooter Hub"
	},
	KeySystem = false,
	KeySettings = {}
})

Window:CreateHomeTab({
	SupportedExecutors = {},
	DiscordInvite = "ZF5fTWPh5a",
	Icon = 2,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local CharactersFolder = Workspace:FindFirstChild("Characters") or Workspace

local MyTeam = nil
local espObjects = {}
local chamsObjects = {}
local weaponChamsObjects = {}

local S = {
    ESPEnabled = false,
    PlayerChamsEnabled = false,
    WeaponChamsEnabled = false,
    HealthBasedChams = false,
    TeamCheck = true,
    Triggerbot = false,
    TriggerAlwaysOn = false,
    TriggerKey = Enum.KeyCode.Q,
    TriggerDelay = 0,
    ShowFov = false,
    FovRadius = 100,
    HeadSize = 1,
    SilentAim = false,
    NoRecoil = false,
    Bhop = false,
    Aimbot = false,
    ToggleKey = Enum.KeyCode.E,
    TargetPart = "Head",
    BoxESP = false,
    BoxCol = Color3.fromRGB(0, 255, 137),
}

local tbDelay = 0
local isTriggering = false
local mouse = LocalPlayer:GetMouse()
local eD = {}

-- ===================== VISUALS (ESP) TAB =====================
local VisualsTab = Window:CreateTab({
	Name = "Visuals",
	Icon = "visibility",
	ImageSource = "Material",
	ShowTitle = true
})

VisualsTab:CreateToggle({
	Name = "Box & Info ESP",
	Description = nil,
	CurrentValue = false,
	Callback = function(Value)
		S.ESPEnabled = Value
        S.BoxESP = Value
		if not S.ESPEnabled then
			for player, _ in pairs(espObjects) do
				if espObjects[player] then
					pcall(function()
						if espObjects[player].boxOutline then espObjects[player].boxOutline:Remove() end
						if espObjects[player].boxFill then espObjects[player].boxFill:Remove() end
						if espObjects[player].nameTag then espObjects[player].nameTag:Remove() end
						if espObjects[player].distanceTag then espObjects[player].distanceTag:Remove() end
						if espObjects[player].healthBarBg then espObjects[player].healthBarBg:Remove() end
						if espObjects[player].healthBarFill then espObjects[player].healthBarFill:Remove() end
					end)
					espObjects[player] = nil
				end
			end
		end
	end
}, "ESPToggle")

VisualsTab:CreateToggle({
	Name = "Player Chams",
	Description = nil,
	CurrentValue = false,
	Callback = function(Value)
		S.PlayerChamsEnabled = Value
		if not S.PlayerChamsEnabled then
			for p, h in pairs(chamsObjects) do
				pcall(function() h:Destroy() end)
				chamsObjects[p] = nil
			end
		end
	end
}, "PlayerChamsToggle")

VisualsTab:CreateToggle({
	Name = "Weapon Chams",
	Description = nil,
	CurrentValue = false,
	Callback = function(Value)
		S.WeaponChamsEnabled = Value
		if not S.WeaponChamsEnabled then
			for p, h in pairs(weaponChamsObjects) do
				pcall(function() h:Destroy() end)
				weaponChamsObjects[p] = nil
			end
		end
	end
}, "WeaponChamsToggle")

VisualsTab:CreateToggle({
	Name = "Health-Based Chams",
	Description = nil,
	CurrentValue = false,
	Callback = function(Value)
		S.HealthBasedChams = Value
	end
}, "HealthChamsToggle")

VisualsTab:CreateToggle({
	Name = "Team Check",
	Description = nil,
	CurrentValue = true,
	Callback = function(Value)
		S.TeamCheck = Value
	end
}, "TeamCheckToggle")

-- ===================== COMBAT / LEGIT TAB =====================
local CombatTab = Window:CreateTab({
	Name = "Combat",
	Icon = "gps_fixed",
	ImageSource = "Material",
	ShowTitle = true
})

CombatTab:CreateToggle({
	Name = "Aimbot",
	CurrentValue = false,
	Callback = function(Value)
		S.Aimbot = Value
	end
}, "AimbotToggle")

CombatTab:CreateToggle({
	Name = "Triggerbot",
	Description = nil,
	CurrentValue = false,
	Callback = function(Value)
		S.Triggerbot = Value
	end
}, "TriggerToggle")

CombatTab:CreateToggle({
	Name = "Triggerbot Mode (Always On)",
	Description = "Off = Hold Key, On = Always On",
	CurrentValue = false,
	Callback = function(Value)
		S.TriggerAlwaysOn = Value
	end
}, "TriggerModeToggle")

CombatTab:CreateKeybind({
	Name = "Trigger Key",
	Description = nil,
	CurrentKeybind = "Q",
	HoldToInteract = false,
	Callback = function(Key)
		S.TriggerKey = Key
	end,
	ChangedCallback = function(NewKey)
		S.TriggerKey = NewKey
	end
}, "TriggerKeybind")

CombatTab:CreateSlider({
	Name = "Delay (ms)",
	Description = nil,
	Range = {0, 1000},
	Increment = 1,
	CurrentValue = 0,
	Callback = function(Value)
		S.TriggerDelay = Value
	end
}, "TriggerDelaySlider")

CombatTab:CreateToggle({
	Name = "Show FOV Circle",
	Description = nil,
	CurrentValue = false,
	Callback = function(Value)
		S.ShowFov = Value
	end
}, "ShowFovToggle")

CombatTab:CreateSlider({
	Name = "FOV Radius",
	Description = nil,
	Range = {10, 500},
	Increment = 1,
	CurrentValue = 100,
	Callback = function(Value)
		S.FovRadius = Value
	end
}, "FovRadiusSlider")

CombatTab:CreateSlider({
	Name = "Head Size",
	Description = nil,
	Range = {1, 3},
	Increment = 0.5,
	CurrentValue = 1,
	Callback = function(Value)
		S.HeadSize = Value
	end
}, "HeadSizeSlider")

CombatTab:CreateToggle({
   Name = "Silent Aim",
   CurrentValue = false,
   Callback = function(Value)
      S.SilentAim = Value
   end
}, "SilentAimToggle")

CombatTab:CreateToggle({
   Name = "No Recoil",
   CurrentValue = false,
   Callback = function(Value)
      S.NoRecoil = Value
   end
}, "NoRecoilToggle")

-- ===================== MOVEMENT TAB =====================
local MovementTab = Window:CreateTab({
	Name = "Movement",
	Icon = "directions_run",
	ImageSource = "Material",
	ShowTitle = true
})

MovementTab:CreateToggle({
   Name = "Auto BunnyHop",
   CurrentValue = false,
   Callback = function(Value)
      S.Bhop = Value
   end
}, "BhopToggle")

UserInputService.JumpRequest:Connect(function()
   if S.Bhop then
      local char = LocalPlayer.Character
      if char then
         local hum = char:FindFirstChildOfClass("Humanoid")
         if hum then
            hum.Jump = true
         end
      end
   end
end)

local Circle = Drawing.new("Circle")
Circle.Thickness = 2
Circle.Color = Color3.fromRGB(255, 0, 0)
Circle.Transparency = 0.6
Circle.Filled = false
Circle.Visible = false

UserInputService.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == S.ToggleKey then
        S.Aimbot = not S.Aimbot
        print("Aimbot:", S.Aimbot)
    end
    if i.KeyCode == S.TriggerKey then
        isTriggering = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == S.TriggerKey then
        isTriggering = false
    end
end)

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

if LocalPlayer.Character then
    task.spawn(UpdateMyTeam)
end

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
    if not S.TeamCheck then return true end
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
    h.Parent = game:GetService("CoreGui")
    return h
end

local function GetHealthColor(health, maxhealth)
    local p = math.clamp(health / maxhealth, 0, 1)
    return Color3.fromRGB((1-p)*255, p*255, 50)
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
    boxFill.Color = Color3.new(1, 0, 0)
    boxFill.Thickness = 1
    boxFill.Filled = false

    local nameTag = Drawing.new("Text")
    nameTag.Visible = false
    nameTag.Center = true
    nameTag.Outline = true
    nameTag.Color = Color3.new(1, 1, 1)
    nameTag.Size = 14

    local distanceTag = Drawing.new("Text")
    distanceTag.Visible = false
    distanceTag.Center = true
    distanceTag.Outline = true
    distanceTag.Color = Color3.new(1, 1, 1)
    distanceTag.Size = 13

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

    local lines = {}
    for i = 1, 4 do
        local l = Drawing.new("Line")
        l.Visible = false
        table.insert(lines, l)
    end
    eD[player] = {L = lines}
end

local function removeESP(player)
    local data = espObjects[player]
    if data then
        pcall(function()
            if data.boxOutline then data.boxOutline:Remove() end
            if data.boxFill then data.boxFill:Remove() end
            if data.nameTag then data.nameTag:Remove() end
            if data.distanceTag then data.distanceTag:Remove() end
            if data.healthBarBg then data.healthBarBg:Remove() end
            if data.healthBarFill then data.healthBarFill:Remove() end
        end)
        espObjects[player] = nil
    end
    if eD[player] then
        pcall(function()
            for _, l in pairs(eD[player].L) do l:Remove() end
        end)
        eD[player] = nil
    end
end

local function isValid(plr)
    if not plr or plr == LocalPlayer then return false end
    local char = plr.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    if not isEnemy(plr) then return false end
    return true
end

RunService.RenderStepped:Connect(function(deltaTime)
    if not Camera then return end

    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    Circle.Position = center
    Circle.Radius = S.FovRadius
    Circle.Visible = S.ShowFov

    if S.Aimbot and MyTeam then
        local best = nil
        local bestDist = S.FovRadius + 1

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == LocalPlayer or IsSameTeam(plr) then continue end
            local char = plr.Character
            if not char then continue end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then continue end

            local part = char:FindFirstChild(S.TargetPart) or char:FindFirstChild("HumanoidRootPart")
            if part then
                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if dist < bestDist then
                        bestDist = dist
                        best = Vector2.new(pos.X, pos.Y)
                    end
                end
            end
        end
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local head = p.Character:FindFirstChild("Head")
            if head then
                if S.HeadSize > 1 then
                    head.Size = Vector3.new(S.HeadSize, S.HeadSize, S.HeadSize)
                    head.Transparency = 0.5
                    head.CanCollide = false
                else
                    head.Size = Vector3.new(2, 1, 1)
                    head.Transparency = 0
                    head.CanCollide = true
                end
            end
        end
    end

    if S.Triggerbot and (S.TriggerAlwaysOn or isTriggering) and tick() - tbDelay > (S.TriggerDelay / 1000) then
        local target = mouse.Target
        if target then
            local char = target.Parent
            if char and not char:FindFirstChildOfClass("Humanoid") then char = char.Parent end
            if char and char:IsA("Model") and char:FindFirstChildOfClass("Humanoid") then
                local p = Players:GetPlayerFromCharacter(char)
                if p and p ~= LocalPlayer and isValid(p) then
                    if mouse1click then mouse1click(); tbDelay = tick() end
                end
            end
        end
    end

    if not S.ESPEnabled then
        for _, data in pairs(espObjects) do
            if data then
                pcall(function()
                    data.boxOutline.Visible = false
                    data.boxFill.Visible = false
                    data.nameTag.Visible = false
                    data.distanceTag.Visible = false
                    data.healthBarBg.Visible = false
                    data.healthBarFill.Visible = false
                end)
            end
        end
    else
        local toRemove = {}

        for player, data in pairs(espObjects) do
            if not player or not player.Parent or not player.Character then
                table.insert(toRemove, player)
            else
                local char = player.Character
                local root = char:FindFirstChild("HumanoidRootPart")
                local head = char:FindFirstChild("Head")
                local humanoid = char:FindFirstChildOfClass("Humanoid")

                if not root or not head or not humanoid or humanoid.Health <= 0 or not isEnemy(player) then
                    pcall(function()
                        data.boxOutline.Visible = false
                        data.boxFill.Visible = false
                        data.nameTag.Visible = false
                        data.distanceTag.Visible = false
                        data.healthBarBg.Visible = false
                        data.healthBarFill.Visible = false
                    end)
                else
                    local rootPos, rootOnScreen = Camera:WorldToScreenPoint(root.Position)
                    local headPos, headOnScreen = Camera:WorldToScreenPoint(head.Position + Vector3.new(0, 0.5, 0))

                    if not rootOnScreen and not headOnScreen then
                        pcall(function()
                            data.boxOutline.Visible = false
                            data.boxFill.Visible = false
                            data.nameTag.Visible = false
                            data.distanceTag.Visible = false
                            data.healthBarBg.Visible = false
                            data.healthBarFill.Visible = false
                        end)
                    else
                        local height = math.abs(headPos.Y - rootPos.Y)
                        local width = height / 2
                        local boxX = rootPos.X - width / 2
                        local boxY = rootPos.Y

                        pcall(function()
                            data.boxOutline.Visible = true
                            data.boxOutline.Position = Vector2.new(boxX, boxY)
                            data.boxOutline.Size = Vector2.new(width, height)

                            data.boxFill.Visible = true
                            data.boxFill.Position = Vector2.new(boxX, boxY)
                            data.boxFill.Size = Vector2.new(width, height)

                            data.nameTag.Visible = true
                            data.nameTag.Text = player.Name
                            data.nameTag.Position = Vector2.new(rootPos.X, boxY - 18)

                            local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
                                and (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude
                                or 0
                            data.distanceTag.Visible = true
                            data.distanceTag.Text = string.format("%.0f m", dist)
                            data.distanceTag.Position = Vector2.new(rootPos.X, boxY + height + 2)

                            local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                            local barWidth = 2
                            local barHeight = height
                            local barX = boxX - barWidth - 4
                            local barY = boxY

                            data.healthBarBg.Visible = true
                            data.healthBarBg.Position = Vector2.new(barX, barY)
                            data.healthBarBg.Size = Vector2.new(barWidth, barHeight)

                            data.healthBarFill.Visible = true
                            data.healthBarFill.Position = Vector2.new(barX, barY + barHeight * (1 - healthPercent))
                            data.healthBarFill.Size = Vector2.new(barWidth, barHeight * healthPercent)
                            data.healthBarFill.Color = Color3.new(1 - healthPercent, healthPercent, 0)
                        end)
                    end
                end
            end
        end

        for _, uid in ipairs(toRemove) do
            removeESP(uid)
        end
    end

    for p, d in pairs(eD) do
        local ch = p.Character
        local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
        if hrp and isEnemy(p) then
            local hd = ch:FindFirstChild("Head") or hrp
            local tP, tO = Camera:WorldToViewportPoint(hd.Position + Vector3.new(0, (hd.Size and hd.Size.Y or 1) / 2 + 0.5, 0))
            local bP, bO = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
            if S.BoxESP and tO and bO then
                local w = math.abs(tP.Y - bP.Y) * 0.65
                local hV = Camera:WorldToViewportPoint(hrp.Position)
                local w2 = w / 2
                local xs = {hV.X - w2, hV.X + w2, hV.X + w2, hV.X - w2}
                local ys = {tP.Y, tP.Y, bP.Y, bP.Y}
                for i = 1, 4 do
                    if d.L[i] then
                        pcall(function()
                            d.L[i].Color = S.BoxCol
                            d.L[i].From = Vector2.new(xs[i], ys[i])
                            d.L[i].To = Vector2.new(xs[(i % 4) + 1], ys[(i % 4) + 1])
                            d.L[i].Visible = true
                        end)
                    end
                end
            else
                for _, l in pairs(d.L) do
                    if l then pcall(function() l.Visible = false end) end
                end
            end
        else
            for _, l in pairs(d.L) do
                if l then pcall(function() l.Visible = false end) end
            end
        end
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if IsSameTeam(plr) then
                if chamsObjects[plr] then chamsObjects[plr]:Destroy() chamsObjects[plr] = nil end
                if weaponChamsObjects[plr] then weaponChamsObjects[plr]:Destroy() weaponChamsObjects[plr] = nil end
            else
                local char = plr.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")

                if S.PlayerChamsEnabled and char and hum and hum.Health > 0 then
                    if not chamsObjects[plr] then
                        chamsObjects[plr] = CreateHighlight(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 255), 0.5)
                    end
                    if S.HealthBasedChams then
                        chamsObjects[plr].FillColor = GetHealthColor(hum.Health, hum.MaxHealth)
                    else
                        chamsObjects[plr].FillColor = Color3.fromRGB(255, 0, 0)
                    end
                    chamsObjects[plr].Adornee = char
                else
                    if chamsObjects[plr] then chamsObjects[plr]:Destroy() chamsObjects[plr] = nil end
                end

                if S.WeaponChamsEnabled and char then
                    local debris = Workspace:FindFirstChild("Debris")
                    local weapon = debris and debris:FindFirstChild(plr.Name .. "_Weapon")
                    if weapon then
                        if not weaponChamsObjects[plr] then
                            weaponChamsObjects[plr] = CreateHighlight(Color3.fromRGB(0, 255, 0), Color3.fromRGB(255, 255, 255), 0.5)
                        end
                        weaponChamsObjects[plr].Adornee = weapon
                    else
                        if weaponChamsObjects[plr] then weaponChamsObjects[plr]:Destroy() weaponChamsObjects[plr] = nil end
                    end
                else
                    if weaponChamsObjects[plr] then weaponChamsObjects[plr]:Destroy() weaponChamsObjects[plr] = nil end
                end
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(player)
    createESPForPlayer(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        if not espObjects[player] then
            createESPForPlayer(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
    if chamsObjects[player] then chamsObjects[player]:Destroy() chamsObjects[player] = nil end
    if weaponChamsObjects[player] then weaponChamsObjects[player]:Destroy() weaponChamsObjects[player] = nil end
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createESPForPlayer(player)
    end
end
