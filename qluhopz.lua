local Airflow = loadstring(game:HttpGet("https://raw.githubusercontent.com/PookiePepelsss/Airflow-UI/refs/heads/main/Source.luau"))()

local Players = cloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = cloneref(game:GetService("TweenService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local RunService = cloneref(game:GetService("RunService"))

if getgenv().__montex_kill then
    pcall(getgenv().__montex_kill)
    getgenv().__montex_kill = nil
end

pcall(function()
    local gethui = rawget(getgenv(), "gethui")
    local containers = { LocalPlayer:WaitForChild("PlayerGui") }
    if type(gethui) == "function" then
        local ok, hui = pcall(gethui)
        if ok and hui then table.insert(containers, hui) end
    end
    pcall(function() table.insert(containers, game:GetService("CoreGui")) end)
    for _, c in ipairs(containers) do
        if c then
            local g = c:FindFirstChild("MontexIntro")
            if g then g:Destroy() end
        end
    end
end)

local COLORS = {
    Background = Color3.fromRGB(8, 12, 24),
    Surface    = Color3.fromRGB(12, 18, 34),
    Stroke     = Color3.fromRGB(28, 42, 72),
    Accent     = Color3.fromRGB(56, 132, 255),
    Text       = Color3.fromRGB(220, 230, 255),
    Muted      = Color3.fromRGB(120, 140, 180),
}

local FONTS = {
    Title = Font.new("rbxasset://fonts/families/Satisfy.json", Enum.FontWeight.Regular),
    Discord = Font.new("rbxasset://fonts/families/Inter.json", Enum.FontWeight.SemiBold),
    Subtitle = Font.new("rbxasset://fonts/families/Inter.json", Enum.FontWeight.Regular),
}

local ICON_ID = "rbxassetid://135298897189778"
local HUB_NAME = "Montex Hub"
local DISCORD = "discord.gg/montex"
local SUB_ONE = "Thank you for using Montex"
local SUB_TWO = "Montex is starting"

local introGui = Instance.new("ScreenGui")
introGui.Name = "MontexIntro"
introGui.IgnoreGuiInset = true
introGui.ResetOnSpawn = false
introGui.DisplayOrder = 2147483647
introGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
introGui.Parent = PlayerGui

local function pushToTop()
    pcall(function()
        local gethui = rawget(getgenv(), "gethui")
        if type(gethui) == "function" then
            local ok, hui = pcall(gethui)
            if ok and hui then introGui.Parent = hui; return end
        end
    end)
end
pushToTop()

local cover = Instance.new("Frame")
cover.Name = "Cover"
cover.BackgroundColor3 = COLORS.Background
cover.BorderSizePixel = 0
cover.Size = UDim2.fromScale(1, 1)
cover.Position = UDim2.fromScale(1, 0)
cover.ZIndex = 1
cover.Parent = introGui

local container = Instance.new("Frame")
container.Name = "Container"
container.BackgroundTransparency = 1
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.fromScale(0.5, 0.5)
container.Size = UDim2.fromScale(1, 1)
container.ZIndex = 3
container.Parent = introGui

local icon = Instance.new("ImageLabel")
icon.Name = "Icon"
icon.BackgroundTransparency = 1
icon.AnchorPoint = Vector2.new(0.5, 0.5)
icon.Position = UDim2.fromScale(0.5, 0.42)
icon.Size = UDim2.fromOffset(140, 140)
icon.Image = ICON_ID
icon.ImageColor3 = COLORS.Text
icon.ScaleType = Enum.ScaleType.Fit
icon.ZIndex = 4
icon.Parent = container

local iconGlow = Instance.new("ImageLabel")
iconGlow.Name = "IconGlow"
iconGlow.BackgroundTransparency = 1
iconGlow.AnchorPoint = Vector2.new(0.5, 0.5)
iconGlow.Position = UDim2.fromScale(0.5, 0.42)
iconGlow.Size = UDim2.fromOffset(220, 220)
iconGlow.Image = ICON_ID
iconGlow.ImageColor3 = COLORS.Accent
iconGlow.ImageTransparency = 0.75
iconGlow.ScaleType = Enum.ScaleType.Fit
iconGlow.ZIndex = 3
iconGlow.Parent = container

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.BackgroundTransparency = 1
titleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
titleLabel.Position = UDim2.fromScale(0.5, 0.60)
titleLabel.Size = UDim2.fromOffset(480, 56)
titleLabel.FontFace = FONTS.Title
titleLabel.Text = ""
titleLabel.TextColor3 = COLORS.Text
titleLabel.TextSize = 52
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.TextTransparency = 1
titleLabel.ZIndex = 5
titleLabel.Parent = container

local discordLabel = Instance.new("TextLabel")
discordLabel.Name = "Discord"
discordLabel.BackgroundTransparency = 1
discordLabel.AnchorPoint = Vector2.new(0.5, 0.5)
discordLabel.Position = UDim2.fromScale(0.5, 0.700)
discordLabel.Size = UDim2.fromOffset(440, 24)
discordLabel.FontFace = FONTS.Discord
discordLabel.Text = ""
discordLabel.TextColor3 = COLORS.Accent
discordLabel.TextSize = 18
discordLabel.TextXAlignment = Enum.TextXAlignment.Center
discordLabel.TextTransparency = 1
discordLabel.ZIndex = 5
discordLabel.Parent = container

local subLabel = Instance.new("TextLabel")
subLabel.Name = "Subtitle"
subLabel.BackgroundTransparency = 1
subLabel.AnchorPoint = Vector2.new(0.5, 0.5)
subLabel.Position = UDim2.fromScale(0.5, 0.775)
subLabel.Size = UDim2.fromOffset(440, 22)
subLabel.FontFace = FONTS.Subtitle
subLabel.Text = ""
subLabel.TextColor3 = COLORS.Muted
subLabel.TextSize = 16
subLabel.TextXAlignment = Enum.TextXAlignment.Center
subLabel.TextTransparency = 1
subLabel.ZIndex = 5
subLabel.Parent = container

local skipRequested = false
local skipConn
skipConn = UserInputService.InputBegan:Connect(function(_, gp)
    if gp then return end
    skipRequested = true
end)

local function tween(obj, time, props, style, dir)
    local info = TweenInfo.new(time, style or Enum.EasingStyle.Sine, dir or Enum.EasingDirection.InOut, 0, false, 0)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local function waitTween(t)
    if t then t.Completed:Wait() end
end

local function smoothSwipe(obj, targetPos, duration, skip)
    local startPos = obj.Position
    local elapsed = 0
    local conn
    conn = RunService.RenderStepped:Connect(function(dt)
        if skip() then
            obj.Position = targetPos
            if conn then conn:Disconnect() end
            return
        end
        elapsed = elapsed + dt
        local t = math.clamp(elapsed / duration, 0, 1)
        local eased = 0.5 - 0.5 * math.cos(math.pi * t)
        local x = startPos.X.Scale + (targetPos.X.Scale - startPos.X.Scale) * eased
        local xo = startPos.X.Offset + (targetPos.X.Offset - startPos.X.Offset) * eased
        local y = startPos.Y.Scale + (targetPos.Y.Scale - startPos.Y.Scale) * eased
        local yo = startPos.Y.Offset + (targetPos.Y.Offset - startPos.Y.Offset) * eased
        obj.Position = UDim2.new(x, xo, y, yo)
        if t >= 1 then
            obj.Position = targetPos
            if conn then conn:Disconnect() end
        end
    end)
    while conn.Connected and not skip() do
        task.wait()
    end
    if conn.Connected then conn:Disconnect() end
    obj.Position = targetPos
end

task.spawn(function()
    cover.Position = UDim2.fromScale(1, 0)
    waitTween(tween(cover, 0.7, { Position = UDim2.fromScale(0, 0) }, Enum.EasingStyle.Sine))

    local spinElapsed = 0
    local glowSpin = RunService.Heartbeat:Connect(function(dt)
        spinElapsed = spinElapsed + dt
        iconGlow.Rotation = (spinElapsed * 14) % 360
    end)

    local pulseIn = tween(iconGlow, 1.6, { ImageTransparency = 0.5 }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    pulseIn.Completed:Connect(function()
        if skipRequested then return end
        local pulseOut = tween(iconGlow, 1.6, { ImageTransparency = 0.85 }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        pulseOut.Completed:Connect(function()
            if skipRequested then return end
            tween(iconGlow, 1.6, { ImageTransparency = 0.5 }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        end)
    end)

    task.wait(0.9)

    local swipeTarget = UDim2.new(0.5, -110, 0.42, 0)
    iconGlow.Position = swipeTarget
    if skipRequested then
        icon.Position = swipeTarget
        iconGlow.ImageTransparency = 0.9
    else
        smoothSwipe(icon, swipeTarget, 1.6, function() return skipRequested end)
        tween(iconGlow, 0.5, { ImageTransparency = 0.9 })
    end

    titleLabel.Text = HUB_NAME
    discordLabel.Text = DISCORD
    tween(titleLabel, 0.8, { TextTransparency = 0 }, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    tween(discordLabel, 1.0, { TextTransparency = 0 }, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

    task.wait(0.6)
    subLabel.Text = SUB_ONE
    tween(subLabel, 0.6, { TextTransparency = 0 })

    local t0 = os.clock()
    while os.clock() - t0 < 2.4 and not skipRequested do
        task.wait(0.05)
    end

    local fadeSub = tween(subLabel, 0.6, { TextTransparency = 1 })
    waitTween(fadeSub)

    subLabel.Text = SUB_TWO
    tween(subLabel, 0.6, { TextTransparency = 0 })

    local t1 = os.clock()
    while os.clock() - t1 < 1.8 and not skipRequested do
        task.wait(0.05)
    end

    glowSpin:Disconnect()
    if skipConn then skipConn:Disconnect() end

    tween(subLabel, 0.5, { TextTransparency = 1 })
    tween(titleLabel, 0.7, { TextTransparency = 1 })
    tween(discordLabel, 0.7, { TextTransparency = 1 })
    tween(icon, 0.7, { ImageTransparency = 1 })
    tween(iconGlow, 0.7, { ImageTransparency = 1 })

    waitTween(tween(cover, 0.9, { BackgroundTransparency = 1 }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))

    introGui:Destroy()
end)

task.spawn(function()
    Airflow:LoadFont({ Name = "ValleySans" })
end)

local MidnightBlue = {
    Background   = Color3.fromRGB(8, 12, 24),
    Surface      = Color3.fromRGB(12, 18, 34),
    Surface2     = Color3.fromRGB(16, 24, 44),
    Surface3     = Color3.fromRGB(24, 34, 58),
    Stroke       = Color3.fromRGB(28, 42, 72),
    StrokeHover  = Color3.fromRGB(56, 90, 150),
    Accent       = Color3.fromRGB(56, 132, 255),
    AccentDark   = Color3.fromRGB(10, 16, 30),
    Text         = Color3.fromRGB(220, 230, 255),
    Muted        = Color3.fromRGB(120, 140, 180),
    Glow         = Color3.fromRGB(180, 210, 255),
    Warning      = Color3.fromRGB(240, 180, 70),
    Success      = Color3.fromRGB(64, 200, 140),
    Error        = Color3.fromRGB(235, 90, 100),
}

local Window = Airflow:CreateWindow({
    Name = "Montex Hub",
    LoadingSubtitle = "by qlu9",
    Theme = MidnightBlue,
    ToggleUIKeybind = "RightControl",
    Icon = "rbxassetid://135298897189778",
    ConfigurationSaving = { Enabled = true, FolderName = "MontexHub", FileName = "default" },
    Home = {
        Name = "Home",
        Stats = { "FPS", "Ping", "Executor", "Game", "Region", "Time" },
        Pages = {
            {
                Name = "Changelog",
                Icon = "scroll-text",
                Entries = {
                    { Title = "v1.3", Tag = "Latest", Changes = { "Modern glass visualizers gated to toggle", "Magnet/reach labels as HUD cards", "3PT-only filter for Aural", "Anti Lag with shadow/texture/post-fx strip" } },
                },
            },
        },
    },
})

local LocalPlayer        = Players.LocalPlayer
local UserInputService   = cloneref(game:GetService("UserInputService"))
local RunService         = cloneref(game:GetService("RunService"))
local ReplicatedStorage  = cloneref(game:GetService("ReplicatedStorage"))
local TweenService       = cloneref(game:GetService("TweenService"))
local CollectionService  = cloneref(game:GetService("CollectionService"))
local TeleportService    = cloneref(game:GetService("TeleportService"))
local HttpService        = cloneref(game:GetService("HttpService"))
local Input              = cloneref(game:GetService("VirtualInputManager"))
local Stats              = cloneref(game:GetService("Stats"))
local SharedTableRegistry= cloneref(game:GetService("SharedTableRegistry"))
local Camera             = workspace.CurrentCamera

local DeviceEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("deviceEvent")

local Janitor = (function()
    local Janitor = {}
    Janitor.__index = Janitor
    Janitor.ClassName = "Janitor"
    local DEFAULT_METHODS = { "Destroy", "Disconnect", "destroy", "disconnect", "Cleanup" }
    local function runCleanup(entry)
        local obj, method = entry.obj, entry.method
        local kind = typeof(obj)
        if method then
            if method == true then
                if type(obj) == "function" then obj() end
                return
            end
            local fn = obj[method]
            if type(fn) == "function" then fn(obj) end
            return
        end
        if kind == "function" then obj()
        elseif kind == "RBXScriptConnection" then
            if obj.Connected then obj:Disconnect() end
        elseif kind == "Instance" then obj:Destroy()
        elseif kind == "thread" then
            if coroutine.status(obj) ~= "dead" and obj ~= coroutine.running() then task.cancel(obj) end
        elseif kind == "table" or kind == "userdata" then
            for _, name in ipairs(DEFAULT_METHODS) do
                local ok, fn = pcall(function() return obj[name] end)
                if ok and type(fn) == "function" then fn(obj); return end
            end
        end
    end
    function Janitor.new()
        return setmetatable({ _entries = {}, _named = {}, _cleaning = false, _destroyed = false }, Janitor)
    end
    function Janitor:Add(obj, method, name)
        if self._destroyed then pcall(runCleanup, { obj = obj, method = method }); return obj end
        if name ~= nil then self:Remove(name) end
        local entry = { obj = obj, method = method, name = name }
        table.insert(self._entries, entry)
        if name ~= nil then self._named[name] = entry end
        return obj
    end
    function Janitor:Connect(signal, fn, name) return self:Add(signal:Connect(fn), nil, name) end
    function Janitor:Spawn(fn, ...) return self:Add(task.spawn(fn, ...)) end
    function Janitor:Delay(t, fn, ...) return self:Add(task.delay(t, fn, ...)) end
    function Janitor:Remove(name)
        local entry = self._named[name]
        if not entry then return false end
        self._named[name] = nil
        for i, e in ipairs(self._entries) do
            if e == entry then table.remove(self._entries, i); break end
        end
        pcall(runCleanup, entry)
        return true
    end
    function Janitor:Cleanup()
        if self._cleaning then return end
        self._cleaning = true
        local entries = self._entries
        self._entries = {}; self._named = {}
        for i = #entries, 1, -1 do pcall(runCleanup, entries[i]) end
        self._cleaning = false
    end
    function Janitor:Destroy() self:Cleanup(); self._destroyed = true end
    return Janitor
end)()

local J = Janitor.new()
getgenv().__montex_janitor = J

local rankelo = {
    ["Rookie 1"]=0,["Rookie 2"]=25,["Rookie 3"]=50,
    ["Veteran 1"]=100,["Veteran 2"]=150,["Veteran 3"]=200,
    ["Elite 1"]=300,["Elite 2"]=400,["Elite 3"]=500,
    ["Pro 1"]=650,["Pro 2"]=800,["Pro 3"]=950,
    ["All-star 1"]=1150,["All-star 2"]=1350,["All-star 3"]=1550,
    ["Superstar 1"]=1800,["Superstar 2"]=2050,["Superstar 3"]=2300,
    ["Phenom 1"]=2550,["Phenom 2"]=2800,["Phenom 3"]=3100,
    ["Legend 1"]=3350,["Legend 2"]=3600,["Legend 3"]=3850,
    ["Mamba 1"]=4100,["Mamba 2"]=5050,["Mamba 3"]=6050,
    ["HoF 1"]=10000,["HoF 2"]=12500,["HoF 3"]=15000,
    ["G.O.A.T 1"]=20000,["G.O.A.T 2"]=22500,["G.O.A.T 3"]=25000,
    ["Aura 1"]=30000,["Aura 2"]=32500,["Aura 3"]=35000
}

local defaults = {
    Shooting = {
        Mode = "Aural", AuralKeybind = Enum.KeyCode.X, HumanizeAim = false,
        HumanizeStrength = 0, MissChance = 0, AuralEnabled = false,
        ShotDelay = 0.32, EBLHop = false, GreenChance = 0,
        ThreePTOnly = false, ThreePTMin = 59,
    },
    SelfPass = { Enabled = false, Keybind = "T", Power = 85, Distance = 50, Angle = 170 },
    Ball = {
        BallMags = false, SmartReach = false, SmartReachDistance = 14,
        BallMagRange = 15, BallMagVisualizer = false, MagnetKeybind = "M",
        BallReach = false, BallReachRange = 10, BallReachVisualizer = false,
        ReachKeybind = "N"
    },
    Player = { Walkspeed = false, WSvalue = 1.35 },
    Visuals = {
        CustomName = false, CustomNameText = "",
        CustomRecord = false, CustomRecordText = "",
        CustomTitle = false, CustomTitleText = "",
    },
    Goal        = { Enabled = false, SelectedEffect = "LightRay", CurrentEffect = "LightRay" },
    BallChanger = { Enabled = false, SelectedBall = "ForceField", CurrentBall = "ForceField" },
    Aura        = { Enabled = false, SelectedAura = "None", CurrentAura = nil },
    TrailChanger= { Enabled = false, SelectedTrail = "None", CurrentTrail = "None" },
    AvatarChanger = { SelectedPlayer = "None", CustomUser = "", LastCopiedUserId = nil, LastCopiedName = nil },
    FPSCap      = { Enabled = false, Value = 60, Original = nil },
    LogoBadges  = { Enabled = false, Badge = "None", CustomIds = {} },
    Misc        = { DeviceSpoofer = false, Device = "PC", AntiFall = false, AntiLag = false },
}

getgenv().Settings = getgenv().Settings or {}
for k, v in pairs(defaults) do
    if type(v) == "table" then
        getgenv().Settings[k] = getgenv().Settings[k] or {}
        for kk, vv in pairs(v) do
            if getgenv().Settings[k][kk] == nil then
                getgenv().Settings[k][kk] = vv
            end
        end
    elseif getgenv().Settings[k] == nil then
        getgenv().Settings[k] = v
    end
end
local s = getgenv().Settings
s.Player.WSvalue = math.clamp(s.Player.WSvalue or 1.35, 1, 1.65)
s.Shooting.ThreePTMin = 59
s.Ball.BallMagVisualizer = false
s.Ball.BallReachVisualizer = false

local function safeFind(parent, name)
    if typeof(parent) ~= "Instance" then return nil end
    return parent:FindFirstChild(name)
end

local MatchState = { Cached = false, CheckedAt = 0 }
function IsInMatch()
    local now = os.clock()
    if now - MatchState.CheckedAt < 0.5 then return MatchState.Cached end
    MatchState.CheckedAt = now
    local inMatch = LocalPlayer:GetAttribute("Ingame") == true
        or LocalPlayer:GetAttribute("InGame") == true
        or LocalPlayer:GetAttribute("InMatch") == true
    if not inMatch and safeFind(workspace, "Court") then inMatch = true end
    MatchState.Cached = inMatch
    return inMatch
end

local function getRoot(character) return character and character:FindFirstChild("HumanoidRootPart") end
local function getHumanoid(character) return character and character:FindFirstChildOfClass("Humanoid") end
function hasball(char) return char and char:FindFirstChild("Basketball") ~= nil end

local function restoreMouseBehavior()
    pcall(function()
        if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end
    end)
end

local function screencenter()
    local sc = Camera.ViewportSize
    return sc.X / 2, sc.Y / 2
end

local Rankings
do
    local ok, mod = pcall(function() return require(ReplicatedStorage.Util.Rankings) end)
    if ok and type(mod) == "table" then
        Rankings = mod
    else
        Rankings = {
            getRankFromELO = function(elo)
                local best, bestTier = "Rookie", 1
                local bestElo = -math.huge
                for rankName, minElo in pairs(rankelo) do
                    if elo >= minElo and minElo >= bestElo then
                        bestElo = minElo
                        local rk, tier = rankName:match("^(.-)%s+(%d+)$")
                        best, bestTier = rk or rankName, tonumber(tier) or 1
                    end
                end
                return best, bestTier
            end,
            getRankMinMaxFromELO = function(elo)
                local minV, maxV = nil, nil
                local names = {}
                for n in pairs(rankelo) do table.insert(names, n) end
                table.sort(names, function(a, b) return rankelo[a] < rankelo[b] end)
                for i, n in ipairs(names) do
                    if elo >= rankelo[n] then
                        minV = rankelo[n]
                        maxV = names[i + 1] and rankelo[names[i + 1]] or nil
                    end
                end
                return minV, maxV
            end,
            getNextRankFromELO = function(elo)
                local names = {}
                for n in pairs(rankelo) do table.insert(names, n) end
                table.sort(names, function(a, b) return rankelo[a] < rankelo[b] end)
                for _, n in ipairs(names) do
                    if rankelo[n] > elo then
                        local rk, tier = n:match("^(.-)%s+(%d+)$")
                        return rk or n, tonumber(tier) or 1
                    end
                end
                return "Aura", 3
            end,
            getRankImageFromELO = function() return "" end,
        }
    end
end

local Effects, EffectNames = {}, {}
local Balls, BallNames = {}, {}
local AuraList, AuraNames = {}, {"None"}
local Trails, TrailNames = {}, {}

do
    pcall(function()
        local EffectsFolder = ReplicatedStorage.ShopItems.Effect
        for _, eff in EffectsFolder:GetChildren() do
            local Name = eff.Name:gsub("Effect_", "")
            Effects[Name] = eff
            table.insert(EffectNames, Name)
        end
    end)
    pcall(function()
        for _, ballItem in ReplicatedStorage.ShopItems.Ball:GetChildren() do
            local Name = ballItem.Name:gsub("Ball_", "")
            Balls[Name] = ballItem.Name
            table.insert(BallNames, Name)
        end
    end)
    pcall(function()
        local TrailFolder = ReplicatedStorage.ShopItems:FindFirstChild("Trail")
        if TrailFolder then
            for _, trail in TrailFolder:GetChildren() do
                local cleanName = trail.Name:gsub("^Trail_", "")
                Trails[cleanName] = trail
                table.insert(TrailNames, cleanName)
            end
            table.sort(TrailNames)
        end
    end)
    pcall(function()
        local AuraFolder = ReplicatedStorage.ShopItems:FindFirstChild("Aura")
        if AuraFolder then
            for _, child in pairs(AuraFolder:GetChildren()) do
                if child:IsA("Model") then
                    table.insert(AuraList, child)
                    table.insert(AuraNames, child.Name)
                end
            end
        end
    end)
    if #TrailNames == 0 then TrailNames = {"None"}; Trails["None"] = nil end
end

local goals, rimsCache = {}, {}
local fieldGoals = {}

do
    local function validgoal(object)
        if not object:IsA("BasePart") then return false end
        local name2 = string.lower(object.Name)
        if name2 ~= "goal" and name2 ~= "goalhome" and name2 ~= "goalaway" then return false end
        local parent = object.Parent
        for _ = 1, 5 do
            if not parent then break end
            local parentname = string.lower(parent.Name)
            if string.find(parentname, "hitbox", 1, true) or string.find(parentname, "fieldgoal", 1, true) then
                return true
            end
            parent = parent.Parent
        end
        return false
    end

    function refreshgoals()
        table.clear(goals)
        for _, object in workspace:GetDescendants() do
            if validgoal(object) then table.insert(goals, object) end
        end
    end

    refreshgoals()
    J:Connect(workspace.DescendantAdded, function(o) if validgoal(o) then table.insert(goals, o) end end, "GoalAdd")
    J:Connect(workspace.DescendantRemoving, function(o)
        if not o:IsA("BasePart") then return end
        for i = #goals, 1, -1 do if goals[i] == o then table.remove(goals, i); break end end
    end, "GoalRemove")

    for _, inst in ipairs(workspace:GetDescendants()) do
        if inst.Name == "FieldGoal" and inst:IsA("BasePart") then
            table.insert(fieldGoals, inst)
        end
    end
end

function getclosestdunkfunc()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local pos = hrp.Position
    for i = #fieldGoals, 1, -1 do
        local v = fieldGoals[i]
        if not v.Parent then table.remove(fieldGoals, i)
        elseif (pos - v.Position).Magnitude <= 13 then return v:FindFirstChild("dunkFunction") end
    end
    return nil
end

do
    function nearestgoal(root)
        local best, bestDist = nil, math.huge
        for i = #goals, 1, -1 do
            local goal = goals[i]
            if not goal or not goal.Parent then table.remove(goals, i); continue end
            local Hitboxes = goal.Parent
            if Hitboxes and (Hitboxes.Name == "HitboxesHome" or Hitboxes.Name == "HitboxesAway") then
                local Court = Hitboxes.Parent
                local CourtPlayers = Court and Court:FindFirstChild("_CourtPlayers")
                if CourtPlayers then
                    local MyTeam
                    for _, v in ipairs(CourtPlayers:GetChildren()) do
                        local SlotTeam = v.Name:sub(1, 4)
                        local SlotValue = v.Value
                        if typeof(SlotValue) == "Instance" and SlotValue:IsA("Player") then
                            if SlotValue.Name == LocalPlayer.Name then
                                MyTeam = (SlotTeam == "Home") and "Home" or (SlotTeam == "Away" and "Away")
                                break
                            end
                        end
                    end
                    if MyTeam then
                        if (MyTeam == "Home" and Hitboxes.Name == "HitboxesHome") or
                           (MyTeam == "Away" and Hitboxes.Name == "HitboxesAway") then
                            continue
                        end
                    end
                end
            end
            local delta = goal.Position - root.Position
            local flat = Vector3.new(delta.X, 0, delta.Z).Magnitude
            if flat < bestDist then best = goal; bestDist = flat end
        end
        return best, bestDist
    end

    function nearestrim(pos)
        if #rimsCache == 0 then
            for _, desc in workspace:GetDescendants() do
                if desc:IsA("BasePart") and (desc.Name == "Goal" or desc.Name == "Rim") then
                    table.insert(rimsCache, desc)
                end
            end
        end
        local best, bestd = nil, math.huge
        for _, rim in rimsCache do
            if rim and rim.Parent then
                local d = (rim.Position - pos).Magnitude
                if d < bestd then bestd = d; best = rim end
            end
        end
        return best, bestd
    end
end

local shot_data = {
    [59]=83,[60]=81,[61]=82,[62]=79,[63]=78.8,[64]=75,[65]=74.8,[66]=71,
    [67]=70.8,[68]=66,[69]=62,[70]=59,[71]=51,[72]=51,[73]=51
}
local inner_arc_data = {
    [7]=123,[8]=122,[9]=121,[10]=120,[11]=119,[12]=118,[13]=117,[14]=116,[15]=115,[16]=114,
    [17]=113,[18]=112,[19]=111,[20]=110,[21]=109,[22]=108,[23]=107,[24]=106,[25]=105,[26]=105,
    [27]=106,[28]=106,[29]=107,[30]=107,[31]=106,[32]=105,[33]=105,[34]=104,[35]=103,[36]=103,
    [37]=102,[38]=102,[39]=101,[40]=101,[41]=100,[42]=99,[43]=99,[44]=98,[45]=97,[46]=96,
    [47]=95,[48]=95,[49]=94,[50]=93,[51]=91,[52]=90,[53]=88,[54]=87,[55]=85,[56]=84,[57]=82,[58]=81
}
local mobileArcs = {
    [30]=38,[31]=38,[32]=38,[33]=38,[34]=38,[35]=38,[36]=38,[37]=38,[38]=38,[39]=38,
    [40]=39,[41]=38,[42]=38,[43]=38,[44]=38,[45]=38,[46]=38,[47]=38,[48]=38,[49]=38,
    [50]=38,[51]=37,[52]=37,[53]=37,[54]=36,[55]=34,[56]=34,[57]=34,[58]=34,[59]=31,
    [60]=31,[61]=31,[62]=31,[63]=29,[64]=29,[65]=29,[66]=26,[67]=26,[68]=24,[69]=24,
    [70]=21,[71]=21,[72]=19,[73]=19
}

local isMobile = UserInputService.TouchEnabled

function getArcOffset(dist)
    if isMobile then
        local d = math.floor(dist + 0.5)
        if d < 30 then d = 30 end
        if d > 73 then d = 73 end
        return mobileArcs[d] or 37
    end
    if inner_arc_data[dist] then return inner_arc_data[dist] end
    if shot_data[dist] then return shot_data[dist] end
    if dist < 7 then return 122 end
    if dist > 73 then return math.max(20, 50 - (dist - 73) * 1.5) end
    local lower, upper = nil, nil
    for d in pairs(inner_arc_data) do
        if d <= dist and (not lower or d > lower) then lower = d end
        if d >= dist and (not upper or d < upper) then upper = d end
    end
    for d in pairs(shot_data) do
        if d <= dist and (not lower or d > lower) then lower = d end
        if d >= dist and (not upper or d < upper) then upper = d end
    end
    if lower and upper and lower ~= upper then
        local lowerVal = inner_arc_data[lower] or shot_data[lower] or 0
        local upperVal = inner_arc_data[upper] or shot_data[upper] or 0
        local t = (dist - lower) / (upper - lower)
        return lowerVal + (upperVal - lowerVal) * t
    elseif lower then
        return inner_arc_data[lower] or shot_data[lower] or 0
    elseif upper then
        return inner_arc_data[upper] or shot_data[upper] or 0
    end
    return 100
end

function getArc(dist, power)
    if isMobile then
        local d = math.floor(dist + 0.5)
        if d < 30 then d = 30 end
        if d > 73 then d = 73 end
        local base = mobileArcs[d] or 37
        if power ~= 85 then base = base * (85 / power) end
        return base
    end
    if inner_arc_data[dist] then
        local base = inner_arc_data[dist]
        if power ~= 85 then base = base * (85 / power) end
        return base
    end
    local baseArc
    if shot_data[dist] then baseArc = shot_data[dist]
    elseif dist < 73 then
        local nearestDiff = math.huge
        for d, v in pairs(shot_data) do
            local diff = math.abs(d - dist)
            if diff < nearestDiff then nearestDiff = diff; baseArc = v end
        end
    else
        baseArc = math.max(20, 50 - (dist - 73) * 1.5)
    end
    if power ~= 85 then baseArc = baseArc * (85 / power) end
    return baseArc
end

local function teamOf(nm)
    if nm:find("^Home") then return "Home" end
    if nm:find("^Away") then return "Away" end
    return nil
end

function getTeammates()
    local tms = {}
    for _, Inst in next, workspace:GetDescendants() do
        if not (Inst:IsA("ObjectValue") and Inst.Parent and Inst.Parent.Name == "_CourtPlayers") then
            continue
        end
        if Inst.Value ~= LocalPlayer then continue end
        local myTeam = teamOf(Inst.Name)
        if not myTeam then continue end
        for _, tmVal in next, Inst.Parent:GetChildren() do
            if tmVal:IsA("ObjectValue")
               and typeof(tmVal.Value) == "Instance"
               and tmVal.Value:IsA("Player")
               and tmVal.Value ~= LocalPlayer
               and teamOf(tmVal.Name) == myTeam
            then
                table.insert(tms, tmVal.Value)
            end
        end
        break
    end
    return tms
end

local teammatesCache = setmetatable({}, { __mode = "k" })
local lastTeammateRefresh = 0
local function isTeammatePlayer(player)
    local now = os.clock()
    if now - lastTeammateRefresh > 0.5 or not teammatesCache.list then
        teammatesCache.list = getTeammates()
        lastTeammateRefresh = now
    end
    for _, tm in ipairs(teammatesCache.list) do
        if tm == player then return true end
    end
    return false
end

local setpower, fatalClick, doClick

setpower = function(p)
    LocalPlayer:SetAttribute("Power", p)
    pcall(function() SharedTableRegistry:GetSharedTable("PowerData").Power = p end)
end

doClick = function()
    getgenv().__montex_aiming = true
    if isMobile then
        local pos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        Input:SendTouchEvent(1, 0, pos.X, pos.Y)
        Input:SendTouchEvent(1, 2, pos.X, pos.Y)
    else
        local vp = Camera.ViewportSize
        Input:SendMouseButtonEvent(vp.X / 2, vp.Y / 2, 0, true, game, 1)
        Input:SendMouseButtonEvent(vp.X / 2, vp.Y / 2, 0, false, game, 1)
    end
    task.delay(0.35, function() getgenv().__montex_aiming = false end)
end

fatalClick = function(targetPos)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetPos then return false end
    local origcf = Camera.CFrame
    local origct = Camera.CameraType
    local origmb = UserInputService.MouseBehavior
    getgenv().__montex_aiming = true
    local ok = pcall(function()
        Camera.CameraType = Enum.CameraType.Scriptable
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        Camera.CFrame = CFrame.lookAt(hrp.Position, targetPos)
        RunService.RenderStepped:Wait()
        local vp = Camera.ViewportSize
        Input:SendMouseButtonEvent(vp.X / 2, vp.Y / 2, 0, true, game, 1)
        RunService.RenderStepped:Wait()
        Input:SendMouseButtonEvent(vp.X / 2, vp.Y / 2, 0, false, game, 1)
    end)
    Camera.CFrame = origcf
    Camera.CameraType = origct
    if origmb ~= Enum.MouseBehavior.LockCenter then UserInputService.MouseBehavior = origmb end
    task.defer(function()
        task.wait()
        getgenv().__montex_aiming = false
        pcall(restoreMouseBehavior)
    end)
    return ok
end

local AURAL_MIN_DIST = 12
local AURAL_MAX_DIST = 73

local state = {
    target = nil, connections = {}, actorst = nil, actorname = nil,
    actors = {}, oldnewindex = nil, active = true, clicking = false
}

local function addconnection(c) table.insert(state.connections, c); return c end
local function settarget(target)
    state.target = target
    if state.actorst then pcall(function() state.actorst.t = target end) end
end

local function passesThreePTGate(distance)
    if not s.Shooting.ThreePTOnly then return true end
    return distance >= (s.Shooting.ThreePTMin or 59)
end

local function applyGreenNudge(targetPos)
    local greenChance = s.Shooting.GreenChance or 0
    if greenChance <= 0 then return targetPos end
    if math.random(1, 100) <= greenChance then
        return targetPos + Vector3.new(0, 4.05, 0)
    end
    return targetPos
end

local function velocify(target, dist)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return target end
    local velocity = hrp.AssemblyLinearVelocity
    local travelTime = dist / 50
    local prediction = travelTime * 0.06
    return target + Vector3.new(velocity.X * prediction, 0, velocity.Z * prediction)
end

local function updateAuralTarget()
    if not state.active or not s.Shooting.AuralEnabled then settarget(nil); return end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not hum or not root then settarget(nil); return end
    if not hasball(char) then settarget(nil); return end
    if hum.FloorMaterial ~= Enum.Material.Air and not hum.Jump then settarget(nil); return end
    local goal, distance = nearestgoal(root)
    if not goal then settarget(nil); return end
    if distance < AURAL_MIN_DIST or distance > AURAL_MAX_DIST then settarget(nil); return end
    if not passesThreePTGate(distance) then settarget(nil); return end
    local offset = getArcOffset(distance)
    if s.Shooting.HumanizeAim then
        local strength = s.Shooting.HumanizeStrength or 1.2
        local missChance = (s.Shooting.MissChance or 0) / 100
        if math.random() < missChance then
            if math.random() < 0.5 then
                offset = offset + strength * 3 + math.random() * strength * 2
            else
                offset = offset - strength * 3 - math.random() * strength * 2
            end
        else
            offset = offset + (math.random() * 2 - 1) * strength
        end
    end
    local basePos = goal.Position + Vector3.new(0, offset, 0)
    settarget(velocify(applyGreenNudge(basePos), distance))
end

local actorcode = [==[
local registry = game:GetService("SharedTableRegistry")
local players = game:GetService("Players")
local st = registry:GetSharedTable(__silentaimtable)
local camera = workspace.CurrentCamera
local function target() local v = st.t return typeof(v) == "Vector3" and v or nil end
local function aimcframe()
    local v = target()
    local char = players.LocalPlayer.Character
    local head = char and char:FindFirstChild("Head")
    if v and head then return CFrame.new(head.Position, v) end
end
pcall(function()
    local oldrender
    oldrender = hookfunction(camera.GetRenderCFrame, function(self, ...) return aimcframe() or oldrender(self, ...) end)
    local oldscreen
    oldscreen = hookfunction(camera.ScreenPointToRay, function(self, ...)
        local v = aimcframe()
        if v then return Ray.new(v.Position, v.LookVector) end
        return oldscreen(self, ...)
    end)
    local oldviewport
    oldviewport = hookfunction(camera.ViewportPointToRay, function(self, ...)
        local v = aimcframe()
        if v then return Ray.new(v.Position, v.LookVector) end
        return oldviewport(self, ...)
    end)
    local cameradata = registry:GetSharedTable("CameraData")
    local history = cameradata.CameraHistory
    local meta = getrawmetatable(cameradata)
    local oldnewindex
    oldnewindex = hookfunction(meta.__newindex, newcclosure(function(tab, key, value)
        local current = tab == cameradata and key == "CameraCFrame"
        local previous = history ~= nil and tab == history and type(key) == "number"
        local aimed = aimcframe()
        if aimed and (current or previous) then return oldnewindex(tab, key, aimed) end
        return oldnewindex(tab, key, value)
    end))
end)
]==]

function hookmain()
    pcall(function()
        state.actorname = "mx" .. tostring(math.floor(os.clock() * 100000)) .. tostring(math.random(10000, 99999))
        state.actorst = SharedTableRegistry:GetSharedTable(state.actorname)
        state.actorst.t = nil
        local cameradata = SharedTableRegistry:GetSharedTable("CameraData")
        local history = cameradata.CameraHistory
        local meta = getrawmetatable(cameradata)
        state.oldnewindex = hookfunction(meta.__newindex, newcclosure(function(tab, key, value)
            local current  = tab == cameradata and key == "CameraCFrame"
            local previous = history ~= nil and tab == history and type(key) == "number"
            local tgt = state.target
            if tgt and (current or previous) and typeof(value) == "CFrame" then
                local char = LocalPlayer.Character
                local head = char and char:FindFirstChild("Head")
                if head then
                    return state.oldnewindex(tab, key, CFrame.new(head.Position, tgt))
                end
            end
            return state.oldnewindex(tab, key, value)
        end))
    end)
end

function hookactors()
    if type(getactors) ~= "function" or type(run_on_actor) ~= "function" or not state.actorname then return end
    local ok, actors = pcall(getactors)
    if not ok or type(actors) ~= "table" then return end
    local code = "local __silentaimtable = " .. string.format("%q", state.actorname) .. " " .. actorcode
    for _, actor in actors do
        if not state.actors[actor] then
            if pcall(run_on_actor, actor, code) then
                state.actors[actor] = true
            end
        end
    end
end

local function triggerJump()
    local char = LocalPlayer.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    if humanoid.FloorMaterial == Enum.Material.Air then return end
    local st = humanoid:GetState()
    if st == Enum.HumanoidStateType.Jumping or st == Enum.HumanoidStateType.Freefall then return end
    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end

local function setupCharacterAural(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if not hum then return end
    local jumps = 0
    addconnection(hum.Jumping:Connect(function(active)
        if not active then return end
        if not s.Shooting.AuralEnabled then return end
        if not hasball(char) then return end
        if s.Shooting.EBLHop then
            jumps = jumps + 1
            if jumps < 2 then return end
            jumps = 0
        end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local goal, distance = nearestgoal(root)
        local minDist = isMobile and 30 or AURAL_MIN_DIST
        if not goal or distance < minDist or distance > AURAL_MAX_DIST then return end
        if not passesThreePTGate(distance) then return end
        local arc = getArcOffset(distance)
        local targetPos = nil
        if s.Shooting.HumanizeAim then
            local strength = s.Shooting.HumanizeStrength or 1.2
            local missChance = (s.Shooting.MissChance or 0) / 100
            if math.random() < missChance then
                local mode = math.random(1, 3)
                if mode == 1 then
                    arc = arc + strength * 3 + math.random() * strength * 2
                elseif mode == 2 then
                    arc = arc - strength * 3 - math.random() * strength * 2
                else
                    local side = (math.random() < 0.5) and -1 or 1
                    targetPos = goal.Position
                        + Vector3.new(0, getArcOffset(distance), 0)
                        + Camera.CFrame.RightVector * (side * (strength * 2 + math.random() * 2))
                end
            else
                arc = arc + (math.random() * 2 - 1) * strength
            end
        end
        targetPos = targetPos or goal.Position + Vector3.new(0, arc, 0)
        targetPos = applyGreenNudge(targetPos)
        settarget(targetPos)
        task.wait(0.05)
        LocalPlayer:SetAttribute("Power", 85)
        local shotdelay = s.Shooting.ShotDelay or 0.25
        task.wait(shotdelay)
        doClick()
        task.wait(0.1)
        updateAuralTarget()
    end))
end

if LocalPlayer.Character then setupCharacterAural(LocalPlayer.Character) end
addconnection(LocalPlayer.CharacterAdded:Connect(setupCharacterAural))

hookmain()
hookactors()

addconnection(workspace.DescendantAdded:Connect(function(object)
    if object:IsA("BasePart") and (object.Name == "Goal" or object.Name == "Rim") then
        table.insert(rimsCache, object)
    end
end))
addconnection(RunService.Heartbeat:Connect(updateAuralTarget))
addconnection(Players.PlayerAdded:Connect(function() task.defer(hookactors) end))

local function performSelfPass()
    if not s.SelfPass.Enabled then return end

    local char = LocalPlayer.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")

    if not hrp or not hum or not char:FindFirstChild("Basketball") then return end

    local moveDir = hum.MoveDirection
    local aimDirection

    if moveDir.Magnitude < 0.1 then
        aimDirection = Vector3.new(0, 1, 0)
    else
        moveDir = Vector3.new(moveDir.X, 0, moveDir.Z).Unit
        local upAngle = math.rad(s.SelfPass.Angle or 170)
        aimDirection = (moveDir * math.cos(upAngle - math.rad(90))) + Vector3.new(0, math.sin(upAngle - math.rad(90)), 0)
    end

    local aimPoint = hrp.Position + aimDirection.Unit * (s.SelfPass.Distance or 50)

    if setpower then setpower(s.SelfPass.Power or 85) end

    local origcf = Camera.CFrame
    local origct = Camera.CameraType
    local origmb = UserInputService.MouseBehavior

    getgenv().__montex_aiming = true

    Camera.CameraType = Enum.CameraType.Scriptable
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    Camera.CFrame = CFrame.lookAt(hrp.Position, aimPoint)

    local cx, cy = screencenter()
    Input:SendMouseButtonEvent(cx, cy, 0, true, game, 1)
    RunService.RenderStepped:Wait()
    Input:SendMouseButtonEvent(cx, cy, 0, false, game, 1)

    Camera.CFrame = origcf
    Camera.CameraType = origct
    if origmb ~= Enum.MouseBehavior.LockCenter then
        UserInputService.MouseBehavior = origmb
    end

    task.defer(function()
        task.wait()
        getgenv().__montex_aiming = false
        pcall(restoreMouseBehavior)
    end)
end

local selfPassConnection = nil
local function enableSelfPass()
    if selfPassConnection then
        selfPassConnection:Disconnect()
        selfPassConnection = nil
    end
    selfPassConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if not input.KeyCode then return end
        if input.KeyCode == Enum.KeyCode[s.SelfPass.Keybind] then
            task.spawn(performSelfPass)
        end
    end)
end
local function disableSelfPass()
    if selfPassConnection then
        selfPassConnection:Disconnect()
        selfPassConnection = nil
    end
end

-- ===== VISUALIZER MODULE =====

local VizTheme = {
    Magnet     = Color3.fromRGB(96, 165, 250),
    MagnetSoft = Color3.fromRGB(147, 197, 253),
    MagnetCore = Color3.fromRGB(219, 234, 254),
    Reach      = Color3.fromRGB(244, 114, 182),
    ReachSoft  = Color3.fromRGB(251, 207, 232),
    ReachCore  = Color3.fromRGB(253, 242, 248),
    Bg         = Color3.fromRGB(10, 15, 28),
    BgSoft     = Color3.fromRGB(20, 30, 52),
    Text       = Color3.fromRGB(240, 245, 255),
    Muted      = Color3.fromRGB(148, 163, 200),
}

local function makeVizLabel(adornee, offsetY, color, tag, subText)
    local bb = Instance.new("BillboardGui")
    bb.Name = "MontexVizLabel"
    bb.Adornee = adornee
    bb.Size = UDim2.fromOffset(168, 40)
    bb.StudsOffsetWorldSpace = Vector3.new(0, offsetY, 0)
    bb.AlwaysOnTop = false
    bb.MaxDistance = 200
    bb.LightInfluence = 0
    bb.ClipsDescendants = false

    local card = Instance.new("Frame")
    card.Name = "Card"
    card.BackgroundColor3 = VizTheme.Bg
    card.BackgroundTransparency = 0.12
    card.BorderSizePixel = 0
    card.Size = UDim2.fromScale(1, 1)
    card.Parent = bb

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 9)
    corner.Parent = card

    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = 1.2
    stroke.Transparency = 0.35
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = card

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, color),
    })
    grad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.55),
        NumberSequenceKeypoint.new(1, 0.9),
    })
    grad.Rotation = 90
    grad.Parent = stroke

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 10)
    pad.PaddingRight = UDim.new(0, 10)
    pad.PaddingTop = UDim.new(0, 5)
    pad.PaddingBottom = UDim.new(0, 5)
    pad.Parent = card

    local dot = Instance.new("Frame")
    dot.Name = "Dot"
    dot.BackgroundColor3 = color
    dot.BorderSizePixel = 0
    dot.AnchorPoint = Vector2.new(0, 0.5)
    dot.Position = UDim2.new(0, 0, 0.28, 0)
    dot.Size = UDim2.fromOffset(6, 6)
    dot.Parent = card

    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot

    local dotGlow = Instance.new("ImageLabel")
    dotGlow.BackgroundTransparency = 1
    dotGlow.Image = "rbxassetid://5028857084"
    dotGlow.ImageColor3 = color
    dotGlow.ImageTransparency = 0.35
    dotGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    dotGlow.Position = UDim2.fromScale(0.5, 0.5)
    dotGlow.Size = UDim2.fromOffset(18, 18)
    dotGlow.Parent = dot

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 14, 0, 0)
    title.Size = UDim2.new(1, -14, 0.55, 0)
    title.Font = Enum.Font.GothamBold
    title.Text = tag
    title.TextSize = 12
    title.TextColor3 = VizTheme.Text
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextYAlignment = Enum.TextYAlignment.Center
    title.Parent = card

    local sub = Instance.new("TextLabel")
    sub.Name = "Sub"
    sub.BackgroundTransparency = 1
    sub.Position = UDim2.new(0, 14, 0.5, 0)
    sub.Size = UDim2.new(1, -14, 0.5, 0)
    sub.Font = Enum.Font.Gotham
    sub.Text = subText or ""
    sub.TextSize = 11
    sub.TextColor3 = VizTheme.Muted
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.TextYAlignment = Enum.TextYAlignment.Center
    sub.Parent = card

    return bb, title, sub, stroke, card
