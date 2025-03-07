local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local Title = Instance.new("TextLabel")
local Welcome = Instance.new("TextLabel")
local ToggleButton = Instance.new("ImageButton")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
Frame.Size = UDim2.new(0, 250, 0, 400)
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)

ScrollingFrame.Parent = Frame
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 3, 0)
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
Welcome.Position = UDim2.new(0, 10, 0, -10)
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

local function godModeFunction(enabled)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end

    if enabled then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        end
    else
        if character:FindFirstChildOfClass("Humanoid") then
            character.Humanoid.MaxHealth = 100
            character.Humanoid.Health = 100
        end
    end
end

local function clickTPFunction(enabled)
    local UIS = game:GetService("UserInputService")
    local player = game.Players.LocalPlayer

    if enabled then
        UIS.InputBegan:Connect(function(input, gameProcessed)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed then
                local mouse = player:GetMouse()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p)
                end
            end
        end)
    end
end

local function freezePlayerFunction()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.Anchored = not player.Character.HumanoidRootPart.Anchored
    end
end

local function noFallDamageFunction(enabled)
    local player = game.Players.LocalPlayer
    if enabled then
        player.Character.Humanoid.StateChanged:Connect(function(_, newState)
            if newState == Enum.HumanoidStateType.Freefall then
                task.wait()
                player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
            end
        end)
    end
end

local function viewPlayerFunction()
    local players = game.Players:GetPlayers()
    local player = game.Players.LocalPlayer
    for _, target in ipairs(players) do
        if target ~= player then
            player.CameraMode = Enum.CameraMode.LockFirstPerson
            player.CameraSubject = target.Character.Humanoid
            break
        end
    end
end

local function giveBToolsFunction()
    local backpack = game.Players.LocalPlayer.Backpack
    local hammer = Instance.new("HopperBin", backpack)
    local cloneTool = Instance.new("HopperBin", backpack)
    local grabTool = Instance.new("HopperBin", backpack)

    hammer.BinType = Enum.BinType.Hammer
    cloneTool.BinType = Enum.BinType.Clone
    grabTool.BinType = Enum.BinType.Grab
end

local function flingPlayerFunction()
    local player = game.Players.LocalPlayer
    local target = game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]

    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local force = Instance.new("BodyVelocity")
        force.Velocity = Vector3.new(0, 500, 0)
        force.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        force.Parent = target.Character.HumanoidRootPart

        task.wait(0.5)
        force:Destroy()
    end
end

createButton("God Mode", godModeFunction)
createButton("Click TP", clickTPFunction)
createButton("Freeze Player", freezePlayerFunction)
createButton("No Fall Damage", noFallDamageFunction)
createButton("View Player", viewPlayerFunction)
createButton("BTools (Client Only)", giveBToolsFunction)
createButton("Fling Player", flingPlayerFunction)
