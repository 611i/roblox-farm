local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local WALK_SPEED = 35 -- عدل هنا سرعة المشي حسب رغبتك

local startPoint = Vector3.new(275.19, 4.03, -169.78) -- التلبورت للنقطة الأولى فقط
local points = {
    Vector3.new(293.22, 4.00, -170.01),
    Vector3.new(221.01, 4.03, -78.31),
}

local FARM_INTERVAL = 240
local farming = true

-- GUI الحقوق والتوضيح
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FarmGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 90)
frame.Position = UDim2.new(1, -390, 0.9, -100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Parent = screenGui

local rightsLabel = Instance.new("TextLabel")
rightsLabel.Size = UDim2.new(1, 0, 0, 35)
rightsLabel.Position = UDim2.new(0, 0, 0, 0)
rightsLabel.BackgroundTransparency = 1
rightsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
rightsLabel.Font = Enum.Font.SourceSansBold
rightsLabel.TextScaled = true
rightsLabel.Text = "Dev.Anwar 🇮🇶 | TikTok: @hf4_l"
rightsLabel.Parent = frame

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -10, 0, 50)
infoLabel.Position = UDim2.new(0, 5, 0, 35)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextWrapped = true
infoLabel.Text = "تم ضبط سرعة المشي على "..WALK_SPEED.." في هذه الماب لضمان احتساب النقاط وتجنب مشاكل الحماية."
infoLabel.Parent = frame

-- تثبيت سرعة المشي بشكل دائم
coroutine.wrap(function()
    while farming do
        if humanoid and humanoid.Parent then
            humanoid.WalkSpeed = WALK_SPEED
        end
        wait(1)
    end
end)()

-- التلبورت للنقطة الأولى مرة واحدة
hrp.CFrame = CFrame.new(startPoint)
wait(0.5)
humanoid.WalkSpeed = WALK_SPEED

-- الحركة المستمرة بين النقطتين
local currentPointIndex = 1
while farming do
    local targetPos = points[currentPointIndex]
    local direction = (targetPos - hrp.Position)
    local horizontalDir = Vector3.new(direction.X, 0, direction.Z)

    if horizontalDir.Magnitude < 5 then
        currentPointIndex = currentPointIndex + 1
        if currentPointIndex > #points then
            currentPointIndex = 1
        end
    else
        humanoid:Move(horizontalDir.Unit, false)
    end
    wait()
end

-- إعادة الدخول بعد المدة المحددة
delay(FARM_INTERVAL, function()
    farming = false
    print("Rejoining server...")
    TeleportService:Teleport(game.PlaceId, player)
end)
