local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local Window = Luna:CreateWindow({
    Name = "wequil HUB",
    Subtitle = nil,
    LogoID = nil,
    LoadingEnabled = true,
    LoadingTitle = "OE HUB",
    LoadingSubtitle = "by saldı",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "OE Hub"
    },
    KeySystem = false,
    KeySettings = {}
})

Window:CreateHomeTab({
    SupportedExecutors = {},
    DiscordInvite = "ZF5fTWPh5a",
    Icon = 2,
})

local p = game:GetService("Players").LocalPlayer
local Plrs = game:GetService("Players")
local lp = Plrs.LocalPlayer
local rs = game:GetService("RunService")
local cam = workspace.CurrentCamera
local plrs = game:GetService("Players")
local workspace = game:GetService("Workspace")
local vim = game:GetService("VirtualInputManager")

local TrollTab = Window:CreateTab({
    Name = "Troll",
    Icon = "sports_esports",
    ImageSource = "Material",
    ShowTitle = true
})

TrollTab:CreateButton({
    Name = "Infinite Yield",
    Description = nil,
    Callback = function()
        pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
    end
})

TrollTab:CreateButton({
    Name = "Jet Patlatıcı (TA)",
    Description = nil,
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/rXiKU8Wp"))() end)
    end
})

TrollTab:CreateButton({
    Name = "Müzik Açıcı",
    Description = nil,
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/VL7xGTJ6"))() end)
    end
})

TrollTab:CreateButton({
    Name = "Küfür İftira",
    Description = nil,
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/r8u6LKKU"))() end)
    end
})

local hileTrollTarget = {_running = false, _player = nil}

local function getPlayerNames()
    local names = {}
    for _, pl in ipairs(game.Players:GetPlayers()) do
        if pl ~= lp then
            table.insert(names, pl.Name)
        end
    end
    if #names == 0 then table.insert(names, "Oyuncu Yok") end
    return names
end

local hileDD = TrollTab:CreateDropdown({
    Name = "Hile İftira - Hedef Seç",
    Description = "Listeyi yenilemek için butona bas",
    Options = getPlayerNames(),
    CurrentOption = {getPlayerNames()[1]},
    MultipleOptions = false,
    SpecialType = nil,
    Callback = function() end
}, "HileTrollDD")

TrollTab:CreateButton({
    Name = "Oyuncu Listesini Yenile",
    Description = nil,
    Callback = function()
        local names = getPlayerNames()
        hileDD:Refresh(names, {names[1]})
    end
})

TrollTab:CreateButton({
    Name = "Hile İftira Başlat",
    Description = nil,
    Callback = function()
        if hileTrollTarget._running then return end
        local selected = hileDD.CurrentOption
        local tn = type(selected) == "table" and selected[1] or selected
        if not tn or tn == "Oyuncu Yok" or tn == "" then
            game:GetService("StarterGui"):SetCore("SendNotification",{Title="Hata",Text="Geçerli bir oyuncu seç",Duration=3})
            return
        end
        local tp = game.Players:FindFirstChild(tn)
        if not tp then
            game:GetService("StarterGui"):SetCore("SendNotification",{Title="Hata",Text="Oyuncu bulunamadı",Duration=3})
            return
        end
        hileTrollTarget._running = true
        hileTrollTarget._player = tp
        task.spawn(function()
            while hileTrollTarget._running and hileTrollTarget._player do
                local c = hileTrollTarget._player.Character
                if c then
                    local h = c:FindFirstChildOfClass("Humanoid")
                    local hrp = c:FindFirstChild("HumanoidRootPart")
                    if h and hrp then
                        local cp = hrp.Position
                        hrp.CFrame = CFrame.new(Vector3.new(cp.X+math.random(-5,5)/10,cp.Y,cp.Z+math.random(-5,5)/10),cp+hrp.CFrame.LookVector)
                        local a = Instance.new("Animation")
                        a.AnimationId = "rbxassetid://180436148?"..tostring(math.random(1000,9999))
                        local at = h:LoadAnimation(a)
                        at.Looped = true; at:Play(); at:AdjustSpeed(math.random(5,20))
                    end
                end
                task.wait(0.1)
            end
        end)
    end
})

TrollTab:CreateButton({
    Name = "Hile İftira Durdur",
    Description = nil,
    Callback = function()
        if hileTrollTarget._player and hileTrollTarget._player.Character then
            local h = hileTrollTarget._player.Character:FindFirstChildOfClass("Humanoid")
            if h then
                for _, t in ipairs(h:GetPlayingAnimationTracks()) do t:Stop() end
                h.PlatformStand = false
                h:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end
        hileTrollTarget._running = false
        hileTrollTarget._player = nil
    end
})

