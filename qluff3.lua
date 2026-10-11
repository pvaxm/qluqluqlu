local Airflow = loadstring(game:HttpGet("https://raw.githubusercontent.com/PookiePepelsss/Airflow-UI/refs/heads/main/Source.luau"))()

Airflow:LoadFont({ Name = "ValleySans" })

if not LPH_OBFUSCATED then
	LPH_JIT = function(Function) return Function end
	LPH_JIT_MAX = function(Function) return Function end
	LPH_NO_VIRTUALIZE = function(Function) return Function end
	LPH_NO_UPVALUES = function(Function) return Function end
	LPH_ENCFUNC = function(Function) return Function end
	LPH_ENCSTR = function(String) return String end
	LPH_ENCNUM = function(Number) return Number end
	LPH_CRASH = function() end
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local IsPractice = (game.PlaceId == 81310542478972)
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Aural = {
	AcBypass = {
		DebugMode = false,
	},

	Catching = {
		Magnets = false,
		ShowMagHitbox = false,
		CustomizableRadius = 20,
		CustomizableDelay = 0,
		TweenSpeed = 0,

		PullVector = false,
		PullVectorMode = "Drag",
		PullVectorSpeed = 30,
		PullVectorRadius = 15,

		DiveVector = false,
		DiveVectorSpeed = 45,
		DiveVectorRadius = 30,
		DiveVectorDistance = 1.5,

		MagEnhancer = false,
		MagEnhancerMultiplier = 2,
	},

	Automatics = {
		AutoQb = false,
		AutoQbType = "Legit",

		AutoCaptain = false,
		AutoCatch = false,
		AutoCatchRadius = 15,

		AutoJump = false,
		AutoJumpRadius = 15,
		AutoJumpHeight = 10,

		AutoSwat = false,
		AutoSwatRadius = 15,

		KickerAim = false,
		KickerAimPower = 100,
		KickerAimAccuracy = 100,

		AutoRush = false,
		AutoRushDelay = 0,
		AutoRushPrediction = 100,
		AutoRushAccuracy = 100,

		AutoGuard = false,
		AutoGuardRadius = 25,

		AutoBlock = false,
		AutoBlockRadius = 6,
	},

	Physics = {
		ClickTackleAimbot = false,
		ClickTackleAimbotRadius = 15,

		QuickTp = false,
		QuickTpSpeed = 12,

		AntiBlock = false,
		AntiJam = false,
		NoJumpCooldown = false,

		AntiOob = false,

		BlockExtender = false,
		BlockExtenderReach = 10,
		BlockExtenderTransparency = 1,

		AntiTackle = false,
		AntiDown = false,

		SwatReach = false,
		SwatReachRadius = 15,
		TackleReach = false,
		TackleReachRadius = 15,
	},

	QbAimbot = {
		Enabled = false,
		TargetLock = false,
		LockedTarget = nil,

		AutoAngle = true,
		AngleBased = false,
		DesiredAngle = 30,
		MaxAirTime = 20,
		BeamMode = true,
		AutoChooseThrowType = false,
		Use95PowerMode = false,
		FastestThrow = false,

		ThrowProfile = "Dime",
		ThrowAngle = 45,
		BulletAngle = 25,
		NormalPower = 94,
		AutoPower = false,
		HighestPowerMode = false,
		CustomLead = 0,

		VerticalLead = 1.25,
		HorizontalLead = 3,
		FieldMargin = 15,
		AntiOob = true,
		AntiOobInset = 3,

		Fov = 500,
		TargetPriority = "Closest To Mouse",

		PredictionColor = Color3.fromRGB(194, 155, 165),

		ReceiverEsp = false,
		ShowRoutes = false,
		ShowDistance = false,
	},

	Player = {
		JumpPower = false,
		Jp = 50,

		AngleEnhancer = false,
		AngleEnhancerValue = 56,

		WalkSpeed = false,
		WalkSpeedValue = 22,
		FreezeDuringPrePlay = true,

		CframeSpeed = false,
		CfSpeed = 10,

		Fly = false,
		FlySpeed = 50,

		BoostEnhancer = false,
		BoostEnhancerSpeed = 23,

		NoMoveRestrictions = false,

		HandSize = 2,
		ShowHandHitbox = false,
	},

	Visuals = {
		NoTextures = false,
		ThrownBallBeam = true,
		ThrownBallBeamColor = Color3.fromRGB(255, 95, 175),
		ThrownBallBeamColor2 = Color3.fromRGB(105, 190, 255),
	},

	Gamepasses = {
		UnlockAll = false,
	},

	Config = {
		AutoSave = true,
		AutoSaveInterval = 30,
		LastSaved = 0,
	},
}

do
	local function RunBypass()
		if (IsPractice) then
			return
		end

		local _ge = getgenv()
		local _gk = "_x7q2m"
		if rawget(_ge, _gk) then
			return
		end
		rawset(_ge, _gk, true)

		local DebugMode = false
		local ScriptContext = cloneref and cloneref(game:GetService("ScriptContext")) or game:GetService("ScriptContext")
		local Remotes = ReplicatedStorage:WaitForChild("Remotes")
		local HeartbeatRemote = Remotes:WaitForChild("CharacterSoundEvent")

		local SecondaryRemote = nil
		local ShufflePrimary = nil
		local ShuffleSecondary = nil
		local HandshakeFunction = nil
		local UpdateFunction = nil
		local ContentUri = nil
		local LargeString = nil
		local UpdateTable = nil
		local SwingTable = nil
		local AltTable = nil

		local Shuffles = {}
		local LargeTables = {}
		local SmallTables = {}
		local RemoteEvents = {}
		local Hooks = {}

		local IsSetup = false
		local BypassReady = false
		local HandshakeCount = 0

		local HandshakeSequences = {
			{ 1750, 1750, 1655, 1761, 1888, 1767 },
			{ 1645, 1765, 1623, 1714, 1881, 1656 },
			{ 1650, 1749, 1853, 1741, 1761, 1856 },
		}

		local ExecutorName = "Unknown"
		pcall(function()
			local Name = identifyexecutor and identifyexecutor() or (getexecutorname and getexecutorname())
			if Name then ExecutorName = tostring(Name) end
		end)

		local function Wrap(Fn)
			if newcclosure then
				local Ok, Wrapped = pcall(newcclosure, Fn)
				if Ok and Wrapped then
					return Wrapped
				end
			end
			return Fn
		end

		local function SafeCheckcaller()
			if not checkcaller then return true end
			local Ok, Result = pcall(checkcaller)
			return Ok and Result
		end

		local function SafeGetupvalues(Fn)
			if not getupvalues then return nil end
			local Ok, Result = pcall(getupvalues, Fn)
			if Ok and typeof(Result) == "table" then return Result end
			return nil
		end

		local function SafeGetconstants(Fn)
			if not getconstants then return nil end
			local Ok, Result = pcall(getconstants, Fn)
			if Ok and typeof(Result) == "table" then return Result end
			return nil
		end

		if not getgc then return end

		local function Log(...)
			if DebugMode then
				pcall(print, ...)
			end
		end

		local function Fail(Code)
			LocalPlayer:Kick(string.format("Failed to initialize (code %d). Try rejoining.", Code))
			Log("Init failed — code", Code)
			task.wait(1.5)
		end

		local function TamperKick(Code)
			LocalPlayer:Kick(string.format("Something went wrong (code %d). Try rejoining.", Code))
			Log("Tamper — code", Code)
			task.wait(1.5)
		end

		local function FromModule(Value)
			if typeof(Value) ~= "function" or (islclosure and not islclosure(Value)) then
				return false
			end

			local Ok, Source = pcall(function() return getrenv().debug.info(Value, "s") end)
			return Ok and Source ~= nil and Source:find("PlayerModule") ~= nil
		end

		local function IsShuffle(Value)
			if typeof(Value) ~= "function" or (islclosure and not islclosure(Value)) then
				return false
			end

			local Constants = SafeGetconstants(Value)
			return Constants ~= nil and table.find(Constants, 90001) ~= nil
		end

		local function IsOtherRemote(Value)
			if typeof(Value) ~= "Instance" then
				return false
			end

			local Ok, Class = pcall(function() return Value.ClassName end)
			return Ok and Class == "RemoteEvent" and Value ~= HeartbeatRemote
		end

		local function GetTrapSlot(Value)
			local OkMeta, Meta = pcall(getrawmetatable, Value)
			if not OkMeta or typeof(Meta) ~= "table" then return end

			local OkCall, Call = pcall(rawget, Meta, "__call")
			if not OkCall or not IsShuffle(Call) then return end

			local OkInner, Inner = pcall(rawget, Value, 1)
			if not OkInner or typeof(Inner) ~= "table" then return end

			local OkSlot, Slot = pcall(rawget, Inner, 19)
			if not OkSlot or typeof(Slot) ~= "number" then return end

			return Slot
		end

		local function Grabbed(List, Target)
			for _, Value in next, List do
				if Value.Tbl == Target then
					return true
				end
			end
			return false
		end

		local function GetMetaCall(List)
			for _, Value in next, List do
				local OkMeta, Meta = pcall(getrawmetatable, Value.Tbl)
				if OkMeta and Meta then
					local OkCall, Call = pcall(rawget, Meta, "__call")
					if OkCall and typeof(Call) == "function" then
						return Call
					end
				end
			end
		end

		local function FireHandshake()
			task.wait()
			HandshakeCount += 1

			local Odd = (HandshakeCount % 2 == 1)
			local SecondaryTable = (Odd and AltTable or (SwingTable))
			local PrimaryTable = (Odd and SwingTable or (UpdateTable))

			ShufflePrimary(LargeString, UpdateTable, 1645, 1765, 1623, LargeString, 1714, 1881, 1656)

			SecondaryRemote.Name = HeartbeatRemote.Name
			SecondaryRemote:FireServer(ContentUri, ShuffleSecondary(LargeString, SecondaryTable, 1767, 1676, 1854, LargeString, 1689, 1775, 1776), nil)
			HeartbeatRemote:FireServer(ContentUri, ShufflePrimary(LargeString, PrimaryTable, 1750, 1750, 1655, LargeString, 1761, 1888, 1767), nil)

			ShufflePrimary(LargeString, UpdateTable, 1650, 1749, 1853, LargeString, 1741, 1761, 1856)

			SecondaryRemote.Name = ""
			BypassReady = true

			Log("Handshake #" .. HandshakeCount)
		end

		LPH_JIT_MAX(function()
			for _, Value in next, getgc() do
				if FromModule(Value) and IsShuffle(Value) and not table.find(Shuffles, Value) then
					table.insert(Shuffles, Value)
				end
			end
		end)()

		if #Shuffles < 2 then
			return Fail(1)
		end

		Log("Shuffle functions:", #Shuffles)

		LPH_JIT_MAX(function()
			for _, Value in next, getgc() do
				if not FromModule(Value) then continue end

				local Upvalues = SafeGetupvalues(Value)
				if not Upvalues then continue end

				local HasRemote = false
				local ShuffleCount = 0

				for _, Upvalue in next, Upvalues do
					if IsOtherRemote(Upvalue) then
						HasRemote = true
					elseif IsShuffle(Upvalue) then
						ShuffleCount += 1
					end
				end

				if HasRemote and ShuffleCount >= 2 then
					HandshakeFunction = Value
					break
				end
			end
		end)()

		if not HandshakeFunction then
			return Fail(2)
		end

		Log("Handshake function:", HandshakeFunction)

		do
			local Constants = SafeGetconstants(HandshakeFunction)

			if Constants then
				for _, Value in next, Constants do
					if typeof(Value) == "string" and #Value > 5 and string.byte(Value, 1) == 240 then
						ContentUri = Value
						break
					end
				end
			end
		end

		Log("Content uri length:", ContentUri and #ContentUri or "nil")

		local HandshakeUpvalues = SafeGetupvalues(HandshakeFunction) or {}

		LPH_JIT_MAX(function()
			for Index, Value in next, HandshakeUpvalues do
				local Type = typeof(Value)

				if Type == "string" then
					if #Value > 1000000 and not LargeString then
						LargeString = Value
						Log("Large string @", Index, "#" .. #Value)
					end

				elseif Type == "Instance" then
					if IsOtherRemote(Value) then
						table.insert(RemoteEvents, Value)
						Log("Secondary remote @", Index)
					end

				elseif Type == "function" then
					if IsShuffle(Value) then
						Log("Shuffle upvalue @", Index)
					end

				elseif Type == "table" then
					local Slot = GetTrapSlot(Value)
					if not Slot then continue end

					if Slot >= 1000000 then
						table.insert(LargeTables, { Idx = Index, Tbl = Value })
						Log("Large table @", Index, "slot=" .. Slot)
					elseif Slot >= 1 then
						table.insert(SmallTables, { Idx = Index, Tbl = Value })
						Log("Small table @", Index, "slot=" .. Slot)
					end
				end
			end
		end)()

		Log("Upvalue scan:", #HandshakeUpvalues, "upvalues,", #LargeTables, "large,", #SmallTables, "small")

		if #SmallTables < 2 then
			Log("Small tables missing, scanning gc...")

			LPH_JIT_MAX(function()
				for _, Value in next, getgc(true) do
					if typeof(Value) ~= "table" then continue end
					if Grabbed(LargeTables, Value) or Grabbed(SmallTables, Value) then continue end

					local Slot = GetTrapSlot(Value)

					if Slot and Slot >= 1 and Slot < 1000000 then
						table.insert(SmallTables, { Idx = 0, Tbl = Value })
						Log("gc: Small table slot=" .. Slot)
						if #SmallTables >= 2 then break end
					end
				end
			end)()
		end

		if #LargeTables < 1 then
			Log("Large table missing, scanning gc...")

			LPH_JIT_MAX(function()
				for _, Value in next, getgc(true) do
					if typeof(Value) ~= "table" then continue end

					local Slot = GetTrapSlot(Value)

					if Slot and Slot >= 1000000 and table.find(HandshakeUpvalues, Value) then
						table.insert(LargeTables, { Idx = 0, Tbl = Value })
						Log("gc -> Large table slot=" .. Slot)
						break
					end
				end
			end)()
		end

		local MetaCall = GetMetaCall(LargeTables) or GetMetaCall(SmallTables)

		if MetaCall then
			for _, Value in next, Shuffles do
				if Value == MetaCall then
					ShuffleSecondary = Value
				else
					ShufflePrimary = Value
				end
			end
		end

		if not ShufflePrimary or not ShuffleSecondary then
			ShufflePrimary = ShufflePrimary or Shuffles[1]
			ShuffleSecondary = ShuffleSecondary or Shuffles[2]

			if MetaCall and ShufflePrimary == MetaCall then
				ShufflePrimary, ShuffleSecondary = ShuffleSecondary, ShufflePrimary
			end
		end

		pcall(function()
			for _, Connection in next, getconnections(ScriptContext.Error) do
				Connection:Disable()
			end
		end)

		Log("Executor:", ExecutorName)
		Log("Error loggers disabled.")

		SecondaryRemote = RemoteEvents[1]
		UpdateTable = LargeTables[1] and LargeTables[1].Tbl
		SwingTable = SmallTables[1] and SmallTables[1].Tbl
		AltTable = SmallTables[2] and SmallTables[2].Tbl

		if not ContentUri       then return Fail(3) end
		if not SecondaryRemote  then return Fail(4) end
		if not ShuffleSecondary then return Fail(5) end
		if not ShufflePrimary   then return Fail(5) end
		if not UpdateTable      then return Fail(6) end
		if not SwingTable       then return Fail(6) end
		if not AltTable         then return Fail(6) end
		if not LargeString      then return Fail(7) end

		Hooks.StringSub = hookfunction(getrenv().string.sub, Wrap(function(...)
			local Arguments = { ... }

			if not SafeCheckcaller() then
				if Arguments[2] == -3 and Arguments[3] == -3 then
					return "i"
				end

				if Arguments[2] == -1 then
					return " "
				end
			end

			return Hooks.StringSub(...)
		end))

		Hooks.ShufflePrimary = hookfunction(ShufflePrimary, Wrap(function(...)
			local Arguments = { ... }

			if rawlen(Arguments) >= 9 then
				local p3 = Arguments[3]
				local p4 = Arguments[4]
				local p5 = Arguments[5]
				local p7 = Arguments[7]
				local p8 = Arguments[8]
				local p9 = Arguments[9]

				for _, Sequence in next, HandshakeSequences do
					if
						p3 == Sequence[1]
						and p4 == Sequence[2]
						and p5 == Sequence[3]
						and p7 == Sequence[4]
						and p8 == Sequence[5]
						and p9 == Sequence[6]
					then
						return Hooks.ShufflePrimary(...)
					end
				end

				return task.wait(9e9)
			end

			return Hooks.ShufflePrimary(...)
		end))

		Log("Hooked primary shuffle.")

		local Killed = 0
		local DeadEvent = Instance.new("BindableEvent").Event

		LPH_JIT_MAX(function()
			for _, Value in next, getgc() do
				if not FromModule(Value) then continue end

				pcall(function()
					local Upvalues = SafeGetupvalues(Value)
					if not Upvalues then return end

					for UpIndex, Upvalue in next, Upvalues do
						if typeof(Upvalue) ~= "RBXScriptSignal" then continue end

						if Upvalue == RunService.Heartbeat or Upvalue == RunService.RenderStepped or Upvalue == RunService.Stepped then
							pcall(setupvalue, Value, UpIndex, DeadEvent)
							Killed += 1
						end
					end
				end)
			end
		end)()

		Log("Killed", Killed, "RunService refs.")

		local EnvRawget = getrenv().rawget
		local EnvRawset = getrenv().rawset

		LPH_JIT_MAX(function()
			for _, Value in next, getgc() do
				if not FromModule(Value) or Value == HandshakeFunction then continue end

				local Upvalues = SafeGetupvalues(Value)
				if not Upvalues then continue end

				local HasGet = false
				local HasSet = false
				local HasShuffle = false

				for _, Upvalue in next, Upvalues do
					if Upvalue == EnvRawget then
						HasGet = true
					elseif Upvalue == EnvRawset then
						HasSet = true
					elseif IsShuffle(Upvalue) then
						HasShuffle = true
					end
				end

				if HasGet and HasSet and not HasShuffle then
					UpdateFunction = Value
					break
				end
			end
		end)()

		Log(UpdateFunction and "Update function found." or "Update function missing.")

		Hooks.Handshake = hookfunction(HandshakeFunction, Wrap(function(Id, ...)
			if not IsSetup then
				return Hooks.Handshake(Id, ...)
			end

			if Id ~= ContentUri then
				return
			end

			FireHandshake()
		end))

		Log("Hooked handshake.")

		if UpdateFunction then
			Hooks.Update = hookfunction(UpdateFunction, Wrap(function(Id, BypassState, Values)
				if not IsSetup or Id ~= ContentUri then
					return Hooks.Update(Id, BypassState, Values)
				end

				if typeof(Values) == "table" and UpdateTable then
					local Inner = rawget(UpdateTable, 1)

					if Inner then
						for Index, Value in next, Values do
							rawset(Inner, Index + 1, Value)
						end
					end
				end

				return Hooks.Update(Id, BypassState, Values)
			end))

			Log("Hooked update handler.")
		end

		local TamperCheckInterval = 5
		local LastTamperCheck = 0

		local function CheckIntegrity()
			if not Hooks.StringSub or typeof(Hooks.StringSub) ~= "function" then return 10 end
			if not Hooks.ShufflePrimary or typeof(Hooks.ShufflePrimary) ~= "function" then return 11 end
			if not Hooks.Handshake or typeof(Hooks.Handshake) ~= "function" then return 12 end
			if UpdateFunction and (not Hooks.Update or typeof(Hooks.Update) ~= "function") then return 13 end

			local OkRemote, RemoteParent = pcall(function() return HeartbeatRemote.Parent end)
			if not OkRemote or not RemoteParent then return 14 end

			local OkSecondary, SecondaryParent = pcall(function() return SecondaryRemote.Parent end)
			if not OkSecondary or not SecondaryParent then return 15 end

			if not UpdateTable or typeof(UpdateTable) ~= "table" then return 16 end

			local OkInner, Inner = pcall(rawget, UpdateTable, 1)
			if not OkInner or typeof(Inner) ~= "table" then return 17 end

			if not SwingTable or typeof(SwingTable) ~= "table" then return 18 end
			if not AltTable or typeof(AltTable) ~= "table" then return 19 end
			if not ContentUri or typeof(ContentUri) ~= "string" then return 20 end
			if not LargeString or typeof(LargeString) ~= "string" then return 21 end

			return nil
		end

		RunService.Heartbeat:Connect(function()
			if not IsSetup then return end

			local Now = tick()
			if Now - LastTamperCheck < TamperCheckInterval then return end
			LastTamperCheck = Now

			local Code = CheckIntegrity()
			if Code then
				Log("Anti-tamper triggered: code", Code)
				IsSetup = false
				TamperKick(Code)
			end
		end)

		IsSetup = true
		Log("Bypass loaded.")

		task.wait()
	end

	task.spawn(RunBypass)
end

local MidnightBlue = {
	Background           = Color3.fromRGB(8, 12, 24),
	SecondaryBackground  = Color3.fromRGB(12, 18, 34),
	TertiaryBackground   = Color3.fromRGB(16, 24, 44),
	QuaternaryBackground = Color3.fromRGB(20, 30, 54),
	Border               = Color3.fromRGB(28, 42, 72),
	Divider              = Color3.fromRGB(24, 36, 62),
	Text                 = Color3.fromRGB(220, 230, 255),
	SubText              = Color3.fromRGB(120, 140, 180),
	PlaceholderText      = Color3.fromRGB(80, 100, 140),
	Accent               = Color3.fromRGB(56, 132, 255),
	AccentHover          = Color3.fromRGB(80, 155, 255),
	AccentPressed        = Color3.fromRGB(40, 108, 220),
	Success              = Color3.fromRGB(64, 200, 140),
	Warning              = Color3.fromRGB(240, 180, 70),
	Error                = Color3.fromRGB(235, 90, 100),
	Info                 = Color3.fromRGB(90, 170, 255),
	Toggle               = Color3.fromRGB(56, 132, 255),
	ToggleOff            = Color3.fromRGB(40, 56, 90),
	Slider               = Color3.fromRGB(56, 132, 255),
	SliderTrack          = Color3.fromRGB(24, 36, 62),
	Scrollbar            = Color3.fromRGB(36, 52, 88),
	ScrollbarHover       = Color3.fromRGB(56, 80, 130),
	Dropdown             = Color3.fromRGB(16, 24, 44),
	DropdownHover        = Color3.fromRGB(28, 42, 72),
	Popup                = Color3.fromRGB(12, 18, 34),
	Shadow               = Color3.fromRGB(0, 0, 0),
}

local Window = Airflow:CreateWindow({
	Name = "Montex Hub",
	LoadingSubtitle = "Montex",
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
					{ Title = "v1.0", Tag = "Latest", Changes = { "Added FF3 Support, Fully Working", "Mobile Supported", "All features tested if buggy report." } },
				},
			},
		},
	},
})

