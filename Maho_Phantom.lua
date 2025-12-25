-- 🎖️ MAHO SECRET MODULE: PHANTOM CHAT LOGGER
-- 🛡️ meho61919-create | Ultra Privacy & Search System

local player = game:GetService("Players").LocalPlayer
local coreGui = game:GetService("CoreGui")
local tweenService = game:GetService("TweenService")
local userInput = game:GetService("UserInputService")

-- [ TEMİZLİK ]
if coreGui:FindFirstChild("MahoChatLogger") then coreGui.MahoChatLogger:Destroy() end

-- [ ANA PANEL UI ]
local sg = Instance.new("ScreenGui", coreGui); sg.Name = "MahoChatLogger"
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 350, 0, 450)
Main.Position = UDim2.new(0.8, -175, 0.5, -225) -- Ekranın sağında açılır
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(130, 0, 255); Stroke.Thickness = 2

-- [ HEADER & SEARCH ]
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40); Title.Text = "PHANTOM CHAT LOGS"; Title.TextColor3 = Color3.new(1,1,1)
Title.Font = "GothamBold"; Title.TextSize = 16; Title.BackgroundTransparency = 1

local SearchBar = Instance.new("TextBox", Main)
SearchBar.Size = UDim2.new(1, -20, 0, 35); SearchBar.Position = UDim2.new(0, 10, 0, 45)
SearchBar.PlaceholderText = "Kullanıcı veya mesaj ara..."; SearchBar.Text = ""
SearchBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30); SearchBar.TextColor3 = Color3.new(1,1,1)
SearchBar.Font = "Gotham"; SearchBar.TextSize = 14; Instance.new("UICorner", SearchBar)

-- [ LOG ALANI ]
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -100); Scroll.Position = UDim2.new(0, 10, 0, 90)
Scroll.BackgroundTransparency = 1; Scroll.ScrollBarThickness = 2
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0); Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0, 5); List.SortOrder = Enum.SortOrder.LayoutOrder

-- [ FONKSİYONLAR ]
local logs = {}

local function AddLog(sender, message)
    local logEntry = {Sender = sender, Message = message}
    table.insert(logs, logEntry)
    
    local logLabel = Instance.new("TextLabel", Scroll)
    logLabel.Size = UDim2.new(1, 0, 0, 30); logLabel.BackgroundTransparency = 0.9
    logLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    logLabel.Text = "  [" .. sender .. "]: " .. message
    logLabel.TextColor3 = Color3.new(1, 1, 1); logLabel.TextXAlignment = "Left"
    logLabel.Font = "GothamMedium"; logLabel.TextSize = 13
    logLabel.Name = sender:lower() -- Arama için ismi name'e atıyoruz
    Instance.new("UICorner", logLabel)

    -- Mesaj içeriğini de aratabilmek için attribute ekleyelim
    logLabel:SetAttribute("Msg", message:lower())
end

-- Arama Motoru
SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
    local searchText = SearchBar.Text:lower()
    for _, item in pairs(Scroll:GetChildren()) do
        if item:IsA("TextLabel") then
            if searchText == "" or item.Name:find(searchText) or item:GetAttribute("Msg"):find(searchText) then
                item.Visible = true
            else
                item.Visible = false
            end
        end
    end
end)

-- Mesajları Yakala
for _, v in pairs(game.Players:GetPlayers()) do
    v.Chatted:Connect(function(msg) AddLog(v.DisplayName, msg) end)
end

game.Players.PlayerAdded:Connect(function(v)
    v.Chatted:Connect(function(msg) AddLog(v.DisplayName, msg) end)
end)

-- [ KAPATMA ]
local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0, 25, 0, 25); Close.Position = UDim2.new(1, -30, 0, 7)
Close.Text = "X"; Close.BackgroundColor3 = Color3.fromRGB(200, 0, 0); Close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Close)
Close.MouseButton1Click:Connect(function() sg:Destroy() end)

print("PHANTOM CHATLOGS LOADED!")