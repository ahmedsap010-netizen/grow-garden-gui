-- Grow a Garden GUI Auto Script | By Ahmed 🪄
-- Supports Delta / KRNL
-- GUI with Anti-AFK, Seed/Gear/Egg buying features

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Main GUI
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "GrowGardenGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 320)
frame.Position = UDim2.new(0.5, -150, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(70, 0, 0)
title.Text = "🌱 Grow Garden GUI | Ahmed"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

-- Dropdowns
local function createBox(placeholder, position)
    local box = Instance.new("TextBox", frame)
    box.PlaceholderText = placeholder
    box.Size = UDim2.new(0.9, 0, 0, 30)
    box.Position = position
    box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.SourceSans
    box.TextScaled = true
    return box
end

local seedBox = createBox("اكتب اسم البذرة", UDim2.new(0.05, 0, 0.2, 0))
local gearBox = createBox("اكتب اسم الأداة", UDim2.new(0.05, 0, 0.35, 0))
local eggBox  = createBox("اكتب اسم البيضة", UDim2.new(0.05, 0, 0.5, 0))

-- Buttons
local function createBtn(text, position, color, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Text = text
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.MouseButton1Click:Connect(callback)
end

createBtn("✅ اشتري بذرة", UDim2.new(0.05, 0, 0.65, 0), Color3.fromRGB(0, 170, 0), function()
    local item = seedBox.Text
    if item ~= "" then
        local event = ReplicatedStorage:FindFirstChild("BuyItem")
        if event then
            pcall(function()
                event:FireServer("Seed", item)
            end)
        else
            StarterGui:SetCore("SendNotification", {Title="Error", Text="BuyItem Event Not Found!", Duration=3})
        end
    end
end)

createBtn("🛠️ اشتري أداة", UDim2.new(0.05, 0, 0.75, 0), Color3.fromRGB(0, 120, 170), function()
    local item = gearBox.Text
    if item ~= "" then
        local event = ReplicatedStorage:FindFirstChild("BuyItem")
        if event then
            pcall(function()
                event:FireServer("Gear", item)
            end)
        else
            StarterGui:SetCore("SendNotification", {Title="Error", Text="BuyItem Event Not Found!", Duration=3})
        end
    end
end)

createBtn("🥚 اشتري بيضة", UDim2.new(0.05, 0, 0.85, 0), Color3.fromRGB(170, 120, 0), function()
    local item = eggBox.Text
    if item ~= "" then
        local event = ReplicatedStorage:FindFirstChild("BuyItem")
        if event then
            pcall(function()
                event:FireServer("Egg", item)
            end)
        else
            StarterGui:SetCore("SendNotification", {Title="Error", Text="BuyItem Event Not Found!", Duration=3})
        end
    end
end)