local CatchingTab = Window:CreateTab({ Name = "Catching", Desc = "Magnets and automatics", Icon = "magnet" })
local OffenseTab = Window:CreateTab({ Name = "Offense", Desc = "QB aimbot", Icon = "target" })
local DefenseTab = Window:CreateTab({ Name = "Defense", Desc = "Physics and defense", Icon = "shield" })
local MovementTab = Window:CreateTab({ Name = "Movement", Desc = "Player and visuals", Icon = "move" })
local MiscTab = Window:CreateTab({ Name = "Misc", Desc = "Players, configs, settings", Icon = "settings" })

CatchingTab:CreateSection("Magnets")

CatchingTab:CreateToggle({
	Name = "Magnets",
	CurrentValue = Aural.Catching.Magnets,
	Flag = "Magnets",
	Callback = function(V) Aural.Catching.Magnets = V end,
})

CatchingTab:CreateToggle({
	Name = "Show Magnet Hitbox",
	CurrentValue = Aural.Catching.ShowMagHitbox,
	Flag = "ShowMagHitbox",
	Callback = function(V) Aural.Catching.ShowMagHitbox = V end,
})

CatchingTab:CreateSlider({
	Name = "Magnet Radius",
	Range = { 0, 25 },
	Increment = 1,
	CurrentValue = Aural.Catching.CustomizableRadius,
	Flag = "MagRadius",
	Callback = function(V) Aural.Catching.CustomizableRadius = V end,
})

CatchingTab:CreateSlider({
	Name = "Magnet Delay",
	Range = { 0, 5 },
	Increment = 0.1,
	CurrentValue = Aural.Catching.CustomizableDelay,
	Flag = "MagDelay",
	Callback = function(V) Aural.Catching.CustomizableDelay = V end,
})

CatchingTab:CreateSlider({
	Name = "Tween Speed",
	Range = { 0, 20 },
	Increment = 1,
	CurrentValue = Aural.Catching.TweenSpeed,
	Flag = "TweenSpeed",
	Callback = function(V) Aural.Catching.TweenSpeed = V end,
})

CatchingTab:CreateToggle({
	Name = "Pull Vector",
	CurrentValue = Aural.Catching.PullVector,
	Flag = "PullVector",
	Callback = function(V) Aural.Catching.PullVector = V end,
})

CatchingTab:CreateDropdown({
	Name = "Pull Vector Mode",
	Options = { "Drag", "Instant" },
	CurrentOption = Aural.Catching.PullVectorMode,
	Flag = "PullVectorMode",
	Callback = function(V) Aural.Catching.PullVectorMode = V end,
})

CatchingTab:CreateSlider({
	Name = "Pull Vector Speed",
	Range = { 0, 100 },
	Increment = 1,
	CurrentValue = Aural.Catching.PullVectorSpeed,
	Flag = "PullVectorSpeed",
	Callback = function(V) Aural.Catching.PullVectorSpeed = V end,
})

CatchingTab:CreateSlider({
	Name = "Pull Vector Radius",
	Range = { 0, 35 },
	Increment = 1,
	CurrentValue = Aural.Catching.PullVectorRadius,
	Flag = "PullVectorRadius",
	Callback = function(V) Aural.Catching.PullVectorRadius = V end,
})

CatchingTab:CreateToggle({
	Name = "Dive Vector",
	CurrentValue = Aural.Catching.DiveVector,
	Flag = "DiveVector",
	Callback = function(V) Aural.Catching.DiveVector = V end,
})

CatchingTab:CreateSlider({
	Name = "Dive Vector Speed",
	Range = { 20, 80 },
	Increment = 1,
	CurrentValue = Aural.Catching.DiveVectorSpeed,
	Flag = "DiveVectorSpeed",
	Callback = function(V) Aural.Catching.DiveVectorSpeed = V end,
})

CatchingTab:CreateSlider({
	Name = "Dive Vector Radius",
	Range = { 0, 100 },
	Increment = 1,
	CurrentValue = Aural.Catching.DiveVectorRadius,
	Flag = "DiveVectorRadius",
	Callback = function(V) Aural.Catching.DiveVectorRadius = V end,
})

CatchingTab:CreateSlider({
	Name = "Dive Vector Distance",
	Range = { 1, 3 },
	Increment = 0.1,
	Suffix = "x",
	CurrentValue = Aural.Catching.DiveVectorDistance,
	Flag = "DiveVectorDistance",
	Callback = function(V) Aural.Catching.DiveVectorDistance = V end,
})

CatchingTab:CreateSection("Enhancements")

CatchingTab:CreateToggle({
	Name = "Magnet Enhancer",
	CurrentValue = Aural.Catching.MagEnhancer,
	Flag = "MagEnhancer",
	Callback = function(V) Aural.Catching.MagEnhancer = V end,
})

CatchingTab:CreateSlider({
	Name = "Enhancer Multiplier",
	Range = { 1, 5 },
	Increment = 1,
	CurrentValue = Aural.Catching.MagEnhancerMultiplier,
	Flag = "MagEnhancerMultiplier",
	Callback = function(V) Aural.Catching.MagEnhancerMultiplier = V end,
})

CatchingTab:CreateSection("Automatics")

CatchingTab:CreateToggle({
	Name = "Auto QB",
	CurrentValue = Aural.Automatics.AutoQb,
	Flag = "AutoQb",
	Callback = function(V) Aural.Automatics.AutoQb = V end,
})

CatchingTab:CreateDropdown({
	Name = "Auto QB Type",
	Options = { "Legit", "Rage", "Precise" },
	CurrentOption = Aural.Automatics.AutoQbType,
	Flag = "AutoQbType",
	Callback = function(V) Aural.Automatics.AutoQbType = V end,
})

CatchingTab:CreateToggle({
	Name = "Auto Captain",
	CurrentValue = Aural.Automatics.AutoCaptain,
	Flag = "AutoCaptain",
	Callback = function(V) Aural.Automatics.AutoCaptain = V end,
})

CatchingTab:CreateToggle({
	Name = "Auto Catch",
	CurrentValue = Aural.Automatics.AutoCatch,
	Flag = "AutoCatch",
	Callback = function(V) Aural.Automatics.AutoCatch = V end,
})

CatchingTab:CreateSlider({
	Name = "Auto Catch Radius",
	Range = { 0, 100 },
	Increment = 1,
	CurrentValue = Aural.Automatics.AutoCatchRadius,
	Flag = "AutoCatchRadius",
	Callback = function(V) Aural.Automatics.AutoCatchRadius = V end,
})

CatchingTab:CreateToggle({
	Name = "Auto Jump",
	CurrentValue = Aural.Automatics.AutoJump,
	Flag = "AutoJump",
	Callback = function(V) Aural.Automatics.AutoJump = V end,
})

CatchingTab:CreateSlider({
	Name = "Auto Jump Radius",
	Range = { 0, 50 },
	Increment = 1,
	CurrentValue = Aural.Automatics.AutoJumpRadius,
	Flag = "AutoJumpRadius",
	Callback = function(V) Aural.Automatics.AutoJumpRadius = V end,
})

CatchingTab:CreateSlider({
	Name = "Auto Jump Height",
	Range = { 0, 30 },
	Increment = 1,
	CurrentValue = Aural.Automatics.AutoJumpHeight,
	Flag = "AutoJumpHeight",
	Callback = function(V) Aural.Automatics.AutoJumpHeight = V end,
})

CatchingTab:CreateToggle({
	Name = "Auto Guard",
	CurrentValue = Aural.Automatics.AutoGuard,
	Flag = "AutoGuard",
	Callback = function(V) Aural.Automatics.AutoGuard = V end,
})

CatchingTab:CreateSlider({
	Name = "Auto Guard Radius",
	Range = { 0, 50 },
	Increment = 1,
	CurrentValue = Aural.Automatics.AutoGuardRadius,
	Flag = "AutoGuardRadius",
	Callback = function(V) Aural.Automatics.AutoGuardRadius = V end,
})

CatchingTab:CreateToggle({
	Name = "Auto Block",
	CurrentValue = Aural.Automatics.AutoBlock,
	Flag = "AutoBlock",
	Callback = function(V) Aural.Automatics.AutoBlock = V end,
})

CatchingTab:CreateSlider({
	Name = "Auto Block Radius",
	Range = { 2, 20 },
	Increment = 1,
	CurrentValue = Aural.Automatics.AutoBlockRadius,
	Flag = "AutoBlockRadius",
	Callback = function(V) Aural.Automatics.AutoBlockRadius = V end,
})

CatchingTab:CreateSection("Swat & Kick")

CatchingTab:CreateToggle({
	Name = "Auto Swat",
	CurrentValue = Aural.Automatics.AutoSwat,
	Flag = "AutoSwat",
	Callback = function(V) Aural.Automatics.AutoSwat = V end,
})

CatchingTab:CreateSlider({
	Name = "Auto Swat Radius",
	Range = { 0, 100 },
	Increment = 1,
	CurrentValue = Aural.Automatics.AutoSwatRadius,
	Flag = "AutoSwatRadius",
	Callback = function(V) Aural.Automatics.AutoSwatRadius = V end,
})

CatchingTab:CreateToggle({
	Name = "Auto Kick",
	CurrentValue = Aural.Automatics.KickerAim,
	Flag = "KickerAim",
	Callback = function(V) Aural.Automatics.KickerAim = V end,
})

CatchingTab:CreateSlider({
	Name = "Kick Power",
	Range = { 0, 100 },
	Increment = 1,
	Suffix = "%",
	CurrentValue = Aural.Automatics.KickerAimPower,
	Flag = "KickerAimPower",
	Callback = function(V) Aural.Automatics.KickerAimPower = V end,
})

CatchingTab:CreateSlider({
	Name = "Kick Accuracy",
	Range = { 0, 100 },
	Increment = 1,
	Suffix = "%",
	CurrentValue = Aural.Automatics.KickerAimAccuracy,
	Flag = "KickerAimAccuracy",
	Callback = function(V) Aural.Automatics.KickerAimAccuracy = V end,
})

CatchingTab:CreateSection("Rush")

CatchingTab:CreateToggle({
	Name = "Auto Rush",
	CurrentValue = Aural.Automatics.AutoRush,
	Flag = "AutoRush",
	Callback = function(V) Aural.Automatics.AutoRush = V end,
})

CatchingTab:CreateSlider({
	Name = "Auto Rush Delay",
	Range = { 0, 10 },
	Increment = 0.1,
	CurrentValue = Aural.Automatics.AutoRushDelay,
	Flag = "AutoRushDelay",
	Callback = function(V) Aural.Automatics.AutoRushDelay = V end,
})

CatchingTab:CreateSlider({
	Name = "Auto Rush Prediction",
	Range = { 0, 200 },
	Increment = 1,
	Suffix = "%",
	CurrentValue = Aural.Automatics.AutoRushPrediction,
	Flag = "AutoRushPrediction",
	Callback = function(V) Aural.Automatics.AutoRushPrediction = V end,
})

CatchingTab:CreateSlider({
	Name = "Auto Rush Accuracy",
	Range = { 0, 100 },
	Increment = 1,
	Suffix = "%",
	CurrentValue = Aural.Automatics.AutoRushAccuracy,
	Flag = "AutoRushAccuracy",
	Callback = function(V) Aural.Automatics.AutoRushAccuracy = V end,
})

local ThrowProfiles = { "Dime", "Dive", "Mag", "Dot", "Bullet", "Fade" }
local CurrentThrowIndex = table.find(ThrowProfiles, Aural.QbAimbot.ThrowProfile) or 1
local ThrowProfileDropdown

OffenseTab:CreateSection("Throw Config")

OffenseTab:CreateToggle({
	Name = "QB Aimbot",
	CurrentValue = Aural.QbAimbot.Enabled,
	Flag = "QbAimbot",
	Callback = function(V)
		Aural.QbAimbot.Enabled = V
		Aural.QbAimbot.TargetLock = false
		Aural.QbAimbot.LockedTarget = nil
	end,
})

OffenseTab:CreateToggle({
	Name = "Auto Angle",
	CurrentValue = Aural.QbAimbot.AutoAngle,
	Flag = "AutoAngle",
	Callback = function(V) Aural.QbAimbot.AutoAngle = V end,
})

OffenseTab:CreateToggle({
	Name = "Auto Power",
	CurrentValue = Aural.QbAimbot.AutoPower,
	Flag = "AutoPower",
	Callback = function(V) Aural.QbAimbot.AutoPower = V end,
})

OffenseTab:CreateToggle({
	Name = "Angle Based",
	CurrentValue = Aural.QbAimbot.AngleBased,
	Flag = "AngleBased",
	Callback = function(V) Aural.QbAimbot.AngleBased = V end,
})

OffenseTab:CreateSlider({
	Name = "Desired Angle",
	Range = { 5, 90 },
	Increment = 1,
	CurrentValue = Aural.QbAimbot.DesiredAngle,
	Flag = "DesiredAngle",
	Callback = function(V) Aural.QbAimbot.DesiredAngle = V end,
})

OffenseTab:CreateSlider({
	Name = "Max Air Time",
	Range = { 1, 20 },
	Increment = 1,
	CurrentValue = Aural.QbAimbot.MaxAirTime,
	Flag = "MaxAirTime",
	Callback = function(V) Aural.QbAimbot.MaxAirTime = V end,
})

OffenseTab:CreateToggle({
	Name = "Auto Choose Throw Type",
	CurrentValue = Aural.QbAimbot.AutoChooseThrowType,
	Flag = "AutoChooseThrowType",
	Callback = function(V) Aural.QbAimbot.AutoChooseThrowType = V end,
})

ThrowProfileDropdown = OffenseTab:CreateDropdown({
	Name = "Throw Profile",
	Options = ThrowProfiles,
	CurrentOption = Aural.QbAimbot.ThrowProfile,
	Flag = "ThrowProfile",
	Callback = function(V)
		Aural.QbAimbot.ThrowProfile = V
		CurrentThrowIndex = table.find(ThrowProfiles, V) or 1
	end,
})

