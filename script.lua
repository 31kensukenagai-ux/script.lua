local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local Window = Luna:CreateWindow({
	Name = "Torrycxn&Clooter HUB",
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
local chamsObjects = {}
local weaponChamsObjects = {}
local wallhackObjects = {}
local wallhackEnabled = false

local S = {
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
}

local tbDelay = 0
local isTriggering = false
local mouse = LocalPlayer:GetMouse()

-- ===================== VISUALS (ESP) TAB =====================
local VisualsTab = Window:CreateTab({
	Name = "Visuals",
	Icon = "visibility",
	ImageSource = "Material",
	ShowTitle = true
})

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
	Range = {1, 20},
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
    end
    if i.KeyCode == S.TriggerKey then
        isTriggering = true
    end
    if i.KeyCode == Enum.KeyCode.K then
        wallhackEnabled = not wallhackEnabled
        print(wallhackEnabled and "✅ FULL WALLHACK ENABLED" or "❌ WALLHACK DISABLED")
        if not wallhackEnabled then
            for player, _ in pairs(wallhackObjects) do
                if wallhackObjects[player] then
                    if wallhackObjects[player].Highlight then wallhackObjects[player].Highlight:Destroy() end
                    wallhackObjects[player] = nil
                end
            end
        end
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

local function getTeamColor(player)
    if not player.Team then 
        return Color3.fromRGB(255, 220, 60) 
    end
    return player.Team.TeamColor.Color
end

local function createWallhackESP(player)
    if wallhackObjects[player] then return end
    if not isEnemy(player) then return end

    local character = player.Character
    if not character then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "WallHack"
    highlight.FillColor = getTeamColor(player)
    highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
    highlight.FillTransparency = 0.35
    highlight.OutlineTransparency = 1 -- Çerçeve çizgisi tamamen kapatıldı
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = character
    highlight.Parent = character

    wallhackObjects[player] = {
        Highlight = highlight
    }
end

local function removeWallhackESP(player)
    if wallhackObjects[player] then
        if wallhackObjects[player].Highlight then wallhackObjects[player].Highlight:Destroy() end
        wallhackObjects[player] = nil
    end
end

local function CreateHighlight(fill, trans)
    local h = Instance.new("Highlight")
    h.FillColor = fill
    h.OutlineColor = Color3.fromRGB(0, 0, 0)
    h.FillTransparency = trans
    h.OutlineTransparency = 1 -- Çerçeve çizgisi tamamen kapatıldı
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Enabled = true
    h.Parent = game:GetService("CoreGui")
    return h
end

local function GetHealthColor(health, maxhealth)
    local p = math.clamp(health / maxhealth, 0, 1)
    return Color3.fromRGB((1-p)*255, p*255, 50)
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

    if wallhackEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if isEnemy(player) then
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        if not wallhackObjects[player] then
                            createWallhackESP(player)
                        end
                    else
                        removeWallhackESP(player)
                    end
                else
                    removeWallhackESP(player)
                end
            end
        end
    end

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
        if p ~= LocalPlayer and not IsSameTeam(p) and p.Character then
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
                        chamsObjects[plr] = CreateHighlight(Color3.fromRGB(255, 0, 0), 0.5)
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
                            weaponChamsObjects[plr] = CreateHighlight(Color3.fromRGB(0, 255, 0), 0.5)
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
    player.CharacterAdded:Connect(function()
        if wallhackEnabled and isEnemy(player) then
            task.wait(0.3)
            createWallhackESP(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    removeWallhackESP(player)
    if chamsObjects[player] then chamsObjects[player]:Destroy() chamsObjects[player] = nil end
    if weaponChamsObjects[player] then weaponChamsObjects[player]:Destroy() weaponChamsObjects[player] = nil end
end)

print("Outline-Free & Team-Filtered Clean Wallhack loaded!")