end

-- Magnet

local magnetHitbox = nil
local magnetConnection = nil
local magnetVizConn = nil

local function destroyMagnetVisuals()
    if magnetVizConn then magnetVizConn:Disconnect(); magnetVizConn = nil end
end

local function buildMagnetVisuals(part, range)
    if part:FindFirstChild("MontexMagnetVisual") then return end

    local shell = Instance.new("SphereHandleAdornment")
    shell.Name = "MontexMagnetVisual"
    shell.Adornee = part
    shell.Radius = range / 2
    shell.Color3 = VizTheme.Magnet
    shell.Transparency = 0.86
    shell.AlwaysOnTop = false
    shell.ZIndex = 5
    shell.Parent = part

    local mid = Instance.new("SphereHandleAdornment")
    mid.Name = "MontexMagnetMid"
    mid.Adornee = part
    mid.Radius = range / 2 - 0.18
    mid.Color3 = VizTheme.MagnetSoft
    mid.Transparency = 0.94
    mid.AlwaysOnTop = false
    mid.ZIndex = 4
    mid.Parent = part

    local core = Instance.new("SphereHandleAdornment")
    core.Name = "MontexMagnetCore"
    core.Adornee = part
    core.Radius = 0.4
    core.Color3 = VizTheme.MagnetCore
    core.Transparency = 0.3
    core.AlwaysOnTop = false
    core.ZIndex = 6
    core.Parent = part

    local bb, title, sub, stroke = makeVizLabel(part, range / 2 + 1.0, VizTheme.Magnet, "MAGNET", "range " .. tostring(math.floor(range)))
    bb.Name = "MontexMagnetLabel"
    bb.Parent = part

    local pulse = 0
    destroyMagnetVisuals()
    magnetVizConn = RunService.RenderStepped:Connect(function(dt)
        if not part or not part.Parent then
            if magnetVizConn then magnetVizConn:Disconnect(); magnetVizConn = nil end
            return
        end
        pulse = (pulse + dt * 2.2) % (math.pi * 2)
        local wave = (math.sin(pulse) + 1) * 0.5
        shell.Transparency = 0.80 + wave * 0.14
        mid.Transparency = 0.90 + wave * 0.08
        core.Transparency = 0.20 + wave * 0.30
        shell.Color3 = VizTheme.Magnet:Lerp(VizTheme.MagnetCore, wave * 0.35)
        stroke.Transparency = 0.20 + wave * 0.35

        if s.Ball.BallMagVisualizer ~= true then
            shell.Transparency = 1
            mid.Transparency = 1
            core.Transparency = 1
            bb.Enabled = false
        else
            bb.Enabled = true
        end
    end)