OffenseTab:CreateToggle({
	Name = "Trajectory Beam",
	CurrentValue = Aural.QbAimbot.BeamMode,
	Flag = "BeamMode",
	Callback = function(V) Aural.QbAimbot.BeamMode = V end,
})

OffenseTab:CreateToggle({
	Name = "Fastest Throw",
	CurrentValue = Aural.QbAimbot.FastestThrow,
	Flag = "FastestThrow",
	Callback = function(V) Aural.QbAimbot.FastestThrow = V end,
})

OffenseTab:CreateDropdown({
	Name = "Power Mode",
	Options = { "Normal", "Highest Power", "95 Power" },
	CurrentOption = "Normal",
	Flag = "PowerMode",
	Callback = function(V)
		Aural.QbAimbot.HighestPowerMode = (V == "Highest Power")
		Aural.QbAimbot.Use95PowerMode = (V == "95 Power")
	end,
})

OffenseTab:CreateSlider({
	Name = "Normal Power",
	Range = { 0, 95 },
	Increment = 1,
	CurrentValue = Aural.QbAimbot.NormalPower,
	Flag = "NormalPower",
	Callback = function(V) Aural.QbAimbot.NormalPower = V end,
})

OffenseTab:CreateSection("Targeting")

OffenseTab:CreateSlider({
	Name = "FOV",
	Range = { 0, 1000 },
	Increment = 1,
	CurrentValue = Aural.QbAimbot.Fov,
	Flag = "Fov",
	Callback = function(V) Aural.QbAimbot.Fov = V end,
})

OffenseTab:CreateDropdown({
	Name = "Target Priority",
	Options = { "Closest To Mouse", "Most Open", "Furthest Downfield" },
	CurrentOption = Aural.QbAimbot.TargetPriority,
	Flag = "TargetPriority",
	Callback = function(V)
		Aural.QbAimbot.TargetPriority = V
		Aural.QbAimbot.LockedTarget = nil
	end,
})

OffenseTab:CreateSlider({
	Name = "Throw Angle",
	Range = { 0, 85 },
	Increment = 1,
	CurrentValue = Aural.QbAimbot.ThrowAngle,
	Flag = "ThrowAngle",
	Callback = function(V) Aural.QbAimbot.ThrowAngle = V end,
})

OffenseTab:CreateSlider({
	Name = "Bullet Angle",
	Range = { 0, 40 },
	Increment = 1,
	CurrentValue = Aural.QbAimbot.BulletAngle,
	Flag = "BulletAngle",
	Callback = function(V) Aural.QbAimbot.BulletAngle = V end,
})

OffenseTab:CreateSection("Lead & Field")

OffenseTab:CreateSlider({
	Name = "Vertical Lead",
	Range = { 0, 15 },
	Increment = 0.25,
	CurrentValue = Aural.QbAimbot.VerticalLead,
	Flag = "VerticalLead",
	Callback = function(V) Aural.QbAimbot.VerticalLead = V end,
})

OffenseTab:CreateSlider({
	Name = "Lead In Front",
	Range = { 0, 10 },
	Increment = 0.5,
	Suffix = " studs",
	CurrentValue = Aural.QbAimbot.HorizontalLead,
	Flag = "HorizontalLead",
	Callback = function(V) Aural.QbAimbot.HorizontalLead = V end,
})

OffenseTab:CreateToggle({
	Name = "Anti OOB",
	CurrentValue = Aural.QbAimbot.AntiOob,
	Flag = "QbAntiOob",
	Callback = function(V) Aural.QbAimbot.AntiOob = V end,
})

OffenseTab:CreateSlider({
	Name = "Anti OOB Inset",
	Range = { 0, 15 },
	Increment = 1,
	CurrentValue = Aural.QbAimbot.AntiOobInset,
	Flag = "AntiOobInset",
	Callback = function(V) Aural.QbAimbot.AntiOobInset = V end,
})

OffenseTab:CreateSlider({
	Name = "Field Margin",
	Range = { 0, 30 },
	Increment = 1,
	CurrentValue = Aural.QbAimbot.FieldMargin,
	Flag = "FieldMargin",
	Callback = function(V) Aural.QbAimbot.FieldMargin = V end,
})

OffenseTab:CreateSlider({
	Name = "Custom Lead",
	Range = { 0, 100 },
	Increment = 1,
	CurrentValue = Aural.QbAimbot.CustomLead,
	Flag = "CustomLead",
	Callback = function(V) Aural.QbAimbot.CustomLead = V end,
})

OffenseTab:CreateColorPicker({
	Name = "Prediction Color",
	Color = Aural.QbAimbot.PredictionColor,
	Flag = "PredictionColor",
	Callback = function(V) Aural.QbAimbot.PredictionColor = V end,
})

OffenseTab:CreateSection("Extras")

OffenseTab:CreateToggle({
	Name = "Receiver ESP",
	CurrentValue = Aural.QbAimbot.ReceiverEsp,
	Flag = "ReceiverEsp",
	Callback = function(V) Aural.QbAimbot.ReceiverEsp = V end,
})

OffenseTab:CreateToggle({
	Name = "Show Routes",
	CurrentValue = Aural.QbAimbot.ShowRoutes,
	Flag = "ShowRoutes",
	Callback = function(V) Aural.QbAimbot.ShowRoutes = V end,
})

OffenseTab:CreateToggle({
	Name = "Show Distance",
	CurrentValue = Aural.QbAimbot.ShowDistance,
	Flag = "ShowDistance",
	Callback = function(V) Aural.QbAimbot.ShowDistance = V end,
})

