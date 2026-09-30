local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

--------------------------------------------------
-- SETTINGS
--------------------------------------------------

local walkSpeed = 16
local jumpPower = 50
local flySpeed = 60

local flying = false
local noclip = false
local espEnabled = false

local flyConnection
local noclipConnection

local espObjects = {}

--------------------------------------------------
-- GUI
--------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "PlaymegamarbleMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--------------------------------------------------
-- MAIN MENU
--------------------------------------------------

local menu = Instance.new("Frame")
menu.Name = "MainMenu"
menu.Size = UDim2.new(0, 300, 0, 360)
menu.Position = UDim2.new(0.5, -150, 0.5, -180)
menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menu.BorderSizePixel = 0
menu.Parent = gui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 15)
menuCorner.Parent = menu

--------------------------------------------------
-- TITLE
--------------------------------------------------

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 50)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "PLAYMEGAMARBLE"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = menu

--------------------------------------------------
-- MINIMIZE
--------------------------------------------------

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 40, 0, 35)
minimizeButton.Position = UDim2.new(1, -50, 0, 10)
minimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeButton.Text = "—"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.TextScaled = true
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = menu

--------------------------------------------------
-- REOPEN
--------------------------------------------------

local reopenButton = Instance.new("TextButton")
reopenButton.Size = UDim2.new(0, 60, 0, 45)
reopenButton.Position = UDim2.new(0, 15, 0.5, -22)
reopenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
reopenButton.Text = "☰"
reopenButton.TextColor3 = Color3.new(1, 1, 1)
reopenButton.TextScaled = true
reopenButton.Font = Enum.Font.GothamBold
reopenButton.Visible = false
reopenButton.Parent = gui

local reopenCorner = Instance.new("UICorner")
reopenCorner.CornerRadius = UDim.new(0, 12)
reopenCorner.Parent = reopenButton

--------------------------------------------------
-- NAVIGATION
--------------------------------------------------

local nav = Instance.new("Frame")
nav.Size = UDim2.new(1, -20, 0, 45)
nav.Position = UDim2.new(0, 10, 0, 60)
nav.BackgroundTransparency = 1
nav.Parent = menu

local homeTab = Instance.new("TextButton")
homeTab.Size = UDim2.new(0.5, -5, 1, 0)
homeTab.Position = UDim2.new(0, 0, 0, 0)
homeTab.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
homeTab.Text = "HOME"
homeTab.TextColor3 = Color3.new(1, 1, 1)
homeTab.TextScaled = true
homeTab.Font = Enum.Font.GothamBold
homeTab.Parent = nav

local miscTab = Instance.new("TextButton")
miscTab.Size = UDim2.new(0.5, -5, 1, 0)
miscTab.Position = UDim2.new(0.5, 5, 0, 0)
miscTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
miscTab.Text = "MISC"
miscTab.TextColor3 = Color3.new(1, 1, 1)
miscTab.TextScaled = true
miscTab.Font = Enum.Font.GothamBold
miscTab.Parent = nav

--------------------------------------------------
-- HOME PAGE
--------------------------------------------------

local homePage = Instance.new("Frame")
homePage.Size = UDim2.new(1, -20, 1, -145)
homePage.Position = UDim2.new(0, 10, 0, 115)
homePage.BackgroundTransparency = 1
homePage.Parent = menu

--------------------------------------------------
-- WALKSPEED
--------------------------------------------------

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.45, 0, 0, 40)
speedLabel.Position = UDim2.new(0, 0, 0, 15)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "WalkSpeed"
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.Gotham
speedLabel.Parent = homePage

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.35, 0, 0, 40)
speedBox.Position = UDim2.new(0.5, 0, 0, 15)
speedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedBox.Text = "16"
speedBox.TextColor3 = Color3.new(1, 1, 1)
speedBox.TextScaled = true
speedBox.Font = Enum.Font.Gotham
speedBox.ClearTextOnFocus = false
speedBox.Parent = homePage

local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(0.85, 0, 0, 40)
speedButton.Position = UDim2.new(0.075, 0, 0, 65)
speedButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
speedButton.Text = "SET WALKSPEED"
speedButton.TextColor3 = Color3.new(1, 1, 1)
speedButton.TextScaled = true
speedButton.Font = Enum.Font.GothamBold
speedButton.Parent = homePage