end

local function refreshMagnetVisuals()
    if not magnetHitbox then return end
    local range = s.Ball.BallMagRange
    local shell = magnetHitbox:FindFirstChild("MontexMagnetVisual")
    local mid = magnetHitbox:FindFirstChild("MontexMagnetMid")
    local core = magnetHitbox:FindFirstChild("MontexMagnetCore")
    if shell then shell.Radius = range / 2 end
    if mid then mid.Radius = range / 2 - 0.18 end
    if core then core.Radius = 0.4 end
    local bb = magnetHitbox:FindFirstChild("MontexMagnetLabel")
    if bb then
        bb.StudsOffsetWorldSpace = Vector3.new(0, range / 2 + 1.0, 0)
        local sub = bb:FindFirstChild("Card") and bb.Card:FindFirstChild("Sub")
        if sub then sub.Text = "range " .. tostring(math.floor(range)) end
    end
end

local function createMagnetHitbox(character)
    if magnetHitbox then magnetHitbox:Destroy(); magnetHitbox = nil end
    if character:FindFirstChild("MontexMagnet") then character.MontexMagnet:Destroy() end
    local head = character:FindFirstChild("Head")
    if not head then return end

    local range = s.Ball.BallMagRange

    magnetHitbox = Instance.new("Part")
    magnetHitbox.Name = "MontexMagnet"
    magnetHitbox.Shape = Enum.PartType.Ball
    magnetHitbox.Size = Vector3.new(range, range, range)
    magnetHitbox.Transparency = 1
    magnetHitbox.CanCollide = false
    magnetHitbox.CanTouch = false
    magnetHitbox.CanQuery = false
    magnetHitbox.CastShadow = false
    magnetHitbox.Massless = true
    magnetHitbox.Anchored = false
    magnetHitbox.Parent = character

    local weld = Instance.new("Weld")
    weld.Part0 = head
    weld.Part1 = magnetHitbox
    weld.C0 = CFrame.new(0, 0, 0)
    weld.Parent = magnetHitbox

    if s.Ball.BallMagVisualizer == true then
        buildMagnetVisuals(magnetHitbox, range)
    end

    magnetHitbox.Touched:Connect(function(part)
        if not s.Ball.BallMags then return end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Basketball") then return end
        if part.Name == "Ball" or (part.Parent and part.Parent.Name == "Basketball") then
            firetouchinterest(head, part, 0)
            task.wait()
            firetouchinterest(head, part, 1)
        end
    end)
