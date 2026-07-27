local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local Window = Luna:CreateWindow({
    Name = "! Torrycxn HUB",
    Subtitle = "BloxStrike Ultimate Anime Edition ",
    LogoID = nil,
    LoadingEnabled = true,
    LoadingTitle = "! Torrycxn",
    LoadingSubtitle = "by !Torrycxn",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "!Torrycxn HubUltimate"
    },
    KeySystem = false,
    KeySettings = {}
})


pcall(function()
    local coreGui = game:GetService("CoreGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AnimeBackgroundGuiV5"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = coreGui

    local bgImage = Instance.new("ImageLabel")
    bgImage.Name = "Background"
    bgImage.Size = UDim2.new(1, 0, 1, 0)
    bgImage.BackgroundTransparency = 1
    bgImage.Image = "rbxassetid://13809055877"
    bgImage.ScaleType = Enum.ScaleType.Stretch
    bgImage.ZIndex = -999
    bgImage.Parent = screenGui

    local gradient = Instance.new("UIGradient")
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(1, 0.5)
    })
    gradient.Color = ColorSequence.new(Color3.fromRGB(150, 70, 255), Color3.fromRGB(20, 5, 50))
    gradient.Parent = bgImage
end)

Window:CreateHomeTab({
    SupportedExecutors = {},
    DiscordInvite = "ZF5fTWPh5a",
    Icon = 2,
})

local Plrs = game:GetService("Players")
local lp = Plrs.LocalPlayer
local rs = game:GetService("RunService")
local cam = workspace.CurrentCamera
local workspace = game:GetService("Workspace")
local vim = game:GetService("VirtualInputManager")
local uis = game:GetService("UserInputService")
local lighting = game:GetService("Lighting")
local ts = game:GetService("TweenService")

local currentLang = "TR"
local translations = {
    TR = {
        AimTab = "Aim Bot & Görüş",
        MovementTab = "Gelişmiş Hareket",
        ExpansionTab = "Genişletme & Görsel",
        VisualExtrasTab = "Gelişmiş ESP & Shader",
        AnimationTab = "Animasyonlar",
        ChatTab = "Chat Log & Troll",
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
        CustomCrosshairToggle = "Özel Sniper Nişangahı (Crosshair)",
        NoRecoilToggle = "Geri Tepkisiz Silah (No Recoil)",
        InfiniteAmmoToggle = "Sınırsız Cephane & Anında Şarjör",
        FullbrightToggle = "Gece Görüşü / Aydınlık (Fullbright)",
        BombTimerToggle = "Bomba Zamanlayıcısı ve Durum Göstergesi",
        RapidFireToggle = "Seri Atış (Rapid Fire)",
        AutoPlantToggle = "Otomatik C4 Kurma Yardımı",
        AutoDefuseToggle = "Otomatik C4 Çözme Yardımı",
        HitSoundToggle = "Vuruş Sesi Efekti (Hitmarker Sound)",
        GrenadeTeleportToggle = "Bomba Işınlanması (Grenade Teleport)",
        SilentAimToggle = "Görünmez Mermi İsabeti (Silent Aim Assist)",
        AutoReloadToggle = "Boşta Otomatik Doldurma (Auto Reload)",
        FlyToggle = "Serbest Uçuş Modu (Fly Hack)",
        FlySpeedSlider = "Uçuş Hızı",
        ChamsToggle = "Karakter Chams (Duvar Arkası Renklendirme)",
        CustomSkyToggle = "Anime Gökyüzü Teması (Custom Sky)",
        FieldOfViewSlider = "Kamera Görüş Açısı (FOV Changer)",
        ThirdPersonToggle = "3. Şahıs Kamera Modu (Third Person)",
        AimbotBoneDropdown = "Hedef Kemik Seçimi",
        WallBangToggle = "Duvar Arkasından Vurma (WallBang / Penetration)",
        RainbowSkyToggle = "Gökkuşağı / Renkli Ortam Efekti",
        AutoHealToggle = "Otomatik Can / Yenilenme Desteği",
        WatermarkToggle = "Ekran Üstü Watermark / FPS Göstergesi"
    },
    EN = {
        AimTab = "Aim & Vision",
        MovementTab = "Advanced Movement",
        ExpansionTab = "Expansion & Visuals",
        VisualExtrasTab = "Advanced ESP & Shaders",
        AnimationTab = "Animations",
        ChatTab = "Chat Log & Troll",
        SettingsTab = "Settings",
        AimToggle = "Smart Aim Assist (Red Circle)",
        AimKey = "Lock Only Through Firing",
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
        CustomCrosshairToggle = "Custom Sniper Crosshair",
        NoRecoilToggle = "No Recoil",
        InfiniteAmmoToggle = "Advanced Infinite Ammo & Clip Bypass",
        FullbrightToggle = "Fullbright / Night Vision",
        BombTimerToggle = "Bomb Timer & Status Display",
        RapidFireToggle = "Rapid Fire",
        AutoPlantToggle = "Auto Bomb Planter",
        AutoDefuseToggle = "Auto Bomb Defuser",
        HitSoundToggle = "Hit Sound FX (Hitmarker)",
        GrenadeTeleportToggle = "Grenade Teleport (Toss TP)",
        SilentAimToggle = "Silent Aim Assist",
        AutoReloadToggle = "Auto Reload Empty Mag",
        FlyToggle = "Free Fly Mode",
        FlySpeedSlider = "Fly Speed",
        ChamsToggle = "Player Chams (Glowing Wallhack)",
        CustomSkyToggle = "Anime Atmosphere Skybox",
        FieldOfViewSlider = "Camera Field of View (FOV Changer)",
        ThirdPersonToggle = "Third Person Camera Mode",
        AimbotBoneDropdown = "Target Bone Selector",
        WallBangToggle = "Shoot Through Walls (WallBang / Penetration)",
        RainbowSkyToggle = "Rainbow Lighting Effect",
        AutoHealToggle = "Auto Health Support",
        WatermarkToggle = "On-Screen Watermark / FPS Display"
    }
}

