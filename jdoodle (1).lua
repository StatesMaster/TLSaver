-- Settings
local correctKey = "The_Leaks_Panel_3200"

-- Fonction utilitaire → choisit le bon parent
local function getGuiParent()
	if game:GetService("RunService"):IsStudio() then
		return game.Players.LocalPlayer:WaitForChild("PlayerGui")
	else
		return game:GetService("CoreGui")
	end
end

-- Fonction anim resize smooth
local function tweenSize(frame, size, time)
	local TweenService = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TweenService:Create(frame, tweenInfo, {Size = size})
	tween:Play()
end

-- GUI Principal (fenêtre de check key)
local gui = Instance.new("ScreenGui")
gui.Name = "LeaksMainPanel"
gui.Parent = getGuiParent()

-- Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 220)
frame.Position = UDim2.new(0.5, -175, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 10)

-- Drag variables
local dragging = false
local dragInput, dragStart, startPos

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "🔑 Enter a valid key to enter panel"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.new(1,1,1)
title.Parent = frame

local titleCorner = Instance.new("UICorner", title)
titleCorner.CornerRadius = UDim.new(0, 10)

-- Drag pour title
title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

title.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Minimize Button
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 25, 0, 25)
minBtn.Position = UDim2.new(1, -60, 0, 7)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
minBtn.Parent = frame
local minCorner = Instance.new("UICorner", minBtn)
minCorner.CornerRadius = UDim.new(0,4)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
	if minimized then
		tweenSize(frame, UDim2.new(0,350,0,220), 0.3)
		minimized = false
	else
		tweenSize(frame, UDim2.new(0,350,0,40), 0.3)
		minimized = true
	end
end)

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 7)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
closeBtn.Parent = frame
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0,4)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Input
local input = Instance.new("TextBox")
input.Size = UDim2.new(1, -40, 0, 35)
input.Position = UDim2.new(0, 20, 0, 60)
input.PlaceholderText = "Please enter key"
input.Text = ""
input.Font = Enum.Font.Gotham
input.TextSize = 16
input.TextColor3 = Color3.new(1,1,1)
input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
input.ClearTextOnFocus = false
input.Parent = frame

local inputCorner = Instance.new("UICorner", input)
inputCorner.CornerRadius = UDim.new(0, 6)

-- Enter Button
local enterBtn = Instance.new("TextButton")
enterBtn.Size = UDim2.new(1, -40, 0, 40)
enterBtn.Position = UDim2.new(0, 20, 0, 110)
enterBtn.Text = "Enter"
enterBtn.Font = Enum.Font.GothamBold
enterBtn.TextSize = 18
enterBtn.TextColor3 = Color3.new(1,1,1)
enterBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
enterBtn.Parent = frame

local enterCorner = Instance.new("UICorner", enterBtn)
enterCorner.CornerRadius = UDim.new(0, 6)

-- Copy Button
local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(1, -40, 0, 40)
copyBtn.Position = UDim2.new(0, 20, 0, 160)
copyBtn.Text = "Copy key generator"
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 18
copyBtn.TextColor3 = Color3.new(1,1,1)
copyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
copyBtn.Parent = frame

local copyCorner = Instance.new("UICorner", copyBtn)
copyCorner.CornerRadius = UDim.new(0,6)

-- Footer
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 25)
footer.Position = UDim2.new(0, 0, 1, -35) -- plus d'espace
footer.BackgroundTransparency = 1
footer.Text = "⚡ The Leaks MAIN PANEL"
footer.Font = Enum.Font.Gotham
footer.TextSize = 14
footer.TextColor3 = Color3.fromRGB(180,180,180)
footer.Parent = frame

-- Enter Button Function
enterBtn.MouseButton1Click:Connect(function()
	if input.Text == correctKey then
		enterBtn.Text = "✅ Valid Key"
		enterBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
		wait(2)

		gui:Destroy()

		local mainGui = Instance.new("ScreenGui")
		mainGui.Name = "MainPanel"
		mainGui.Parent = getGuiParent()

		local mainFrame = Instance.new("Frame")
		mainFrame.Size = UDim2.new(0,400,0,250)
		mainFrame.Position = UDim2.new(0.5,-200,0.5,-125)
		mainFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
		mainFrame.BorderSizePixel = 0
		mainFrame.Parent = mainGui

		local mainCorner = Instance.new("UICorner", mainFrame)
		mainCorner.CornerRadius = UDim.new(0,10)

		local mainTitle = Instance.new("TextLabel")
		mainTitle.Size = UDim2.new(1,0,0,40)
		mainTitle.BackgroundColor3 = Color3.fromRGB(50,50,50)
		mainTitle.Text = "📌 The Leaks - Main Panel"
		mainTitle.Font = Enum.Font.GothamBold
		mainTitle.TextSize = 18
		mainTitle.TextColor3 = Color3.new(1,1,1)
		mainTitle.Parent = mainFrame

		local mainTitleCorner = Instance.new("UICorner", mainTitle)
		mainTitleCorner.CornerRadius = UDim.new(0,10)

		-- Drag for main panel
		local dragging2 = false
		local dragInput2, dragStart2, startPos2
		mainTitle.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging2 = true
				dragStart2 = input.Position
				startPos2 = mainFrame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging2 = false
					end
				end)
			end
		end)

		mainTitle.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				dragInput2 = input
			end
		end)

		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == dragInput2 and dragging2 then
				local delta = input.Position - dragStart2
				mainFrame.Position = UDim2.new(
					startPos2.X.Scale,
					startPos2.X.Offset + delta.X,
					startPos2.Y.Scale,
					startPos2.Y.Offset + delta.Y
				)
			end
		end)
	else
		enterBtn.Text = "❌ Invalid Key"
		enterBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
		wait(2)
		enterBtn.Text = "Enter"
		enterBtn.BackgroundColor3 = Color3.fromRGB(0,200,100)
	end
end)

-- Copy Button Function
copyBtn.MouseButton1Click:Connect(function()
	local success = pcall(function()
		setclipboard("https://workink.net/232j/af80h3aj")
	end)
	if success then
		copyBtn.Text = "Copied"
		wait(2)
		copyBtn.Text = "Copy key generator"
	end
end)
