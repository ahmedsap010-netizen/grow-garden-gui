-- [[ سكربت شراء بذور وأدوات + Anti-AFK ]] --
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local VGUI = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
VGUI.Name = "GrowGUI"

-- Anti-AFK
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new())
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new())
end)

-- عناصر المتاجر
local seeds = {
    "Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn", "Daffodil",
    "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango",
    "Grape", "Mushroom", "Pepper", "Cacao", "Beanstalk", "Ember Lily", "Sugar Apple", 
    "Burning Bud", "Giant Pinecone", "Elder Strawberry"
}

local gear = {
    "Watering Can", "Trading Ticket", "Trowel", "Recall Wrench", "Basic Sprinkler",
    "Advanced Sprinkler", "Godly Sprinkler", "Master Sprinkler", "Grandmaster Sprinkler",
    "Magnifying Glass", "Cleaning Spray", "Favorite Tool", "Harvest Tool",
    "Friendship Pot", "Medium Toy", "Medium Treat"
}

-- واجهة المستخدم
local frame = Instance.new("Frame", VGUI)
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Text = "Grow a Garden GUI 🌱"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(50, 100, 50)
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold

local seedDrop = Instance.new("TextButton", frame)
seedDrop.Text = "🌱 شراء بذرة"
seedDrop.Size = UDim2.new(1, -20, 0, 30)
seedDrop.Position = UDim2.new(0, 10, 0, 50)
seedDrop.BackgroundColor3 = Color3.fromRGB(60, 90, 60)
seedDrop.TextColor3 = Color3.new(1,1,1)
seedDrop.Font = Enum.Font.SourceSans
seedDrop.TextScaled = true

local gearDrop = Instance.new("TextButton", frame)
gearDrop.Text = "🛠️ شراء أداة"
gearDrop.Size = UDim2.new(1, -20, 0, 30)
gearDrop.Position = UDim2.new(0, 10, 0, 90)
gearDrop.BackgroundColor3 = Color3.fromRGB(90, 60, 60)
gearDrop.TextColor3 = Color3.new(1,1,1)
gearDrop.Font = Enum.Font.SourceSans
gearDrop.TextScaled = true

local listBox = Instance.new("TextBox", frame)
listBox.PlaceholderText = "العنصر المختار"
listBox.Size = UDim2.new(1, -20, 0, 30)
listBox.Position = UDim2.new(0, 10, 0, 140)
listBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
listBox.TextColor3 = Color3.new(1,1,1)
listBox.Font = Enum.Font.SourceSans
listBox.TextScaled = true
listBox.Text = ""

local buyBtn = Instance.new("TextButton", frame)
buyBtn.Text = "🛒 شراء"
buyBtn.Size = UDim2.new(1, -20, 0, 30)
buyBtn.Position = UDim2.new(0, 10, 0, 190)
buyBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 30)
buyBtn.TextColor3 = Color3.new(1,1,1)
buyBtn.Font = Enum.Font.SourceSansBold
buyBtn.TextScaled = true

local currentMode = "Seed"

seedDrop.MouseButton1Click:Connect(function()
	currentMode = "Seed"
	listBox.Text = seeds[math.random(1, #seeds)]
end)

gearDrop.MouseButton1Click:Connect(function()
	currentMode = "Gear"
	listBox.Text = gear[math.random(1, #gear)]
end)

buyBtn.MouseButton1Click:Connect(function()
	local item = listBox.Text
	if currentMode == "Seed" then
		RS:WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(item)
	elseif currentMode == "Gear" then
		RS:WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer(item)
	end
end)