if not IsMobile then
	UserInputService.InputBegan:Connect(function(Input, GameProcessed)
		if GameProcessed then return end
		if not Aural.QbAimbot.Enabled then return end

		if Input.KeyCode == Enum.KeyCode.Q then
			Aural.QbAimbot.TargetLock = not Aural.QbAimbot.TargetLock
			if not Aural.QbAimbot.TargetLock then
				Aural.QbAimbot.LockedTarget = nil
			end
		elseif Input.KeyCode == Enum.KeyCode.Z then
			CurrentThrowIndex = (CurrentThrowIndex % #ThrowProfiles) + 1
			Aural.QbAimbot.ThrowProfile = ThrowProfiles[CurrentThrowIndex]
			if ThrowProfileDropdown then
				ThrowProfileDropdown:SetValue(ThrowProfiles[CurrentThrowIndex])
			end
		elseif Input.KeyCode == Enum.KeyCode.R then
			local Key = Aural.QbAimbot.AngleBased and "DesiredAngle" or "ThrowAngle"
			Aural.QbAimbot[Key] = math.clamp(Aural.QbAimbot[Key] + 5, 5, 85)
		elseif Input.KeyCode == Enum.KeyCode.F then
			local Key = Aural.QbAimbot.AngleBased and "DesiredAngle" or "ThrowAngle"
			Aural.QbAimbot[Key] = math.clamp(Aural.QbAimbot[Key] - 5, 5, 85)
		end
	end)
end

DefenseTab:CreateSection("Combat")

DefenseTab:CreateToggle({
	Name = "Click Tackle Teleport",
	CurrentValue = Aural.Physics.ClickTackleAimbot,
	Flag = "ClickTackleAimbot",
	Callback = function(V) Aural.Physics.ClickTackleAimbot = V end,
})

DefenseTab:CreateSlider({
	Name = "Tackle Radius",
	Range = { 0, 15 },
	Increment = 1,
	CurrentValue = Aural.Physics.ClickTackleAimbotRadius,
	Flag = "ClickTackleAimbotRadius",
	Callback = function(V) Aural.Physics.ClickTackleAimbotRadius = V end,
})

DefenseTab:CreateToggle({
	Name = "Quick Teleport",
	CurrentValue = Aural.Physics.QuickTp,
	Flag = "QuickTp",
	Callback = function(V) Aural.Physics.QuickTp = V end,
})

DefenseTab:CreateSlider({
	Name = "Quick Teleport Distance",
	Range = { 0, 50 },
	Increment = 1,
	CurrentValue = Aural.Physics.QuickTpSpeed,
	Flag = "QuickTpSpeed",
	Callback = function(V) Aural.Physics.QuickTpSpeed = V end,
})

DefenseTab:CreateToggle({
	Name = "Anti Block",
	CurrentValue = Aural.Physics.AntiBlock,
	Flag = "AntiBlock",
	Callback = function(V) Aural.Physics.AntiBlock = V end,
})

DefenseTab:CreateToggle({
	Name = "Anti Jam",
	CurrentValue = Aural.Physics.AntiJam,
	Flag = "AntiJam",
	Callback = function(V) Aural.Physics.AntiJam = V end,
})

DefenseTab:CreateToggle({
	Name = "No Jump Cooldown",
	CurrentValue = Aural.Physics.NoJumpCooldown,
	Flag = "NoJumpCooldown",
	Callback = function(V) Aural.Physics.NoJumpCooldown = V end,
})

DefenseTab:CreateSection("Defense")

DefenseTab:CreateToggle({
	Name = "Anti Tackle",
	CurrentValue = Aural.Physics.AntiTackle,
	Flag = "AntiTackle",
	Callback = function(V) Aural.Physics.AntiTackle = V end,
})

DefenseTab:CreateToggle({
	Name = "Anti Down",
	CurrentValue = Aural.Physics.AntiDown,
	Flag = "AntiDown",
	Callback = function(V) Aural.Physics.AntiDown = V end,
})

DefenseTab:CreateToggle({
	Name = "Tackle Reach",
	CurrentValue = Aural.Physics.TackleReach,
	Flag = "TackleReach",
	Callback = function(V) Aural.Physics.TackleReach = V end,
})

DefenseTab:CreateSlider({
	Name = "Tackle Reach Radius",
	Range = { 0, 50 },
	Increment = 1,
	CurrentValue = Aural.Physics.TackleReachRadius,
	Flag = "TackleReachRadius",
	Callback = function(V) Aural.Physics.TackleReachRadius = V end,
})

DefenseTab:CreateToggle({
	Name = "Swat Reach",
	CurrentValue = Aural.Physics.SwatReach,
	Flag = "SwatReach",
	Callback = function(V) Aural.Physics.SwatReach = V end,
})

DefenseTab:CreateSlider({
	Name = "Swat Reach Radius",
	Range = { 0, 50 },
	Increment = 1,
	CurrentValue = Aural.Physics.SwatReachRadius,
	Flag = "SwatReachRadius",
	Callback = function(V) Aural.Physics.SwatReachRadius = V end,
})

DefenseTab:CreateSection("Extended")

DefenseTab:CreateToggle({
	Name = "Anti OOB",
	CurrentValue = Aural.Physics.AntiOob,
	Flag = "PhysAntiOob",
	Callback = function(V) Aural.Physics.AntiOob = V end,
})

DefenseTab:CreateToggle({
	Name = "Block Extender",
	CurrentValue = Aural.Physics.BlockExtender,
	Flag = "BlockExtender",
	Callback = function(V) Aural.Physics.BlockExtender = V end,
})

DefenseTab:CreateSlider({
	Name = "Block Extender Reach",
	Range = { 0, 50 },
	Increment = 1,
	CurrentValue = Aural.Physics.BlockExtenderReach,
	Flag = "BlockExtenderReach",
	Callback = function(V) Aural.Physics.BlockExtenderReach = V end,
})

DefenseTab:CreateSlider({
	Name = "Block Extender Transparency",
	Range = { 0, 1 },
	Increment = 0.1,
	CurrentValue = Aural.Physics.BlockExtenderTransparency,
	Flag = "BlockExtenderTransparency",
	Callback = function(V) Aural.Physics.BlockExtenderTransparency = V end,
})

MovementTab:CreateSection("Movement")

MovementTab:CreateToggle({
	Name = "Walkspeed",
	CurrentValue = Aural.Player.WalkSpeed,
	Flag = "WalkSpeed",
	Callback = function(V) Aural.Player.WalkSpeed = V end,
})

MovementTab:CreateSlider({
	Name = "Walkspeed Value",
	Range = { 16, 23 },
	Increment = 0.5,
	CurrentValue = Aural.Player.WalkSpeedValue,
	Flag = "WalkSpeedValue",
	Callback = function(V) Aural.Player.WalkSpeedValue = V end,
})

MovementTab:CreateToggle({
	Name = "Freeze During Pre-Play",
	CurrentValue = Aural.Player.FreezeDuringPrePlay,
	Flag = "FreezeDuringPrePlay",
	Callback = function(V) Aural.Player.FreezeDuringPrePlay = V end,
})

MovementTab:CreateToggle({
	Name = "Jump Power",
	CurrentValue = Aural.Player.JumpPower,
	Flag = "JumpPower",
	Callback = function(V) Aural.Player.JumpPower = V end,
})

MovementTab:CreateSlider({
	Name = "Jump Power Value",
	Range = { 50, 60 },
	Increment = 1,
	CurrentValue = Aural.Player.Jp,
	Flag = "Jp",
	Callback = function(V) Aural.Player.Jp = V end,
})

MovementTab:CreateToggle({
	Name = "Angle Enhancer",
	CurrentValue = Aural.Player.AngleEnhancer,
	Flag = "AngleEnhancer",
	Callback = function(V) Aural.Player.AngleEnhancer = V end,
})

MovementTab:CreateSlider({
	Name = "Angle Enhancer Value",
	Range = { 50, 70 },
	Increment = 1,
	CurrentValue = Aural.Player.AngleEnhancerValue,
	Flag = "AngleEnhancerValue",
	Callback = function(V) Aural.Player.AngleEnhancerValue = V end,
})

MovementTab:CreateToggle({
	Name = "CFrame Speed",
	CurrentValue = Aural.Player.CframeSpeed,
	Flag = "CframeSpeed",
	Callback = function(V) Aural.Player.CframeSpeed = V end,
})

MovementTab:CreateSlider({
	Name = "CFrame Speed Value",
	Range = { 0, 100 },
	Increment = 1,
	CurrentValue = Aural.Player.CfSpeed,
	Flag = "CfSpeed",
	Callback = function(V) Aural.Player.CfSpeed = V end,
})

MovementTab:CreateToggle({
	Name = "Fly",
	CurrentValue = Aural.Player.Fly,
	Flag = "Fly",
	Callback = function(V) Aural.Player.Fly = V end,
})

MovementTab:CreateSlider({
	Name = "Fly Speed",
	Range = { 0, 200 },
	Increment = 1,
	CurrentValue = Aural.Player.FlySpeed,
	Flag = "FlySpeed",
	Callback = function(V) Aural.Player.FlySpeed = V end,
})

MovementTab:CreateSection("Enhancements")

MovementTab:CreateToggle({
	Name = "Boost Enhancer",
	CurrentValue = Aural.Player.BoostEnhancer,
	Flag = "BoostEnhancer",
	Callback = function(V) Aural.Player.BoostEnhancer = V end,
})

MovementTab:CreateSlider({
	Name = "Boost Enhancer Speed",
	Range = { 16, 23 },
	Increment = 0.5,
	CurrentValue = Aural.Player.BoostEnhancerSpeed,
	Flag = "BoostEnhancerSpeed",
	Callback = function(V) Aural.Player.BoostEnhancerSpeed = V end,
})

MovementTab:CreateToggle({
	Name = "No Move Restrictions",
	CurrentValue = Aural.Player.NoMoveRestrictions,
	Flag = "NoMoveRestrictions",
	Callback = function(V) Aural.Player.NoMoveRestrictions = V end,
})

MovementTab:CreateSlider({
	Name = "Hand Size",
	Range = { 2, 15 },
	Increment = 1,
	CurrentValue = Aural.Player.HandSize,
	Flag = "HandSize",
	Callback = function(V) Aural.Player.HandSize = V end,
})

MovementTab:CreateToggle({
	Name = "Show Hand Hitbox",
	CurrentValue = Aural.Player.ShowHandHitbox,
	Flag = "ShowHandHitbox",
	Callback = function(V) Aural.Player.ShowHandHitbox = V end,
})

MovementTab:CreateSection("Gamepasses")

MovementTab:CreateToggle({
	Name = "Unlock All Gamepasses",
	CurrentValue = Aural.Gamepasses.UnlockAll,
	Flag = "UnlockAll",
	Callback = function(V) Aural.Gamepasses.UnlockAll = V end,
})

MovementTab:CreateSection("Visuals")

MovementTab:CreateToggle({
	Name = "No Textures",
	CurrentValue = Aural.Visuals.NoTextures,
	Flag = "NoTextures",
	Callback = function(V) Aural.Visuals.NoTextures = V end,
})

MovementTab:CreateToggle({
	Name = "Football Trajectory",
	CurrentValue = Aural.Visuals.ThrownBallBeam,
	Flag = "ThrownBallBeam",
	Callback = function(V) Aural.Visuals.ThrownBallBeam = V end,
})

MovementTab:CreateColorPicker({
	Name = "Trajectory Start Color",
	Color = Aural.Visuals.ThrownBallBeamColor,
	Flag = "ThrownBallBeamColor",
	Callback = function(V) Aural.Visuals.ThrownBallBeamColor = V end,
})

MovementTab:CreateColorPicker({
	Name = "Trajectory End Color",
	Color = Aural.Visuals.ThrownBallBeamColor2,
	Flag = "ThrownBallBeamColor2",
	Callback = function(V) Aural.Visuals.ThrownBallBeamColor2 = V end,
})

MiscTab:CreateSection("Configs")

MiscTab:CreateConfigManager({
	Name = "Config Manager",
})

MiscTab:CreateToggle({
	Name = "Auto-Save Config",
	Desc = "Automatically saves your config on every change",
	CurrentValue = Aural.Config.AutoSave,
	Flag = "ConfigAutoSave",
	Callback = function(V)
		Aural.Config.AutoSave = V
		if V then
			Airflow:Notify({
				Title = "Auto-Save",
				Content = "Config will save automatically.",
				Type = "Success",
				Duration = 2,
			})
		end
	end,
})

MiscTab:CreateSlider({
	Name = "Auto-Save Interval",
	Range = { 5, 120 },
	Increment = 5,
	Suffix = "s",
	CurrentValue = Aural.Config.AutoSaveInterval,
	Flag = "ConfigAutoSaveInterval",
	Callback = function(V)
		Aural.Config.AutoSaveInterval = V
	end,
})

MiscTab:CreateButton({
	Name = "Save Config Now",
	Icon = "save",
	Style = "Primary",
	Callback = function()
		Window:SaveConfig()
		Aural.Config.LastSaved = os.clock()
		Airflow:Notify({
			Title = "Saved",
			Content = "Config saved successfully.",
			Type = "Success",
			Duration = 2,
		})
	end,
})

MiscTab:CreateButton({
	Name = "Reload Config",
	Icon = "refresh-cw",
	Callback = function()
		Window:LoadConfig()
		Airflow:Notify({
			Title = "Reloaded",
			Content = "Config reloaded from disk.",
			Type = "Info",
			Duration = 2,
		})
	end,
})

MiscTab:CreateSection("Menu")

MiscTab:CreateToggle({
	Name = "Anti-Cheat Debug Mode",
	CurrentValue = Aural.AcBypass.DebugMode,
	Flag = "AcDebugMode",
	Callback = function(V) Aural.AcBypass.DebugMode = V end,
})

MiscTab:CreateParagraph({
	Title = "About",
	Content = "Montex Hub v1.0 — Airflow UI port. User: @" .. LocalPlayer.Name .. " | Place: " .. game.PlaceId,
})

Window:LoadConfig()

task.spawn(function()
	while task.wait(1) do
		if not Aural.Config.AutoSave then continue end

		local Now = os.clock()
		if Now - Aural.Config.LastSaved < Aural.Config.AutoSaveInterval then
			continue
		end

		local Ok, Err = pcall(function()
			Window:SaveConfig()
		end)
		Aural.Config.LastSaved = Now
	end
end)

local Library = { Flags = {}, Folder = "MontexHub", Elements = {}, ToggleKey = Enum.KeyCode.RightShift }

do
	local MagnetHitbox = nil
	local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

	LocalPlayer.CharacterAdded:Connect(function(Char)
		Character = Char
	end)

	local function GetClosestFootball()
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		if not HumanoidRootPart then
			return nil
		end

		local ClosestFootball = nil
		local ClosestDistance = math.huge

		for Index, Object in next, workspace:GetChildren() do
			if Object.Name == "Football" and Object:IsA("BasePart") then
				local Distance = (Object.Position - HumanoidRootPart.Position).Magnitude

				if Distance < ClosestDistance then
					ClosestFootball = Object
					ClosestDistance = Distance
				end
			end
		end

		return ClosestFootball
	end

	local function GetMagnetRadius()
		local Radius = Aural.Catching.CustomizableRadius
		if Aural.Catching.MagEnhancer then
			Radius *= Aural.Catching.MagEnhancerMultiplier
		end
		return Radius
	end

	local function UpdateMagnetHitbox(Football, InRange)
		if not Aural.Catching.ShowMagHitbox or not Football then
			if MagnetHitbox then
				MagnetHitbox:Destroy()
				MagnetHitbox = nil
			end
			return
		end
		if not MagnetHitbox or not MagnetHitbox.Parent then
			MagnetHitbox = Instance.new("Part")
			MagnetHitbox.Name = HttpService:GenerateGUID(false)
			MagnetHitbox.Shape = Enum.PartType.Ball
			MagnetHitbox.Material = Enum.Material.ForceField
			MagnetHitbox.Transparency = 0.7
			MagnetHitbox.CastShadow = false
			MagnetHitbox.Anchored = true
			MagnetHitbox.CanCollide = false
			MagnetHitbox.CanTouch = false
			MagnetHitbox.CanQuery = false
			MagnetHitbox.Parent = workspace
		end
		local Radius = GetMagnetRadius()
		MagnetHitbox.Size = Vector3.new(Radius * 2, Radius * 2, Radius * 2)
		MagnetHitbox.Position = Football.Position
		MagnetHitbox.Color = InRange and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 170, 255)
	end

	RunService.Heartbeat:Connect(function()
		if not Character or not Character.Parent then
			Character = LocalPlayer.Character
			if not Character then
				UpdateMagnetHitbox(nil, false)
				return
			end
		end

		local Football = GetClosestFootball()
		if not Football then
			UpdateMagnetHitbox(nil, false)
			return
		end

		local CatchLeft = Character:FindFirstChild(IsPractice and "CatchLeft" or "CatchL")
		local CatchRight = Character:FindFirstChild(IsPractice and "CatchRight" or "CatchR")

		local MagnetsEnabled = Aural.Catching.Magnets
		local MagnetDistance = GetMagnetRadius()

		local InRange = CatchRight and ((Football.Position - CatchRight.Position).Magnitude <= MagnetDistance) or false
		UpdateMagnetHitbox(Football, InRange)

		if not CatchLeft or not CatchRight or not MagnetsEnabled then
			return
		end

		local Distance = (Football.Position - CatchRight.Position).Magnitude

		if Distance <= MagnetDistance then
			CatchLeft.Position = Football.Position
			CatchRight.Position = Football.Position
		end
	end)

	task.spawn(function()
		while true do
			local Time = task.wait()

			if not Aural.Catching.PullVector then
				continue
			end

			local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
			if not HumanoidRootPart then
				continue
			end

			local ClosestFootball = GetClosestFootball()
			if not ClosestFootball then
				continue
			end

			local Offset = ClosestFootball.Position - HumanoidRootPart.Position
			local Distance = Offset.Magnitude

			if Distance > 0 and Distance <= Aural.Catching.PullVectorRadius then
				local Step = Distance
				if Aural.Catching.PullVectorMode ~= "Instant" then
					Step = math.min(Aural.Catching.PullVectorSpeed * Time, Distance)
				end
				HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Offset.Unit * Step
			end
		end
	end)

	local function GetFlightFootball(Origin, Radius)
		local Closest, ClosestDist = nil, Radius
		for Index, Football in next, workspace:GetChildren() do
			if Football.Name == "Football" and Football:IsA("BasePart") then
				local Configuration = Football:FindFirstChild("Configuration")
				local Catchable = Configuration and Configuration:FindFirstChild("Catchable")
				local InFlight = Football.AssemblyLinearVelocity.Magnitude > 5
				if InFlight and not (Catchable and Catchable.Value == false) then
					local Dist = (Football.Position - Origin).Magnitude
					if Dist <= ClosestDist then
						Closest = Football
						ClosestDist = Dist
					end
				end
			end
		end
		return Closest, ClosestDist
	end

	local BallTracks = setmetatable({}, { __mode = "k" })

	RunService.Heartbeat:Connect(function()
		local Now = os.clock()
		for Index, Football in next, workspace:GetChildren() do
			if Football.Name == "Football" and Football:IsA("BasePart") then
				local Height = Football.Position.Y
				local Track = BallTracks[Football]
				if not Track then
					BallTracks[Football] = { Clock = Now, Height = Height, Vertical = Football.AssemblyLinearVelocity.Y }
				elseif Now - Track.Clock >= 0.1 and math.abs(Height - Track.Height) > 0.001 then
					local Elapsed = Now - Track.Clock
					Track.Vertical = (Height - Track.Height) / Elapsed - 14 * Elapsed
					Track.Clock = Now
					Track.Height = Height
				end
			end
		end
	end)

	local function GetFootballVelocity(Football)
		local Live = Football:GetAttribute("v")
		if typeof(Live) == "Vector3" then
			return Live
		end
		local Launch = Football.AssemblyLinearVelocity
		local Track = BallTracks[Football]
		if not Track then
			return Launch
		end
		return Vector3.new(Launch.X, Track.Vertical - 28 * (os.clock() - Track.Clock), Launch.Z)
	end

	local function GetDiveIntercept(Football, Origin, Speed)
		local Configuration = Football:FindFirstChild("Configuration")
		local GravityValue = Configuration and Configuration:FindFirstChild("Gravity")
		local Gravity = Vector3.new(0, GravityValue and GravityValue.Value or -28, 0)
		local Position = Football.Position
		local Velocity = GetFootballVelocity(Football)

		local Target = Position
		for Index = 1, 4 do
			local Time = math.min((Target - Origin).Magnitude / Speed, 1.5)
			Target = Position + Velocity * Time + Gravity * (0.5 * Time * Time)
		end
		return Vector3.new(Target.X, math.max(Target.Y, 4), Target.Z)
	end

	local DiveStart = nil
	local DiveBoosted = false

	RunService.Heartbeat:Connect(function()
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Diving = Humanoid and HumanoidRootPart and Humanoid.PlatformStand and not Character:FindFirstChild("TackleScript")
		if not Diving then
			DiveStart = nil
			DiveBoosted = false
			return
		end
		DiveStart = DiveStart or os.clock()

		if not Aural.Catching.DiveVector then
			return
		end

		if not DiveBoosted and os.clock() - DiveStart >= 0.1 then
			DiveBoosted = true
			local Velocity = HumanoidRootPart.AssemblyLinearVelocity
			local Multiplier = Aural.Catching.DiveVectorDistance
			HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(Velocity.X * Multiplier, Velocity.Y, Velocity.Z * Multiplier)
		end

		local Hand = Character:FindFirstChild(IsPractice and "CatchRight" or "CatchR") or Character:FindFirstChild("Right Arm") or HumanoidRootPart
		local Football = GetFlightFootball(Hand.Position, Aural.Catching.DiveVectorRadius)
		if not Football then
			return
		end

		local Speed = Aural.Catching.DiveVectorSpeed
		local Offset = GetDiveIntercept(Football, Hand.Position, Speed) - Hand.Position
		if Offset.Magnitude > 0.5 then
			HumanoidRootPart.AssemblyLinearVelocity = Offset.Unit * Speed
		end
	end)

	local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
	local ActionRemote = Remotes and Remotes:FindFirstChild("CharacterSoundEvent")
	local Flags = ReplicatedStorage:FindFirstChild("Flags")
	local LastAction = 0

	local function GetFlag(Name)
		local Flag = Flags and Flags:FindFirstChild(Name)
		return Flag and Flag.Value
	end

	local SwatReachUntil = 0

	local function StartSwatReach()
		if Aural.Physics.SwatReach then
			SwatReachUntil = os.clock() + 1
		end
	end

	UserInputService.InputBegan:Connect(function(Input, GameProcessed)
		if not GameProcessed and Input.KeyCode == Enum.KeyCode.R then
			StartSwatReach()
		end
	end)

	if IsMobile then
		UserInputService.TouchTap:Connect(function(Positions, GameProcessed)
			local MainGui = LocalPlayer.PlayerGui:FindFirstChild("MainGui")
			local MobileButtons = MainGui and MainGui:FindFirstChild("MobileButtons")
			local Block = MobileButtons and MobileButtons:FindFirstChild("Block")
			local Label = Block and Block:FindFirstChild("TextLabel")
			if not GameProcessed and Label and string.sub(Label.Text, 1, 4) == "Swat" then
				StartSwatReach()
			end
		end)
	end

	task.spawn(function()
		while task.wait(0.1) do
			if os.clock() > SwatReachUntil or not Aural.Physics.SwatReach then
				continue
			end

			local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
			local Hand = Character and Character:FindFirstChild(IsPractice and "CatchRight" or "CatchR")
			if not HumanoidRootPart then
				continue
			end

			local Football = GetFlightFootball(HumanoidRootPart.Position, Aural.Physics.SwatReachRadius)
			if not Football then
				continue
			end

			if firetouchinterest and Hand then
				firetouchinterest(Hand, Football, 0)
				task.wait()
				firetouchinterest(Hand, Football, 1)
			else
				HumanoidRootPart.CFrame = CFrame.new(Football.Position)
			end
		end
	end)

	local function FireAction(Swat)
		if not ActionRemote or os.clock() - LastAction < 1 then
			return
		end
		if Flags and not ((GetFlag("Throwable") or not GetFlag("Carrier")) and GetFlag("Ball")) then
			return
		end
		LastAction = os.clock()
		ActionRemote:FireServer("PlayerActions", Swat and "swat" or (IsPractice and "catch " or "catch"))
		if Swat then
			StartSwatReach()
		end
	end

	local function IsOnDefense()
		if not Flags or not LocalPlayer.Team then
			return true
		end
		return GetFlag("PossessionTag") ~= LocalPlayer.Team.Name
	end

	RunService.Heartbeat:Connect(function()
		local Automatics = Aural.Automatics
		if not (Automatics.AutoCatch or Automatics.AutoSwat or Automatics.AutoJump) then
			return
		end

		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		if not Humanoid or not HumanoidRootPart then
			return
		end

		local Football, Distance = GetFlightFootball(HumanoidRootPart.Position, math.huge)
		if not Football then
			return
		end
		local ThrownBy = Football:FindFirstChild("ThrownBy")
		if ThrownBy and ThrownBy.Value == LocalPlayer then
			return
		end

		if Automatics.AutoJump and Distance <= Automatics.AutoJumpRadius and Humanoid.FloorMaterial ~= Enum.Material.Air then
			local Height = Football.Position.Y - HumanoidRootPart.Position.Y
			if Height > 0 and Height <= Automatics.AutoJumpHeight then
				Humanoid.Jump = true
			end
		end

		if Automatics.AutoSwat and Distance <= Automatics.AutoSwatRadius and IsOnDefense() then
			FireAction(true)
		elseif Automatics.AutoCatch and Distance <= Automatics.AutoCatchRadius then
			FireAction(false)
		end
	end)

	local HandDefaults = setmetatable({}, { __mode = "k" })

	task.spawn(function()
		while task.wait(0.25) do
			if not Character then
				continue
			end
			for Index, Name in (IsPractice and { "CatchLeft", "CatchRight" } or { "CatchL", "CatchR" }) do
				local Hand = Character:FindFirstChild(Name)
				if Hand and Hand:IsA("BasePart") then
					HandDefaults[Hand] = HandDefaults[Hand] or Hand.Size
					local Size = Aural.Player.HandSize
					Hand.Size = Size > 2 and Vector3.new(Size, Size, Size) or HandDefaults[Hand]
					Hand.Transparency = Aural.Player.ShowHandHitbox and 0.5 or 1
				end
			end
		end
	end)
end