local function t(key)
    if translations[currentLang] and translations[currentLang][key] then
        return translations[currentLang][key]
    end
    return translations["EN"][key] or key
end

local AimTab = Window:CreateTab({ Name = t("AimTab"), Icon = "gps_fixed", ImageSource = "Material", ShowTitle = true })
local MovementTab = Window:CreateTab({ Name = t("MovementTab"), Icon = "directions_run", ImageSource = "Material", ShowTitle = true })
local ExpansionTab = Window:CreateTab({ Name = t("ExpansionTab"), Icon = "aspect_ratio", ImageSource = "Material", ShowTitle = true })
local VisualExtrasTab = Window:CreateTab({ Name = t("VisualExtrasTab"), Icon = "palette", ImageSource = "Material", ShowTitle = true })
local AnimationTab = Window:CreateTab({ Name = t("AnimationTab"), Icon = "accessibility", ImageSource = "Material", ShowTitle = true })
local ChatTab = Window:CreateTab({ Name = t("ChatTab"), Icon = "forum", ImageSource = "Material", ShowTitle = true })
local SettingsTab = Window:CreateTab({ Name = t("SettingsTab"), Icon = "settings", ImageSource = "Material", ShowTitle = true })

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
local noRecoilEnabled = false
local infiniteAmmoEnabled = false
local fullbrightEnabled = false
local bombTimerEnabled = false
local rapidFireEnabled = false
local autoPlantEnabled = false
local autoDefuseEnabled = false
local hitSoundEnabled = false
local grenadeTpEnabled = false
local silentAimEnabled = false
local autoReloadEnabled = false
local flyEnabled = false
local flySpeed = 50
local chamsEnabled = false
local customSkyEnabled = false
local thirdPersonEnabled = false
local cameraFovValue = 70
local targetBone = "Head"
local wallBangEnabled = false
local rainbowSkyEnabled = false
local autoHealEnabled = false
local watermarkEnabled = true

local activeSkeletons = {}
local active3dBoxes = {}
local chamsCache = {}

local fovGui = Instance.new("ScreenGui")
fovGui.Name = "! TorrycxnFOVRed"
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
stroke.Color = Color3.fromRGB(255, 50, 100)
stroke.Transparency = 0.2
stroke.Parent = fovFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = fovFrame

local crosshairGui = Instance.new("ScreenGui")
crosshairGui.Name = "!TorrycxnHubCustomCrosshair"
crosshairGui.ResetOnSpawn = false
crosshairGui.Parent = game:GetService("CoreGui")