end

local function enableMagnet()
    local char = LocalPlayer.Character
    if not char then return end
    createMagnetHitbox(char)
    if magnetConnection then magnetConnection:Disconnect(); magnetConnection = nil end
    magnetConnection = RunService.Heartbeat:Connect(function()
        if not s.Ball.BallMags then return end
        local character = LocalPlayer.Character
        if character and not character:FindFirstChild("MontexMagnet") then createMagnetHitbox(character) end
    end)
end

local function disableMagnet()
    if magnetConnection then magnetConnection:Disconnect(); magnetConnection = nil end
    destroyMagnetVisuals()
    if magnetHitbox then magnetHitbox:Destroy(); magnetHitbox = nil end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("MontexMagnet") then
        LocalPlayer.Character.MontexMagnet:Destroy()
    end
end

local function applyMagnetVisualizerState()
    if not magnetHitbox then return end
    if s.Ball.BallMagVisualizer == true then
        if not magnetHitbox:FindFirstChild("MontexMagnetVisual") then
            buildMagnetVisuals(magnetHitbox, s.Ball.BallMagRange)
        end
        local bb = magnetHitbox:FindFirstChild("MontexMagnetLabel")
        if bb then bb.Enabled = true end
    else
        destroyMagnetVisuals()
        for _, name in ipairs({"MontexMagnetVisual","MontexMagnetMid","MontexMagnetCore","MontexMagnetLabel"}) do
            local c = magnetHitbox:FindFirstChild(name)
            if c then c:Destroy() end
        end
    end
end

-- Reach

local ReachState = {
    LastTouchAt   = setmetatable({}, { __mode = "k" }),
    TouchCooldown = 0.075,
    ReachScanAt   = 0,
    ScanInterval  = 0.075,
    SmartActive   = false,
}

local reachHitbox, reachVisualizer, reachConnection, reachLabel, reachVizConn

local function destroyReachVisualizer()
    if reachVizConn then reachVizConn:Disconnect(); reachVizConn = nil end
    if reachVisualizer then reachVisualizer:Destroy(); reachVisualizer = nil end
    reachLabel = nil
end

local function IsLooseBall(Ball)
    if not (Ball and Ball.Parent and Ball:IsA("BasePart") and Ball:IsDescendantOf(workspace)) then return false end
    if Ball.Anchored then return false end
    for _, p in ipairs(Players:GetPlayers()) do
        local c = p.Character
        if c and Ball:IsDescendantOf(c) then return false end
    end
    return true
end

local function GetNearestLocalPart(Target)
    local c = LocalPlayer.Character
    if not (c and Target) then return nil end
    local nearest, nearestD
    for _, p in ipairs(c:GetChildren()) do
        if p:IsA("BasePart") then
            local d = (p.Position - Target.Position).Magnitude
            if not nearestD or d < nearestD then nearest, nearestD = p, d end
        end
    end
    return nearest, nearestD
end

local function TryTouch(Ball, TouchPart)
    if not (Ball and TouchPart and Ball.Parent and TouchPart.Parent) then return false end
    local now = os.clock()
    if now - (ReachState.LastTouchAt[Ball] or 0) < ReachState.TouchCooldown then return false end
    ReachState.LastTouchAt[Ball] = now
    if type(firetouchinterest) ~= "function" then return false end
    local ok = pcall(function()
        firetouchinterest(TouchPart, Ball, 0)
        task.defer(function()
            if Ball and Ball.Parent and TouchPart and TouchPart.Parent then
                pcall(firetouchinterest, TouchPart, Ball, 1)
            end
        end)
    end)
    return ok
end

local function StepHeldReach(Radius)
    local myChar = LocalPlayer.Character
    if not myChar then return end
    for _, TargetPlayer in ipairs(Players:GetPlayers()) do
        if TargetPlayer ~= LocalPlayer then
            local tChar  = TargetPlayer.Character
            local tHum   = tChar and tChar:FindFirstChildOfClass("Humanoid")
            local tTorso = tChar and (
                tChar:FindFirstChild("Torso")
                or tChar:FindFirstChild("UpperTorso")
                or tChar:FindFirstChild("HumanoidRootPart"))
            if tChar and tHum and tHum.Health > 0 and tTorso then
                local TouchPart, Distance = GetNearestLocalPart(tTorso)
                if TouchPart and Distance and Distance <= Radius then
                    local seen = {}
                    for _, Child in ipairs(tChar:GetChildren()) do
                        if Child:IsA("Tool") or Child:IsA("Folder")
                           or (Child:IsA("Model") and Child.Name == "Basketball") then
                            for _, o in ipairs(Child:GetDescendants()) do
                                if o:IsA("BasePart") and not seen[o] then
                                    seen[o] = true
                                    TryTouch(o, TouchPart)
                                end
                            end
                        elseif Child:IsA("BasePart") and not seen[Child] then
                            seen[Child] = true
                            TryTouch(Child, TouchPart)
                        end
                    end
                end
            end
        end
    end
end

local function StepLooseReach()
    local myChar = LocalPlayer.Character
    if not myChar then return end
    local hum  = myChar:FindFirstChildOfClass("Humanoid")
    local root = myChar:FindFirstChild("HumanoidRootPart")
    if not (hum and root) or hum.Health <= 0 then return end
    local Radius = math.clamp(tonumber(s.Ball.BallReachRange) or 10, 0.01, 15)
    ReachState.SmartActive = false
    if s.Ball.SmartReach then
        local nearestD = math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local r = p.Character:FindFirstChild("HumanoidRootPart")
                if r then
                    local d = (r.Position - root.Position).Magnitude
                    if d < nearestD then nearestD = d end
                end
            end
        end
        if nearestD <= (tonumber(s.Ball.SmartReachDistance) or 14) then
            ReachState.SmartActive = true
            Radius = math.min(Radius, 8)
        end
    end
    local Target = root.Position + root.CFrame.LookVector * 1.25 + Vector3.new(0, 0.15, 0)
    for _, Ball in ipairs(CollectionService:GetTagged("BallHandle")) do
        if Ball:IsA("BasePart") and Ball.Parent and IsLooseBall(Ball) then
            local Distance = (Target - Ball.Position).Magnitude
            if Distance <= Radius then
                TryTouch(Ball, root)
            end
        end
    end
end

local function performReachSteal()
    if not s.Ball.BallReach then return end
    local now = os.clock()
    if now - ReachState.ReachScanAt < ReachState.ScanInterval then return end
    ReachState.ReachScanAt = now
    local Radius = math.clamp(tonumber(s.Ball.BallReachRange) or 10, 0.01, 15)
    StepHeldReach(Radius)
    StepLooseReach()
end

local function removeReachHitbox()
    if reachHitbox then reachHitbox:Destroy(); reachHitbox = nil end
    destroyReachVisualizer()
end

local function buildReachVisuals(part, range)
    if part:FindFirstChild("MontexReachSphere") then return end

    local sphere = Instance.new("SphereHandleAdornment")
    sphere.Name = "MontexReachSphere"
    sphere.Adornee = part
    sphere.Radius = range
    sphere.Color3 = VizTheme.Reach
    sphere.Transparency = 0.84
    sphere.AlwaysOnTop = false
    sphere.ZIndex = 5
    sphere.Parent = part

    local fill = Instance.new("SphereHandleAdornment")
    fill.Name = "MontexReachFill"
    fill.Adornee = part
    fill.Radius = range - 0.2
    fill.Color3 = VizTheme.ReachSoft
    fill.Transparency = 0.94
    fill.AlwaysOnTop = false
    fill.ZIndex = 4
    fill.Parent = part

    local ring = Instance.new("CylinderHandleAdornment")
    ring.Name = "MontexReachRing"
    ring.Adornee = part
    ring.Radius = range
    ring.Height = 0.05
    ring.Color3 = VizTheme.ReachCore
    ring.Transparency = 0.55
    ring.AlwaysOnTop = false
    ring.ZIndex = 6
    ring.Parent = part

    local bb, title, sub, stroke = makeVizLabel(part, range + 1.0, VizTheme.Reach, "REACH", "range " .. tostring(math.floor(range)))
    bb.Name = "MontexReachLabel"
    bb.Parent = part
    reachLabel = sub

    local spin = 0
    local pulse = 0
    if reachVizConn then reachVizConn:Disconnect() end
    reachVizConn = RunService.RenderStepped:Connect(function(dt)
        if not reachVisualizer or not reachVisualizer.Parent then
            if reachVizConn then reachVizConn:Disconnect(); reachVizConn = nil end
            return
        end
        spin = (spin + dt * 34) % 360
        pulse = (pulse + dt * 2.6) % (math.pi * 2)
        local wave = (math.sin(pulse) + 1) * 0.5
        sphere.Transparency = 0.78 + wave * 0.14
        fill.Transparency = 0.90 + wave * 0.08
        ring.Transparency = 0.40 + wave * 0.30
        ring.CFrame = CFrame.new(reachVisualizer.Position) * CFrame.Angles(0, math.rad(spin), 0)
        sphere.Color3 = VizTheme.Reach:Lerp(VizTheme.ReachSoft, wave * 0.4)
        stroke.Transparency = 0.20 + wave * 0.35
    end)
end

local function updateReachVisualizer()
    if s.Ball.BallReachVisualizer ~= true then
        if reachVisualizer then destroyReachVisualizer() end
        return
    end

    local range = s.Ball.BallReachRange or 10

    local ballPart
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if myRoot then
        local closest = math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local bball = p.Character:FindFirstChild("Basketball")
                if bball then
                    local bp = bball:FindFirstChild("Ball") or bball:FindFirstChildOfClass("BasePart")
                    if bp then
                        local d = (myRoot.Position - bp.Position).Magnitude
                        if d < closest then closest = d; ballPart = bp end
                    end
                end
            end
        end
    end

    if not ballPart then
        if reachVisualizer then destroyReachVisualizer() end
        return
    end

    if not reachVisualizer or not reachVisualizer.Parent then
        reachVisualizer = Instance.new("Part")
        reachVisualizer.Name = "MontexReachVisualizer"
        reachVisualizer.Shape = Enum.PartType.Ball
        reachVisualizer.Size = Vector3.new(0.1, 0.1, 0.1)
        reachVisualizer.Transparency = 1
        reachVisualizer.CanCollide = false
        reachVisualizer.CanTouch = false
        reachVisualizer.CanQuery = false
        reachVisualizer.CastShadow = false
        reachVisualizer.Massless = true
        reachVisualizer.Anchored = true
        reachVisualizer.Parent = workspace

        buildReachVisuals(reachVisualizer, range)
    end

    reachVisualizer.CFrame = ballPart.CFrame

    local sphere = reachVisualizer:FindFirstChild("MontexReachSphere")
    if sphere then sphere.Radius = range end
    local fill = reachVisualizer:FindFirstChild("MontexReachFill")
    if fill then fill.Radius = range - 0.2 end
    local ring = reachVisualizer:FindFirstChild("MontexReachRing")
    if ring then ring.Radius = range end
    if reachLabel then reachLabel.Text = "range " .. tostring(math.floor(range)) end
    local bb = reachVisualizer:FindFirstChild("MontexReachLabel")
    if bb then bb.StudsOffsetWorldSpace = Vector3.new(0, range + 1.0, 0) end
