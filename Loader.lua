local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
Frame.Size = UDim2.new(0, 250, 0, 400)
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)

ScrollingFrame.Parent = Frame
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2.5, 0)
ScrollingFrame.ScrollBarThickness = 5

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

local function flyFunction(enabled)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end

    if enabled then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local fly = Instance.new("BodyVelocity")
            fly.Velocity = Vector3.new(0, 50, 0)
            fly.MaxForce = Vector3.new(4000, 4000, 4000)
            fly.Name = "FlyVelocity"
            fly.Parent = humanoidRootPart
        end
    else
        if character:FindFirstChild("HumanoidRootPart"):FindFirstChild("FlyVelocity") then
            character.HumanoidRootPart.FlyVelocity:Destroy()
        end
    end
end

local noclipEnabled = false
local function noclipFunction(enabled)
    noclipEnabled = enabled
    game:GetService("RunService").Stepped:Connect(function()
        if noclipEnabled then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end

local function espFunction(enabled)
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            if enabled then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESP"
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.FillTransparency = 0.5
                highlight.Parent = player.Character
            else
                if player.Character:FindFirstChild("ESP") then
                    player.Character.ESP:Destroy()
                end
            end
        end
    end
end

local function speedFunction(enabled)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        if enabled then
            player.Character.Humanoid.WalkSpeed = 100
        else
            player.Character.Humanoid.WalkSpeed = 16
        end
    end
end

local function jumpFunction(enabled)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        if enabled then
            player.Character.Humanoid.JumpPower = 150
        else
            player.Character.Humanoid.JumpPower = 50
        end
    end
end

local infiniteJump = false
game.UserInputService.JumpRequest:Connect(function()
    if infiniteJump then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local function infiniteJumpFunction(enabled)
    infiniteJump = enabled
end

local function teleportToPlayer()
    local player = game.Players.LocalPlayer
    local tpGui = Instance.new("ScreenGui", ScreenGui)
    local tpFrame = Instance.new("Frame", tpGui)
end

createButton("Fly", flyFunction)
createButton("Noclip", noclipFunction)
createButton("ESP", espFunction)
createButton("Speed Hack", speedFunction)
createButton("Jump Power", jumpFunction)
createButton("Infinite Jump", infiniteJumpFunction)