local crosshairDot = Instance.new("Frame")
crosshairDot.Size = UDim2.new(0, 6, 0, 6)
crosshairDot.Position = UDim2.new(0.5, -3, 0.5, -3)
crosshairDot.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
crosshairDot.BorderSizePixel = 0
crosshairDot.Visible = false
crosshairDot.Parent = crosshairGui

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = crosshairDot

local crossHLine = Instance.new("Frame")
crossHLine.Size = UDim2.new(0, 18, 0, 2)
crossHLine.Position = UDim2.new(0.5, -9, 0.5, -1)
crossHLine.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
crossHLine.BorderSizePixel = 0
crossHLine.Visible = false
crossHLine.Parent = crosshairGui

local crossVLine = Instance.new("Frame")
crossVLine.Size = UDim2.new(0, 2, 0, 18)
crossVLine.Position = UDim2.new(0.5, -1, 0.5, -9)
crossVLine.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
crossVLine.BorderSizePixel = 0
crossVLine.Visible = false
crossVLine.Parent = crosshairGui

local bombGui = Instance.new("ScreenGui")
bombGui.Name = "OEHubBombTimerV5"
bombGui.ResetOnSpawn = false
bombGui.Parent = game:GetService("CoreGui")

local bombLabel = Instance.new("TextLabel")
bombLabel.Size = UDim2.new(0, 340, 0, 45)
bombLabel.Position = UDim2.new(0.5, -170, 0.08, 0)
bombLabel.BackgroundTransparency = 0.35
bombLabel.BackgroundColor3 = Color3.fromRGB(25, 15, 35)
bombLabel.TextColor3 = Color3.fromRGB(255, 100, 150)
bombLabel.TextSize = 15
bombLabel.Font = Enum.Font.GothamBold
bombLabel.Visible = false
bombLabel.Parent = bombGui

-- Additional Watermark Display GUI
local watermarkGui = Instance.new("ScreenGui")
watermarkGui.Name = "OEHubWatermarkV5"
watermarkGui.ResetOnSpawn = false
watermarkGui.Parent = game:GetService("CoreGui")

local watermarkLabel = Instance.new("TextLabel")
watermarkLabel.Size = UDim2.new(0, 260, 0, 30)
watermarkLabel.Position = UDim2.new(0.01, 0, 0.01, 0)
watermarkLabel.BackgroundTransparency = 0.4
watermarkLabel.BackgroundColor3 = Color3.fromRGB(20, 10, 30)
watermarkLabel.TextColor3 = Color3.fromRGB(255, 120, 200)
watermarkLabel.TextSize = 13
watermarkLabel.Font = Enum.Font.GothamBold
watermarkLabel.Text = "wequil HUB | BloxStrike v5 🌸"
watermarkLabel.Visible = true
watermarkLabel.Parent = watermarkGui

local wCorner = Instance.new("UICorner")
wCorner.CornerRadius = UDim.new(0, 6)
wCorner.Parent = watermarkLabel

local function playHitSound()
    if not hitSoundEnabled then return end
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9060603952"
        sound.Volume = 1
        sound.Parent = game:GetService("SoundService")
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 1)
    end)
end

local function isTeammate(targetPlayer)
    if not targetPlayer or targetPlayer == lp then return true end
    if lp.Team and targetPlayer.Team then
        if lp.Team == targetPlayer.Team then return true end
        return false
    end
    return false
end

local isFiring = false
uis.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then isFiring = true end
end)
uis.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then isFiring = false end
end)

-- Tab Population: Aim & Vision
AimTab:CreateToggle({
    Name = t("AimToggle"),
    Description = "High precision lock system with anime styled tracking circle",
    CurrentValue = false,
    Callback = function(Value) ae = Value; fovFrame.Visible = ae end
}, "AimToggle")

AimTab:CreateToggle({
    Name = t("AimKey"),
    Description = "Engages only during active firing states",
    CurrentValue = false,
    Callback = function(Value) aimOnFireOnly = Value end
}, "AimFireToggle")

AimTab:CreateToggle({
    Name = t("WallBangToggle"),
    Description = "Allows bullets and weapons to pass through walls to hit targets",
    CurrentValue = false,
    Callback = function(Value) wallBangEnabled = Value end
}, "WallBangToggle")