end

local function enableReach()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("MontexReach") then char.MontexReach:Destroy() end
    if reachConnection then reachConnection:Disconnect(); reachConnection = nil end
    reachConnection = RunService.Heartbeat:Connect(function()
        if not s.Ball.BallReach and not s.Ball.BallReachVisualizer then
            removeReachHitbox()
            return
        end
        performReachSteal()
        updateReachVisualizer()
    end)
end

local function disableReach()
    if not s.Ball.BallReachVisualizer then
        if reachConnection then reachConnection:Disconnect(); reachConnection = nil end
        removeReachHitbox()
    else
        destroyReachVisualizer()
    end
end

-- ===== END VISUALIZER MODULE =====

local speedConnection = nil
local function enableSpeedBoost()
    if speedConnection then speedConnection:Disconnect(); speedConnection = nil end
    speedConnection = RunService.Heartbeat:Connect(function()
        if not s.Player.Walkspeed then return end
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if not humanoid or not hrp then return end
        local moveDir = humanoid.MoveDirection
        if moveDir.Magnitude > 0.05 then
            local multiplier = math.clamp(s.Player.WSvalue or 1.35, 1, 1.65)
            local targetSpeed = 16 * multiplier
            local currentY = hrp.AssemblyLinearVelocity.Y
            local targetVel = moveDir.Unit * targetSpeed
            hrp.AssemblyLinearVelocity = Vector3.new(targetVel.X, currentY, targetVel.Z)
        end
    end)
end

local function disableSpeedBoost()
    if speedConnection then speedConnection:Disconnect(); speedConnection = nil end
end

local goalEventHook = nil
local OriginalReplicateBall = nil
local Replicator = nil

pcall(function()
    Replicator = require(ReplicatedStorage.Util.Replicator)
    OriginalReplicateBall = Replicator["ReplicateBall"]
end)

local function applyGoalEffect()
    if s.Goal.CurrentEffect == "LightRay" or Effects[s.Goal.CurrentEffect] == nil then return end
    pcall(function()
        local PlayerData = require(ReplicatedStorage.Util.PlayerData)
        PlayerData.storedData["Equipping"]["Effect"] = Effects[s.Goal.CurrentEffect].Name
        PlayerData.storedData["Inventory"][Effects[s.Goal.CurrentEffect].Name] = 1
    end)
    if goalEventHook then return end
    pcall(function()
        local connections = getconnections(ReplicatedStorage.Remotes.goalEvent.OnClientEvent)
        if connections and connections[1] then
            local old
            old = hookfunction(connections[1].Function, function(Player, Court, Goal, XYZ, GoalEffect, Unknown)
                if Player == LocalPlayer and s.Goal.Enabled then
                    GoalEffect = Effects[s.Goal.CurrentEffect].Value
                end
                return old(Player, Court, Goal, XYZ, GoalEffect, Unknown)
            end)
            goalEventHook = old
        end
    end)
end

local function resetGoalEffect()
    pcall(function()
        local PlayerData = require(ReplicatedStorage.Util.PlayerData)
        PlayerData.storedData["Equipping"]["Effect"] = Effects["LightRay"] and Effects["LightRay"].Name or nil
        if Effects["LightRay"] then
            PlayerData.storedData["Inventory"][Effects["LightRay"].Name] = 1
        end
    end)
end

local function applyBallChanger()
    if not Replicator or not OriginalReplicateBall then return end
    Replicator["ReplicateBall"] = function(Parent, Name)
        Name = Balls[s.BallChanger.CurrentBall]
        return OriginalReplicateBall(Parent, Name)
    end
end

local function resetBallChanger()
    if not Replicator or not OriginalReplicateBall then return end
    Replicator["ReplicateBall"] = OriginalReplicateBall
end

local function getTemplateTrail()
    local trailName = s.TrailChanger.CurrentTrail
    if not trailName or trailName == "None" then return nil end
    local trailModel = Trails[trailName]
    if not trailModel then return nil end
    if trailModel:IsA("BasePart") then
        local t = trailModel:FindFirstChildOfClass("Trail")
        if t then return t end
    end
    local t = trailModel:FindFirstChildOfClass("Trail")
    if t then return t end
    for _, desc in trailModel:GetDescendants() do
        if desc:IsA("Trail") then return desc end
    end
    return nil
end

local function cleanBallTrails(ballPart)
    if not ballPart then return end
    for _, child in ballPart:GetChildren() do
        if child.Name == "MontexAttach0" or child.Name == "MontexAttach1" then child:Destroy() end
        if child:IsA("Trail") and child.Name == "MontexTrail" then child:Destroy() end
    end
end

local function restoreTrailColor(ballPart)
    if not s.TrailChanger.Enabled then return end
    local templateTrail = getTemplateTrail()
    if not templateTrail then return end
    local function fix(trail)
        trail.Color = templateTrail.Color
        trail.LightEmission = templateTrail.LightEmission
        trail.Transparency = templateTrail.Transparency
        trail.Enabled = true
    end
    if ballPart then
        for _, child in ballPart:GetChildren() do
            if child:IsA("Trail") and child.Name == "MontexTrail" then fix(child) end
        end
    else
        for _, desc in workspace:GetDescendants() do
            if desc:IsA("BasePart") and desc.Name == "Ball" then
                for _, child in desc:GetChildren() do
                    if child:IsA("Trail") and child.Name == "MontexTrail" then fix(child) end
                end
            end
        end
    end
end

local function applyTrailToBall(ballPart)
    if not ballPart or not s.TrailChanger.Enabled then return end
    local templateTrail = getTemplateTrail()
    if not templateTrail then return end
    cleanBallTrails(ballPart)
    local attach0 = Instance.new("Attachment")
    attach0.Name = "MontexAttach0"
    attach0.Position = Vector3.new(0, 0.5, 0)
    attach0.Parent = ballPart
    local attach1 = Instance.new("Attachment")
    attach1.Name = "MontexAttach1"
    attach1.Position = Vector3.new(0, -0.5, 0)
    attach1.Parent = ballPart
    local newTrail = templateTrail:Clone()
    newTrail.Name = "MontexTrail"
    newTrail.Attachment0 = attach0
    newTrail.Attachment1 = attach1
    newTrail.Enabled = true
    newTrail.Parent = ballPart
    ballPart:GetPropertyChangedSignal("BrickColor"):Connect(function()
        task.wait(0.05)
        restoreTrailColor(ballPart)
    end)
    ballPart:GetPropertyChangedSignal("Color"):Connect(function()
        task.wait(0.05)
        restoreTrailColor(ballPart)
    end)
end

local function resetTrailOnBall(ballPart)
    if not ballPart then return end
    cleanBallTrails(ballPart)
end

local function applyTrailToAllBalls()
    for _, desc in workspace:GetDescendants() do
        if desc:IsA("BasePart") and desc.Name == "Ball" then applyTrailToBall(desc) end
    end
end

local function resetTrailOnAllBalls()
    for _, desc in workspace:GetDescendants() do
        if desc:IsA("BasePart") and desc.Name == "Ball" then resetTrailOnBall(desc) end
    end
end

local function CleanCharacter()
    local char = LocalPlayer.Character
    if not char then return end
    local realHead = char:FindFirstChild("Head")
    for _, child in char:GetChildren() do
        if child:IsA("Part") or child:IsA("MeshPart") then
            if child.Name:lower():find("head") and child ~= realHead then
                child.Transparency = 1; child.CanCollide = false
            end
            if child.Name:lower() == "aura" then
                child.Transparency = 1; child.CanCollide = false
            end
        end
    end
end

local function FindRig(auraModel)
    for _, child in auraModel:GetChildren() do
        if child:IsA("Model") and child:FindFirstChildOfClass("Humanoid") then return child end
    end
    if auraModel:FindFirstChildOfClass("Humanoid") then return auraModel end
    return nil
end

local function GetAuraRigParts(rigModel)
    local parts = {}
    for _, nm in {"Head","LeftArm","RightArm","Torso","LeftLeg","RightLeg","HumanoidRootPart"} do
        local part = rigModel:FindFirstChild(nm)
        if part and part:IsA("BasePart") then parts[nm] = part end
    end
    return parts
end

local function GetCharacterParts()
    local char = LocalPlayer.Character
    if not char then return {} end
    local parts = {}
    for _, nm in {"Head","LeftArm","RightArm","Torso","UpperTorso","LeftLeg","RightLeg","HumanoidRootPart"} do
        local part = char:FindFirstChild(nm)
        if part and part:IsA("BasePart") then parts[nm] = part end
    end
    return parts
end

local function RemoveFaceTextures(part)
    if not part then return end
    for _, child in part:GetChildren() do
        if child:IsA("Decal") or child:IsA("Texture") or child:IsA("SurfaceAppearance") then
            child:Destroy()
        end
    end
end

local function CreateAuraVisuals(auraModel)
    local char = LocalPlayer.Character
    if not char or not char.Parent then return false end
    if char:FindFirstChild("AuraVisuals") then char.AuraVisuals:Destroy() end
    CleanCharacter()
    local rig = FindRig(auraModel)
    if not rig then return false end
    local auraParts = GetAuraRigParts(rig)
    if not auraParts or next(auraParts) == nil then return false end
    local charParts = GetCharacterParts()
    if not charParts or next(charParts) == nil then return false end
    local container = Instance.new("Model")
    container.Name = "AuraVisuals"
    container.Parent = char
    if not charParts["Head"] then return false end
    for partName, auraPart in auraParts do
        local charPart = charParts[partName]
        if charPart and auraPart then
            local newPart = auraPart:Clone()
            newPart.Anchored = false
            newPart.CanCollide = false
            newPart.Transparency = 1
            newPart.Parent = container
            if partName == "Head" then
                RemoveFaceTextures(newPart)
                local weld = Instance.new("Weld")
                weld.Part0 = charPart; weld.Part1 = newPart
                weld.C0 = CFrame.new(0, 0, 0); weld.Parent = newPart
            elseif partName == "HumanoidRootPart" then
                newPart.Transparency = 1
                newPart.CanCollide = false
                newPart.Anchored = false
            else
                local weld = Instance.new("Weld")
                weld.Part0 = charPart; weld.Part1 = newPart
                local referencePart = rig:FindFirstChild("HumanoidRootPart") or rig.PrimaryPart or auraPart
                weld.C0 = CFrame.new(auraPart.Position - referencePart.Position)
                weld.Parent = newPart
            end
        end
    end
    for _, child in container:GetDescendants() do
        if child:IsA("Script") or child:IsA("LocalScript") or child:IsA("ModuleScript") then
            child:Destroy()
        end
    end
    return true
end

local function ApplyAura(auraModel)
    local char = LocalPlayer.Character
    if not char then return false end
    if char:FindFirstChild("AuraVisuals") then char.AuraVisuals:Destroy() end
    task.wait(0.1)
    return CreateAuraVisuals(auraModel)
end

local function RemoveAura()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("AuraVisuals") then char.AuraVisuals:Destroy() end
    return true
end

local ownNameplateConnection = nil
local originalNameTexts = {}
local originalRecordTexts = {}
local originalTitleTexts = {}
local textListeners = {}

local function formatStrokeText(orig, custom)
    if not custom or custom == "" then return orig end
    if orig and orig:match("^<stroke>") and orig:match("</stroke>$") then
        return "<stroke>" .. custom .. "</stroke>"
    end
    return custom
end

local function applyOwnNameplate()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local nameTag = hrp:FindFirstChild("NameTag")
    if nameTag and nameTag:IsA("BillboardGui") then
        local mainFrame = nameTag:FindFirstChild("MainFrame")
        local gameFrame = nameTag:FindFirstChild("GameFrame")
        local subFrame = mainFrame and mainFrame:FindFirstChild("Frame")
        local nameLabels = {}
        if mainFrame and mainFrame:FindFirstChild("NameLabel") then table.insert(nameLabels, mainFrame.NameLabel) end
        if gameFrame and gameFrame:FindFirstChild("NameLabel") then table.insert(nameLabels, gameFrame.NameLabel) end
        for _, obj in ipairs(nameTag:GetDescendants()) do
            if obj:IsA("TextLabel") and obj.Name == "NameLabel" and not table.find(nameLabels, obj) then
                table.insert(nameLabels, obj)
            end
        end
        for _, obj in ipairs(nameLabels) do
            if not originalNameTexts[obj] then originalNameTexts[obj] = obj.Text end
            local target = (s.Visuals.CustomNameText ~= "") and s.Visuals.CustomNameText or originalNameTexts[obj]
            if obj.Text ~= target then obj.Text = target end
            if not textListeners[obj] then
                textListeners[obj] = obj:GetPropertyChangedSignal("Text"):Connect(function()
                    if s.Visuals.CustomNameText ~= "" and obj.Text ~= s.Visuals.CustomNameText then
                        obj.Text = s.Visuals.CustomNameText
                    end
                end)
            end
        end
        local recordLabels = {}
        if subFrame and subFrame:FindFirstChild("RecordLabel") then table.insert(recordLabels, subFrame.RecordLabel) end
        for _, obj in ipairs(nameTag:GetDescendants()) do
            if obj:IsA("TextLabel") and obj.Name == "RecordLabel" and not table.find(recordLabels, obj) then
                table.insert(recordLabels, obj)
            end
        end
        for _, obj in ipairs(recordLabels) do
            if not originalRecordTexts[obj] then originalRecordTexts[obj] = obj.Text end
            local target = formatStrokeText(originalRecordTexts[obj], s.Visuals.CustomRecordText)
            if obj.Text ~= target then obj.Text = target end
            if not textListeners[obj] then
                textListeners[obj] = obj:GetPropertyChangedSignal("Text"):Connect(function()
                    if s.Visuals.CustomRecordText ~= "" then
                        local expected = formatStrokeText(originalRecordTexts[obj], s.Visuals.CustomRecordText)
                        if obj.Text ~= expected then obj.Text = expected end
                    end
                end)
            end
        end
        local titleLabels = {}
        if subFrame and subFrame:FindFirstChild("AchievementName") then table.insert(titleLabels, subFrame.AchievementName) end
        for _, obj in ipairs(nameTag:GetDescendants()) do
            if obj:IsA("TextLabel") and (obj.Name == "AchievementName" or obj.Name == "TitleLabel") and not table.find(titleLabels, obj) then
                table.insert(titleLabels, obj)
            end
        end
        for _, obj in ipairs(titleLabels) do
            if not originalTitleTexts[obj] then originalTitleTexts[obj] = obj.Text end
            local target = formatStrokeText(originalTitleTexts[obj], s.Visuals.CustomTitleText)
            if obj.Text ~= target then obj.Text = target end
            if not textListeners[obj] then
                textListeners[obj] = obj:GetPropertyChangedSignal("Text"):Connect(function()
                    if s.Visuals.CustomTitleText ~= "" then
                        local expected = formatStrokeText(originalTitleTexts[obj], s.Visuals.CustomTitleText)
                        if obj.Text ~= expected then obj.Text = expected end
                    end
                end)
            end
        end
    end
end

local function setupOwnNameplateListener()
    if ownNameplateConnection then return end
    local function onChar(char)
        task.wait(0.2)
        applyOwnNameplate()
        local hrp = char:WaitForChild("HumanoidRootPart", 5)
        if hrp then
            hrp.ChildAdded:Connect(function(child)
                if child:IsA("BillboardGui") then
                    task.wait(0.05)
                    applyOwnNameplate()
                end
            end)
            local nameTag = hrp:WaitForChild("NameTag", 5)
            if nameTag then
                nameTag.DescendantAdded:Connect(function()
                    task.wait(0.05)
                    applyOwnNameplate()
                end)
            end
        end
    end
    if LocalPlayer.Character then task.spawn(onChar, LocalPlayer.Character) end
    ownNameplateConnection = LocalPlayer.CharacterAdded:Connect(onChar)
end

