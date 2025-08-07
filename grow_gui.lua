-- Grow GUI by Ahmed | Toggle + Watermark + Buy All
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local VGUI = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
VGUI.Name = "GrowGUI"

-- Anti-AFK
Players.LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new()); wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new())
end)

-- Frame UI
local frame = Instance.new("Frame", VGUI)
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true

-- Watermark
local wm = Instance.new("TextLabel", frame)
wm.Size = UDim2.new(1,0,0,25)
wm.Position = UDim2.new(0,0,1,-25)
wm.Text = "Grow GUI by Ahmed"
wm.BackgroundTransparency = 1
wm.TextColor3 = Color3.fromRGB(200,200,200)
wm.TextScaled = true
wm.Font = Enum.Font.SourceSansSemibold

-- Toggle button
local toggle = Instance.new("TextButton", VGUI)
toggle.Size = UDim2.new(0, 100, 0, 30)
toggle.Position = UDim2.new(0, 10, 0, 10)
toggle.Text = "Toggle GUI"
toggle.Font = Enum.Font.SourceSansBold
toggle.TextScaled = true
toggle.BackgroundColor3 = Color3.fromRGB(60,60,60)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Buy All Buttons
local buySeeds = Instance.new("TextButton", frame)
buySeeds.Size = UDim2.new(0.95,0,0,40)
buySeeds.Position = UDim2.new(0.025,0,0.2,0)
buySeeds.Text = "Buy All Seeds"
buySeeds.Font = Enum.Font.SourceSansBold
buySeeds.TextScaled = true
buySeeds.BackgroundColor3 = Color3.fromRGB(0,150,0)
buySeeds.TextColor3 = Color3.new(1,1,1)

local buyGear = Instance.new("TextButton", frame)
buyGear.Size = UDim2.new(0.95,0,0,40)
buyGear.Position = UDim2.new(0.025,0,0.35,0)
buyGear.Text = "Buy All Gears"
buyGear.Font = Enum.Font.SourceSansBold
buyGear.TextScaled = true
buyGear.BackgroundColor3 = Color3.fromRGB(0,0,150)
buyGear.TextColor3 = Color3.new(1,1,1)

-- Action logic
buySeeds.MouseButton1Click:Connect(function()
    for _, item in ipairs({
        "Carrot","Strawberry","Blueberry","Tomato","Watermelon","Bamboo","Dragon Fruit"
        -- اضف حسب المتوفر داخل اللعبة
    }) do
        RS.GameEvents:WaitForChild("BuySeedStock"):FireServer(item)
        wait(0.2)
    end
end)

buyGear.MouseButton1Click:Connect(function()
    for _, item in ipairs({
        "Watering Can","Trading Ticket","Advanced Sprinkler","Magnifying Glass"
        -- اضف الأدوات المتوفرة لديك
    }) do
        RS.GameEvents:WaitForChild("BuyGearStock"):FireServer(item)
        wait(0.2)
    end
end)