AimTab:CreateDropdown({
    Name = t("AimbotBoneDropdown"),
    Description = "Select target bone tracking priority",
    Options = {"Head", "UpperTorso", "HumanoidRootPart"},
    CurrentOption = {"Head"},
    MultipleOptions = false,
    Callback = function(Option)
        local opt = type(Option) == "table" and (Option.Value or Option[1]) or Option
        targetBone = opt
    end
}, "BoneDropdown")

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
    Name = t("SilentAimToggle"),
    Description = "Redirects bullet hits seamlessly without camera snap",
    CurrentValue = false,
    Callback = function(Value) silentAimEnabled = Value end
}, "SilentAimToggle")

AimTab:CreateToggle({
    Name = t("HitboxToggle"),
    Description = "Expands opponent hit collision boxes for reliable hits",
    CurrentValue = false,
    Callback = function(Value)
        he = Value
        for _, pl in ipairs(Plrs:GetPlayers()) do
            if not isTeammate(pl) and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                pl.Character.HumanoidRootPart.Size = he and Vector3.new(16,16,16) or Vector3.new(2,2,1)
                pl.Character.HumanoidRootPart.Transparency = he and 0.9 or 1
            end
        end
    end
}, "HitboxToggle")

AimTab:CreateToggle({
    Name = t("NoRecoilToggle"),
    Description = "Removes weapon recoil entirely",
    CurrentValue = false,
    Callback = function(Value) noRecoilEnabled = Value end
}, "NoRecoilToggle")

AimTab:CreateToggle({
    Name = t("InfiniteAmmoToggle"),
    Description = "Bypasses clip counts and ammo reloads",
    CurrentValue = false,
    Callback = function(Value) infiniteAmmoEnabled = Value end
}, "InfiniteAmmoToggle")

AimTab:CreateToggle({
    Name = t("AutoReloadToggle"),
    Description = "Instantly reloads when clip is dry",
    CurrentValue = false,
    Callback = function(Value) autoReloadEnabled = Value end
}, "AutoReloadToggle")

AimTab:CreateToggle({
    Name = t("RapidFireToggle"),
    Description = "Unlocks maximum weapon firing rate",
    CurrentValue = false,
    Callback = function(Value) rapidFireEnabled = Value end
}, "RapidFireToggle")

AimTab:CreateToggle({
    Name = t("SniperFixToggle"),
    Description = "Clears full-screen lens overlay for clear visibility",
    CurrentValue = true,
    Callback = function(Value) sniperFixEnabled = Value end
}, "SniperFixToggle")

AimTab:CreateToggle({
    Name = t("CustomCrosshairToggle"),
    Description = "Displays customizable center crosshair point",
    CurrentValue = true,
    Callback = function(Value) customCrosshairEnabled = Value end
}, "CustomCrosshairToggle")

-- Tab Population: Visual Extras & Shaders
VisualExtrasTab:CreateToggle({
    Name = t("ChamsToggle"),
    Description = "Applies glowing high-visibility aesthetic highlights to players through walls",
    CurrentValue = false,
    Callback = function(Value)
        chamsEnabled = Value
        if not chamsEnabled then
            for _, pData in pairs(chamsCache) do
                pcall(function() pData:Destroy() end)
            end
            chamsCache = {}
        end
    end
}, "ChamsToggle")

VisualExtrasTab:CreateToggle({
    Name = t("CustomSkyToggle"),
    Description = "Transforms the game skybox into an anime twilight aesthetic atmosphere",
    CurrentValue = false,
    Callback = function(Value)
        customSkyEnabled = Value
        if customSkyEnabled then
            pcall(function()
                local existingSky = lighting:FindFirstChild("OEAnimeSky")
                if not existingSky then
                    local sky = Instance.new("Sky")
                    sky.Name = "OEAnimeSky"
                    sky.SkyboxBk = "rbxassetid://155097235"
                    sky.SkyboxDn = "rbxassetid://155097239"
                    sky.SkyboxFt = "rbxassetid://155097245"
                    sky.SkyboxLf = "rbxassetid://155097255"
                    sky.SkyboxRt = "rbxassetid://155097261"
                    sky.SkyboxUp = "rbxassetid://155097268"
                    sky.Parent = lighting
                end
            end)
        else
            pcall(function()
                local sky = lighting:FindFirstChild("OEAnimeSky")
                if sky then sky:Destroy() end
            end)
        end
    end
}, "CustomSkyToggle")