local function applyLogoBadge()
    if not s.LogoBadges.Enabled then
        for _, bn in ipairs({"VIP","Youtuber","Twitch","Booster","Tester","Staff"}) do
            if LocalPlayer:GetAttribute(bn) == true then
                pcall(function() LocalPlayer:SetAttribute(bn, false) end)
            end
        end
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local creatorTag = root and root:FindFirstChild("CreatorTag")
        if creatorTag then
            for _, bn in ipairs({"VIP","Youtuber","Twitch","Booster","Tester","Staff"}) do
                local el = creatorTag:FindFirstChild(bn)
                if el then el.Visible = false end
            end
        end
        return
    end
    local badge = s.LogoBadges.Badge
    for _, bn in ipairs({"VIP","Youtuber","Twitch","Booster","Tester","Staff"}) do
        local want = (bn == badge)
        if LocalPlayer:GetAttribute(bn) ~= want then
            pcall(function() LocalPlayer:SetAttribute(bn, want) end)
        end
    end
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local creatorTag = root and root:FindFirstChild("CreatorTag")
    if creatorTag then
        for _, bn in ipairs({"VIP","Youtuber","Twitch","Booster","Tester","Staff"}) do
            local el = creatorTag:FindFirstChild(bn)
            if el then el.Visible = (bn == badge) end
        end
        if #s.LogoBadges.CustomIds > 0 then
            local prefix = "MONTEX_Custom_"
            for _, child in ipairs(creatorTag:GetChildren()) do
                if string.find(child.Name, prefix, 1, true) then child:Destroy() end
            end
            local template = creatorTag:FindFirstChild(badge) or creatorTag:FindFirstChild("VIP")
            if template then
                for i, id in ipairs(s.LogoBadges.CustomIds) do
                    local ok, clone = pcall(function() return template:Clone() end)
                    if ok and clone then
                        clone.Name = prefix .. tostring(id)
                        clone.LayoutOrder = 50 + i
                        clone.Visible = true
                        clone.Image = "rbxthumb://type=Asset&id=" .. tostring(id) .. "&w=420&h=420"
                        clone.ImageColor3 = Color3.new(1,1,1)
                        clone.ImageTransparency = 0
                        clone.Parent = creatorTag
                    end
                end
            end
        end
    end
end

local function getInGamePlayerNames()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(names, p.Name)
        end
    end
    if #names == 0 then table.insert(names, "None") end
    table.sort(names)
    return names
end

local originalHumanoidDescription = nil
local originalAvatarBackup = {
    BodyColors = nil, Clothing = {}, Accessories = {}, CharacterMeshes = {},
    Decals = {}, HeadMesh = nil, HasHeadMesh = false, SurfaceAppearance = nil, Scales = {},
}

local function captureOriginalAvatar()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not originalHumanoidDescription and LocalPlayer.UserId then
            pcall(function()
                originalHumanoidDescription = Players:GetHumanoidDescriptionFromUserId(LocalPlayer.UserId)
            end)
        end
        local bc = char:FindFirstChildOfClass("BodyColors")
        if bc then
            originalAvatarBackup.BodyColors = {
                HeadColor3 = bc.HeadColor3,
                LeftArmColor3 = bc.LeftArmColor3,
                RightArmColor3 = bc.RightArmColor3,
                LeftLegColor3 = bc.LeftLegColor3,
                RightLegColor3 = bc.RightLegColor3,
                TorsoColor3 = bc.TorsoColor3,
            }
        end
        originalAvatarBackup.Clothing = {}
        for _, item in ipairs(char:GetChildren()) do
            if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
                table.insert(originalAvatarBackup.Clothing, item:Clone())
            end
        end
        originalAvatarBackup.Accessories = {}
        for _, item in ipairs(char:GetChildren()) do
            if item:IsA("Accessory") or item:IsA("Hat") then
                table.insert(originalAvatarBackup.Accessories, item:Clone())
            end
        end
        originalAvatarBackup.CharacterMeshes = {}
        for _, item in ipairs(char:GetChildren()) do
            if item:IsA("CharacterMesh") then
                table.insert(originalAvatarBackup.CharacterMeshes, item:Clone())
            end
        end
        local head = char:FindFirstChild("Head")
        if head then
            originalAvatarBackup.Decals = {}
            for _, d in ipairs(head:GetChildren()) do
                if d:IsA("Decal") then table.insert(originalAvatarBackup.Decals, d:Clone()) end
            end
            local mesh = head:FindFirstChildOfClass("SpecialMesh")
            if mesh then
                originalAvatarBackup.HasHeadMesh = true
                originalAvatarBackup.HeadMesh = {
                    MeshId = mesh.MeshId, TextureId = mesh.TextureId,
                    Scale = mesh.Scale, Offset = mesh.Offset
                }
            else
                originalAvatarBackup.HasHeadMesh = false
                originalAvatarBackup.HeadMesh = nil
            end
            local sa = head:FindFirstChildOfClass("SurfaceAppearance")
            if sa then originalAvatarBackup.SurfaceAppearance = sa:Clone() end
        end
        if hum then
            originalAvatarBackup.Scales = {}
            for _, scaleName in ipairs({"BodyHeightScale","BodyWidthScale","BodyDepthScale","HeadScale","BodyProportionScale","BodyTypeScale"}) do
                local sc = hum:FindFirstChild(scaleName)
                if sc then originalAvatarBackup.Scales[scaleName] = sc.Value end
            end
        end
    end)
end

task.defer(function()
    task.wait(1)
    captureOriginalAvatar()
end)

local function attachAccessoryToChar(localChar, accClone, originalAcc)
    local handle = accClone:FindFirstChild("Handle") or accClone:FindFirstChildOfClass("BasePart")
    if not handle then return end
    for _, joint in ipairs(handle:GetChildren()) do
        if joint:IsA("Weld") or joint:IsA("WeldConstraint") or joint:IsA("ManualWeld") or joint:IsA("Motor6D") then
            if joint.Name == "AccessoryWeld" or not joint.Part1 or not joint.Part1:IsDescendantOf(accClone) then
                joint:Destroy()
            end
        end
    end
    handle.Anchored = false
    handle.CanCollide = false
    handle.CanTouch = false
    handle.CanQuery = false
    pcall(function() handle.Massless = true end)
    local attached = false
    local handleAtt = handle:FindFirstChildOfClass("Attachment")
    if handleAtt then
        for _, part in ipairs(localChar:GetChildren()) do
            if part:IsA("BasePart") then
                local charAtt = part:FindFirstChild(handleAtt.Name)
                if charAtt and charAtt:IsA("Attachment") then
                    local weld = Instance.new("Weld")
                    weld.Name = "AccessoryWeld"
                    weld.Part0 = handle
                    weld.Part1 = part
                    weld.C0 = handleAtt.CFrame
                    weld.C1 = charAtt.CFrame
                    weld.Parent = handle
                    attached = true
                    break
                end
            end
        end
    end
    if not attached and originalAcc then
        local origHandle = originalAcc:FindFirstChild("Handle") or originalAcc:FindFirstChildOfClass("BasePart")
        if origHandle then
            local origWeld = origHandle:FindFirstChild("AccessoryWeld") or origHandle:FindFirstChildOfClass("Weld")
            if origWeld and origWeld.Part1 then
                local targetPart = localChar:FindFirstChild(origWeld.Part1.Name)
                if targetPart and targetPart:IsA("BasePart") then
                    local weld = Instance.new("Weld")
                    weld.Name = "AccessoryWeld"
                    weld.Part0 = handle
                    weld.Part1 = targetPart
                    weld.C0 = origWeld.C0
                    weld.C1 = origWeld.C1
                    weld.Parent = handle
                    attached = true
                end
            end
        end
    end
    if not attached then
        local nameLower = accClone.Name:lower()
        local targetPartName = "Head"
        if nameLower:find("hair") or nameLower:find("hat") or nameLower:find("cap") or nameLower:find("hood")
            or nameLower:find("helm") or nameLower:find("horns") or nameLower:find("bandana")
            or nameLower:find("glasses") or nameLower:find("mask") or nameLower:find("face")
            or nameLower:find("beanie") or nameLower:find("fedora") or nameLower:find("crown") then
            targetPartName = "Head"
        elseif nameLower:find("cape") or nameLower:find("wings") or nameLower:find("backpack")
            or nameLower:find("sword") or nameLower:find("back") or nameLower:find("quiver") then
            targetPartName = localChar:FindFirstChild("UpperTorso") and "UpperTorso" or "Torso"
        elseif nameLower:find("waist") or nameLower:find("tail") or nameLower:find("belt") then
            targetPartName = localChar:FindFirstChild("LowerTorso") and "LowerTorso" or "Torso"
        elseif nameLower:find("shoulder") or nameLower:find("pauldrons") then
            targetPartName = localChar:FindFirstChild("RightUpperArm") and "RightUpperArm" or (localChar:FindFirstChild("Right Arm") and "Right Arm" or "Torso")
        elseif nameLower:find("necklace") or nameLower:find("scarf") or nameLower:find("collar") or nameLower:find("neck") then
            targetPartName = localChar:FindFirstChild("UpperTorso") and "UpperTorso" or (localChar:FindFirstChild("Head") and "Head" or "Torso")
        end
        local targetPart = localChar:FindFirstChild(targetPartName) or localChar:FindFirstChild("Head") or localChar:FindFirstChild("HumanoidRootPart")
        if targetPart then
            local weld = Instance.new("Weld")
            weld.Name = "AccessoryWeld"
            weld.Part0 = handle
            weld.Part1 = targetPart
            if handleAtt then weld.C0 = handleAtt.CFrame else weld.C0 = CFrame.new(0, 0, 0) end
            weld.C1 = CFrame.new(0, 0, 0)
            weld.Parent = handle
            attached = true
        end
    end
    accClone.Parent = localChar
end

local function copyCharacterDirect(targetChar, targetUserId)
    local localChar = LocalPlayer.Character
    if not localChar or not targetChar then return false end
    local localHum = localChar:FindFirstChildOfClass("Humanoid")
    local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
    if not localHum then return false end
    local targetColors = targetChar:FindFirstChildOfClass("BodyColors")
    if targetColors then
        local localColors = localChar:FindFirstChildOfClass("BodyColors")
        if not localColors then localColors = Instance.new("BodyColors", localChar) end
        localColors.HeadColor3 = targetColors.HeadColor3
        localColors.LeftArmColor3 = targetColors.LeftArmColor3
        localColors.RightArmColor3 = targetColors.RightArmColor3
        localColors.LeftLegColor3 = targetColors.LeftLegColor3
        localColors.RightLegColor3 = targetColors.RightLegColor3
        localColors.TorsoColor3 = targetColors.TorsoColor3
    end
    for _, item in ipairs(localChar:GetChildren()) do
        if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then item:Destroy() end
    end
    for _, item in ipairs(targetChar:GetChildren()) do
        if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
            local clone = item:Clone()
            clone.Parent = localChar
        end
    end
    for _, item in ipairs(localChar:GetChildren()) do
        if item:IsA("Accessory") or item:IsA("Hat") then item:Destroy() end
    end
    for _, item in ipairs(targetChar:GetChildren()) do
        if item:IsA("Accessory") or item:IsA("Hat") then
            local clone = item:Clone()
            attachAccessoryToChar(localChar, clone, item)
        end
    end
    local targetHead = targetChar:FindFirstChild("Head")
    local localHead = localChar:FindFirstChild("Head")
    if targetHead and localHead then
        local targetFace = targetHead:FindFirstChildOfClass("Decal") or targetHead:FindFirstChild("face")
        local localFace = localHead:FindFirstChildOfClass("Decal") or localHead:FindFirstChild("face")
        if targetFace then
            if not localFace then
                localFace = Instance.new("Decal")
                localFace.Name = "face"
                localFace.Face = Enum.NormalId.Front
                localFace.Parent = localHead
            end
            localFace.Texture = targetFace.Texture
        end
        local targetMesh = targetHead:FindFirstChildOfClass("SpecialMesh")
        local localMesh = localHead:FindFirstChildOfClass("SpecialMesh")
        if targetMesh and localMesh then
            localMesh.MeshId = targetMesh.MeshId
            localMesh.TextureId = targetMesh.TextureId
            localMesh.Scale = targetMesh.Scale
        end
    end
    for _, item in ipairs(localChar:GetChildren()) do
        if item:IsA("CharacterMesh") then item:Destroy() end
    end
    for _, item in ipairs(targetChar:GetChildren()) do
        if item:IsA("CharacterMesh") then item:Clone().Parent = localChar end
    end
    if targetHum then
        for _, scaleName in ipairs({"BodyHeightScale","BodyWidthScale","BodyDepthScale","HeadScale","BodyProportionScale","BodyTypeScale"}) do
            local tScale = targetHum:FindFirstChild(scaleName)
            local lScale = localHum:FindFirstChild(scaleName)
            if tScale and lScale then lScale.Value = tScale.Value end
        end
    end
    return true
end

local function applyAvatar(targetUserId, targetPlayerInstance)
    local char = LocalPlayer.Character
    if not char then return false, "No character found" end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false, "No humanoid found" end
    if targetPlayerInstance and targetPlayerInstance.Character and targetPlayerInstance.Character:FindFirstChild("Head") then
        if copyCharacterDirect(targetPlayerInstance.Character, targetUserId) then
            s.AvatarChanger.LastCopiedUserId = targetUserId
            return true
        end
    end
    if targetUserId then
        for _, p in ipairs(Players:GetPlayers()) do
            if p.UserId == targetUserId and p.Character and p.Character:FindFirstChild("Head") then
                if copyCharacterDirect(p.Character, targetUserId) then
                    s.AvatarChanger.LastCopiedUserId = targetUserId
                    return true
                end
            end
        end
    end
    if targetUserId then
        local dummy = nil
        pcall(function() dummy = Players:CreateHumanoidModelFromUserId(targetUserId) end)
        if not dummy then
            local ok, desc = pcall(function() return Players:GetHumanoidDescriptionFromUserId(targetUserId) end)
            if ok and desc then
                pcall(function() dummy = Players:CreateHumanoidModelFromDescription(desc, hum.RigType) end)
            end
        end
        if dummy then
            local copied = copyCharacterDirect(dummy, targetUserId)
            dummy:Destroy()
            if copied then
                s.AvatarChanger.LastCopiedUserId = targetUserId
                return true
            end
        end
        local ok, desc = pcall(function() return Players:GetHumanoidDescriptionFromUserId(targetUserId) end)
        if ok and desc then
            local applied = pcall(function() hum:ApplyDescription(desc) end)
            if applied then
                s.AvatarChanger.LastCopiedUserId = targetUserId
                return true
            end
        end
    end
    return false, "Could not apply avatar"
end

local function copyAvatarFromSelected()
    local selectedName = s.AvatarChanger.SelectedPlayer
    if not selectedName or selectedName == "None" or selectedName == "" then
        return false, "Select a player from the list first"
    end
    local targetPlayer = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and (p.Name == selectedName or p.DisplayName == selectedName or p.Name:lower() == selectedName:lower()) then
            targetPlayer = p
            break
        end
    end
    if not targetPlayer then return false, "Player not found in game" end
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("Head") then
        return false, "Target player character not spawned yet"
    end
    s.AvatarChanger.LastCopiedName = targetPlayer.Name
    local ok, err = applyAvatar(targetPlayer.UserId, targetPlayer)
    return ok, ok and targetPlayer.Name or err
end

local function copyAvatarFromCustom()
    local input = s.AvatarChanger.CustomUser
    if not input or input:gsub("%s+", "") == "" then return false, "Enter a Username or UserId" end
    input = input:match("^%s*(.-)%s*$")
    local userId = tonumber(input)
    local targetName = input
    if not userId then
        local ok, resolvedId = pcall(function() return Players:GetUserIdFromNameAsync(input) end)
        if ok and resolvedId then userId = resolvedId
        else return false, "Username not found on Roblox" end
    end
    local targetPlayer = Players:GetPlayerByUserId(userId)
    s.AvatarChanger.LastCopiedName = targetName
    local ok, err = applyAvatar(userId, targetPlayer)
    return ok, ok and targetName or err