local AnimTab = Window:CreateTab({
    Name = "Animasyonlar",
    Icon = "directions_run",
    ImageSource = "Material",
    ShowTitle = true
})

AnimTab:CreateButton({
    Name = "Tüm Animasyonları Durdur",
    Description = nil,
    Callback = function()
        local c = p.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then for _, t in ipairs(h:GetPlayingAnimationTracks()) do t:Stop() end end
        end
    end
})

local anims = {{"ArmDetach","33169583"},{"ArmTurbine","259438880"},{"BowDown","204292303"},{"Crouch","182724289"},{"Dab","183412246"},{"DinoWalk","204328711"},{"FloatSit","179224234"},{"FloorCrawl","282574440"},{"FullPunch","204062532"},{"FullSwing","218504594"},{"HeadThrow","35154961"},{"HeroJump","184574340"},{"Insane","33796059"},{"InsaneArms","27432691"},{"JumpingJacks","429681631"},{"LoopHead","35154961"},{"LoopSlam","204295235"},{"MegaInsane","184574340"},{"MoonDance","45834924"},{"MovingDance","429703734"},{"Scared","180612465"},{"SpinDance","429730430"},{"SpinDance2","186934910"},{"SuperPunch","126753849"},{"SwordSlam","204295235"},{"SwordSlice","35978879"},{"CrazySlash","674871189"},{"DownSlash","746398327"},{"Pull","675025795"},{"RotateSlash","675025570"},{"FlingArms","754656200"},{"FloatSlash","717879555"},{"WeirdZombie","708553116"},{"Bend","696096087"},{"Open","582855105"},{"R15Spinner","754658275"},{"ArmsOut","582384156"},{"CircleArm","698251653"},{"SandStorm","241061487"},{"Helicopter","259438880"},{"BarrelRoll","35154961"},{"Levitate","179224234"},{"TPose","429681631"},{"GodMode","33796059"},{"Hype","429730430"},{"Crawl","282574440"}}

local curAnim = nil
for _, a in ipairs(anims) do
    AnimTab:CreateButton({
        Name = a[1],
        Description = nil,
        Callback = function()
            local c = p.Character
            if c then
                local h = c:FindFirstChildOfClass("Humanoid")
                if h then
                    if curAnim then curAnim:Stop() end
                    local obj = Instance.new("Animation")
                    obj.AnimationId = "rbxassetid://"..a[2].."?"..tostring(math.random(1000,9999))
                    curAnim = h:LoadAnimation(obj)
                    curAnim.Priority = Enum.AnimationPriority.Action
                    curAnim:Play()
                end
            end
        end
    })
end

local AimTab = Window:CreateTab({
    Name = "Aim Bot",
    Icon = "gps_fixed",
    ImageSource = "Material",
    ShowTitle = true
})

local ae, he, ee = false, false, false
local fs = 150
local speedHackEnabled = false
local speedMultiplier = 3.5
local spinbotEnabled = false
local spinSpeed = 50.0
local triggerbotEnabled = false
local noclipEnabled = false
local bunnyhopEnabled = false

local espConfig = {
    color = Color3.new(1, 0, 0),
    thickness = 1
}
local activeBoxes = {}

local fovGui = Instance.new("ScreenGui")
fovGui.Name = "OEHubFOV"
fovGui.ResetOnSpawn = false
fovGui.Parent = game:GetService("CoreGui")

local fov = Instance.new("Frame")
fov.Size = UDim2.new(0, 150, 0, 150)
fov.Position = UDim2.new(0.5, -75, 0.5, -75)
fov.BackgroundTransparency = 1
fov.BorderSizePixel = 0
fov.Visible = false
fov.Parent = fovGui

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1.5
stroke.Color = Color3.new(1, 1, 1)
stroke.Transparency = 0.3
stroke.Parent = fov

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = fov

AimTab:CreateToggle({
    Name = "Aim Bot",
    Description = nil,
    CurrentValue = false,
    Callback = function(Value)
        ae = Value
        fov.Visible = ae
    end
}, "AimToggle")

AimTab:CreateSlider({
    Name = "FOV Boyutu",
    Range = {50, 300},
    Increment = 5,
    CurrentValue = 150,
    Callback = function(Value)
        fs = Value
        fov.Size = UDim2.new(0, fs, 0, fs)
        fov.Position = UDim2.new(0.5, -fs/2, 0.5, -fs/2)
    end
}, "FovSlider")