VisualExtrasTab:CreateToggle({
    Name = t("RainbowSkyToggle"),
    Description = "Cycles map lighting colors dynamically through a vivid spectrum",
    CurrentValue = false,
    Callback = function(Value) rainbowSkyEnabled = Value end
}, "RainbowSkyToggle")

VisualExtrasTab:CreateSlider({
    Name = t("FieldOfViewSlider"),
    Range = {50, 120},
    Increment = 1,
    CurrentValue = 70,
    Callback = function(Value)
        cameraFovValue = Value
        cam.FieldOfView = cameraFovValue
    end
}, "CameraFOVSlider")

VisualExtrasTab:CreateToggle({
    Name = t("ThirdPersonToggle"),
    Description = "Switches camera perspective to 3rd person view",
    CurrentValue = false,
    Callback = function(Value)
        thirdPersonEnabled = Value
        if thirdPersonEnabled then
            lp.CameraMode = Enum.CameraMode.Classic
            cam.CameraSubject = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
        else
            lp.CameraMode = Enum.CameraMode.LockFirstPerson
        end
    end
}, "ThirdPersonToggle")

VisualExtrasTab:CreateToggle({
    Name = t("WatermarkToggle"),
    Description = "Displays UI status watermark overlay on screen",
    CurrentValue = true,
    Callback = function(Value)
        watermarkEnabled = Value
        watermarkLabel.Visible = watermarkEnabled
    end
}, "WatermarkToggle")

-- Tab Population: Expansion & ESP
ExpansionTab:CreateToggle({
    Name = t("SkeletonEspToggle"),
    Description = "Clean mapping of structural opponent elements and distance markers",
    CurrentValue = false,
    Callback = function(Value) skeletonEspEnabled = Value end
}, "SkeletonEspToggle")

ExpansionTab:CreateToggle({
    Name = t("FullbrightToggle"),
    Description = "Brightens all dark map corners for complete visibility",
    CurrentValue = false,
    Callback = function(Value) fullbrightEnabled = Value end
}, "FullbrightToggle")

ExpansionTab:CreateToggle({
    Name = t("BombTimerToggle"),
    Description = "Displays live C4 detonation timer panel on screen",
    CurrentValue = false,
    Callback = function(Value)
        bombTimerEnabled = Value
        bombLabel.Visible = bombTimerEnabled
    end
}, "BombTimerToggle")

ExpansionTab:CreateToggle({
    Name = t("HitSoundToggle"),
    Description = "Plays satisfying hitmarker feedback sound on successful hit",
    CurrentValue = false,
    Callback = function(Value) hitSoundEnabled = Value end
}, "HitSoundToggle")

-- Tab Population: Movement & Utility
MovementTab:CreateToggle({
    Name = t("SpeedHackToggle"),
    Description = "Optimized velocity movement adjustments",
    CurrentValue = false,
    Callback = function(Value) speedHackEnabled = Value end
}, "SpeedHackToggle")

MovementTab:CreateSlider({
    Name = t("SpeedMultiplierSlider"),
    Range = {1, 10},
    Increment = 0.5,
    CurrentValue = 3.5,
    Callback = function(Value) speedMultiplier = Value end
}, "SpeedMultiplierSlider")

MovementTab:CreateToggle({
    Name = t("FlyToggle"),
    Description = "Enables spatial free-flight control mode",
    CurrentValue = false,
    Callback = function(Value) flyEnabled = Value end
}, "FlyToggle")

MovementTab:CreateSlider({
    Name = t("FlySpeedSlider"),
    Range = {10, 200},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value) flySpeed = Value end
}, "FlySpeedSlider")

MovementTab:CreateToggle({
    Name = t("BhopToggle"),
    Description = "Maintains smooth continuous momentum jumps",
    CurrentValue = false,
    Callback = function(Value) bunnyhopEnabled = Value end
}, "BhopToggle")

MovementTab:CreateToggle({
    Name = t("SpinBotToggle"),
    Description = "Smoothly rotates character orientation model",
    CurrentValue = false,
    Callback = function(Value) spinbotEnabled = Value end
}, "SpinBotToggle")