end

local function resetAvatar()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not char or not hum then return false end
    s.AvatarChanger.LastCopiedUserId = nil
    pcall(function()
        local desc = originalHumanoidDescription or Players:GetHumanoidDescriptionFromUserId(LocalPlayer.UserId)
        if desc then hum:ApplyDescription(desc) end
    end)
    for _, item in ipairs(char:GetChildren()) do
        if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") or item:IsA("Accessory") or item:IsA("Hat") or item:IsA("CharacterMesh") then
            item:Destroy()
        end
    end
    if originalAvatarBackup.BodyColors then
        local bc = char:FindFirstChildOfClass("BodyColors") or Instance.new("BodyColors", char)
        bc.HeadColor3 = originalAvatarBackup.BodyColors.HeadColor3
        bc.LeftArmColor3 = originalAvatarBackup.BodyColors.LeftArmColor3
        bc.RightArmColor3 = originalAvatarBackup.BodyColors.RightArmColor3
        bc.LeftLegColor3 = originalAvatarBackup.BodyColors.LeftLegColor3
        bc.RightLegColor3 = originalAvatarBackup.BodyColors.RightLegColor3
        bc.TorsoColor3 = originalAvatarBackup.BodyColors.TorsoColor3
    end
    for _, cloth in ipairs(originalAvatarBackup.Clothing) do
        cloth:Clone().Parent = char
    end
    for _, acc in ipairs(originalAvatarBackup.Accessories) do
        local clone = acc:Clone()
        attachAccessoryToChar(char, clone, acc)
    end
    for _, cm in ipairs(originalAvatarBackup.CharacterMeshes) do
        cm:Clone().Parent = char
    end
    local head = char:FindFirstChild("Head")
    if head then
        for _, d in ipairs(head:GetChildren()) do
            if d:IsA("Decal") or d:IsA("SurfaceAppearance") or d:IsA("FaceControls") then d:Destroy() end
        end
        if #originalAvatarBackup.Decals > 0 then
            for _, d in ipairs(originalAvatarBackup.Decals) do d:Clone().Parent = head end
        else
            local decal = Instance.new("Decal")
            decal.Name = "face"
            decal.Face = Enum.NormalId.Front
            decal.Texture = "rbxasset://textures/face.png"
            decal.Parent = head
        end
        if originalAvatarBackup.SurfaceAppearance then
            originalAvatarBackup.SurfaceAppearance:Clone().Parent = head
        end
        local mesh = head:FindFirstChildOfClass("SpecialMesh")
        if originalAvatarBackup.HasHeadMesh and originalAvatarBackup.HeadMesh then
            if not mesh then mesh = Instance.new("SpecialMesh", head) end
            mesh.MeshId = originalAvatarBackup.HeadMesh.MeshId
            mesh.TextureId = originalAvatarBackup.HeadMesh.TextureId
            mesh.Scale = originalAvatarBackup.HeadMesh.Scale
            mesh.Offset = originalAvatarBackup.HeadMesh.Offset
        else
            if mesh then mesh:Destroy() end
        end
    end
    for scaleName, val in pairs(originalAvatarBackup.Scales) do
        local sc = hum:FindFirstChild(scaleName)
        if sc then sc.Value = val end
    end
    return true
end

local function SpoofDevice()
    if not s.Misc.DeviceSpoofer then return end
    local device = s.Misc.Device
    if device == "PC" then DeviceEvent:FireServer("Desktop")
    elseif device == "Mobile" then DeviceEvent:FireServer("Mobile")
    elseif device == "Gamepad" then DeviceEvent:FireServer("Gamepad") end
end

local function SetFPSCap(enabled, value)
    if type(setfpscap) ~= "function" then return end
    if s.FPSCap.Original == nil and type(getfpscap) == "function" then
        local ok, orig = pcall(getfpscap)
        if ok and tonumber(orig) then s.FPSCap.Original = tonumber(orig) end
    end
    if enabled then
        s.FPSCap.Value = math.clamp(math.floor((tonumber(value) or 60) + 0.5), 15, 360)
        pcall(setfpscap, s.FPSCap.Value)
    else
        pcall(setfpscap, s.FPSCap.Original or 9999)
    end
end

local AntiLagCache = { active = false, entries = {}, conn = nil }

local function stripAntiLag()
    local cache = AntiLagCache.entries
    table.clear(cache)

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
            if obj.CastShadow then
                table.insert(cache, { obj = obj, prop = "CastShadow", val = true })
                obj.CastShadow = false
            end
            if obj:IsA("MeshPart") and obj.TextureID ~= "" then
                table.insert(cache, { obj = obj, prop = "TextureID", val = obj.TextureID })
                obj.TextureID = ""
            end
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            table.insert(cache, { obj = obj, prop = "Transparency", val = obj.Transparency })
            obj.Transparency = 1
        elseif obj:IsA("SurfaceAppearance") then
            table.insert(cache, { obj = obj, prop = "Transparency", val = obj.Transparency })
            obj.Transparency = 1
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
            or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            table.insert(cache, { obj = obj, prop = "Enabled", val = obj.Enabled })
            obj.Enabled = false
        elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
            table.insert(cache, { obj = obj, prop = "Enabled", val = obj.Enabled })
            obj.Enabled = false
        end
    end

    local ShopItems = ReplicatedStorage:FindFirstChild("ShopItems")
    if ShopItems then
        for _, folderName in ipairs({ "Aura", "Trail", "Ball", "Effect" }) do
            local f = ShopItems:FindFirstChild(folderName)
            if f then
                for _, obj in ipairs(f:GetDescendants()) do
                    if obj:IsA("MeshPart") then
                        if obj.TextureID ~= "" then
                            table.insert(cache, { obj = obj, prop = "TextureID", val = obj.TextureID })
                            obj.TextureID = ""
                        end
                        if obj.Transparency < 1 then
                            table.insert(cache, { obj = obj, prop = "Transparency", val = obj.Transparency })
                            obj.Transparency = 1
                        end
                    elseif obj:IsA("Part") and obj.Name:find("^Ball_") then
                        if obj.Transparency < 1 then
                            table.insert(cache, { obj = obj, prop = "Transparency", val = obj.Transparency })
                            obj.Transparency = 1
                        end
                    elseif obj:IsA("SurfaceAppearance") then
                        table.insert(cache, { obj = obj, prop = "Transparency", val = obj.Transparency })
                        obj.Transparency = 1
                    end
                end
            end
        end
    end

    local Lighting = game:GetService("Lighting")
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("PostEffect") then
            if obj.Enabled then
                table.insert(cache, { obj = obj, prop = "Enabled", val = true })
                obj.Enabled = false
            end
        elseif obj:IsA("Atmosphere") then
            table.insert(cache, { obj = obj, prop = "Density", val = obj.Density })
            obj.Density = 0
        elseif obj:IsA("Sky") then
            table.insert(cache, { obj = obj, prop = "StarCount", val = obj.StarCount })
            obj.StarCount = 0
        end
    end
    table.insert(cache, { obj = Lighting, prop = "GlobalShadows", val = Lighting.GlobalShadows })
    Lighting.GlobalShadows = false

    pcall(function()
        local SoundService = game:GetService("SoundService")
        table.insert(cache, { obj = SoundService, prop = "AmbientReverb", val = SoundService.AmbientReverb })
        SoundService.AmbientReverb = Enum.ReverbType.NoReverb
    end)

    AntiLagCache.active = true

    AntiLagCache.conn = workspace.DescendantAdded:Connect(function(obj)
        if not AntiLagCache.active then return end
        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
            if obj.CastShadow then
                table.insert(cache, { obj = obj, prop = "CastShadow", val = true })
                obj.CastShadow = false
            end
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
            or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            if obj.Enabled then
                table.insert(cache, { obj = obj, prop = "Enabled", val = true })
                obj.Enabled = false
            end
        elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
            if obj.Enabled then
                table.insert(cache, { obj = obj, prop = "Enabled", val = true })
                obj.Enabled = false
            end
        end
    end)
end

local function restoreAntiLag()
    if AntiLagCache.conn then
        AntiLagCache.conn:Disconnect()
        AntiLagCache.conn = nil
    end
    for _, e in ipairs(AntiLagCache.entries) do
        pcall(function()
            if e.obj and e.obj.Parent then
                e.obj[e.prop] = e.val
            end
        end)
    end
    table.clear(AntiLagCache.entries)
    AntiLagCache.active = false
end

getgenv().__montex_kill = function()
    pcall(function()
        if AntiLagCache and AntiLagCache.active then restoreAntiLag() end
    end)
    pcall(function() if s.FPSCap.Enabled then SetFPSCap(false) end end)
    pcall(function() if settarget then settarget(nil) end end)
    pcall(function() if disableMagnet then disableMagnet() end end)
    pcall(function() if disableReach then disableReach() end end)
    pcall(function() if disableSpeedBoost then disableSpeedBoost() end end)
    pcall(function() if disableSelfPass then disableSelfPass() end end)
    pcall(function() if resetBallChanger then resetBallChanger() end end)
    pcall(function() if resetGoalEffect then resetGoalEffect() end end)
    pcall(function() if RemoveAura then RemoveAura() end end)
    pcall(function() if resetTrailOnAllBalls then resetTrailOnAllBalls() end end)
    if state and state.connections then
        for _, c in ipairs(state.connections) do
            pcall(function() if c and c.Connected then c:Disconnect() end end)
        end
        table.clear(state.connections)
    end
    pcall(function()
        if getgenv().__montex_janitor then
            getgenv().__montex_janitor:Destroy()
            getgenv().__montex_janitor = nil
        end
    end)
    pcall(function()
        local gethui = rawget(getgenv(), "gethui")
        local containers = { PlayerGui }
        if type(gethui) == "function" then
            local ok, hui = pcall(gethui)
            if ok and hui then table.insert(containers, hui) end
        end
        pcall(function() table.insert(containers, game:GetService("CoreGui")) end)
        for _, c in ipairs(containers) do
            if c then
                local g = c:FindFirstChild("MontexIntro")
                if g then g:Destroy() end
            end
        end
    end)
    pcall(function() restoreMouseBehavior() end)
    getgenv().__montex_aiming = false
end

local offTab = Window:CreateTab({ Name = "Offense", Desc = "Silent aim and self pass", Icon = "target" })

offTab:CreateSection("Silent Aim Section")

local auralToggle
auralToggle = offTab:CreateToggle({
    Name = "Enable Silent Aim",
    Desc = "Toggles Aimbot, Shoots for you on jump",
    CurrentValue = s.Shooting.AuralEnabled,
    Flag = "AuralToggle",
    Callback = function(v)
        s.Shooting.AuralEnabled = v
        if not v then settarget(nil) end
    end,
})

offTab:CreateKeybind({
    Name = "Silent Aim Keybind",
    Desc = "Toggles silent aim on/off",
    CurrentKeybind = s.Shooting.AuralKeybind,
    Flag = "AuralKeybind",
    Callback = function(key)
        if not key then return end
        s.Shooting.AuralEnabled = not s.Shooting.AuralEnabled
        if auralToggle then auralToggle:Set(s.Shooting.AuralEnabled) end
        if not s.Shooting.AuralEnabled then settarget(nil) end
    end,
})

offTab:CreateSlider({
    Name = "Shot Delay",
    Range = { 0.15, 0.42 },
    Increment = 0.01,
    Suffix = "s",
    CurrentValue = s.Shooting.ShotDelay,
    Flag = "AuralShotDelay",
    Callback = function(v) s.Shooting.ShotDelay = v end,
})

offTab:CreateSlider({
    Name = "Perfect Percentage",
    Desc = "Chance to force a perfect release",
    Range = { 0, 100 },
    Increment = 5,
    Suffix = "%",
    CurrentValue = s.Shooting.GreenChance,
    Flag = "AuralGreenChance",
    Callback = function(v) s.Shooting.GreenChance = v end,
})

offTab:CreateToggle({
    Name = "EBL Hop",
    Desc = "Shoots after double jumping",
    CurrentValue = s.Shooting.EBLHop,
    Flag = "AuralEBLHop",
    Callback = function(v) s.Shooting.EBLHop = v end,
})

offTab:CreateToggle({
    Name = "3PT Only",
    Desc = "Only fires from deep 3pt range",
    CurrentValue = s.Shooting.ThreePTOnly,
    Flag = "AuralThreePTOnly",
    Callback = function(v) s.Shooting.ThreePTOnly = v end,
})

offTab:CreateSection("Self Pass")

local selfPassToggle
selfPassToggle = offTab:CreateToggle({
    Name = "Enable Self Pass",
    CurrentValue = s.SelfPass.Enabled,
    Flag = "SelfPassToggle",
    Callback = function(v)
        s.SelfPass.Enabled = v
        if v then enableSelfPass() else disableSelfPass() end
    end,
})

offTab:CreateKeybind({
    Name = "Self Pass Keybind",
    CurrentKeybind = s.SelfPass.Keybind,
    Flag = "SelfPassKeybind",
    OnChanged = function(key)
        if not key then return end
        s.SelfPass.Keybind = key.Name
        if s.SelfPass.Enabled then
            disableSelfPass()
            enableSelfPass()
        end
    end,
})

offTab:CreateSlider({
    Name = "Pass Power",
    Range = { 10, 85 },
    Increment = 1,
    CurrentValue = s.SelfPass.Power,
    Flag = "SelfPassPower",
    Callback = function(v) s.SelfPass.Power = v end,
})

local defenseTab = Window:CreateTab({ Name = "Defense", Desc = "Ball handling and speed", Icon = "shield" })

defenseTab:CreateSection("Ball Magnet")

local magnetToggle
magnetToggle = defenseTab:CreateToggle({
    Name = "Ball Magnet",
    CurrentValue = s.Ball.BallMags,
    Flag = "BallMagnetToggle",
    Callback = function(v)
        s.Ball.BallMags = v
        if v then enableMagnet() else disableMagnet() end
    end,
})

defenseTab:CreateKeybind({
    Name = "Magnet Keybind",
    CurrentKeybind = s.Ball.MagnetKeybind,
    Flag = "MagnetKeybind",
    OnChanged = function(key)
        if not key then return end
        s.Ball.MagnetKeybind = key.Name
    end,
})

defenseTab:CreateSlider({
    Name = "Magnet Size",
    Range = { 1, 50 },
    Increment = 1,
    CurrentValue = s.Ball.BallMagRange,
    Flag = "MagnetRange",
    Callback = function(v)
        s.Ball.BallMagRange = v
        if magnetHitbox then
            magnetHitbox.Size = Vector3.new(v, v, v)
            refreshMagnetVisuals()
        end
    end,
})

defenseTab:CreateToggle({
    Name = "Show Magnet Visualizer",
    CurrentValue = s.Ball.BallMagVisualizer,
    Flag = "MagnetVisualizer",
    Callback = function(v)
        s.Ball.BallMagVisualizer = v
        if s.Ball.BallMags then applyMagnetVisualizerState() end
    end,
})

defenseTab:CreateSection("Ball Reach")

local reachToggle
reachToggle = defenseTab:CreateToggle({
    Name = "Ball Reach",
    CurrentValue = s.Ball.BallReach,
    Flag = "BallReachToggle",
    Callback = function(v)
        s.Ball.BallReach = v
        if v then enableReach() else disableReach() end
    end,
})

defenseTab:CreateKeybind({
    Name = "Reach Keybind",
    CurrentKeybind = s.Ball.ReachKeybind,
    Flag = "ReachKeybind",
    OnChanged = function(key)
        if not key then return end
        s.Ball.ReachKeybind = key.Name
    end,
})

defenseTab:CreateToggle({
    Name = "Legit Reach",
    CurrentValue = s.Ball.SmartReach,
    Flag = "SmartReach",
    Callback = function(v) s.Ball.SmartReach = v end,
})

defenseTab:CreateSlider({
    Name = "Reach Size",
    Range = { 1, 30 },
    Increment = 1,
    CurrentValue = s.Ball.BallReachRange,
    Flag = "ReachRange",
    Callback = function(v) s.Ball.BallReachRange = v end,
})

