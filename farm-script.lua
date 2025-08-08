local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- الإحداثيات
local firstTeleport = Vector3.new(275.19, 4.03, -169.78)
local teleportPositions = {
    Vector3.new(293.22, 4.00, -170.01),
    Vector3.new(221.01, 4.03, -78.31),
}

local currentIndex = 0
local autoDelay = 0 -- أسرع سرعة ممكنة بدون انتظار
local firstTeleportDone = false

local FARM_INTERVAL = 240 -- 4 دقائق بالثواني
local farming = true

-- إنشاء واجهة GUI صغيرة على اليمين تعرض الحقوق فقط
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FarmGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 40)
frame.Position = UDim2.new(1, -190, 0.95, -50)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Parent = screenGui

local rightsLabel = Instance.new("TextLabel")
rightsLabel.Size = UDim2.new(1, 0, 1, 0)
rightsLabel.BackgroundTransparency = 1
rightsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
rightsLabel.Font = Enum.Font.SourceSansBold
rightsLabel.TextScaled = true
rightsLabel.Text = "Dev.Anwar 🇮🇶 | TikTok: @hf4_l"
rightsLabel.Parent = frame

-- دالة التلبورت
local function teleportTo(position)
    local character = player.Character
    if character then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(position)
        end
    end
end

-- دالة التشغيل التلقائي للتنقل بين النقاط
local function autoFarm()
    while farming do
        if not firstTeleportDone then
            teleportTo(firstTeleport)
            firstTeleportDone = true
            wait(0)
        else
            currentIndex = currentIndex + 1
            if currentIndex > #teleportPositions then
                currentIndex = 1
            end
            teleportTo(teleportPositions[currentIndex])
            wait(autoDelay)
        end
    end
end

-- تشغيل الفارم التلقائي من البداية
coroutine.wrap(autoFarm)()

-- إعادة دخول السيرفر بعد 4 دقائق (240 ثانية)
delay(FARM_INTERVAL, function()
    farming = false -- إيقاف الفارم قبل الخروج
    TeleportService:Teleport(game.PlaceId, player)
end)