do
	local Flags = ReplicatedStorage:FindFirstChild("Flags")
	local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
	local ActionRemote = Remotes and Remotes:FindFirstChild("CharacterSoundEvent")

	local function GetFlag(Name)
		local Flag = Flags and Flags:FindFirstChild(Name)
		return Flag and Flag.Value
	end

	local function GetParts(Model)
		local Humanoid = Model and Model:FindFirstChildOfClass("Humanoid")
		local Root = Model and Model:FindFirstChild("HumanoidRootPart")
		if Humanoid and Root then
			return Humanoid, Root
		end
		return nil, nil
	end

	local function IsOpponent(Player)
		return Player ~= LocalPlayer and (LocalPlayer.Team == nil or Player.Team ~= LocalPlayer.Team)
	end

	local function IsInPlay()
		return not Flags or GetFlag("Status") == "InPlay"
	end

	local function GetOpposingCarrier()
		local Carrier = GetFlag("Carrier")
		if Carrier then
			return IsOpponent(Carrier) and Carrier.Character or nil
		end
		for Index, Player in Players:GetPlayers() do
			local Model = Player.Character
			if Model and IsOpponent(Player) and Model:FindFirstChild("Football") then
				return Model
			end
		end
		return nil
	end

	local function GetClosestOpponent(Origin, Radius)
		local Closest, ClosestDist = nil, Radius
		for Index, Player in Players:GetPlayers() do
			local Humanoid, Root = GetParts(Player.Character)
			if Root and IsOpponent(Player) then
				local Dist = (Root.Position - Origin).Magnitude
				if Dist <= ClosestDist then
					Closest = Player.Character
					ClosestDist = Dist
				end
			end
		end
		return Closest
	end

	local function GetHighlightedPlayer()
		local Models = workspace:FindFirstChild("Models")
		local Beam = Models and Models:FindFirstChild("GroundBeam")
		local Attachment = Beam and Beam.Enabled and Beam.Attachment1
		local Model = Attachment and Attachment.Parent and Attachment.Parent.Parent
		if Model and Model ~= LocalPlayer.Character and Model:FindFirstChildOfClass("Humanoid") then
			return Model
		end
		return nil
	end

	local function FlatVelocity(Root)
		local Velocity = Root.AssemblyLinearVelocity
		return Vector3.new(Velocity.X, 0, Velocity.Z)
	end

	if not IsPractice then
		task.spawn(function()
			local Models = workspace:WaitForChild("Models", 10)
			local LockerRoom = Models and Models:WaitForChild("LockerRoomA", 10)
			local FinishLine = LockerRoom and LockerRoom:WaitForChild("FinishLine3", 10)
			if not FinishLine then
				return
			end

			FinishLine:GetPropertyChangedSignal("CFrame"):Connect(function()
				if not Aural.Automatics.AutoCaptain or FinishLine.Position.Y <= 0 then
					return
				end
				for Index = 1, 7 do
					task.wait(0.2)
					local Humanoid, Root = GetParts(LocalPlayer.Character)
					if Root then
						Root.CFrame = FinishLine.CFrame + Vector3.new(0, 2, 0)
					end
				end
			end)
		end)
	end

	local SkippedPlays = { KICKOFF = true, PUNT = true, PAT = true }

	RunService.Heartbeat:Connect(function()
		if not Aural.Automatics.AutoQb or not Flags or not LocalPlayer.Team then
			return
		end
		if GetFlag("Status") ~= "PrePlay" or GetFlag("PossessionTag") ~= LocalPlayer.Team.Name then
			return
		end
		if SkippedPlays[GetFlag("StatusTag")] or GetFlag("QB") or GetFlag("Carrier") then
			return
		end

		local Humanoid, Root = GetParts(LocalPlayer.Character)
		local Football = workspace:FindFirstChild("Football")
		if not Root or not Football or not Football:IsA("BasePart") then
			return
		end

		local Mode = Aural.Automatics.AutoQbType
		if Mode == "Legit" then
			Humanoid:MoveTo(Football.Position)
		elseif Mode == "Precise" then
			Root.CFrame = CFrame.new(Football.Position + Vector3.new(0, 2, -0.5))
		else
			Root.CFrame = CFrame.new(Football.Position + Vector3.new(0, 2, 0))
		end
	end)

	local RushTarget, RushStart, RushSpread, RushSpreadTick = nil, 0, Vector3.zero, 0
	local Rushing = false

	RunService.Heartbeat:Connect(function()
		local Humanoid, Root = GetParts(LocalPlayer.Character)
		local Target = Aural.Automatics.AutoRush and IsInPlay() and GetOpposingCarrier() or nil
		local TargetHumanoid, TargetRoot = GetParts(Target)

		if not Root or not TargetRoot then
			RushTarget = nil
			if Rushing and Humanoid then
				Humanoid:Move(Vector3.zero)
			end
			Rushing = false
			return
		end

		if Target ~= RushTarget then
			RushTarget = Target
			RushStart = os.clock()
		end
		if os.clock() - RushStart < Aural.Automatics.AutoRushDelay then
			return
		end

		if os.clock() - RushSpreadTick > 0.5 then
			RushSpreadTick = os.clock()
			local Angle = math.random() * math.pi * 2
			RushSpread = Vector3.new(math.cos(Angle), 0, math.sin(Angle))
		end

		local Distance = (TargetRoot.Position - Root.Position).Magnitude
		local Time = Distance / math.max(Humanoid.WalkSpeed, 16) * (Aural.Automatics.AutoRushPrediction / 100)
		local Error = (100 - Aural.Automatics.AutoRushAccuracy) / 100 * 8 * math.min(1, Distance / 15)

		Rushing = true
		Humanoid:MoveTo(TargetRoot.Position + FlatVelocity(TargetRoot) * Time + RushSpread * Error)
	end)

	local GuardTarget = nil
	local Guarding = false

	if Flags and Flags:FindFirstChild("Status") then
		Flags.Status.Changed:Connect(function()
			GuardTarget = nil
		end)
	end

	RunService.Heartbeat:Connect(function()
		local Humanoid, Root = GetParts(LocalPlayer.Character)
		if not Aural.Automatics.AutoGuard or not Root then
			GuardTarget = nil
			if Guarding and Humanoid then
				Humanoid:Move(Vector3.zero)
			end
			Guarding = false
			return
		end

		local TargetHumanoid, TargetRoot = GetParts(GuardTarget)
		if not TargetRoot or not GuardTarget.Parent then
			GuardTarget = GetHighlightedPlayer() or GetClosestOpponent(Root.Position, Aural.Automatics.AutoGuardRadius)
			TargetHumanoid, TargetRoot = GetParts(GuardTarget)
		end
		if not TargetRoot then
			if Guarding then
				Humanoid:Move(Vector3.zero)
			end
			Guarding = false
			return
		end

		Guarding = true
		Humanoid:MoveTo(TargetRoot.Position + FlatVelocity(TargetRoot) * 0.2)
	end)

	local LastTackle = 0

	RunService.Heartbeat:Connect(function()
		if not Aural.Physics.TackleReach or not Flags or not ActionRemote then
			return
		end
		if not IsInPlay() or os.clock() - LastTackle < 0.2 then
			return
		end

		local Humanoid, Root = GetParts(LocalPlayer.Character)
		local TargetHumanoid, TargetRoot = GetParts(GetOpposingCarrier())
		if not Root or not TargetRoot then
			return
		end

		if (TargetRoot.Position - Root.Position).Magnitude <= Aural.Physics.TackleReachRadius then
			LastTackle = os.clock()
			ActionRemote:FireServer("Game", "TackleTouch", "Torso", "Torso")
		end
	end)

	UserInputService.InputBegan:Connect(function(Input, GameProcessed)
		if GameProcessed or not Aural.Physics.ClickTackleAimbot or not IsInPlay() then
			return
		end
		if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local Humanoid, Root = GetParts(LocalPlayer.Character)
		local TargetHumanoid, TargetRoot = GetParts(GetOpposingCarrier())
		if Root and TargetRoot and (TargetRoot.Position - Root.Position).Magnitude <= Aural.Physics.ClickTackleAimbotRadius then
			Root.CFrame = TargetRoot.CFrame
		end
	end)

	local function CleanMover(Object)
		if Aural.Physics.AntiBlock and string.find(Object.Name, "FFmover") then
			task.defer(Object.Destroy, Object)
		end
	end

	if LocalPlayer.Character then
		LocalPlayer.Character.DescendantAdded:Connect(CleanMover)
	end
	LocalPlayer.CharacterAdded:Connect(function(Model)
		Model.DescendantAdded:Connect(CleanMover)
	end)

	local JamConstraints = {}

	local function ClearJamConstraints()
		for Index, Constraint in JamConstraints do
			Constraint:Destroy()
		end
		table.clear(JamConstraints)
	end

	task.spawn(function()
		while task.wait(0.5) do
			ClearJamConstraints()
			local Model = LocalPlayer.Character
			if not Aural.Physics.AntiJam or not Model then
				continue
			end

			for Index, Player in Players:GetPlayers() do
				local Other = Player.Character
				if Other and IsOpponent(Player) then
					for Index, MyName in { "Head", "Torso" } do
						for Index, OtherName in { "Head", "Torso" } do
							local MyPart, OtherPart = Model:FindFirstChild(MyName), Other:FindFirstChild(OtherName)
							if MyPart and OtherPart then
								local Constraint = Instance.new("NoCollisionConstraint")
								Constraint.Part0 = MyPart
								Constraint.Part1 = OtherPart
								Constraint.Parent = workspace.CurrentCamera
								table.insert(JamConstraints, Constraint)
							end
						end
					end
				end
			end
		end
	end)

	task.spawn(function()
		while task.wait(0.5) do
			local Models = workspace:FindFirstChild("Models")
			local Boundaries = Models and Models:FindFirstChild("Boundaries")
			if Boundaries then
				for Index, Boundary in Boundaries:GetChildren() do
					if Boundary:IsA("BasePart") then
						Boundary.CanTouch = not Aural.Physics.AntiOob
					end
				end
			end
		end
	end)

	local BlokDefaults = setmetatable({}, { __mode = "k" })

	task.spawn(function()
		while task.wait(0.1) do
			local Model = LocalPlayer.Character
			local BlokPart = Model and Model:FindFirstChild("BlokPart")
			if BlokPart and BlokPart:IsA("BasePart") then
				BlokDefaults[BlokPart] = BlokDefaults[BlokPart] or { Size = BlokPart.Size, Transparency = BlokPart.Transparency }
				if Aural.Physics.BlockExtender then
					local Reach = math.max(Aural.Physics.BlockExtenderReach, 1.5)
					BlokPart.Size = Vector3.new(Reach, 5, Reach)
					BlokPart.Transparency = Aural.Physics.BlockExtenderTransparency
				else
					BlokPart.Size = BlokDefaults[BlokPart].Size
					BlokPart.Transparency = BlokDefaults[BlokPart].Transparency
				end
			end
		end
	end)

	local AutoBlocking = false

	local function IsAllowedToBlock(Root)
		if not Flags then
			return false
		end
		local Carrier = GetFlag("Carrier")
		if Carrier == LocalPlayer then
			return false
		end
		if (Carrier and GetFlag("Throwable") == false) or GetFlag("Fumble") then
			return true
		end
		local LineDown, LineTogo = workspace:FindFirstChild("LineDown"), workspace:FindFirstChild("LineTogo")
		if not LineDown or not LineTogo then
			return false
		end
		if LineTogo.Position.Z < LineDown.Position.Z then
			return Root.Position.Z > LineDown.Position.Z - 15
		end
		return Root.Position.Z < LineDown.Position.Z + 15
	end

	local function GetBlockTarget(BlokPart, Model)
		local Params = OverlapParams.new()
		Params.FilterType = Enum.RaycastFilterType.Exclude
		Params.FilterDescendantsInstances = { Model }

		local Fallback = nil
		for Index, Part in workspace:GetPartsInPart(BlokPart, Params) do
			local Player = Part.Parent and Players:GetPlayerFromCharacter(Part.Parent)
			if Player and IsOpponent(Player) and Part.Transparency == 0 then
				if Part.Name == "Torso" then
					return Part
				end
				Fallback = Fallback or Part
			end
		end
		return Fallback
	end

	local function AutoBlock(Model, Humanoid)
		AutoBlocking = true
		local Start = os.clock()
		ActionRemote:FireServer("PlayerActions", "block")

		local Animations = ReplicatedStorage:FindFirstChild("Animations")
		local Animation = Animations and Animations:FindFirstChild("Block")
		if Animation and Animation:IsA("Animation") then
			pcall(function()
				Humanoid:LoadAnimation(Animation):Play()
			end)
		end

		local BlokPart = Model:WaitForChild("BlokPart", 1)
		local Target = nil
		while BlokPart and BlokPart.Parent and os.clock() - Start < 1 do
			local Touching = GetBlockTarget(BlokPart, Model)
			if not Target and Touching then
				Target = Touching
				ActionRemote:FireServer("PlayerActions", "execBlock ", Target.Parent.Name, Target.Name)
				task.wait(0.15)
			elseif Target and not Touching then
				break
			end
			task.wait(0.1)
		end
		if Target then
			ActionRemote:FireServer("PlayerActions", "blockTouchEnded")
		end

		task.wait(math.max(0, 1 - (os.clock() - Start)))
		AutoBlocking = false
	end

	RunService.Heartbeat:Connect(function()
		if AutoBlocking or not Aural.Automatics.AutoBlock or not ActionRemote or not Flags then
			return
		end
		if GetFlag("Status") ~= "InPlay" or (LocalPlayer.Team and GetFlag("PossessionTag") ~= LocalPlayer.Team.Name) then
			return
		end

		local Model = LocalPlayer.Character
		local Humanoid, Root = GetParts(Model)
		if not Root or Humanoid.PlatformStand or not IsAllowedToBlock(Root) then
			return
		end

		if GetClosestOpponent(Root.Position, Aural.Automatics.AutoBlockRadius) then
			task.spawn(AutoBlock, Model, Humanoid)
		end
	end)
end

do
	local Settings = Aural.Player
	local MaxWalkSpeed = 23
	local MaxJumpPower = 60

	local GameSpeed, GameJump = 20, 50
	local WrittenSpeed, WrittenJump = nil, nil
	local AngleUntil = 0

	local Environment = getgenv and getgenv() or _G
	local Generation = (Environment.MontexPlayerGeneration or 0) + 1
	Environment.MontexPlayerGeneration = Generation

	local function IsCurrent()
		return Environment.MontexPlayerGeneration == Generation
	end

	local function WatchCharacter(Character)
		local Humanoid = Character:WaitForChild("Humanoid", 5)
		if not Humanoid then
			return
		end
		GameSpeed, GameJump = Humanoid.WalkSpeed, Humanoid.JumpPower
		WrittenSpeed, WrittenJump = nil, nil

		Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			if IsCurrent() and (not WrittenSpeed or math.abs(Humanoid.WalkSpeed - WrittenSpeed) > 0.01) then
				GameSpeed = Humanoid.WalkSpeed
			end
		end)
		Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
			if IsCurrent() and (not WrittenJump or math.abs(Humanoid.JumpPower - WrittenJump) > 0.01) then
				GameJump = Humanoid.JumpPower
			end
		end)
	end

	if LocalPlayer.Character then
		task.spawn(WatchCharacter, LocalPlayer.Character)
	end
	LocalPlayer.CharacterAdded:Connect(WatchCharacter)

	local WasShiftLocked = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
	UserInputService:GetPropertyChangedSignal("MouseBehavior"):Connect(function()
		local ShiftLocked = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
		if WasShiftLocked and not ShiftLocked then
			AngleUntil = os.clock() + 0.2
		end
		WasShiftLocked = ShiftLocked
	end)

	local FlyVelocity, FlyGyro = nil, nil
	local FlyUp, FlyDown = false, false

	local function StopFly()
		if FlyVelocity then
			FlyVelocity:Destroy()
			FlyVelocity = nil
		end
		if FlyGyro then
			FlyGyro:Destroy()
			FlyGyro = nil
		end
	end

	local function UpdateFly(Humanoid, Root)
		if not FlyVelocity or FlyVelocity.Parent ~= Root then
			StopFly()
			FlyVelocity = Instance.new("BodyVelocity")
			FlyVelocity.Name = HttpService:GenerateGUID(false)
			FlyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			FlyVelocity.Velocity = Vector3.zero
			FlyVelocity.Parent = Root

			FlyGyro = Instance.new("BodyGyro")
			FlyGyro.Name = HttpService:GenerateGUID(false)
			FlyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
			FlyGyro.D = 200
			FlyGyro.P = 10000
			FlyGyro.Parent = Root
		end

		local Camera = workspace.CurrentCamera.CFrame
		local Direction = Vector3.zero
		if IsMobile then
			Direction = Humanoid.MoveDirection
		else
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then Direction += Camera.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then Direction -= Camera.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then Direction += Camera.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then Direction -= Camera.RightVector end
		end
		if FlyUp or UserInputService:IsKeyDown(Enum.KeyCode.Space) then Direction += Vector3.new(0, 1, 0) end
		if FlyDown or UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then Direction -= Vector3.new(0, 1, 0) end

		FlyVelocity.Velocity = Direction.Magnitude > 0 and Direction.Unit * Settings.FlySpeed or Vector3.zero
		FlyGyro.CFrame = Camera
		Humanoid:ChangeState(Enum.HumanoidStateType.Flying)
	end

	if IsMobile then
		local Gui = Instance.new("ScreenGui")
		Gui.Name = HttpService:GenerateGUID(false)
		Gui.ResetOnSpawn = false
		Gui.DisplayOrder = 50
		Gui.Parent = CoreGui

		local function FlyButton(Text, Offset, SetHeld)
			local Button = Instance.new("TextButton")
			Button.AnchorPoint = Vector2.new(1, 1)
			Button.Position = UDim2.new(1, -180, 1, Offset)
			Button.Size = UDim2.fromOffset(52, 52)
			Button.BackgroundColor3 = Color3.fromRGB(15, 15, 19)
			Button.BackgroundTransparency = 0.25
			Button.Font = Enum.Font.GothamBold
			Button.TextSize = 12
			Button.TextColor3 = Color3.fromRGB(240, 240, 245)
			Button.Text = Text
			Button.Parent = Gui

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(1, 0)
			Corner.Parent = Button

			Button.MouseButton1Down:Connect(function() SetHeld(true) end)
			Button.MouseButton1Up:Connect(function() SetHeld(false) end)
			Button.MouseLeave:Connect(function() SetHeld(false) end)
			return Button
		end

		local Up = FlyButton("UP", -250, function(Held) FlyUp = Held end)
		local Down = FlyButton("DOWN", -190, function(Held) FlyDown = Held end)
		RunService.Heartbeat:Connect(function()
			Up.Visible = Settings.Fly
			Down.Visible = Settings.Fly
		end)
	end

	local PlayerConnection
	PlayerConnection = RunService.Heartbeat:Connect(function(DeltaTime)
		if not IsCurrent() then
			PlayerConnection:Disconnect()
			StopFly()
			return
		end

		local Character = LocalPlayer.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local Root = Character and Character:FindFirstChild("HumanoidRootPart")
		if not Humanoid or not Root then
			StopFly()
			return
		end

		local Frozen = GameSpeed <= 0
		local HoldFreeze = Frozen and Settings.FreezeDuringPrePlay

		local Speed = GameSpeed
		if Frozen then
			if not HoldFreeze and (Settings.WalkSpeed or Settings.NoMoveRestrictions) then
				Speed = Settings.WalkSpeed and Settings.WalkSpeedValue or 20
			end
		else
			if (Settings.NoMoveRestrictions or Aural.Physics.AntiBlock) and Speed < 16 then
				Speed = 20
			end
			if Settings.WalkSpeed then
				Speed = Settings.WalkSpeedValue
			end
			if Settings.BoostEnhancer and (IsMobile or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)) then
				Speed = math.max(Speed, Settings.BoostEnhancerSpeed)
			end
		end
		Speed = math.min(Speed, MaxWalkSpeed)
		if math.abs(Humanoid.WalkSpeed - Speed) > 0.01 then
			WrittenSpeed = Speed
			Humanoid.WalkSpeed = Speed
		end

		local Jump = GameJump
		if GameJump > 0 then
			if Settings.NoMoveRestrictions and Jump < 50 then
				Jump = 50
			end
			if Settings.JumpPower then
				Jump = math.min(Settings.Jp, MaxJumpPower)
			end
			if Settings.AngleEnhancer and os.clock() < AngleUntil then
				Jump = math.max(Jump, Settings.AngleEnhancerValue)
			end
		end
		if math.abs(Humanoid.JumpPower - Jump) > 0.01 then
			WrittenJump = Jump
			Humanoid.JumpPower = Jump
		end

		if Aural.Physics.NoJumpCooldown and not Humanoid.PlatformStand and not Humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
		end

		if Settings.Fly then
			UpdateFly(Humanoid, Root)
		else
			StopFly()
			if Settings.CframeSpeed and not HoldFreeze and Humanoid.MoveDirection.Magnitude > 0 then
				Root.CFrame = Root.CFrame + Humanoid.MoveDirection * (Settings.CfSpeed * DeltaTime)
			end
		end
	end)

	local PassModule, OriginalOwnsPass = nil, nil

	task.spawn(function()
		while task.wait(1) do
			if PassModule or not Aural.Gamepasses.UnlockAll or not getgc then
				continue
			end
			for Index, Object in getgc(true) do
				if type(Object) == "table" and type(rawget(Object, "PlayerOwnsPass")) == "function" and type(rawget(Object, "WaitForSave")) == "function" then
					PassModule = Object
					OriginalOwnsPass = rawget(Object, "PlayerOwnsPass")
					rawset(Object, "PlayerOwnsPass", function(...)
						if Aural.Gamepasses.UnlockAll then
							return true
						end
						return OriginalOwnsPass(...)
					end)
					break
				end
			end
		end
	end)
end

do
	local function QuickTeleport()
		local Distance = Aural.Physics.QuickTpSpeed
		local Character = LocalPlayer.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local Root = Character and Character:FindFirstChild("HumanoidRootPart")
		if not Aural.Physics.QuickTp or Distance <= 0 or not Humanoid or not Root then
			return
		end

		local Direction = Humanoid.MoveDirection
		if Direction.Magnitude < 0.1 then
			local Look = Root.CFrame.LookVector
			Direction = Vector3.new(Look.X, 0, Look.Z)
		end
		if Direction.Magnitude < 0.1 then
			return
		end

		Root.CFrame = Root.CFrame + Direction.Unit * Distance
	end

	UserInputService.InputBegan:Connect(function(Input, GameProcessed)
		if GameProcessed or Input.KeyCode ~= Enum.KeyCode.F then
			return
		end
		local Character = LocalPlayer.Character
		if Aural.QbAimbot.Enabled and Character and Character:FindFirstChildOfClass("Tool") then
			return
		end
		QuickTeleport()
	end)

	if IsMobile then
		local Gui = Instance.new("ScreenGui")
		Gui.Name = HttpService:GenerateGUID(false)
		Gui.ResetOnSpawn = false
		Gui.DisplayOrder = 50
		Gui.Parent = CoreGui

		local Button = Instance.new("TextButton")
		Button.AnchorPoint = Vector2.new(1, 1)
		Button.Position = UDim2.new(1, -110, 1, -190)
		Button.Size = UDim2.fromOffset(58, 58)
		Button.BackgroundColor3 = Color3.fromRGB(15, 15, 19)
		Button.BackgroundTransparency = 0.25
		Button.AutoButtonColor = true
		Button.Font = Enum.Font.GothamBold
		Button.TextSize = 13
		Button.TextColor3 = Color3.fromRGB(240, 240, 245)
		Button.Text = "TP"
		Button.Parent = Gui

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(1, 0)
		Corner.Parent = Button

		local Stroke = Instance.new("UIStroke")
		Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		Stroke.Thickness = 1.5
		Stroke.Transparency = 0.3
		Stroke.Parent = Button

		Button.MouseButton1Click:Connect(QuickTeleport)

		RunService.Heartbeat:Connect(function()
			Button.Visible = Aural.Physics.QuickTp
			Stroke.Color = Color3.fromRGB(56, 132, 255)
		end)
	end
