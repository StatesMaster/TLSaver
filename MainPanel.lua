-- Fonction utilitaire → choisit le bon parent
local function getGuiParent()
	if game:GetService("RunService"):IsStudio() then
		return game.Players.LocalPlayer:WaitForChild("PlayerGui")
	else
		return game:GetService("CoreGui")
	end
end

-- GUI Principal (Main Panel)
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "MainPanel"
mainGui.Parent = getGuiParent()

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 200)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = mainGui

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 10)

-- Title
local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(1, 0, 0, 40)
mainTitle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainTitle.Text = "📌 The Leaks - Main Panel"
mainTitle.Font = Enum.Font.GothamBold
mainTitle.TextSize = 18
mainTitle.TextColor3 = Color3.new(1, 1, 1)
mainTitle.Parent = mainFrame

local mainTitleCorner = Instance.new("UICorner", mainTitle)
mainTitleCorner.CornerRadius = UDim.new(0, 10)

-- Drag variables
local dragging = false
local dragInput, dragStart, startPos

mainTitle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainTitle.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
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
closeBtn.Parent = mainFrame
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0,4)

closeBtn.MouseButton1Click:Connect(function()
	mainGui:Destroy()
end)

-- Player Name
local playerNameLabel = Instance.new("TextLabel")
playerNameLabel.Size = UDim2.new(0.5, -10, 0, 25)
playerNameLabel.Position = UDim2.new(0, 10, 0, 50)
playerNameLabel.BackgroundTransparency = 1
playerNameLabel.Text = game.Players.LocalPlayer.Name
playerNameLabel.Font = Enum.Font.Gotham
playerNameLabel.TextSize = 16
playerNameLabel.TextColor3 = Color3.new(1,1,1)
playerNameLabel.TextXAlignment = Enum.TextXAlignment.Left
playerNameLabel.Parent = mainFrame

-- Game Name
local gameNameLabel = Instance.new("TextLabel")
gameNameLabel.Size = UDim2.new(0.5, -10, 0, 25)
gameNameLabel.Position = UDim2.new(0.5, 0, 0, 50)
gameNameLabel.BackgroundTransparency = 1
gameNameLabel.Text = game.Name -- Nom du jeu
gameNameLabel.Font = Enum.Font.Gotham
gameNameLabel.TextSize = 16
gameNameLabel.TextColor3 = Color3.new(1,1,1)
gameNameLabel.TextXAlignment = Enum.TextXAlignment.Right
gameNameLabel.Parent = mainFrame
