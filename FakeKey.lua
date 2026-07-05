--// Grow a Garden 2 Nova Hub - Key System GUI
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NovaHubKeySystem"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 280)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(0, 170, 100)
uiStroke.Thickness = 2
uiStroke.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundTransparency = 1
title.Text = "🌱 Grow a Garden 2"
title.TextColor3 = Color3.fromRGB(0, 255, 150)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 30)
subtitle.Position = UDim2.new(0, 0, 0, 50)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Nova Hub"
subtitle.TextColor3 = Color3.fromRGB(100, 255, 180)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.GothamSemibold
subtitle.Parent = mainFrame

-- Key Input Box
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.85, 0, 0, 50)
keyBox.Position = UDim2.new(0.075, 0, 0.45, 0)
keyBox.PlaceholderText = "Enter your key here..."
keyBox.Text = ""
keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.Font = Enum.Font.Gotham
keyBox.TextScaled = true
keyBox.ClearTextOnFocus = false
keyBox.Parent = mainFrame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyBox

-- Button Frame (for side-by-side buttons)
local buttonFrame = Instance.new("Frame")
buttonFrame.Size = UDim2.new(0.85, 0, 0, 55)
buttonFrame.Position = UDim2.new(0.075, 0, 0.7, 0)
buttonFrame.BackgroundTransparency = 1
buttonFrame.Parent = mainFrame

-- Check Key Button (Left)
local checkButton = Instance.new("TextButton")
checkButton.Size = UDim2.new(0.48, 0, 1, 0)
checkButton.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
checkButton.Text = "Check Key"
checkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkButton.Font = Enum.Font.GothamBold
checkButton.TextScaled = true
checkButton.Parent = buttonFrame

local checkCorner = Instance.new("UICorner")
checkCorner.CornerRadius = UDim.new(0, 10)
checkCorner.Parent = checkButton

-- Copy Link Button (Right)
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0.48, 0, 1, 0)
copyButton.Position = UDim2.new(0.52, 0, 0, 0)
copyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
copyButton.Text = "Copy Link"
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.Font = Enum.Font.GothamBold
copyButton.TextScaled = true
copyButton.Parent = buttonFrame

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 10)
copyCorner.Parent = copyButton

-- **CHANGE YOUR LINK HERE**
local keyLink = "https://www.robiox.com.gr/communities/3765943415/Nova-HUB"   -- ← Put your actual link inside the quotes

-- Functions
copyButton.MouseButton1Click:Connect(function()
    setclipboard(keyLink)
    copyButton.Text = "✅ Copied!"
    wait(1.5)
    copyButton.Text = "Copy Link"
end)

checkButton.MouseButton1Click:Connect(function()
    local enteredKey = keyBox.Text:gsub("%s+", "") -- remove spaces
    
    if enteredKey == "" then
        checkButton.Text = "❌ Enter a key!"
        wait(1.5)
        checkButton.Text = "Check Key"
        return
    end
    
    -- ================== YOUR KEY CHECK LOGIC HERE ==================
    -- Example (replace with your own verification):
    if enteredKey == "NovaTestKey123" or enteredKey == "YOUR_REAL_KEY" then
        checkButton.Text = "✅ Success!"
        wait(1)
        screenGui:Destroy() -- Remove GUI on success
        -- Load your main script here
        print("✅ Key verified! Loading Nova Hub...")
    else
        checkButton.Text = "❌ Invalid Key"
        wait(1.5)
        checkButton.Text = "Check Key"
    end
end)

-- Draggable
local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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

title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        updateInput(input)
    end
end)