--------------------------------------------------
-- JUMPPOWER
--------------------------------------------------

local jumpLabel = Instance.new("TextLabel")
jumpLabel.Size = UDim2.new(0.45, 0, 0, 40)
jumpLabel.Position = UDim2.new(0, 0, 0, 120)
jumpLabel.BackgroundTransparency = 1
jumpLabel.Text = "JumpPower"
jumpLabel.TextColor3 = Color3.new(1, 1, 1)
jumpLabel.TextScaled = true
jumpLabel.Font = Enum.Font.Gotham
jumpLabel.Parent = homePage

local jumpBox = Instance.new("TextBox")
jumpBox.Size = UDim2.new(0.35, 0, 0, 40)
jumpBox.Position = UDim2.new(0.5, 0, 0, 120)
jumpBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
jumpBox.Text = "50"
jumpBox.TextColor3 = Color3.new(1, 1, 1)
jumpBox.TextScaled = true
jumpBox.Font = Enum.Font.Gotham
jumpBox.ClearTextOnFocus = false
jumpBox.Parent = homePage

local jumpButton = Instance.new("TextButton")
jumpButton.Size = UDim2.new(0.85, 0, 0, 40)
jumpButton.Position = UDim2.new(0.075, 0, 0, 170)
jumpButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
jumpButton.Text = "SET JUMPPOWER"
jumpButton.TextColor3 = Color3.new(1, 1, 1)
jumpButton.TextScaled = true
jumpButton.Font = Enum.Font.GothamBold
jumpButton.Parent = homePage

--------------------------------------------------
-- MISC PAGE
--------------------------------------------------

local miscPage = Instance.new("Frame")
miscPage.Size = UDim2.new(1, -20, 1, -145)
miscPage.Position = UDim2.new(0, 10, 0, 115)
miscPage.BackgroundTransparency = 1
miscPage.Visible = false
miscPage.Parent = menu

--------------------------------------------------
-- FLY
--------------------------------------------------

local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0.85, 0, 0, 40)
flyButton.Position = UDim2.new(0.075, 0, 0, 10)
flyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
flyButton.Text = "FLY: OFF"
flyButton.TextColor3 = Color3.new(1, 1, 1)
flyButton.TextScaled = true
flyButton.Font = Enum.Font.GothamBold
flyButton.Parent = miscPage

--------------------------------------------------
-- FLY SPEED
--------------------------------------------------

local flySpeedLabel = Instance.new("TextLabel")
flySpeedLabel.Size = UDim2.new(0.45, 0, 0, 40)
flySpeedLabel.Position = UDim2.new(0, 0, 0, 65)
flySpeedLabel.BackgroundTransparency = 1
flySpeedLabel.Text = "Fly Speed"
flySpeedLabel.TextColor3 = Color3.new(1, 1, 1)
flySpeedLabel.TextScaled = true
flySpeedLabel.Font = Enum.Font.Gotham
flySpeedLabel.Parent = miscPage

local flySpeedBox = Instance.new("TextBox")
flySpeedBox.Size = UDim2.new(0.35, 0, 0, 40)
flySpeedBox.Position = UDim2.new(0.5, 0, 0, 65)
flySpeedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
flySpeedBox.Text = "60"
flySpeedBox.TextColor3 = Color3.new(1, 1, 1)
flySpeedBox.TextScaled = true
flySpeedBox.Font = Enum.Font.Gotham
flySpeedBox.ClearTextOnFocus = false
flySpeedBox.Parent = miscPage

--------------------------------------------------
-- ESP
--------------------------------------------------

local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(0.85, 0, 0, 40)
espButton.Position = UDim2.new(0.075, 0, 0, 120)
espButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espButton.Text = "ESP: OFF"
espButton.TextColor3 = Color3.new(1, 1, 1)
espButton.TextScaled = true
espButton.Font = Enum.Font.GothamBold
espButton.Parent = miscPage

--------------------------------------------------
-- NOCLIP
--------------------------------------------------

local noclipButton = Instance.new("TextButton")
noclipButton.Size = UDim2.new(0.85, 0, 0, 40)
noclipButton.Position = UDim2.new(0.075, 0, 0, 175)
noclipButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
noclipButton.Text = "NOCLIP: OFF"
noclipButton.TextColor3 = Color3.new(1, 1, 1)
noclipButton.TextScaled = true
noclipButton.Font = Enum.Font.GothamBold
noclipButton.Parent = miscPage