AimTab:CreateToggle({
    Name = "Hitbox Genişletici",
    Description = nil,
    CurrentValue = false,
    Callback = function(Value)
        he = Value
        for _, pl in ipairs(plrs:GetPlayers()) do
            if pl ~= lp and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                pl.Character.HumanoidRootPart.Size = he and Vector3.new(20,20,20) or Vector3.new(2,2,1)
                pl.Character.HumanoidRootPart.Transparency = he and 0.9 or 1
                if he then
                    local b = Instance.new("BoxHandleAdornment")
                    b.Size = Vector3.new(20,20,20); b.AlwaysOnTop = true; b.ZIndex = 10
                    b.Adornee = pl.Character.HumanoidRootPart; b.Color3 = Color3.new(1,0,0)
                    b.Transparency = 0.5; b.Name = "HB"; b.Parent = pl.Character.HumanoidRootPart
                else
                    for _, v in ipairs(pl.Character.HumanoidRootPart:GetChildren()) do
                        if v.Name == "HB" then v:Destroy() end
                    end
                end
            end
        end
    end
}, "HitboxToggle")

AimTab:CreateToggle({
    Name = "Dynamic 2D ESP",
    Description = "Accurate height/width box",
    CurrentValue = false,
    Callback = function(Value)
        ee = Value
        if not ee then
            for pl, box in pairs(activeBoxes) do
                pcall(function() box:Remove() end)
            end
            activeBoxes = {}
        end
    end
}, "EspToggle")

AimTab:CreateToggle({
    Name = "Speed Hack",
    Description = "Bypasses standard WalkSpeed limits",
    CurrentValue = false,
    Callback = function(Value)
        speedHackEnabled = Value
    end
}, "SpeedHackToggle")

AimTab:CreateSlider({
    Name = "Speed Multiplier",
    Range = {1, 10},
    Increment = 0.5,
    CurrentValue = 3.5,
    Callback = function(Value)
        speedMultiplier = Value
    end
}, "SpeedMultiplierSlider")

AimTab:CreateToggle({
    Name = "BunnyHop",
    Description = "Automatically jumps when touching the ground",
    CurrentValue = false,
    Callback = function(Value)
        bunnyhopEnabled = Value
    end
}, "BhopToggle")

AimTab:CreateToggle({
    Name = "SpinBot (Character Only)",
    Description = "Spins character root part without affecting camera view",
    CurrentValue = false,
    Callback = function(Value)
        spinbotEnabled = Value
    end
}, "SpinBotToggle")

AimTab:CreateSlider({
    Name = "Spin Speed",
    Range = {10, 200},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value)
        spinSpeed = Value
    end
}, "SpinSpeedSlider")

AimTab:CreateToggle({
    Name = "TriggerBot",
    Description = "Automatically clicks when aiming at an enemy",
    CurrentValue = false,
    Callback = function(Value)
        triggerbotEnabled = Value
    end
}, "TriggerBotToggle")

AimTab:CreateToggle({
    Name = "Noclip",
    Description = "Walk through walls",
    CurrentValue = false,
    Callback = function(Value)
        noclipEnabled = Value
    end
}, "NoclipToggle")

local MM2Tab = Window:CreateTab({
    Name = "MM2",
    Icon = "security",
    ImageSource = "Material",
    ShowTitle = true
})

local mm2RolesEnabled = false
local roleBillboards = {}

local function getPlayerRole(player)
    local char = player.Character
    if not char then return "Innocent", Color3.fromRGB(0, 255, 0) end

    local backpack = player:FindFirstChildOfClass("Backpack")
    
    local hasKnife = char:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife"))
    local hasGun = char:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun")) or char:FindFirstChild("Revolver") or (backpack and backpack:FindFirstChild("Revolver"))

    if hasKnife then
        return "Murderer", Color3.fromRGB(255, 0, 0)
    elseif hasGun then
        return "Sheriff", Color3.fromRGB(0, 120, 255)
    else
        return "Innocent", Color3.fromRGB(0, 255, 0)
    end
end

MM2Tab:CreateToggle({
    Name = "MM2 Role ESP",
    Description = "Shows Murderer, Sheriff, and Innocent status above heads",
    CurrentValue = false,
    Callback = function(Value)
        mm2RolesEnabled = Value
        if not mm2RolesEnabled then
            for _, gui in pairs(roleBillboards) do
                pcall(function() gui:Destroy() end)
            end
            roleBillboards = {}
        end
    end
}, "MM2RoleToggle")