MovementTab:CreateSlider({
    Name = t("SpinSpeedSlider"),
    Range = {10, 200},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value) spinSpeed = Value end
}, "SpinSpeedSlider")

MovementTab:CreateToggle({
    Name = t("TriggerBotToggle"),
    Description = "Auto fires when crosshair crosses target entity",
    CurrentValue = false,
    Callback = function(Value) triggerbotEnabled = Value end
}, "TriggerBotToggle")

MovementTab:CreateToggle({
    Name = t("GrenadeTeleportToggle"),
    Description = "Instantly teleports your character position to thrown utilities",
    CurrentValue = false,
    Callback = function(Value) grenadeTpEnabled = Value end
}, "GrenadeTPToggle")

MovementTab:CreateToggle({
    Name = t("AutoPlantToggle"),
    Description = "Instantly completes C4 bomb planting sequences",
    CurrentValue = false,
    Callback = function(Value) autoPlantEnabled = Value end
}, "AutoPlantToggle")

MovementTab:CreateToggle({
    Name = t("AutoDefuseToggle"),
    Description = "Instantly completes C4 bomb defusal interactions",
    CurrentValue = false,
    Callback = function(Value) autoDefuseEnabled = Value end
}, "AutoDefuseToggle")

MovementTab:CreateToggle({
    Name = t("AutoHealToggle"),
    Description = "Continuously restores character humanoid health pool",
    CurrentValue = false,
    Callback = function(Value) autoHealEnabled = Value end
}, "AutoHealToggle")

MovementTab:CreateToggle({
    Name = t("NoclipToggle"),
    Description = "Traverse map walls and obstacles seamlessly",
    CurrentValue = false,
    Callback = function(Value) noclipEnabled = Value end
}, "NoclipToggle")

-- Tab Population: Animations
local currentAnimTrack = nil
local function playAnimation(animId)
    pcall(function()
        if currentAnimTrack then currentAnimTrack:Stop(); currentAnimTrack = nil end
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

AnimationTab:CreateButton({ Name = "Kutlama Dansı (Anime Dance)", Callback = function() playAnimation(507710273) end })
AnimationTab:CreateButton({ Name = "Selamlama (Wave)", Callback = function() playAnimation(507770677) end })
AnimationTab:CreateButton({ Name = "Kahkaha (Laugh)", Callback = function() playAnimation(507771019) end })
AnimationTab:CreateButton({ Name = "Mücadele Duruşu (Combat Stance)", Callback = function() playAnimation(507772104) end })
AnimationTab:CreateButton({ Name = "Zafer Pozu (Victory Pose)", Callback = function( ) playAnimation(507776043) end })
AnimationTab:CreateButton({ Name = "Animasyonları Durdur / Stop Animations", Callback = function() if currentAnimTrack then currentAnimTrack:Stop(); currentAnimTrack = nil end end })

-- Tab Population: Chat & Troll
ChatTab:CreateButton({
    Name = "Anime Slogan Spam Chat",
    Callback = function()
        pcall(function()
            local textService = game:GetService("TextChatService")
            if textService.ChatInputBarConfiguration and textService.ChatInputBarConfiguration.TargetTextChannel then
                textService.ChatInputBarConfiguration.TargetTextChannel:SendAsync("OE Hub Ultimate | BloxStrike Extended v5! 🌸✨")
            else
                game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("OE Hub Ultimate | BloxStrike Extended v5! 🌸✨", "All")
            end
        end)
    end
})

ChatTab:CreateButton({
    Name = "Pro Gamer Flex Chat",
    Callback = function()
        pcall(function()
            local textService = game:GetService("TextChatService")
            if textService.ChatInputBarConfiguration and textService.ChatInputBarConfiguration.TargetTextChannel then
                textService.ChatInputBarConfiguration.TargetTextChannel:SendAsync("Too fast, too clean! Powered by OE Hub Ultimate 🚀")
            else
                game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("Too fast, too clean! Powered by OE Hub Ultimate 🚀", "All")
            end
        end)
    end
})

workspace.ChildAdded:Connect(function(child)
    if not grenadeTpEnabled then return end
    if child.Name:lower():find("grenade") or child.Name:lower():find("flash") or child.Name:lower():find("smoke") then
        task.wait(0.2)
        pcall(function()
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                local part = child:FindFirstChildWhichIsA("BasePart") or child
                if part then lp.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 3, 0) end
            end
        end)
    end
end)