--------------------------------------------------
-- NAVIGATION
--------------------------------------------------

homeTab.MouseButton1Click:Connect(function()
	homePage.Visible = true
	miscPage.Visible = false

	homeTab.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	miscTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

miscTab.MouseButton1Click:Connect(function()
	homePage.Visible = false
	miscPage.Visible = true

	miscTab.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	homeTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

--------------------------------------------------
-- MOVEMENT
--------------------------------------------------

local function applyMovement()

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.WalkSpeed = walkSpeed
		humanoid.UseJumpPower = true
		humanoid.JumpPower = jumpPower
	end
end

speedButton.MouseButton1Click:Connect(function()

	local value = tonumber(speedBox.Text)

	if value then
		walkSpeed = math.clamp(value, 0, 250)
		speedBox.Text = tostring(walkSpeed)
		applyMovement()
	end
end)

jumpButton.MouseButton1Click:Connect(function()

	local value = tonumber(jumpBox.Text)

	if value then
		jumpPower = math.clamp(value, 0, 250)
		jumpBox.Text = tostring(jumpPower)
		applyMovement()
	end
end)

--------------------------------------------------
-- FLY
-- MOBILE JOYSTICK + WASD
--------------------------------------------------

local function stopFlying()

	flying = false
	flyButton.Text = "FLY: OFF"

	if flyConnection then
		flyConnection:Disconnect()
		flyConnection = nil
	end

	local character = player.Character

	if character then

		local humanoid =
			character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid.PlatformStand = false
			humanoid.AutoRotate = true
		end
	end
end

local function startFlying()

	local character = player.Character

	if not character then return end

	local root =
		character:WaitForChild("HumanoidRootPart")

	local humanoid =
		character:WaitForChild("Humanoid")

	flying = true
	flyButton.Text = "FLY: ON"

	humanoid.PlatformStand = true
	humanoid.AutoRotate = false

	flyConnection = RunService.RenderStepped:Connect(function()

		if not flying or not root.Parent then
			stopFlying()
			return
		end

		-- MoveDirection comes from:
		-- PC: WASD
		-- Mobile: Roblox joystick

		local direction = humanoid.MoveDirection

		if direction.Magnitude > 0 then

			root.AssemblyLinearVelocity =
				direction.Unit * flySpeed

			root.CFrame = CFrame.lookAt(
				root.Position,
				root.Position + direction
			)

		else

			root.AssemblyLinearVelocity =
				Vector3.zero

		end
	end)
end

flyButton.MouseButton1Click:Connect(function()

	if flying then
		stopFlying()
	else
		startFlying()
	end
end)

--------------------------------------------------
-- FLY SPEED
--------------------------------------------------

flySpeedBox.FocusLost:Connect(function()

	local value = tonumber(flySpeedBox.Text)

	if value then
		flySpeed = math.clamp(value, 1, 250)
		flySpeedBox.Text = tostring(flySpeed)
	end
end)

--------------------------------------------------
-- ESP
-- USERNAME + HEALTH
--------------------------------------------------

local function addESP(target)

	if target == player then return end

	local character = target.Character

	if not character then return end

	if espObjects[target] then
		return
	end

	local humanoid =
		character:FindFirstChildOfClass("Humanoid")

	if not humanoid then return end

	--------------------------------------------------
	-- HIGHLIGHT
	--------------------------------------------------

	local highlight = Instance.new("Highlight")

	highlight.Name = "PlayerESP"
	highlight.FillColor = Color3.fromRGB(255, 0, 0)
	highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 0
	highlight.Adornee = character
	highlight.Parent = character

	--------------------------------------------------
	-- NAME + HEALTH
	--------------------------------------------------

	local billboard = Instance.new("BillboardGui")

	billboard.Name = "ESPInfo"
	billboard.Size = UDim2.new(0, 220, 0, 45)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Adornee = character
	billboard.Parent = character

	local label = Instance.new("TextLabel")

	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextStrokeTransparency = 0
	label.TextScaled = true
	label.Font = Enum.Font.GothamBold

	local function updateHealth()

		label.Text =
			target.Name ..
			" [" ..
			math.floor(humanoid.Health) ..
			"/" ..
			math.floor(humanoid.MaxHealth) ..
			"]"

	end

	updateHealth()

	label.Parent = billboard

	--------------------------------------------------
	-- HEALTH UPDATER
	--------------------------------------------------

	local healthConnection =
		humanoid.HealthChanged:Connect(updateHealth)

	espObjects[target] = {
		highlight = highlight,
		billboard = billboard,
		healthConnection = healthConnection
	}
end

local function removeESP(target)

	local data = espObjects[target]

	if not data then return end

	if data.healthConnection then
		data.healthConnection:Disconnect()
	end

	if data.highlight then
		data.highlight:Destroy()
	end

	if data.billboard then
		data.billboard:Destroy()
	end

	espObjects[target] = nil
end

local function enableESP()

	espEnabled = true
	espButton.Text = "ESP: ON"

	for _, target in ipairs(Players:GetPlayers()) do
		addESP(target)
	end
end

local function disableESP()

	espEnabled = false
	espButton.Text = "ESP: OFF"

	for _, target in ipairs(Players:GetPlayers()) do
		removeESP(target)
	end
end

espButton.MouseButton1Click:Connect(function()

	if espEnabled then
		disableESP()
	else
		enableESP()
	end
end)

Players.PlayerAdded:Connect(function(target)

	target.CharacterAdded:Connect(function()

		if espEnabled then
			task.wait(0.5)
			addESP(target)
		end
	end)
end)

Players.PlayerRemoving:Connect(function(target)
	removeESP(target)
end)

--------------------------------------------------
-- NOCLIP
--------------------------------------------------

local function setNoclip(enabled)

	noclip = enabled

	if noclip then

		noclipButton.Text = "NOCLIP: ON"

		if noclipConnection then
			noclipConnection:Disconnect()
		end

		noclipConnection =
			RunService.Stepped:Connect(function()

				if not noclip then return end

				local character = player.Character

				if character then

					for _, part in
						ipairs(character:GetDescendants()) do

						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)

	else

		noclipButton.Text = "NOCLIP: OFF"

		if noclipConnection then
			noclipConnection:Disconnect()
			noclipConnection = nil
		end

		local character = player.Character

		if character then

			for _, part in
				ipairs(character:GetDescendants()) do

				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
	end
end

noclipButton.MouseButton1Click:Connect(function()
	setNoclip(not noclip)
end)

--------------------------------------------------
-- DRAG MENU
--------------------------------------------------

local dragging = false
local dragStart
local startPosition

title.Active = true

title.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then

		dragging = true
		dragStart = input.Position
		startPosition = menu.Position

		input.Changed:Connect(function()

			if input.UserInputState ==
				Enum.UserInputState.End then

				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then return end

	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseMovement then

		local delta =
			input.Position - dragStart

		menu.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

--------------------------------------------------
-- MINIMIZE / REOPEN
--------------------------------------------------

minimizeButton.MouseButton1Click:Connect(function()

	menu.Visible = false
	reopenButton.Visible = true
end)

reopenButton.MouseButton1Click:Connect(function()

	menu.Visible = true
	reopenButton.Visible = false
end)

--------------------------------------------------
-- CREDIT
--------------------------------------------------

local credit = Instance.new("TextLabel")

credit.Size = UDim2.new(1, 0, 0, 25)
credit.Position = UDim2.new(0, 0, 1, -30)
credit.BackgroundTransparency = 1
credit.Text = "Made By Playmegamarble"
credit.TextColor3 = Color3.fromRGB(180, 180, 180)
credit.TextScaled = true
credit.Font = Enum.Font.Gotham
credit.Parent = menu

--------------------------------------------------
-- KEEP MOVEMENT VALUES
--------------------------------------------------

RunService.Heartbeat:Connect(function()

	if player.Character then

		local humanoid =
			player.Character:FindFirstChildOfClass("Humanoid")

		if humanoid then

			humanoid.WalkSpeed = walkSpeed
			humanoid.UseJumpPower = true
			humanoid.JumpPower = jumpPower

		end
	end
end)

--------------------------------------------------
-- RESPAWN
--------------------------------------------------

player.CharacterAdded:Connect(function()

	task.wait(0.5)

	applyMovement()

	if noclip then
		setNoclip(true)
	end

	if espEnabled then

		for _, target in ipairs(Players:GetPlayers()) do

			if target ~= player then
				addESP(target)
			end
		end
	end
end)