end

do
	local Settings = Aural.QbAimbot
	local Gravity = 28
	local MaxPower = 95
	local RestHeight = 3.4
	local Flags = ReplicatedStorage:FindFirstChild("Flags")

	local ThrowTypes = {
		Dime = { Arc = 1, Height = 2.5, Lead = 0 },
		Mag = { Arc = 1.1, Height = 4.5, Lead = 1 },
		Dive = { Arc = 0.9, Height = 0.5, Lead = 3 },
		Dot = { Arc = 0.8, Height = 2, Lead = 0 },
		Bullet = { Arc = 0.7, Height = 2, Lead = 0 },
		Fade = { Arc = 1.45, Height = 5, Lead = 0 },
	}

	local Calibration = { Speed = 1, Yaw = 0, Release = IsPractice and 4 or 4.7 }
	local LastThrow = nil

	local function Flatten(Vector)
		return Vector3.new(Vector.X, 0, Vector.Z)
	end

	local function RotateYaw(Vector, Angle)
		local Cos, Sin = math.cos(Angle), math.sin(Angle)
		return Vector3.new(Vector.X * Cos - Vector.Z * Sin, Vector.Y, Vector.X * Sin + Vector.Z * Cos)
	end

	local BoundsCache, BoundsClock = nil, 0

	local function GetBounds(Position)
		if BoundsCache and os.clock() - BoundsClock < 1 then
			return BoundsCache
		end

		local Bounds = { MinX = -math.huge, MaxX = math.huge, MinZ = -math.huge, MaxZ = math.huge }
		local Models = workspace:FindFirstChild("Models")
		local Folder = Models and (Models:FindFirstChild("Boundaries") or Models:FindFirstChild("Incomplete"))
		if Folder then
			for Index, Part in Folder:GetDescendants() do
				if Part:IsA("BasePart") then
					local Frame, Size = Part.CFrame, Part.Size / 2
					local Right, Up, Look = Frame.RightVector, Frame.UpVector, Frame.LookVector
					local HalfX = math.abs(Right.X) * Size.X + math.abs(Up.X) * Size.Y + math.abs(Look.X) * Size.Z
					local HalfY = math.abs(Right.Y) * Size.X + math.abs(Up.Y) * Size.Y + math.abs(Look.Y) * Size.Z
					local HalfZ = math.abs(Right.Z) * Size.X + math.abs(Up.Z) * Size.Y + math.abs(Look.Z) * Size.Z
					local Center = Part.Position

					if HalfY > 5 then
						if HalfX < 2 and math.abs(Position.Z - Center.Z) <= HalfZ + 1 then
							if Center.X > Position.X then
								Bounds.MaxX = math.min(Bounds.MaxX, Center.X - HalfX)
							else
								Bounds.MinX = math.max(Bounds.MinX, Center.X + HalfX)
							end
						elseif HalfZ < 2 and math.abs(Position.X - Center.X) <= HalfX + 1 then
							if Center.Z > Position.Z then
								Bounds.MaxZ = math.min(Bounds.MaxZ, Center.Z - HalfZ)
							else
								Bounds.MinZ = math.max(Bounds.MinZ, Center.Z + HalfZ)
							end
						end
					end
				end
			end
		end

		if Bounds.MaxX - Bounds.MinX < 40 then
			Bounds.MinX, Bounds.MaxX = -math.huge, math.huge
		end
		if Bounds.MaxZ - Bounds.MinZ < 40 then
			Bounds.MinZ, Bounds.MaxZ = -math.huge, math.huge
		end

		BoundsCache, BoundsClock = Bounds, os.clock()
		return Bounds
	end

	local function IsInBounds(Position, Inset, Bounds)
		return Position.X >= Bounds.MinX + Inset and Position.X <= Bounds.MaxX - Inset
			and Position.Z >= Bounds.MinZ + Inset and Position.Z <= Bounds.MaxZ - Inset
	end

	local function SolveAngle(Range, Height, Speed, HighArc)
		local Speed2 = Speed * Speed
		local Discriminant = Speed2 * Speed2 - Gravity * (Gravity * Range * Range + 2 * Height * Speed2)
		if Discriminant < 0 or Range < 0.01 then
			return nil
		end
		local Root = math.sqrt(Discriminant)
		return math.atan((Speed2 + (HighArc and Root or -Root)) / (Gravity * Range))
	end

	local function RequiredSpeed(Range, Height, Angle)
		local Cos = math.cos(Angle)
		local Denominator = 2 * Cos * Cos * (Range * math.tan(Angle) - Height)
		if Denominator <= 0 then
			return nil
		end
		return math.sqrt(Gravity * Range * Range / Denominator)
	end

	local function GetTargetParts(Model)
		local Humanoid = Model and Model:FindFirstChildOfClass("Humanoid")
		local Root = Model and Model:FindFirstChild("HumanoidRootPart")
		if Humanoid and Root and Model.Parent then
			return Humanoid, Root
		end
		return nil, nil
	end

	local function GetReceivers()
		local Receivers = {}
		for Index, Player in Players:GetPlayers() do
			local SameSide = IsPractice or LocalPlayer.Team == nil or Player.Team == LocalPlayer.Team
			if Player ~= LocalPlayer and SameSide and Player.Character then
				table.insert(Receivers, Player.Character)
			end
		end
		local Bots = IsPractice and workspace:FindFirstChild("npcwr")
		if Bots then
			for Index, Object in Bots:GetDescendants() do
				if Object:IsA("Model") and string.match(Object.Name, "^bot %d+$") then
					table.insert(Receivers, Object)
				end
			end
		end
		return Receivers
	end

	local function GetDefenderDistance(Position)
		local Closest = math.huge
		for Index, Player in Players:GetPlayers() do
			if Player ~= LocalPlayer and LocalPlayer.Team and Player.Team ~= LocalPlayer.Team then
				local Humanoid, Root = GetTargetParts(Player.Character)
				if Root then
					Closest = math.min(Closest, (Root.Position - Position).Magnitude)
				end
			end
		end
		return Closest
	end

	local function GetAimPoint()
		if IsMobile then
			return workspace.CurrentCamera.ViewportSize / 2
		end
		return UserInputService:GetMouseLocation()
	end

	local function PickTarget(MyRoot)
		local Locked = Settings.LockedTarget
		if Locked then
			if GetTargetParts(Locked) then
				return Locked
			end
			Settings.LockedTarget = nil
		end

		local Camera = workspace.CurrentCamera
		local AimPoint = GetAimPoint()
		local Best, BestScore = nil, -math.huge
		for Index, Model in GetReceivers() do
			local Humanoid, Root = GetTargetParts(Model)
			if Root and Settings.AntiOob and not IsInBounds(Root.Position, 0, GetBounds(MyRoot.Position)) then
				Root = nil
			end
			if Root then
				local Screen, OnScreen = Camera:WorldToViewportPoint(Root.Position)
				local ScreenDistance = (Vector2.new(Screen.X, Screen.Y) - AimPoint).Magnitude
				if OnScreen and (Settings.Fov <= 0 or ScreenDistance <= Settings.Fov) then
					local Score = -ScreenDistance
					if Settings.TargetPriority == "Most Open" and LocalPlayer.Team then
						Score = GetDefenderDistance(Root.Position)
					elseif Settings.TargetPriority == "Furthest Downfield" then
						Score = math.abs(Root.Position.Z - MyRoot.Position.Z)
					end
					if Score > BestScore then
						Best, BestScore = Model, Score
					end
				end
			end
		end
		return Best
	end

	local function GetRoute(Humanoid, Root, MyRoot)
		local Velocity = Flatten(Root.AssemblyLinearVelocity)
		if Velocity.Magnitude < 2 then
			return "Still"
		end
		local Downfield = (Root.Position.Z - MyRoot.Position.Z) >= 0 and 1 or -1
		local Dot = Velocity.Unit.Z * Downfield
		if Dot >= 0.8 then
			return "Straight"
		elseif Dot >= 0.45 then
			return "Post"
		elseif Dot >= -0.2 then
			return "Slant"
		end
		return "Comeback"
	end

	local function ChooseThrowType(Range, Route)
		if Route == "Slant" then
			return Range <= 100 and "Bullet" or "Dive"
		elseif Route == "Straight" or Route == "Post" then
			return Range <= 150 and "Dive" or "Dime"
		elseif Route == "Comeback" then
			return Range <= 150 and "Bullet" or "Dive"
		end
		return Range <= 100 and "Dot" or "Dime"
	end

	local function GetWantedAngle(ThrowType, Range)
		if Settings.AutoAngle then
			local Base = math.clamp(14 + Range * 0.12, 16, 42)
			return math.rad(math.clamp(Base * (ThrowTypes[ThrowType] or ThrowTypes.Dime).Arc, 10, 62))
		elseif ThrowType == "Bullet" then
			return math.rad(Settings.BulletAngle)
		end
		return math.rad(Settings.AngleBased and Settings.DesiredAngle or Settings.ThrowAngle)
	end

	local function ResolveAngleAndPower(Range, Height, ThrowType)
		if Settings.FastestThrow or Settings.Use95PowerMode or ThrowType == "Bullet" then
			return SolveAngle(Range, Height, MaxPower * Calibration.Speed, false), MaxPower
		end
		if Settings.HighestPowerMode then
			local Power = math.clamp(math.ceil(math.sqrt(Range * Gravity)), 85, MaxPower)
			return SolveAngle(Range, Height, Power * Calibration.Speed, false), Power
		end

		local Wanted = math.clamp(GetWantedAngle(ThrowType, Range), math.rad(1), math.rad(85))
		local Needed = RequiredSpeed(Range, Height, Wanted)
		if not Needed then
			Wanted = math.min(math.atan2(Height, Range) + math.rad(12), math.rad(85))
			Needed = RequiredSpeed(Range, Height, Wanted)
		end
		if not Needed then
			return nil, MaxPower
		end

		local Limit = Settings.AutoPower and MaxPower or math.clamp(math.round(Settings.NormalPower), 1, MaxPower)
		local Power = math.clamp(math.ceil(Needed / Calibration.Speed), 1, MaxPower)
		local WantsLob = Wanted > math.rad(45)
		if Power > Limit then
			Power = Limit
		end

		local Speed = Power * Calibration.Speed
		local Low, High = SolveAngle(Range, Height, Speed, false), SolveAngle(Range, Height, Speed, true)
		if not Low then
			return nil, Power
		end
		if WantsLob and Range / (Speed * math.cos(High)) <= Settings.MaxAirTime then
			return High, Power
		end
		return Low, Power
	end

	local RunSpeed = 20
	local SpeedUpTime = 0.25
	local Motion = setmetatable({}, { __mode = "k" })

	local function TrackMotion(Target, Humanoid, Root)
		local Now = os.clock()
		local Track = Motion[Target]
		if Track and Track.Stamp == Now then
			return Track
		end

		local Velocity = Flatten(Root.AssemblyLinearVelocity)
		local Speed = Velocity.Magnitude
		local Input = Flatten(Humanoid.MoveDirection)
		local Direction = nil
		if Input.Magnitude > 0.1 then
			Direction = Input.Unit
		elseif Speed > 2 and not Players:GetPlayerFromCharacter(Target) then
			Direction = Velocity.Unit
		end

		if not Track then
			Track = { Since = Now }
			Motion[Target] = Track
		end
		if not Direction or not Track.Anchor or Direction:Dot(Track.Anchor) < 0.97 or Now - (Track.Stamp or 0) > 0.3 then
			Track.Anchor = Direction
			Track.Since = Now
		end

		Track.Stamp = Now
		Track.Direction = Direction
		Track.Speed = Speed
		Track.Velocity = Velocity
		Track.Steady = Direction ~= nil and Speed > 15 and Now - Track.Since >= 0.6
		return Track
	end

	local function GetLeadTrust(Track, Time)
		if Track.Steady then
			return 1
		end
		return math.clamp(1 - 0.06 * Time, 0.85, 1)
	end

	local function GetExpectedMiss(Track, Time)
		if not Track.Direction then
			return 2 + 3 * Time
		elseif Track.Steady then
			return 4.4 * Time ^ 1.65
		end
		return 8.2 * Time ^ 1.2
	end

	local function PredictPosition(Humanoid, Root, Time, Profile, Track)
		local Position = Root.Position + Vector3.new(0, Settings.VerticalLead + Profile.Height, 0)
		local Direction, Speed = Track.Direction, Track.Speed
		if not Direction then
			if Speed > 0.5 then
				return Position + Track.Velocity.Unit * (Speed * 0.12)
			end
			return Position
		end

		local TopSpeed = math.max(RunSpeed, Speed)
		local Distance = TopSpeed * Time - (TopSpeed - Speed) * SpeedUpTime * (1 - math.exp(-Time / SpeedUpTime))
		local Lead = Distance * GetLeadTrust(Track, Time) + Settings.HorizontalLead + Profile.Lead + Settings.CustomLead * Time
		return Position + Direction * Lead
	end

	local function ClampToField(Position)
		if IsPractice then
			return Position
		end
		local Margin = Settings.AntiOob and -Settings.AntiOobInset or Settings.FieldMargin
		return Vector3.new(
			math.clamp(Position.X, -(80 + Margin), 80 + Margin),
			Position.Y,
			math.clamp(Position.Z, -(180 + Margin), 180 + Margin)
		)
	end

	local function KeepInBounds(Current, Predicted, Bounds)
		if not Settings.AntiOob then
			return ClampToField(Predicted), false
		end

		local Inset = Settings.AntiOobInset
		if IsInBounds(Predicted, Inset, Bounds) then
			return Predicted, false
		end

		local MinX, MaxX = Bounds.MinX + Inset, Bounds.MaxX - Inset
		local MinZ, MaxZ = Bounds.MinZ + Inset, Bounds.MaxZ - Inset
		local Delta = Predicted - Current
		local Fraction = 1
		if math.abs(Delta.X) > 0.01 then
			if Predicted.X > MaxX then
				Fraction = math.min(Fraction, (MaxX - Current.X) / Delta.X)
			elseif Predicted.X < MinX then
				Fraction = math.min(Fraction, (MinX - Current.X) / Delta.X)
			end
		end
		if math.abs(Delta.Z) > 0.01 then
			if Predicted.Z > MaxZ then
				Fraction = math.min(Fraction, (MaxZ - Current.Z) / Delta.Z)
			elseif Predicted.Z < MinZ then
				Fraction = math.min(Fraction, (MinZ - Current.Z) / Delta.Z)
			end
		end

		local Point = Current + Delta * math.clamp(Fraction, 0, 1)
		return Vector3.new(math.clamp(Point.X, MinX, MaxX), Predicted.Y, math.clamp(Point.Z, MinZ, MaxZ)), true
	end

	local FlightTimes = setmetatable({}, { __mode = "k" })

	local function BuildSolution(Target, MyRoot, Head)
		local Humanoid, Root = GetTargetParts(Target)
		if not Root then
			return nil
		end

		local Route = GetRoute(Humanoid, Root, MyRoot)
		local Range = Flatten(Root.Position - Head.Position).Magnitude
		local ThrowType = Settings.AutoChooseThrowType and ChooseThrowType(Range, Route) or Settings.ThrowProfile
		local Profile = ThrowTypes[ThrowType] or ThrowTypes.Dime
		local Latency = LocalPlayer:GetNetworkPing() * 2
		local Track = TrackMotion(Target, Humanoid, Root)

		local Time = FlightTimes[Target] or 1
		local Origin, Aim, Angle, Power, FlatDirection
		local Direction = nil
		local Sideline = false
		for Index = 1, 8 do
			Aim, Sideline = KeepInBounds(Root.Position, PredictPosition(Humanoid, Root, Time + Latency, Profile, Track), GetBounds(MyRoot.Position))

			local Offset = Flatten(Aim - Head.Position)
			if Offset.Magnitude < 1 then
				return nil
			end
			Direction = Direction or (Aim - Head.Position).Unit
			Origin = Head.Position + Direction * Calibration.Release

			Offset = Flatten(Aim - Origin)
			if Offset.Magnitude < 1 then
				return nil
			end
			FlatDirection = Offset.Unit
			Angle, Power = ResolveAngleAndPower(Offset.Magnitude, Aim.Y - Origin.Y, ThrowType)
			if not Angle then
				break
			end
			Direction = FlatDirection * math.cos(Angle) + Vector3.new(0, math.sin(Angle), 0)
			Time = Offset.Magnitude / (Power * Calibration.Speed * math.cos(Angle))
		end

		if not Angle then
			return { Target = Target, Aim = Aim, Origin = Origin, ThrowType = ThrowType, Route = Route, Power = Power, OutOfRange = true }
		end
		FlightTimes[Target] = Time

		local Velocity = Direction * (Power * Calibration.Speed)
		local LandTime = Time
		local Discriminant = Velocity.Y * Velocity.Y + 2 * Gravity * (Origin.Y - RestHeight)
		if Discriminant > 0 then
			LandTime = math.max(Time, (Velocity.Y + math.sqrt(Discriminant)) / Gravity)
		end

		return {
			Steady = Track.Steady,
			ExpectedMiss = GetExpectedMiss(Track, Time + Latency),
			Sideline = Sideline,
			LandTime = LandTime,
			Landing = Origin + Velocity * LandTime - Vector3.new(0, 0.5 * Gravity * LandTime * LandTime, 0),
			Target = Target,
			Aim = Aim,
			Origin = Origin,
			ThrowType = ThrowType,
			Route = Route,
			Power = Power,
			Angle = Angle,
			Time = Time,
			Direction = Direction,
			Velocity = Velocity,
			Range = Flatten(Aim - Origin).Magnitude,
		}
	end

	local function GetThrowRemote(Character)
		local Tool = Character and Character:FindFirstChildOfClass("Tool")
		local Handle = Tool and Tool:FindFirstChild("Handle")
		return Handle and Handle:FindFirstChild("RemoteEvent")
	end

	local function IsReadyToThrow(Character)
		if not GetThrowRemote(Character) then
			return false
		end
		if IsPractice or not Flags then
			return true
		end
		local Status, Throwable = Flags:FindFirstChild("Status"), Flags:FindFirstChild("Throwable")
		return LocalPlayer.PlayerGui:FindFirstChild("BallGui") ~= nil and Status and Status.Value == "InPlay" and Throwable and Throwable.Value
	end

	local function FireThrow(Character, Solution)
		local Remote = GetThrowRemote(Character)
		local Head = Character:FindFirstChild("Head")
		local Root = Character:FindFirstChild("HumanoidRootPart")
		if not Remote or not Head or not Root then
			return
		end

		local Direction = RotateYaw(Solution.Direction, -Calibration.Yaw)
		LastThrow = { Clock = os.clock(), Head = Head.Position, Velocity = Solution.Velocity, Direction = Solution.Direction }

		if IsPractice then
			Remote:FireServer("Clicked", Head.CFrame.Position, Head.Position + Direction * 10000, Solution.Power)
		else
			local Origin = (Root.CFrame * CFrame.new(0, 1.5, 0)).Position + Vector3.new(70000000, 0, 0)
			Remote:FireServer("Clicked", Origin, Head.Position + Direction * 10000, Solution.Power, 1)
		end
	end

	local function Blend(Old, New)
		return Old + (New - Old) * 0.5
	end

	workspace.ChildAdded:Connect(function(Ball)
		local Throw = LastThrow
		if not Throw or os.clock() - Throw.Clock > 1 or Ball.Name ~= "Football" or not Ball:IsA("BasePart") then
			return
		end
		if (Ball.Position - Throw.Head).Magnitude > 25 then
			return
		end
		LastThrow = nil
		task.wait()

		local Launch = Ball.AssemblyLinearVelocity
		local Intended = Throw.Velocity
		local FlatLaunch, FlatIntended = Flatten(Launch), Flatten(Intended)
		if FlatLaunch.Magnitude < 1 or FlatIntended.Magnitude < 1 then
			return
		end

		local SpeedRatio = FlatLaunch.Magnitude / FlatIntended.Magnitude
		if math.abs(SpeedRatio - 1) < 0.1 then
			Calibration.Speed = Blend(Calibration.Speed, Calibration.Speed * SpeedRatio)
		end

		local YawError = math.atan2(FlatLaunch.Z, FlatLaunch.X) - math.atan2(FlatIntended.Z, FlatIntended.X)
		YawError = (YawError + math.pi) % (2 * math.pi) - math.pi
		if math.abs(YawError) < math.rad(6) then
			Calibration.Yaw = Blend(Calibration.Yaw, Calibration.Yaw + YawError)
		end

		local Current = Ball:GetAttribute("v")
		if typeof(Current) == "Vector3" then
			local Elapsed = math.clamp((Intended.Y - Current.Y) / Gravity, 0, 1)
			local Origin = Ball.Position - Vector3.new(Launch.X, Intended.Y, Launch.Z) * Elapsed + Vector3.new(0, 0.5 * Gravity * Elapsed * Elapsed, 0)
			local Release = (Origin - Throw.Head):Dot(Throw.Direction)
			if Release > 0 and Release < 10 then
				Calibration.Release = Blend(Calibration.Release, Release)
			end
		end
	end)

	local Visuals = nil

	local function BeamProjectile(Velocity, Origin, Time)
		local Acceleration = Vector3.new(0, -Gravity, 0)
		local P3 = 0.5 * Acceleration * Time * Time + Velocity * Time + Origin
		local P1 = Origin + Velocity * Time / 3
		local P2 = P3 - (Acceleration * Time * Time + Velocity * Time) / 3

		local R1, R2 = (P1 - Origin).Unit, (P2 - P3).Unit
		local Up = Vector3.new(0, 1, 0)
		local B1, B2 = R1:Cross(Up).Unit, R2:Cross(Up).Unit
		local U1, U2 = B1:Cross(R1).Unit, B2:Cross(R2).Unit

		local CFrame1 = CFrame.new(Origin.X, Origin.Y, Origin.Z, R1.X, U1.X, B1.X, R1.Y, U1.Y, B1.Y, R1.Z, U1.Z, B1.Z)
		local CFrame2 = CFrame.new(P3.X, P3.Y, P3.Z, R2.X, U2.X, B2.X, R2.Y, U2.Y, B2.Y, R2.Z, U2.Z, B2.Z)
		return (P1 - Origin).Magnitude, -(P2 - P3).Magnitude, CFrame1, CFrame2
	end

	local CardText = Color3.fromRGB(240, 240, 245)
	local CardMuted = Color3.fromRGB(150, 150, 162)
	local CardRed = Color3.fromRGB(255, 90, 90)
	local CardGreen = Color3.fromRGB(110, 230, 150)
	local CardAmber = Color3.fromRGB(255, 185, 90)

	local function New(ClassName, Properties, Parent)
		local Object = Instance.new(ClassName)
		for Property, Value in Properties do
			Object[Property] = Value
		end
		Object.Parent = Parent
		return Object
	end

	local function NewText(Properties, Parent)
		local Label = New("TextLabel", {
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 14,
			TextColor3 = CardText,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, nil)
		for Property, Value in Properties do
			Label[Property] = Value
		end
		Label.Parent = Parent
		return Label
	end

	local function CreateCard()
		local Billboard = New("BillboardGui", {
			Name = HttpService:GenerateGUID(false),
			AlwaysOnTop = true,
			LightInfluence = 0,
			Size = UDim2.fromOffset(236, 104),
			StudsOffsetWorldSpace = Vector3.new(0, 5.5, 0),
			Enabled = false,
		}, CoreGui)

		local Frame = New("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(15, 15, 19),
			BackgroundTransparency = 0.08,
			BorderSizePixel = 0,
		}, Billboard)
		New("UICorner", { CornerRadius = UDim.new(0, 12) }, Frame)
		New("UIGradient", {
			Rotation = 90,
			Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(190, 190, 205)),
		}, Frame)
		local Stroke = New("UIStroke", { Thickness = 1, Transparency = 0.5 }, Frame)
		local Scale = New("UIScale", { Scale = 1 }, Frame)

		local Glow = New("Frame", {
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, 0),
			Size = UDim2.new(0.55, 0, 0, 2),
			BorderSizePixel = 0,
		}, Frame)
		New("UICorner", { CornerRadius = UDim.new(1, 0) }, Glow)
		New("UIGradient", {
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(1, 1),
			}),
		}, Glow)

		local Avatar = New("Frame", {
			Position = UDim2.fromOffset(12, 11),
			Size = UDim2.fromOffset(34, 34),
			BackgroundColor3 = Color3.fromRGB(32, 32, 40),
			BorderSizePixel = 0,
		}, Frame)
		New("UICorner", { CornerRadius = UDim.new(1, 0) }, Avatar)
		local AvatarStroke = New("UIStroke", { Thickness = 1.5, Transparency = 0.2 }, Avatar)
		local Initial = NewText({
			Size = UDim2.fromScale(1, 1),
			TextSize = 15,
			TextXAlignment = Enum.TextXAlignment.Center,
		}, Avatar)
		local Image = New("ImageLabel", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		}, Avatar)
		New("UICorner", { CornerRadius = UDim.new(1, 0) }, Image)

		local Name = NewText({
			Position = UDim2.fromOffset(55, 11),
			Size = UDim2.new(1, -150, 0, 17),
		}, Frame)
		local Detail = NewText({
			Position = UDim2.fromOffset(55, 29),
			Size = UDim2.new(1, -67, 0, 14),
			Font = Enum.Font.GothamMedium,
			TextSize = 11,
			TextColor3 = CardMuted,
		}, Frame)

		local Badge = New("Frame", {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -12, 0, 11),
			Size = UDim2.fromOffset(0, 18),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 0.82,
			BorderSizePixel = 0,
		}, Frame)
		New("UICorner", { CornerRadius = UDim.new(1, 0) }, Badge)
		New("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }, Badge)
		local BadgeText = NewText({
			Size = UDim2.fromOffset(0, 18),
			AutomaticSize = Enum.AutomaticSize.X,
			TextSize = 9,
			TextTruncate = Enum.TextTruncate.None,
			TextXAlignment = Enum.TextXAlignment.Center,
		}, Badge)

		New("Frame", {
			Position = UDim2.fromOffset(12, 54),
			Size = UDim2.new(1, -24, 0, 1),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 0.92,
			BorderSizePixel = 0,
		}, Frame)

		local Row = New("Frame", {
			Position = UDim2.fromOffset(12, 60),
			Size = UDim2.new(1, -24, 0, 30),
			BackgroundTransparency = 1,
		}, Frame)
		New("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}, Row)

		local Cells = {}
		for Order, Key in { "Power", "Angle", "Air", "Range" } do
			local Cell = New("Frame", { BackgroundTransparency = 1, LayoutOrder = Order, Size = UDim2.fromScale(0.25, 1) }, Row)
			local Value = NewText({ Size = UDim2.new(1, 0, 0, 17), TextSize = 15 }, Cell)
			NewText({
				Position = UDim2.fromOffset(0, 18),
				Size = UDim2.new(1, 0, 0, 11),
				Font = Enum.Font.GothamMedium,
				TextSize = 9,
				TextColor3 = CardMuted,
				Text = ({ Power = "POWER", Angle = "ANGLE", Air = "AIR TIME", Range = "DISTANCE" })[Key],
			}, Cell)
			Cells[Key] = { Frame = Cell, Value = Value }
		end

		local Track = New("Frame", {
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 12, 1, -7),
			Size = UDim2.new(1, -24, 0, 3),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 0.9,
			BorderSizePixel = 0,
		}, Frame)
		New("UICorner", { CornerRadius = UDim.new(1, 0) }, Track)
		local Fill = New("Frame", { Size = UDim2.fromScale(0, 1), BorderSizePixel = 0 }, Track)
		New("UICorner", { CornerRadius = UDim.new(1, 0) }, Fill)
		New("UIGradient", {
			Color = ColorSequence.new(Color3.fromRGB(170, 170, 185), Color3.new(1, 1, 1)),
		}, Fill)

		return {
			Billboard = Billboard, Stroke = Stroke, Scale = Scale, Glow = Glow, AvatarStroke = AvatarStroke, Initial = Initial, Image = Image,
			Name = Name, Detail = Detail, Badge = Badge, BadgeText = BadgeText, Cells = Cells, Fill = Fill,
			Target = nil, Power = 0, Angle = 0, Air = 0, Range = 0, Clock = os.clock(),
		}
	end

	local function UpdateCard(Card, Solution, Accent)
		local Now = os.clock()
		local Alpha = math.clamp((Now - Card.Clock) * 12, 0, 1)
		Card.Clock = Now

		local Target = Solution.Target
		local Humanoid, Root = GetTargetParts(Target)
		if Card.Target ~= Target then
			Card.Target = Target
			Card.Scale.Scale = 0.84
			Alpha = 1

			local Player = Players:GetPlayerFromCharacter(Target)
			Card.Name.Text = Player and Player.DisplayName or Target.Name
			Card.Initial.Text = string.upper(string.sub(Target.Name, 1, 1))
			Card.Image.Image = Player and string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=48&h=48", Player.UserId) or ""
		end
		Card.Scale.Scale += (1 - Card.Scale.Scale) * math.clamp(Alpha * 1.2, 0, 1)
		Card.Billboard.Adornee = Target:FindFirstChild("Head") or Root
		Card.Billboard.Enabled = true

		local BadgeLabel, BadgeColor = nil, Accent
		if Solution.OutOfRange then
			BadgeLabel, BadgeColor = "OUT OF RANGE", CardRed
		elseif Solution.Sideline then
			BadgeLabel, BadgeColor = "SIDELINE", CardAmber
		elseif Settings.LockedTarget == Target then
			BadgeLabel = "LOCKED"
		elseif LocalPlayer.Team and Root and not IsPractice then
			if GetDefenderDistance(Root.Position) >= 12 then
				BadgeLabel, BadgeColor = "OPEN", CardGreen
			else
				BadgeLabel, BadgeColor = "COVERED", CardAmber
			end
		end
		Card.Badge.Visible = BadgeLabel ~= nil
		Card.Name.Size = UDim2.new(1, BadgeLabel and -160 or -67, 0, 17)
		Card.Badge.BackgroundColor3 = BadgeColor
		Card.BadgeText.Text = BadgeLabel or ""
		Card.BadgeText.TextColor3 = BadgeColor

		Card.Stroke.Color = Accent
		Card.Glow.BackgroundColor3 = Accent
		Card.AvatarStroke.Color = Accent
		Card.Fill.BackgroundColor3 = Accent
		local Detail = Settings.ShowRoutes and (Solution.ThrowType .. "  ·  " .. Solution.Route) or Solution.ThrowType
		if Solution.ExpectedMiss then
			Detail ..= string.format("  ·  %s ±%d", Solution.Steady and "steady" or "breaking", math.round(Solution.ExpectedMiss))
		end
		Card.Detail.Text = Detail

		Card.Cells.Range.Frame.Visible = Settings.ShowDistance
		local Width = Settings.ShowDistance and 0.25 or (1 / 3)
		for Key, Cell in Card.Cells do
			Cell.Frame.Size = UDim2.fromScale(Width, 1)
		end

		if Solution.OutOfRange then
			for Key, Cell in Card.Cells do
				Cell.Value.Text = "--"
				Cell.Value.TextColor3 = CardMuted
			end
			Card.Power = 0
		else
			Card.Power += (Solution.Power - Card.Power) * Alpha
			Card.Angle += (math.deg(Solution.Angle) - Card.Angle) * Alpha
			Card.Air += (Solution.Time - Card.Air) * Alpha
			Card.Range += (Solution.Range - Card.Range) * Alpha

			Card.Cells.Power.Value.Text = string.format("%d", math.round(Card.Power))
			Card.Cells.Angle.Value.Text = string.format("%d°", math.round(Card.Angle))
			Card.Cells.Air.Value.Text = string.format("%.1fs", Card.Air)
			Card.Cells.Range.Value.Text = string.format("%d", math.round(Card.Range))
			for Key, Cell in Card.Cells do
				Cell.Value.TextColor3 = CardText
			end
		end
		Card.Fill.Size = UDim2.fromScale(math.clamp(Card.Power / MaxPower, 0, 1), 1)
	end

	local function CreateVisuals()
		local Attachment0, Attachment1 = Instance.new("Attachment"), Instance.new("Attachment")
		Attachment0.Parent = workspace.Terrain
		Attachment1.Parent = workspace.Terrain

		local Beam = Instance.new("Beam")
		Beam.Attachment0 = Attachment0
		Beam.Attachment1 = Attachment1
		Beam.Segments = 60
		Beam.Width0 = 0.35
		Beam.Width1 = 0.35
		Beam.LightEmission = 1
		Beam.LightInfluence = 0
		Beam.FaceCamera = true
		Beam.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.08, 0.15),
			NumberSequenceKeypoint.new(1, 0.15),
		})
		Beam.Parent = workspace.Terrain

		local Marker = Instance.new("Part")
		Marker.Name = HttpService:GenerateGUID(false)
		Marker.Shape = Enum.PartType.Ball
		Marker.Material = Enum.Material.Neon
		Marker.Size = Vector3.new(1.2, 1.2, 1.2)
		Marker.Anchored = true
		Marker.CanCollide = false
		Marker.CanTouch = false
		Marker.CanQuery = false
		Marker.CastShadow = false
		Marker.Parent = workspace

		local Landing = Instance.new("Part")
		Landing.Name = HttpService:GenerateGUID(false)
		Landing.Shape = Enum.PartType.Cylinder
		Landing.Material = Enum.Material.Neon
		Landing.Size = Vector3.new(0.12, 3, 3)
		Landing.Anchored = true
		Landing.CanCollide = false
		Landing.CanTouch = false
		Landing.CanQuery = false
		Landing.CastShadow = false
		Landing.Parent = workspace

		local Highlight = Instance.new("Highlight")
		Highlight.Name = HttpService:GenerateGUID(false)
		Highlight.FillTransparency = 0.8
		Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		Highlight.Parent = CoreGui

		return { Attachment0 = Attachment0, Attachment1 = Attachment1, Beam = Beam, Marker = Marker, Landing = Landing, Card = CreateCard(), Highlight = Highlight }
	end

	local function HideVisuals()
		if Visuals then
			Visuals.Beam.Enabled = false
			Visuals.Card.Billboard.Enabled = false
			Visuals.Card.Target = nil
			Visuals.Marker.Transparency = 1
			Visuals.Landing.Transparency = 1
			Visuals.Highlight.Adornee = nil
		end
	end

	local function UpdateVisuals(Solution)
		Visuals = Visuals or CreateVisuals()

		local Color = Solution.OutOfRange and Color3.fromRGB(255, 80, 80) or Settings.PredictionColor
		Visuals.Marker.Color = Color
		Visuals.Marker.Transparency = 0.2
		Visuals.Marker.Position = Solution.Aim
		Visuals.Highlight.Adornee = Settings.ReceiverEsp and Solution.Target or nil
		Visuals.Highlight.FillColor = Color
		Visuals.Highlight.OutlineColor = Color

		UpdateCard(Visuals.Card, Solution, Color)

		if Settings.BeamMode and not Solution.OutOfRange then
			Visuals.Landing.Color = Color
			Visuals.Landing.Transparency = 0.45
			Visuals.Landing.CFrame = CFrame.new(Solution.Landing.X, RestHeight - 0.3, Solution.Landing.Z) * CFrame.Angles(0, 0, math.pi / 2)
		else
			Visuals.Landing.Transparency = 1
		end

		if Settings.BeamMode and not Solution.OutOfRange then
			local Curve0, Curve1, CFrame1, CFrame2 = BeamProjectile(Solution.Velocity, Solution.Origin, Solution.LandTime)
			Visuals.Attachment0.CFrame = CFrame1
			Visuals.Attachment1.CFrame = CFrame2
			Visuals.Beam.CurveSize0 = Curve0
			Visuals.Beam.CurveSize1 = Curve1
			Visuals.Beam.Color = ColorSequence.new(Color)
			Visuals.Beam.Enabled = true
		else
			Visuals.Beam.Enabled = false
		end
	end

	local CurrentSolution = nil

	RunService.RenderStepped:Connect(function()
		local Character = LocalPlayer.Character
		local Head = Character and Character:FindFirstChild("Head")
		local MyRoot = Character and Character:FindFirstChild("HumanoidRootPart")
		if not Settings.Enabled or not Head or not MyRoot or not GetThrowRemote(Character) then
			CurrentSolution = nil
			HideVisuals()
			return
		end

		for Index, Model in GetReceivers() do
			local Humanoid, Root = GetTargetParts(Model)
			if Root then
				TrackMotion(Model, Humanoid, Root)
			end
		end

		local Target = PickTarget(MyRoot)
		if Target and Settings.TargetLock and not Settings.LockedTarget then
			Settings.LockedTarget = Target
		end

		CurrentSolution = Target and BuildSolution(Target, MyRoot, Head) or nil
		if CurrentSolution then
			UpdateVisuals(CurrentSolution)
		else
			HideVisuals()
		end
	end)

	local function TryThrow()
		local Character = LocalPlayer.Character
		local Solution = CurrentSolution
		if not Settings.Enabled or not Solution or Solution.OutOfRange or not IsReadyToThrow(Character) then
			return
		end
		FireThrow(Character, Solution)
	end

	UserInputService.InputBegan:Connect(function(Input, GameProcessed)
		if not GameProcessed and Input.UserInputType == Enum.UserInputType.MouseButton1 then
			TryThrow()
		end
	end)

	if IsMobile then
		UserInputService.TouchTapInWorld:Connect(function(Position, GameProcessed)
			if not GameProcessed then
				TryThrow()
			end
		end)
	end