MM2Tab:CreateButton({
    Name = "Drop Silaha Işınlan (Teleport to Gun Drop)",
    Description = "Teleports you to the dropped Sheriff gun",
    Callback = function()
        local droppedGun = nil
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "GunDrop" or obj.Name == "DroppedGun" or (obj:IsA("BasePart") and obj.Name == "Handle" and obj.Parent and obj.Parent.Name == "GunDrop") then
                droppedGun = obj:IsA("Model") and obj.PrimaryPart or obj
                break
            end
        end

        if droppedGun and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = droppedGun.CFrame
            game:GetService("StarterGui"):SetCore("SendNotification",{Title="OE HUB",Text="Silaha ışınlanıldı!",Duration=3})
        else
            game:GetService("StarterGui"):SetCore("SendNotification",{Title="Hata",Text="Yerde silah bulunamadı!",Duration=3})
        end
    end
})

MM2Tab:CreateButton({
    Name = "Şerif: Murderer'ı Tek Atışta Vur",
    Description = "Teleports/Aim-shoots the murderer if you are Sheriff",
    Callback = function()
        local role, _ = getPlayerRole(lp)
        if role ~= "Sheriff" then
            game:GetService("StarterGui"):SetCore("SendNotification",{Title="Hata",Text="Sen Şerif değilsin!",Duration=3})
            return
        end

        local murdererPlr = nil
        for _, pl in ipairs(plrs:GetPlayers()) do
            if pl ~= lp then
                local r, _ = getPlayerRole(pl)
                if r == "Murderer" then
                    murdererPlr = pl
                    break
                end
            end
        end

        if murdererPlr and murdererPlr.Character and murdererPlr.Character:FindFirstChild("Head") then
            local gun = lp.Character and lp.Character:FindFirstChild("Gun") or (lp:FindFirstChildOfClass("Backpack") and lp:FindFirstChildOfClass("Backpack"):FindFirstChild("Gun"))
            if gun and gun.Parent == lp.Backpack then
                gun.Parent = lp.Character
            end
            cam.CFrame = CFrame.new(cam.CFrame.Position, murdererPlr.Character.Head.Position)
            task.wait(0.05)
            pcall(function()
                vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait()
                vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end)
            game:GetService("StarterGui"):SetCore("SendNotification",{Title="OE HUB",Text="Murderer vuruldu!",Duration=3})
        else
            game:GetService("StarterGui"):SetCore("SendNotification",{Title="Hata",Text="Murderer bulunamadı!",Duration=3})
        end
    end
})

MM2Tab:CreateButton({
    Name = "Murderer: Herkesi Tek Atışta Öldür",
    Description = "Teleports behind everyone and kills them if you are Murderer",
    Callback = function()
        local role, _ = getPlayerRole(lp)
        if role ~= "Murderer" then
            game:GetService("StarterGui"):SetCore("SendNotification",{Title="Hata",Text="Sen Murderer değilsin!",Duration=3})
            return
        end

        local knife = lp.Character and lp.Character:FindFirstChild("Knife") or (lp:FindFirstChildOfClass("Backpack") and lp:FindFirstChildOfClass("Backpack"):FindFirstChild("Knife"))
        if knife and knife.Parent == lp.Backpack then
            knife.Parent = lp.Character
        end

        local myHrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if not myHrp then return end

        local originalCF = myHrp.CFrame
        for _, pl in ipairs(plrs:GetPlayers()) do
            if pl ~= lp and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = pl.Character.HumanoidRootPart
                myHrp.CFrame = hrp.CFrame * CFrame.new(0, 0, 2)
                task.wait(0.05)
                pcall(function()
                    vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait()
                    vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end)
                task.wait(0.05)
            end
        end
        myHrp.CFrame = originalCF
        game:GetService("StarterGui"):SetCore("SendNotification",{Title="OE HUB",Text="Herkes katledildi!",Duration=3})
    end
})