-- Main Render Loop & Extended Feature Logic Handler
rs.RenderStepped:Connect(function(dt)
    if fullbrightEnabled then
        pcall(function() lighting.Brightness = 3; lighting.ClockTime = 12; lighting.GlobalShadows = false end)
    end

    if rainbowSkyEnabled then
        pcall(function()
            local hue = (tick() % 10) / 10
            lighting.Ambient = Color3.fromHSV(hue, 1, 1)
            lighting.OutdoorAmbient = Color3.fromHSV(hue, 0.8, 0.9)
        end)
    end

    if infiniteAmmoEnabled then
        pcall(function()
            if lp.Character then
                for _, tool in ipairs(lp.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        for _, v in pairs(tool:GetDescendants()) do
                            if v:IsA("NumberValue") or v:IsA("IntValue") then
                                local lname = string.lower(v.Name)
                                if lname:find("ammo") or lname:find("clip") or lname:find("mag") then v.Value = 9999 end
                            end
                        end
                    end
                end
            end
        end)
    end

    if autoHealEnabled then
        pcall(function()
            if lp.Character then
                local hum = lp.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 and hum.Health < hum.MaxHealth then
                    hum.Health = hum.MaxHealth
                end
            end
        end)
    end

    crosshairDot.Visible = customCrosshairEnabled
    crossHLine.Visible = customCrosshairEnabled
    crossVLine.Visible = customCrosshairEnabled

    if chamsEnabled then
        for _, pl in ipairs(Plrs:GetPlayers()) do
            if pl ~= lp and not isTeammate(pl) and pl.Character then
                if not chamsCache[pl] then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "OEChamsHighlight"
                    highlight.Adornee = pl.Character
                    highlight.FillColor = Color3.fromRGB(255, 80, 150)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.4
                    highlight.OutlineTransparency = 0.1
                    highlight.Parent = pl.Character
                    chamsCache[pl] = highlight
                end
            elseif chamsCache[pl] then
                chamsCache[pl]:Destroy()
                chamsCache[pl] = nil
            end
        end
    end

    -- WallBang / Penetration Safe Override Logic
    if wallBangEnabled then
        for _, pl in ipairs(Plrs:GetPlayers()) do
            if pl ~= lp and not isTeammate(pl) and pl.Character then
                local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CanCollide = false
                end
            end
        end
    end

    if ae then
        local canLock = true
        if aimOnFireOnly then canLock = isFiring end
        if canLock then
            local targetPartObj, shortestDistance = nil, math.huge
            local centerScreen = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
            for _, pl in ipairs(Plrs:GetPlayers()) do
                if not isTeammate(pl) and pl.Character then
                    local targetNode = pl.Character:FindFirstChild(targetBone) or pl.Character:FindFirstChild("Head")
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
            if targetPartObj then cam.CFrame = CFrame.new(cam.CFrame.Position, targetPartObj.Position) end
        end
    end

    if triggerbotEnabled then
        pcall(function()
            local mouse = lp:GetMouse()
            local target = mouse.Target
            if target and target.Parent then
                local enemyPlr = Plrs:GetPlayerFromCharacter(target.Parent)
                if enemyPlr and not isTeammate(enemyPlr) then
                    vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait(0.05)
                    vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end
            end
        end)
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
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = hrp.CFrame * CFrame.Angles(0, dt * spinSpeed, 0) end
        end
    end

    if flyEnabled then
        local character = lp.Character
        if character then
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local moveDir = Vector3.new()
                if uis:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
                hrp.AssemblyLinearVelocity = moveDir * flySpeed
            end
        end
    end

    if noclipEnabled then
        local character = lp.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

rs.Heartbeat:Connect(function()
    if not speedHackEnabled then return end
    local character = lp.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid then return end
    local moveDirection = humanoid.MoveDirection
    if moveDirection.Magnitude > 0 then
        local targetSpeed = humanoid.WalkSpeed * speedMultiplier
        hrp.AssemblyLinearVelocity = Vector3.new(moveDirection.X * targetSpeed, hrp.AssemblyLinearVelocity.Y, moveDirection.Z * targetSpeed)
    end
end)