end

do
	local GroundHeight = 3
	local RestHeight = 3.4
	local PathObjects = {}
	local PathConnection = nil

	local function BeamProjectile(Gravity, Velocity, Origin, Time)
		local C = 0.5 * 0.5 * 0.5
		local P3 = 0.5 * Gravity * Time * Time + Velocity * Time + Origin
		local P2 = P3 - (Gravity * Time * Time + Velocity * Time) / 3
		local P1 = (C * Gravity * Time * Time + 0.5 * Velocity * Time + Origin - C * (Origin + P3)) / (3 * C) - P2

		local Curve0 = (P1 - Origin).Magnitude
		local Curve1 = (P2 - P3).Magnitude

		local B = (Origin - P3).Unit
		local R1 = (P1 - Origin).Unit
		local U1 = R1:Cross(B).Unit
		local R2 = (P2 - P3).Unit
		local U2 = R2:Cross(B).Unit
		B = U1:Cross(R1).Unit

		local CFrame1 = CFrame.new(
			Origin.X, Origin.Y, Origin.Z,
			R1.X, U1.X, B.X,
			R1.Y, U1.Y, B.Y,
			R1.Z, U1.Z, B.Z
		)

		local CFrame2 = CFrame.new(
			P3.X, P3.Y, P3.Z,
			R2.X, U2.X, B.X,
			R2.Y, U2.Y, B.Y,
			R2.Z, U2.Z, B.Z
		)

		return Curve0, -Curve1, CFrame1, CFrame2
	end

	local RevealTime = 0.45
	local FadeTime = 0.35
	local White = Color3.new(1, 1, 1)

	local function StopBallPath()
		if PathConnection then
			PathConnection:Disconnect()
			PathConnection = nil
		end
		for Index, Object in PathObjects do
			Object:Destroy()
		end
		table.clear(PathObjects)
	end

	local function BuildTransparency(Base, Reveal, Fade)
		local Body = Base + (1 - Base) * Fade
		if Reveal >= 0.999 then
			return NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.06, Body),
				NumberSequenceKeypoint.new(0.9, Body),
				NumberSequenceKeypoint.new(1, 1),
			})
		end
		local Edge = math.clamp(Reveal, 0.08, 0.98)
		return NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.06, Body),
			NumberSequenceKeypoint.new(Edge - 0.01, Body),
			NumberSequenceKeypoint.new(Edge, 1),
			NumberSequenceKeypoint.new(1, 1),
		})
	end

	local function BuildColor(Color0, Color1, Shine)
		local Center = 0.1 + 0.8 * Shine
		return ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color0),
			ColorSequenceKeypoint.new(Center - 0.07, Color0:Lerp(Color1, Center - 0.07)),
			ColorSequenceKeypoint.new(Center, Color0:Lerp(Color1, Center):Lerp(White, 0.8)),
			ColorSequenceKeypoint.new(Center + 0.07, Color0:Lerp(Color1, Center + 0.07)),
			ColorSequenceKeypoint.new(1, Color1),
		})
	end

	local function CreateBeam(Attachment0, Attachment1, Curve0, Curve1, Width0, Width1)
		local Beam = Instance.new("Beam")
		Beam.Attachment0 = Attachment0
		Beam.Attachment1 = Attachment1
		Beam.Segments = 100
		Beam.Width0 = Width0
		Beam.Width1 = Width1
		Beam.CurveSize0 = Curve0
		Beam.CurveSize1 = Curve1
		Beam.LightEmission = 1
		Beam.LightInfluence = 0
		Beam.FaceCamera = true
		Beam.Transparency = NumberSequence.new(1)
		Beam.Parent = workspace.Terrain
		return Beam
	end

	local function StartBallPath(Ball)
		StopBallPath()

		if not Aural.Visuals.ThrownBallBeam then
			return
		end
		if not Ball or not Ball:IsA("BasePart") or Ball.Name ~= "Football" then
			return
		end
		if Ball.AssemblyLinearVelocity.Magnitude < 1 then
			return
		end

		local Configuration = Ball:FindFirstChild("Configuration")
		local GravityValue = Configuration and Configuration:FindFirstChild("Gravity")
		local Gravity = Vector3.new(0, GravityValue and GravityValue.Value or -28, 0)
		local LaunchVelocity = Ball.AssemblyLinearVelocity

		local Fall = math.max(-Gravity.Y, 1)
		local TrueLaunchY = LaunchVelocity.Y + (IsPractice and 0.82 or 0.467)
		local FitStart = os.clock()
		local Count, SumT, SumTT, SumY, SumTY, SumX, SumZ = 0, 0, 0, 0, 0, 0, 0
		local LastSample = nil

		local function AddSample()
			local Position = Ball.Position
			if LastSample and (Position - LastSample).Magnitude < 0.01 then
				return
			end
			LastSample = Position

			local Time = os.clock() - FitStart
			local Height = Position.Y + 0.5 * Fall * Time * Time
			Count += 1
			SumT += Time
			SumTT += Time * Time
			SumY += Height
			SumTY += Time * Height
			SumX += Position.X - LaunchVelocity.X * Time
			SumZ += Position.Z - LaunchVelocity.Z * Time
		end

		local function SolvePath()
			local Slope = TrueLaunchY - Fall * 0.04
			local Mean = SumT / Count
			if Count >= 8 and SumTT / Count - Mean * Mean > 0.005 then
				Slope = (Count * SumTY - SumT * SumY) / (Count * SumTT - SumT * SumT)
			end
			local Base = Vector3.new(SumX / Count, (SumY - Slope * SumT) / Count, SumZ / Count)

			local LaunchTime = math.clamp((Slope - TrueLaunchY) / Fall, -0.5, 0)
			local Origin = Base + Vector3.new(LaunchVelocity.X, Slope, LaunchVelocity.Z) * LaunchTime - Vector3.new(0, 0.5 * Fall * LaunchTime * LaunchTime, 0)
			local Velocity = Vector3.new(LaunchVelocity.X, Slope - Fall * LaunchTime, LaunchVelocity.Z)

			local AirTime = 2
			local Discriminant = Velocity.Y * Velocity.Y + 2 * Fall * (Origin.Y - RestHeight)
			if Discriminant > 0 then
				AirTime = math.max((Velocity.Y + math.sqrt(Discriminant)) / Fall, 0.05)
			end
			return Origin, Velocity, AirTime, LaunchTime
		end

		AddSample()
		local Origin, PathVelocity, AirTime, LaunchTime = SolvePath()
		local Curve0, Curve1, CFrame1, CFrame2 = BeamProjectile(Gravity, PathVelocity, Origin, AirTime)

		local Attachment0 = Instance.new("Attachment")
		Attachment0.CFrame = CFrame1
		Attachment0.Parent = workspace.Terrain

		local Attachment1 = Instance.new("Attachment")
		Attachment1.CFrame = CFrame2
		Attachment1.Parent = workspace.Terrain

		local Core = CreateBeam(Attachment0, Attachment1, Curve0, Curve1, 0.45, 0.2)
		local Glow = CreateBeam(Attachment0, Attachment1, Curve0, Curve1, 2.4, 1.2)
		local Flow = CreateBeam(Attachment0, Attachment1, Curve0, Curve1, 1.1, 0.6)
		Flow.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		Flow.TextureMode = Enum.TextureMode.Wrap
		Flow.TextureLength = 5
		Flow.TextureSpeed = 1.6

		local Landing = CFrame2.Position
		local Marker = Instance.new("Part")
		Marker.Name = HttpService:GenerateGUID(false)
		Marker.Shape = Enum.PartType.Cylinder
		Marker.Material = Enum.Material.Neon
		Marker.Anchored = true
		Marker.CanCollide = false
		Marker.CanTouch = false
		Marker.CanQuery = false
		Marker.CastShadow = false
		Marker.Transparency = 1
		Marker.Size = Vector3.new(0.12, 3, 3)
		Marker.CFrame = CFrame.new(Landing.X, GroundHeight + 0.1, Landing.Z) * CFrame.Angles(0, 0, math.pi / 2)
		Marker.Parent = workspace

		PathObjects = { Attachment0, Attachment1, Core, Glow, Flow, Marker }

		local Started = os.clock()
		local FadeStarted = nil

		PathConnection = RunService.Heartbeat:Connect(function()
			local Now = os.clock()
			local Landed = Ball.Parent ~= nil and (Ball.Position.Y < RestHeight - 1 or Now - FitStart > LaunchTime + AirTime + 0.25)
			local Ended = not Aural.Visuals.ThrownBallBeam or not Ball.Parent or Landed or (Ball.AssemblyLinearVelocity - LaunchVelocity).Magnitude > 1
			if Ended and not FadeStarted then
				FadeStarted = Now
			end

			if not FadeStarted then
				AddSample()
				Origin, PathVelocity, AirTime, LaunchTime = SolvePath()
				Curve0, Curve1, CFrame1, CFrame2 = BeamProjectile(Gravity, PathVelocity, Origin, AirTime)
				Attachment0.CFrame = CFrame1
				Attachment1.CFrame = CFrame2
				for Index, Beam in { Core, Glow, Flow } do
					Beam.CurveSize0 = Curve0
					Beam.CurveSize1 = Curve1
				end
				Landing = CFrame2.Position
				Marker.CFrame = CFrame.new(Landing.X, GroundHeight + 0.1, Landing.Z) * CFrame.Angles(0, 0, math.pi / 2)
			end

			local Fade = FadeStarted and math.clamp((Now - FadeStarted) / FadeTime, 0, 1) or 0
			if Fade >= 1 then
				StopBallPath()
				return
			end

			local Linear = math.clamp((Now - Started) / RevealTime, 0, 1)
			local Reveal = 1 - (1 - Linear) ^ 3
			local Pulse = 0.5 + 0.5 * math.sin(Now * 5)
			local Shine = (Now * 0.7) % 1

			local Color0, Color1 = Aural.Visuals.ThrownBallBeamColor, Aural.Visuals.ThrownBallBeamColor2
			local Colors = BuildColor(Color0, Color1, Shine)

			Core.Color = Colors
			Core.Transparency = BuildTransparency(0, Reveal, Fade)
			Glow.Color = Colors
			Glow.Transparency = BuildTransparency(0.8 + 0.06 * Pulse, Reveal, Fade)
			Flow.Color = Colors
			Flow.Transparency = BuildTransparency(0.35, Reveal, Fade)

			local Diameter = 2.6 + 1.6 * Pulse
			Marker.Color = Color1
			Marker.Size = Vector3.new(0.12, Diameter, Diameter)
			Marker.Transparency = 1 - (0.55 - 0.3 * Pulse) * Linear * (1 - Fade)
		end)
	end

	workspace.ChildAdded:Connect(function(Ball)
		if not Aural.Visuals.ThrownBallBeam then
			return
		end
		if not Ball:IsA("BasePart") or Ball.Name ~= "Football" then
			return
		end

		task.wait()
		StartBallPath(Ball)
	end)
