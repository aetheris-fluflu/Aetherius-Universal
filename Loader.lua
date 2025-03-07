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
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
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

local function espFunction(enabled)
    if enabled then
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Parent = player.Character
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.OutlineColor = Color3.new(1, 1, 1)
            end
        end
    else
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Character then
                for _, v in pairs(player.Character:GetChildren()) do
                    if v:IsA("Highlight") then
                        v:Destroy()
                    end
                end
            end
        end
    end
end

local function flyFunction(enabled)
    local character = game.Players.LocalPlayer.Character
    if enabled then
        local fly = Instance.new("BodyVelocity")
        fly.Velocity = Vector3.new(0, 50, 0)
        fly.MaxForce = Vector3.new(4000, 4000, 4000)
        fly.Name = "FlyVelocity"
        fly.Parent = character.HumanoidRootPart
    else
        if character.HumanoidRootPart:FindFirstChild("FlyVelocity") then
            character.HumanoidRootPart.FlyVelocity:Destroy()
        end
    end
end

local function noclipFunction(enabled)
    game:GetService("RunService").Stepped:Connect(function()
        if enabled then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end

local function speedHackFunction(enabled)
    local character = game.Players.LocalPlayer.Character
    if enabled then
        character.Humanoid.WalkSpeed = 100
    else
        character.Humanoid.WalkSpeed = 16
    end
end

local function jumpPowerFunction(enabled)
    local character = game.Players.LocalPlayer.Character
    if enabled then
        character.Humanoid.JumpPower = 150
    else
        character.Humanoid.JumpPower = 50
    end
end

local function infiniteJumpFunction(enabled)
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

local function gravityControlFunction(enabled)
    if enabled then
        game.Workspace.Gravity = 20
    else
        game.Workspace.Gravity = 196.2
    end
end

local function walkOnWaterFunction(enabled)
    local character = game.Players.LocalPlayer.Character
    if enabled then
        character.HumanoidRootPart.CanCollide = false
    else
        character.HumanoidRootPart.CanCollide = true
    end
end

local function antiRagdollFunction(enabled)
    local character = game.Players.LocalPlayer.Character
    if enabled then
        for _, joint in ipairs(character:FindFirstChildOfClass("Model"):GetChildren()) do
            if joint:IsA("Motor6D") then
                joint:Destroy()
            end
        end
    end
end

local function resetCharacterFunction()
    local character = game.Players.LocalPlayer.Character
    character:BreakJoints()
end

local function godModeFunction(enabled)
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    if enabled then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    else
        humanoid.MaxHealth = 100
        humanoid.Health = 100
    end
end

local function clickTPFunction(enabled)
    local UIS = game:GetService("UserInputService")
    if enabled then
        UIS.InputBegan:Connect(function(input, gameProcessed)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed then
                local mouse = game.Players.LocalPlayer:GetMouse()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p)
            end
        end)
    end
end

local function freezePlayerFunction(enabled)
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

local function noFallDamageFunction(enabled)
    local character = game.Players.LocalPlayer.Character
    if enabled then
        character.Humanoid.FallDamage = 0
    else
        character.Humanoid.FallDamage = 50
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

createButton("ESP", espFunction)
createButton("Fly", flyFunction)
createButton("Noclip", noclipFunction)
createButton("Speed Hack", speedHackFunction)
createButton("Jump Power", jumpPowerFunction)
createButton("Infinite Jump", infiniteJumpFunction)
createButton("Gravity Control", gravityControlFunction)
createButton("Walk on Water", walkOnWaterFunction)
createButton("Anti-Ragdoll", antiRagdollFunction)
createButton("Reset Character", resetCharacterFunction)
createButton("God Mode", godModeFunction)
createButton("Click TP", clickTPFunction)
createButton("Freeze Player", freezePlayerFunction)
createButton("No Fall Damage", noFallDamageFunction)
createButton("View Player", viewPlayerFunction)
