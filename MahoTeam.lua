-- MAHO TEAM TERMINAL v4.0 (Elite Force Edition)
local Player = game.Players.LocalPlayer
local Teams = game:GetService("Teams")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- ESKİ UI TEMİZLİĞİ
local old = game.CoreGui:FindFirstChild("MahoEliteUI")
if old then old:Destroy() end

-- UI OLUŞTURMA
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MahoEliteUI"
ScreenGui.Parent = game.CoreGui

-- ANA PANEL (MODERN GLASS DESIGN)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -230)
MainFrame.Size = UDim2.new(0, 380, 0, 460)
MainFrame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- GÖLGE VE PARLAKLIK (STROKE)
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(45, 45, 55)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Text = "MAHO TEAM ELITE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Position = UDim2.new(0, 25, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- DURUM PANELİ
local Status = Instance.new("TextLabel")
Status.Parent = MainFrame
Status.Position = UDim2.new(0, 25, 0, 75)
Status.Size = UDim2.new(1, -50, 0, 25)
Status.Text = "SİSTEM DURUMU: ANALİZ BEKLENİYOR"
Status.TextColor3 = Color3.fromRGB(0, 170, 255)
Status.Font = Enum.Font.GothamMedium
Status.TextSize = 11
Status.BackgroundTransparency = 1

-- KAYDIRMA ALANI
local Scroll = Instance.new("ScrollingFrame")
Scroll.Parent = MainFrame
Scroll.Position = UDim2.new(0, 20, 0, 170)
Scroll.Size = UDim2.new(1, -40, 0, 270)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 0

local Layout = Instance.new("UIListLayout")
Layout.Parent = Scroll
Layout.Padding = UDim.new(0, 10)

-- FORCED TEAM JOIN FONKSİYONU
local function forceJoin(targetTeam)
    Status.Text = "PROTOKOL BAŞLATILDI: " .. targetTeam.Name:upper()
    Status.TextColor3 = Color3.fromRGB(255, 170, 0)

    -- 1. Client Tarafı Değişim
    Player.Team = targetTeam

    -- 2. Brute Force Remote Search (Sunucuyu Zorla)
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and (v.Name:lower():find("team") or v.Name:lower():find("change")) then
            v:FireServer(targetTeam)
            v:FireServer(targetTeam.Name)
        end
    end

    -- 3. Fiziksel Spawn Zorlaması (Teleport)
    task.spawn(function()
        for _, spawn in pairs(workspace:GetDescendants()) do
            if spawn:IsA("SpawnLocation") and spawn.TeamColor == targetTeam.TeamColor then
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    Player.Character.HumanoidRootPart.CFrame = spawn.CFrame * CFrame.new(0, 5, 0)
                    Status.Text = "DURUM: BAŞARIYLA AKTARILDI"
                    Status.TextColor3 = Color3.fromRGB(0, 255, 127)
                end
            end
        end
    end)
end

-- ANALİZ ET BUTONU
local Fetch = Instance.new("TextButton")
Fetch.Parent = MainFrame
Fetch.Position = UDim2.new(0, 20, 0, 110)
Fetch.Size = UDim2.new(1, -40, 0, 45)
Fetch.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Fetch.Text = "SİSTEMLERİ TARA VE TAKIMLARI ÇEK"
Fetch.TextColor3 = Color3.fromRGB(255, 255, 255)
Fetch.Font = Enum.Font.GothamBold
Fetch.TextSize = 14

local FetchCorner = Instance.new("UICorner")
FetchCorner.CornerRadius = UDim.new(0, 8)
FetchCorner.Parent = Fetch

Fetch.MouseButton1Click:Connect(function()
    for _, v in pairs(Scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    
    for _, t in pairs(Teams:GetChildren()) do
        local b = Instance.new("TextButton")
        b.Parent = Scroll
        b.Size = UDim2.new(1, 0, 0, 50)
        b.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        b.Text = t.Name:upper() .. " - AKTARIMI BAŞLAT"
        b.TextColor3 = t.TeamColor.Color
        b.Font = Enum.Font.GothamSemibold
        b.TextSize = 12
        
        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 8)
        bc.Parent = b
        
        b.MouseButton1Click:Connect(function()
            forceJoin(t)
        end)
    end
    Scroll.CanvasSize = UDim2.new(0, 0, 0, #Teams:GetChildren() * 60)
end)

-- SÜRÜKLENEBİLİR YAPMA (DRAG)
local dragStart, startPos, dragging
Header.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = i.Position startPos = MainFrame.Position end end)
game:GetService("UserInputService").InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then local delta = i.Position - dragStart MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
Header.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