local function UpdateEsp(pl, char)
    if not char then
        if activeBoxes[pl] then
            pcall(function() activeBoxes[pl].Visible = false end)
        end
        return
    end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    
    if not activeBoxes[pl] then
        local success, box = pcall(function()
            return Drawing.new("Square")
        end)
        if success and box then
            box.Visible = false
            box.Filled = false
            box.Thickness = espConfig.thickness
            box.Color = espConfig.color
            activeBoxes[pl] = box
        else
            return
        end
    end
    
    local box = activeBoxes[pl]

    if not hrp or not ee or not humanoid or humanoid.Health <= 0 then
        if box then box.Visible = false end
        return
    end

    local _, onScreen = cam:WorldToViewportPoint(hrp.Position)
    
    if onScreen then
        local cf, size = char:GetBoundingBox()
        local topPos = (cf + Vector3.new(0, size.Y / 2, 0)).Position
        local bottomPos = (cf - Vector3.new(0, size.Y / 2, 0)).Position
        
        local top2D, topVisible = cam:WorldToViewportPoint(topPos)
        local bottom2D, bottomVisible = cam:WorldToViewportPoint(bottomPos)

        if topVisible and bottomVisible then
            local height = math.abs(bottom2D.Y - top2D.Y)
            local width = height * 0.5
            
            box.Size = Vector2.new(width, height)
            box.Position = Vector2.new(top2D.X - width / 2, top2D.Y)
            box.Visible = true
        else
            box.Visible = false
        end
    else
        box.Visible = false
    end
end

rs.RenderStepped:Connect(function(dt)
    if ae then
        fov.Position = UDim2.new(0.5, -fs/2, 0.5, -fs/2)
        local t, md = nil, math.huge
        for _, pl in ipairs(plrs:GetPlayers()) do
            if pl ~= lp and pl.Character and pl.Character:FindFirstChild("Head") then
                local h = pl.Character.Head
                local pos, vis = cam:WorldToViewportPoint(h.Position)
                if vis then
                    local d = (Vector2.new(pos.X,pos.Y) - Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)).Magnitude
                    if d < fs/2 and d < md then md = d; t = h end
                end
            end
        end
        if t then cam.CFrame = CFrame.new(cam.CFrame.Position, t.Position) end
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
            local enemyPlr = plrs:GetPlayerFromCharacter(target.Parent)
            if enemyPlr and enemyPlr ~= lp then
                pcall(function()
                    vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait()
                    vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end)
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
    
    if ee then
        for _, pl in ipairs(plrs:GetPlayers()) do
            if pl ~= lp then
                UpdateEsp(pl, pl.Character)
            end
        end
    end

    if mm2RolesEnabled then
        for _, pl in ipairs(plrs:GetPlayers()) do
            if pl ~= lp and pl.Character and pl.Character:FindFirstChild("Head") then
                local head = pl.Character.Head
                local role, color = getPlayerRole(pl)
                
                local billboard = roleBillboards[pl]
                if not billboard then
                    billboard = Instance.new("BillboardGui")
                    billboard.Name = "MM2RoleESP"
                    billboard.Size = UDim2.new(0, 100, 0, 40)
                    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                    billboard.AlwaysOnTop = true
                    
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Name = "RoleText"
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextScaled = true
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.TextStrokeTransparency = 0
                    textLabel.Parent = billboard
                    
                    billboard.Parent = head
                    roleBillboards[pl] = billboard
                end
                
                local txt = billboard:FindFirstChild("RoleText")
                if txt then
                    txt.Text = pl.Name .. "\n[" .. role .. "]"
                    txt.TextColor3 = color
                end
            else
                if roleBillboards[pl] then
                    roleBillboards[pl]:Destroy()
                    roleBillboards[pl] = nil
                end
            end
        end
    end
end)

rs.Heartbeat:Connect(function(dt)
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

plrs.PlayerRemoving:Connect(function(pl)
    if activeBoxes[pl] then
        pcall(function() activeBoxes[pl]:Remove() end)
        activeBoxes[pl] = nil
    end
    if roleBillboards[pl] then
        pcall(function() roleBillboards[pl]:Destroy() end)
        roleBillboards[pl] = nil
    end
end)

local ChatTab = Window:CreateTab({
    Name = "Chat Log",
    Icon = "forum",
    ImageSource = "Material",
    ShowTitle = true
})

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
        game:GetService("StarterGui"):SetCore("SendNotification",{Title="OE HUB",Text="Chat temizlendi",Duration=3})
    end
})

for _, pl in ipairs(Plrs:GetPlayers()) do
    pl.Chatted:Connect(function(m) addChatMsg(m, pl.Name) end)
end
Plrs.PlayerAdded:Connect(function(pl)
    pl.Chatted:Connect(function(m) addChatMsg(m, pl.Name) end)
end)