end

do
	local function GetKickTrigger()
		if not (getconnections and debug.getupvalues and debug.setupvalue) then
			return nil
		end
		for Index, SignalName in { "InputBegan", "TouchTap" } do
			for Index, Connection in getconnections(UserInputService[SignalName]) do
				local Function = Connection.Function
				if Function and islclosure(Function) then
					local Source = debug.info(Function, "s")
					if Source and string.find(Source, "KickerScript") then
						local Upvalues = debug.getupvalues(Function)
						if typeof(Upvalues[1]) == "boolean" and typeof(Upvalues[2]) == "boolean" then
							return function()
								debug.setupvalue(Function, 2, true)
							end
						end
					end
				end
			end
		end
		return nil
	end

	local function GetPowerTarget(KickerGui, Masks)
		local Power = Aural.Automatics.KickerAimPower
		local Section = Power >= 90 and 4 or Power >= 65 and 3 or Power >= 25 and 2 or 1
		local Mask = Masks:FindFirstChild("s" .. Section)
		if not Mask or KickerGui.AbsoluteSize.X <= 0 then
			return 0.5
		end
		local Center = (Mask.AbsolutePosition.X + Mask.AbsoluteSize.X / 2) / KickerGui.AbsoluteSize.X
		return math.clamp(Center, 0.12, 0.88)
	end

	local function FindKickerParts(KickerGui)
		local Frame = KickerGui:WaitForChild("Frame", 5)
		if not Frame then
			return nil, nil
		end

		local Masks, Candidates = nil, {}
		local Deadline = os.clock() + 2
		repeat
			Masks, Candidates = nil, {}
			for Index, Child in Frame:GetChildren() do
				if Child:IsA("Frame") then
					if Child:FindFirstChild("s4") then
						Masks = Child
					else
						table.insert(Candidates, Child)
					end
				end
			end
			if not Masks or #Candidates == 0 then
				task.wait()
			end
		until (Masks and #Candidates > 0) or os.clock() > Deadline
		if not Masks or #Candidates == 0 then
			return nil, nil
		end
		if #Candidates == 1 then
			return Candidates[1], Masks
		end

		local Start = {}
		for Index, Candidate in Candidates do
			Start[Candidate] = Candidate.Position.X.Scale
		end
		Deadline = os.clock() + 2
		while os.clock() < Deadline and KickerGui.Parent do
			RunService.Heartbeat:Wait()
			for Index, Candidate in Candidates do
				if math.abs(Candidate.Position.X.Scale - Start[Candidate]) > 0.001 then
					return Candidate, Masks
				end
			end
		end
		return nil, nil
	end

	local function GetInputTrigger()
		local Ok, VirtualInputManager = pcall(game.GetService, game, "VirtualInputManager")
		if not Ok or not VirtualInputManager then
			return mouse1click
		end

		local function FreePoint()
			local Viewport = workspace.CurrentCamera.ViewportSize
			local Inset = GuiService:GetGuiInset()
			for Index, Scale in { Vector2.new(0.5, 0.35), Vector2.new(0.3, 0.3), Vector2.new(0.7, 0.3), Vector2.new(0.5, 0.6), Vector2.new(0.2, 0.55), Vector2.new(0.8, 0.55) } do
				local Point = Viewport * Scale
				local Blocked = false
				for Index, Root in { LocalPlayer.PlayerGui, CoreGui } do
					local Found, Objects = pcall(Root.GetGuiObjectsAtPosition, Root, Point.X, Point.Y - Inset.Y)
					if Found then
						for Index, Object in Objects do
							if Object.Visible and (Object:IsA("GuiButton") or Object.Active) then
								Blocked = true
								break
							end
						end
					end
				end
				if not Blocked then
					return Point
				end
			end
			return Viewport * Vector2.new(0.5, 0.35)
		end

		local UsesMouse = UserInputService.GamepadEnabled or LocalPlayer:GetAttribute("JoinMouse")
		return function()
			local Point = FreePoint()
			pcall(function()
				if UsesMouse then
					VirtualInputManager:SendMouseButtonEvent(Point.X, Point.Y, 0, true, game, 1)
					VirtualInputManager:SendMouseButtonEvent(Point.X, Point.Y, 0, false, game, 1)
				else
					VirtualInputManager:SendTouchEvent(1, 0, Point.X, Point.Y)
					VirtualInputManager:SendTouchEvent(1, 2, Point.X, Point.Y)
				end
			end)
		end
	end

	local function AutoKickCallback(KickerGui)
		local Started = os.clock()
		local Cursor, Masks = FindKickerParts(KickerGui)
		if not Cursor or not Masks then
			return
		end

		local Trigger
		local Deadline = os.clock() + 0.6
		repeat
			Trigger = GetKickTrigger()
			if not Trigger then
				task.wait()
			end
		until Trigger or os.clock() > Deadline
		Trigger = Trigger or GetInputTrigger()
		if not Trigger then
			return
		end

		local function ClickAt(Target)
			local Last = Cursor.Position.X.Scale
			while KickerGui.Parent do
				RunService.Heartbeat:Wait()
				local X = Cursor.Position.X.Scale
				local Step = math.abs(X - Last)
				Last = X
				if Step > 0 and math.abs(X - Target) <= Step / 2 + 0.0005 then
					Trigger()
					return true
				end
			end
			return false
		end

		local function WaitUntil(Predicate)
			while KickerGui.Parent do
				if Predicate(Cursor.Position.X.Scale) then
					return true
				end
				RunService.Heartbeat:Wait()
			end
			return false
		end

		while os.clock() - Started < 0.65 do
			task.wait()
		end

		if not ClickAt(GetPowerTarget(KickerGui, Masks)) then
			return
		end
		if not WaitUntil(function(X) return X < 0.1 or X > 0.9 end) then
			return
		end
		if not WaitUntil(function(X) return X >= 0.1 and X <= 0.9 end) then
			return
		end

		ClickAt(0.5 + (100 - Aural.Automatics.KickerAimAccuracy) / 100 * 0.051)
	end

	LocalPlayer.PlayerGui.ChildAdded:Connect(function(Child)
		if Child.Name == "KickerGui" and Aural.Automatics.KickerAim then
			AutoKickCallback(Child)
		end
	end)
end