defenseTab:CreateToggle({
    Name = "Show Reach Visualizer",
    CurrentValue = s.Ball.BallReachVisualizer,
    Flag = "ReachVisualizer",
    Callback = function(v)
        s.Ball.BallReachVisualizer = v
        if v then
            if not reachConnection then enableReach() end
        else
            destroyReachVisualizer()
            if not s.Ball.BallReach and reachConnection then
                reachConnection:Disconnect(); reachConnection = nil
            end
        end
    end,
})

defenseTab:CreateSection("Speed Boost")

local speedToggle
speedToggle = defenseTab:CreateToggle({
    Name = "Speed Boost",
    CurrentValue = s.Player.Walkspeed,
    Flag = "SpeedBoostToggle",
    Callback = function(v)
        s.Player.Walkspeed = v
        if v then enableSpeedBoost() else disableSpeedBoost() end
    end,
})

defenseTab:CreateSlider({
    Name = "Speed Multiplier",
    Range = { 1, 1.65 },
    Increment = 0.05,
    CurrentValue = s.Player.WSvalue,
    Flag = "SpeedMultiplier",
    Callback = function(v) s.Player.WSvalue = v end,
})

local visTab = Window:CreateTab({ Name = "Visuals", Desc = "Effects and models", Icon = "eye" })

visTab:CreateSection("Goal Effect Changer")

visTab:CreateDropdown({
    Name = "Select Effect",
    Options = #EffectNames > 0 and EffectNames or {"None"},
    CurrentOption = s.Goal.SelectedEffect or "LightRay",
    Flag = "GoalEffectSelect",
    Callback = function(v)
        s.Goal.SelectedEffect = v
        s.Goal.CurrentEffect = v
        if s.Goal.Enabled then pcall(applyGoalEffect) end
    end,
})

visTab:CreateToggle({
    Name = "Enable Goal Effect Changer",
    CurrentValue = s.Goal.Enabled,
    Flag = "GoalEffectToggle",
    Callback = function(v)
        s.Goal.Enabled = v
        if v then pcall(applyGoalEffect) else pcall(resetGoalEffect) end
    end,
})

visTab:CreateButton({
    Name = "Reset To Default Effect",
    Callback = function()
        s.Goal.Enabled = false
        s.Goal.SelectedEffect = "LightRay"
        s.Goal.CurrentEffect = "LightRay"
        pcall(resetGoalEffect)
    end,
})

visTab:CreateSection("Ball Changer")

visTab:CreateDropdown({
    Name = "Select Ball",
    Options = #BallNames > 0 and BallNames or {"None"},
    CurrentOption = s.BallChanger.SelectedBall or "ForceField",
    Flag = "BallChangerSelect",
    Callback = function(v)
        s.BallChanger.SelectedBall = v
        s.BallChanger.CurrentBall = v
        if s.BallChanger.Enabled then pcall(applyBallChanger) end
    end,
})

visTab:CreateToggle({
    Name = "Enable Ball Changer",
    CurrentValue = s.BallChanger.Enabled,
    Flag = "BallChangerToggle",
    Callback = function(v)
        s.BallChanger.Enabled = v
        if v then pcall(applyBallChanger) else pcall(resetBallChanger) end
    end,
})

visTab:CreateButton({
    Name = "Reset To Default Ball",
    Callback = function()
        s.BallChanger.Enabled = false
        s.BallChanger.SelectedBall = "ForceField"
        s.BallChanger.CurrentBall = "ForceField"
        pcall(resetBallChanger)
    end,
})

visTab:CreateSection("Ball Trail Changer")

visTab:CreateDropdown({
    Name = "Select Trail",
    Options = #TrailNames > 0 and TrailNames or {"None"},
    CurrentOption = s.TrailChanger.SelectedTrail or "None",
    Flag = "TrailSelect",
    Callback = function(v)
        s.TrailChanger.SelectedTrail = v
        s.TrailChanger.CurrentTrail = v
        if s.TrailChanger.Enabled then applyTrailToAllBalls() end
    end,
})

visTab:CreateToggle({
    Name = "Enable Trail Changer",
    CurrentValue = s.TrailChanger.Enabled,
    Flag = "TrailToggle",
    Callback = function(v)
        s.TrailChanger.Enabled = v
        if v then applyTrailToAllBalls() else resetTrailOnAllBalls() end
    end,
})

visTab:CreateButton({
    Name = "Reset To Default Trail",
    Callback = function()
        s.TrailChanger.Enabled = false
        s.TrailChanger.SelectedTrail = "None"
        s.TrailChanger.CurrentTrail = "None"
        resetTrailOnAllBalls()
    end,
})

visTab:CreateSection("Aura Changer")

visTab:CreateDropdown({
    Name = "Select Aura",
    Options = AuraNames,
    CurrentOption = s.Aura.SelectedAura or "None",
    Flag = "AuraSelect",
    Callback = function(v)
        s.Aura.SelectedAura = v
        if s.Aura.Enabled and v ~= "None" then
            for _, aura in AuraList do
                if aura.Name == v then pcall(function() ApplyAura(aura) end); break end
            end
        elseif v == "None" then
            pcall(RemoveAura)
        end
    end,
})

visTab:CreateToggle({
    Name = "Enable Aura",
    CurrentValue = s.Aura.Enabled,
    Flag = "AuraToggle",
    Callback = function(v)
        s.Aura.Enabled = v
        if v and s.Aura.SelectedAura ~= "None" then
            for _, aura in AuraList do
                if aura.Name == s.Aura.SelectedAura then pcall(function() ApplyAura(aura) end); break end
            end
        else
            pcall(RemoveAura)
        end
    end,
})

visTab:CreateButton({
    Name = "Remove Aura",
    Callback = function()
        s.Aura.Enabled = false
        s.Aura.SelectedAura = "None"
        pcall(RemoveAura)
    end,
})

visTab:CreateSection("Avatar Changer")

local avatarDropdown
avatarDropdown = visTab:CreateDropdown({
    Name = "Select Player",
    Options = getInGamePlayerNames(),
    CurrentOption = s.AvatarChanger.SelectedPlayer or "None",
    Flag = "AvatarPlayerSelect",
    Callback = function(v) s.AvatarChanger.SelectedPlayer = v end,
})

visTab:CreateButton({
    Name = "Refresh Player List",
    Callback = function()
        local names = getInGamePlayerNames()
        if avatarDropdown and avatarDropdown.Refresh then
            pcall(function() avatarDropdown:Refresh(names) end)
        end
        Airflow:Notify({
            Title = "Player List Refreshed",
            Content = "Found " .. tostring(#names) .. " player(s)",
            Icon = "refresh-cw",
            Type = "Info",
            Duration = 2,
        })
    end,
})

visTab:CreateButton({
    Name = "Copy Selected Avatar",
    Callback = function()
        local ok, info = copyAvatarFromSelected()
        if ok then
            Airflow:Notify({
                Title = "Avatar Copied",
                Content = "Equipped avatar of " .. tostring(info),
                Icon = "user-check",
                Type = "Success",
                Duration = 3,
            })
        else
            Airflow:Notify({
                Title = "Avatar Error",
                Content = tostring(info or "Failed to copy avatar"),
                Icon = "triangle-alert",
                Type = "Error",
                Duration = 3,
            })
        end
    end,
})

visTab:CreateInput({
    Name = "Custom Username / UserId",
    PlaceholderText = "Username or UserId",
    CurrentValue = s.AvatarChanger.CustomUser or "",
    Flag = "AvatarCustomUser",
    OnChanged = function(text) s.AvatarChanger.CustomUser = text end,
    Callback = function(text) s.AvatarChanger.CustomUser = text end,
})

visTab:CreateButton({
    Name = "Copy Custom Avatar",
    Callback = function()
        local ok, info = copyAvatarFromCustom()
        if ok then
            Airflow:Notify({
                Title = "Avatar Copied",
                Content = "Equipped avatar of " .. tostring(info),
                Icon = "user-check",
                Type = "Success",
                Duration = 3,
            })
        else
            Airflow:Notify({
                Title = "Avatar Error",
                Content = tostring(info or "Failed to copy custom avatar"),
                Icon = "triangle-alert",
                Type = "Error",
                Duration = 3,
            })
        end
    end,
})

visTab:CreateButton({
    Name = "Reset To Original Avatar",
    Callback = function()
        local ok = resetAvatar()
        if ok then
            Airflow:Notify({
                Title = "Avatar Reset",
                Content = "Restored your original avatar",
                Icon = "refresh-cw",
                Type = "Success",
                Duration = 3,
            })
        else
            Airflow:Notify({
                Title = "Avatar Reset Error",
                Content = "Could not restore original avatar",
                Icon = "triangle-alert",
                Type = "Error",
                Duration = 3,
            })
        end
    end,
})

visTab:CreateSection("Nameplate & Title")

visTab:CreateInput({
    Name = "Custom Username",
    PlaceholderText = "Montex",
    CurrentValue = s.Visuals.CustomNameText or "",
    Flag = "CustomNameText",
    OnChanged = function(text)
        s.Visuals.CustomNameText = text
        s.Visuals.CustomName = (text ~= "")
        applyOwnNameplate()
    end,
    Callback = function(text)
        s.Visuals.CustomNameText = text
        s.Visuals.CustomName = (text ~= "")
        applyOwnNameplate()
    end,
})

visTab:CreateInput({
    Name = "Custom Record / Stats",
    PlaceholderText = "",
    CurrentValue = s.Visuals.CustomRecordText or "",
    Flag = "CustomRecordText",
    OnChanged = function(text)
        s.Visuals.CustomRecordText = text
        s.Visuals.CustomRecord = (text ~= "")
        applyOwnNameplate()
    end,
    Callback = function(text)
        s.Visuals.CustomRecordText = text
        s.Visuals.CustomRecord = (text ~= "")
        applyOwnNameplate()
    end,
})

visTab:CreateInput({
    Name = "Custom Achievement",
    PlaceholderText = "",
    CurrentValue = s.Visuals.CustomTitleText or "",
    Flag = "CustomTitleText",
    OnChanged = function(text)
        s.Visuals.CustomTitleText = text
        s.Visuals.CustomTitle = (text ~= "")
        applyOwnNameplate()
    end,
    Callback = function(text)
        s.Visuals.CustomTitleText = text
        s.Visuals.CustomTitle = (text ~= "")
        applyOwnNameplate()
    end,
})

visTab:CreateSection("Logo Badges")

visTab:CreateToggle({
    Name = "Enable Logo Badge",
    CurrentValue = s.LogoBadges.Enabled,
    Flag = "LogoBadgeToggle",
    Callback = function(v)
        s.LogoBadges.Enabled = v
        applyLogoBadge()
    end,
})

visTab:CreateDropdown({
    Name = "Select Badge",
    Options = { "None", "VIP", "Youtuber", "Twitch", "Booster", "Tester", "Staff" },
    CurrentOption = s.LogoBadges.Badge or "None",
    Flag = "LogoBadgeSelect",
    Callback = function(v)
        s.LogoBadges.Badge = v
        applyLogoBadge()
    end,
})

visTab:CreateInput({
    Name = "Custom Asset ID",
    PlaceholderText = "12345,67890",
    CurrentValue = table.concat(s.LogoBadges.CustomIds, ","),
    Flag = "LogoCustomIds",
    OnChanged = function(text)
        local ids = {}
        for n in string.gmatch(text, "%d+") do table.insert(ids, tonumber(n)) end
        s.LogoBadges.CustomIds = ids
        applyLogoBadge()
    end,
    Callback = function(text)
        local ids = {}
        for n in string.gmatch(text, "%d+") do table.insert(ids, tonumber(n)) end
        s.LogoBadges.CustomIds = ids
        applyLogoBadge()
    end,
})

setupOwnNameplateListener()
J:Connect(RunService.Heartbeat, function() applyOwnNameplate() end, "NameplateWatch")
J:Connect(RunService.Heartbeat, function() applyLogoBadge() end, "LogoBadgeWatch")

local miscTab = Window:CreateTab({ Name = "Misc", Desc = "Configs and server", Icon = "wrench" })

miscTab:CreateSection("Miscellaneous")

local fallconnection
miscTab:CreateToggle({
    Name = "Anti Fall",
    CurrentValue = s.Misc.AntiFall,
    Flag = "MiscAntiFall",
    Callback = function(v)
        s.Misc.AntiFall = v
        if fallconnection then fallconnection:Disconnect(); fallconnection = nil end
        if v then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            fallconnection = hum:GetPropertyChangedSignal("PlatformStand"):Connect(function()
                if hum.PlatformStand then hum.PlatformStand = false end
            end)
            if hum.PlatformStand then hum.PlatformStand = false end
        end
    end,
})

miscTab:CreateToggle({
    Name = "Device Spoofer",
    CurrentValue = s.Misc.DeviceSpoofer,
    Flag = "MiscDeviceSpoofer",
    Callback = function(v)
        s.Misc.DeviceSpoofer = v
        SpoofDevice()
    end,
})

miscTab:CreateDropdown({
    Name = "Device",
    Options = { "PC", "Mobile", "Gamepad" },
    CurrentOption = s.Misc.Device,
    Flag = "MiscDevice",
    Callback = function(v)
        s.Misc.Device = v
        SpoofDevice()
    end,
})

miscTab:CreateSection("Performance")

miscTab:CreateToggle({
    Name = "Anti Lag",
    Desc = "Strips textures, shadows, particles, lights, and post-effects",
    CurrentValue = s.Misc.AntiLag,
    Flag = "MiscAntiLag",
    Callback = function(v)
        s.Misc.AntiLag = v
        if v then
            task.spawn(stripAntiLag)
        else
            restoreAntiLag()
        end
    end,
})

miscTab:CreateSection("FPS Cap")

miscTab:CreateToggle({
    Name = "FPS Cap",
    CurrentValue = s.FPSCap.Enabled,
    Flag = "MiscFPSCap",
    Callback = function(v)
        s.FPSCap.Enabled = v
        SetFPSCap(v, s.FPSCap.Value)
    end,
})

miscTab:CreateSlider({
    Name = "FPS Limit",
    Range = { 15, 360 },
    Increment = 1,
    CurrentValue = s.FPSCap.Value,
    Flag = "MiscFPSCapValue",
    Callback = function(v)
        s.FPSCap.Value = v
        if s.FPSCap.Enabled then SetFPSCap(true, v) end
    end,
})

miscTab:CreateSection("Server")

miscTab:CreateButton({
    Name = "Rejoin Server",
    Icon = "rotate-cw",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end,
})

miscTab:CreateButton({
    Name = "Server Hop",
    Icon = "shuffle",
    Callback = function()
        local servers = {}
        local cursor = ""
        repeat
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            if cursor ~= "" then url = url .. "&cursor=" .. cursor end
            local success, result = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end)
            if success and result and result.data then
                for _, server in next, result.data do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        table.insert(servers, server.id)
                    end
                end
                cursor = result.nextPageCursor or ""
            else
                break
            end
        until cursor == ""
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
        else
            Airflow:Notify({
                Title = "No available servers",
                Content = "Could not find any available servers.",
                Icon = "triangle-alert",
                Type = "Warning",
                Duration = 3,
            })
        end
    end,
})

local settingsTab = Window:CreateTab({ Name = "Settings", Desc = "Configs", Icon = "settings" })

settingsTab:CreateSection("Interface")

settingsTab:CreateConfigManager({ Name = "Configs" })

Window:LoadConfig()

J:Add(function()
    state.active = false
    pcall(settarget, nil)
    pcall(disableMagnet)
    pcall(disableReach)
    pcall(disableSpeedBoost)
    pcall(disableSelfPass)
    pcall(resetBallChanger)
    pcall(resetGoalEffect)
    pcall(RemoveAura)
    pcall(resetTrailOnAllBalls)
    if AntiLagCache.active then pcall(restoreAntiLag) end
    pcall(function() if s.FPSCap.Enabled then SetFPSCap(false) end end)
    for _, c in state.connections do pcall(function() c:Disconnect() end) end
    table.clear(state.connections)
end, nil, "manual_leftovers")
