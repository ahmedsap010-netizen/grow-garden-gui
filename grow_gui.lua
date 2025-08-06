-- 🌿 Grow a Garden GUI | Anti-AFK + Auto GUI | Made by Ahmed 🪄

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local Gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
Gui.Name = "GrowGUI"

local frame = Instance.new("Frame", Gui)
frame.Size = UDim2.new(0, 350, 0, 320)
frame.Position = UDim2.new(0.5, -175, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Text = "🌿 Grow Garden GUI - Ahmed"
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(80,0,0)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

local seeds = {
    "Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn",
    "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus",
    "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Beanstalk",
    "Ember Lily", "Sugar Apple", "Burning Bud", "Giant Pinecone", "Elder Strawberry"
}

local eggs = {
    "Common Egg", "Common Summer Egg", "Rare Summer Egg", "Paradise Egg", "Mythical Egg", "Bug Egg"
}

local gears = {
    "Watering Can", "Trading Ticket", "Trowel", "Recall Wrench", "Basic Sprinkler",
    "Advanced Sprinkler", "Godly Sprinkler", "Master Sprinkler", "Grandmaster Sprinkler",
    "Magnifying Glass", "Cleaning Spray", "Favorite Tool", "Harvest Tool",
    "Friendship Pot", "Medium Toy", "Medium Treat"
}

local function createDropdown(items, label, positionY)
    local box = Instance.new("TextButton", frame)
    box.Size = UDim2.new(0.9,0,0,30)
    box.Position = UDim2.new(0.05,0,positionY,0)
    box.BackgroundColor3 = Color3.fromRGB(60,60,60)
    box.TextColor3 = Color3.new(1,1,1)
    box.TextScaled = true
    box.Text = label

    local dropdown = Instance.new("Frame", box)
    dropdown.Size = UDim2.new(1,0,0,#items * 20)
    dropdown.Position = UDim2.new(0,0,1,0)
    dropdown.BackgroundColor3 = Color3.fromRGB(45,45,45)
    dropdown.Visible = false
    dropdown.ClipsDescendants = true

    for i, item in ipairs(items) do
        local choice = Instance.new("TextButton", dropdown)
        choice.Size = UDim2.new(1,0,0,20)
        choice.Position = UDim2.new(0,0,0,(i-1)*20)
        choice.BackgroundColor3 = Color3.fromRGB(70,70,70)
        choice.TextColor3 = Color3.new(1,1,1)
        choice.Text = item
        choice.TextScaled = true
        choice.MouseButton1Click:Connect(function()
            box.Text = item
            dropdown.Visible = false
        end)
    end

    box.MouseButton1Click:Connect(function()
        dropdown.Visible = not dropdown.Visible
    end)

    return box
end

local seedBtn = createDropdown(seeds, "اختر بذرة", 0.15)
local eggBtn  = createDropdown(eggs,  "اختر بيضة", 0.35)
local gearBtn = createDropdown(gears, "اختر أداة", 0.55)

local function createBuyBtn(text, color, posY, getType, getName)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.9,0,0,30)
    btn.Position = UDim2.new(0.05,0,posY,0)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.Text = text

    btn.MouseButton1Click:Connect(function()
        local event = ReplicatedStorage:FindFirstChild("BuyItem")
        if event then
            pcall(function()
                event:FireServer(getType(), getName().Text)
            end)
        end
    end)
end

createBuyBtn("✅ شراء البذرة", Color3.fromRGB(0,170,0), 0.25, function() return "Seed" end, function() return seedBtn end)
createBuyBtn("🥚 شراء البيضة", Color3.fromRGB(170,120,0), 0.45, function() return "Egg" end, function() return eggBtn end)
createBuyBtn("🛠️ شراء الأداة", Color3.fromRGB(0,120,170), 0.65, function() return "Gear" end, function() return gearBtn end)

-- 🛡️ Anti-AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)
