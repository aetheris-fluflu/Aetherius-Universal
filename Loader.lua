local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local Title = Instance.new("TextLabel")
local Welcome = Instance.new("TextLabel")
local ToggleButton = Instance.new("ImageButton")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
Frame.Size = UDim2.new(0, 250, 0, 500)  -- Adjusted for more room
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)

ScrollingFrame.Parent = Frame
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 3, 0)  -- Adjusted for vertical scrolling
ScrollingFrame.ScrollBarThickness = 5

Title.Parent = Frame
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Position = UDim2.new(0, 10, 0, -35)
Title.BackgroundTransparency = 1
Title.Text = "Aetherius Universal"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

Welcome.Parent = Frame
Welcome.Size = UDim2.new(0, 200, 0, 30)
Welcome.Position = UDim2.new(0.5, -100, 0, 10)  -- Centered in frame
Welcome.BackgroundTransparency = 1
Welcome.Font = Enum.Font.SourceSansBold
Welcome.TextSize = 20
Welcome.Text = "Welcome, " .. game.Players.LocalPlayer.Name
Welcome.TextColor3 = Color3.fromRGB(255, 0, 0)

task.spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            Welcome.TextColor3 = Color3.fromHSV(i, 1, 1)
            task.wait(0.02)
        end
    end
end)

ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0.9, 0, 0.1, 0)
ToggleButton.Image = "http://www.roblox.com/asset/?id=108802284870895"
ToggleButton.Draggable = true

ToggleButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

function createButton(name, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = ScrollingFrame
    Button.Size = UDim2.new(0.9, 0, 0, 50)
    Button.Position = UDim2.new(0.05, 0, 0, #ScrollingFrame:GetChildren() * 60)
    Button.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    Button.Text = name .. " - OFF"
    Button.TextColor3 = Color3.fromRGB(255, 0, 0)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 20

    local enabled = false
    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Button.Text = name .. " - ON"
            Button.TextColor3 = Color3.fromRGB(0, 255, 0)
        else
            Button.Text = name .. " - OFF"
            Button.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        callback(enabled)
    end)
end

-- Customizable Fly
local flySpeedInput = Instance.new("TextBox")
flySpeedInput.Parent = ScrollingFrame
flySpeedInput.Size = UDim2.new(0.9, 0, 0, 50)
flySpeedInput.Position = UDim2.new(0.05, 0, 0, #ScrollingFrame:GetChildren() * 60)
flySpeedInput.Text = "Fly Speed: 50"
flySpeedInput.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
flySpeedInput.Font = Enum.Font.SourceSansBold
flySpeedInput.TextSize = 18

local flyFunction = function(enabled)
    local character = game.Players.LocalPlayer.Character
    local flySpeed = tonumber(flySpeedInput.Text:match("Fly Speed: (%d+)")) or 50
    if enabled then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, flySpeed, 0)
        bodyVelocity.Parent = character.HumanoidRootPart
        bodyVelocity.Name = "FlyVelocity"
    else
        if character.HumanoidRootPart:FindFirstChild("FlyVelocity") then
            character.HumanoidRootPart.FlyVelocity:Destroy()
        end
    end
end

createButton("Fly", flyFunction)

-- Noclip
local noclipFunction = function(enabled)
    game:GetService("RunService").Stepped:Connect(function()
        if enabled then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        else
            for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end)
end

createButton("Noclip", noclipFunction)

-- Speed Hack
local speedInput = Instance.new("TextBox")
speedInput.Parent = ScrollingFrame
speedInput.Size = UDim2.new(0.9, 0, 0, 50)
speedInput.Position = UDim2.new(0.05, 0, 0, #ScrollingFrame:GetChildren() * 60)
speedInput.Text = "Speed: 50"
speedInput.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
speedInput.Font = Enum.Font.SourceSansBold
speedInput.TextSize = 18

local speedHackFunction = function(enabled)
    local character = game.Players.LocalPlayer.Character
    local speed = tonumber(speedInput.Text:match("Speed: (%d+)")) or 50
    if enabled then
        character.Humanoid.WalkSpeed = speed
    else
        character.Humanoid.WalkSpeed = 16
    end
end

createButton("Speed Hack", speedHackFunction)

-- Jump Power
local jumpPowerInput = Instance.new("TextBox")
jumpPowerInput.Parent = ScrollingFrame
jumpPowerInput.Size = UDim2.new(0.9, 0, 0, 50)
jumpPowerInput.Position = UDim2.new(0.05, 0, 0, #ScrollingFrame:GetChildren() * 60)
jumpPowerInput.Text = "Jump Power: 50"
jumpPowerInput.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
jumpPowerInput.Font = Enum.Font.SourceSansBold
jumpPowerInput.TextSize = 18

local jumpPowerFunction = function(enabled)
    local character = game.Players.LocalPlayer.Character
    local jumpPower = tonumber(jumpPowerInput.Text:match("Jump Power: (%d+)")) or 50
    if enabled then
        character.Humanoid.JumpPower = jumpPower
    else
        character.Humanoid.JumpPower = 50
    end
end

createButton("Jump Power", jumpPowerFunction)

-- Infinite Jump
local infiniteJumpFunction = function(enabled)
    local UIS = game:GetService("UserInputService")
    local character = game.Players.LocalPlayer.Character
    if enabled then
        UIS.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == Enum.KeyCode.Space then
                    character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                    character.Humanoid:Move(Vector3.new(0, 100, 0))
                end
            end
        end)
    end
end

createButton("Infinite Jump", infiniteJumpFunction)

-- Walk on Water
local walkOnWaterFunction = function(enabled)
    local character = game.Players.LocalPlayer.Character
    if enabled then
        character.HumanoidRootPart.CanCollide = false
    else
        character.HumanoidRootPart.CanCollide = true
    end
end

createButton("Walk on Water", walkOnWaterFunction)

-- Freeze Player
local freezePlayerFunction = function(enabled)
    if enabled then
        local character = game.Players.LocalPlayer.Character
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = true
        end
    else
        local character = game.Players.LocalPlayer.Character
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

createButton("Freeze Player", freezePlayerFunction)

-- Fling Player
local flingPlayerFunction = function()
    local target = game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        target.Character.HumanoidRootPart:ApplyImpulse(Vector3.new(0, 1000, 0))
    end
end

createButton("Fling Player", flingPlayerFunction)
