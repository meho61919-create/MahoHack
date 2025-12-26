-- MAHO TEAM TERMINAL v1.0
-- Özel Hacker Arayüzü

local Player = game.Players.LocalPlayer
local Teams = game:GetService("Teams")

-- UI OLUŞTURMA (Tamamen Kodla Yazılmış Özel Menü)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local InfoLabel = Instance.new("TextLabel")
local TeamListFrame = Instance.new("ScrollingFrame")
local FetchButton = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")

-- GUI Ayarları
ScreenGui.Name = "MahoTeamGui"
ScreenGui.Parent = game.CoreGui -- Executor ile çalıştığı için CoreGui en güvenlisi
ScreenGui.ResetOnSpawn = false

-- Ana Çerçeve (Terminal Görünümü)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10) -- Simsiyah
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0) -- Neon Yeşil Kenarlık
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 450)
MainFrame.Active = true
MainFrame.Draggable = true -- Menü sürüklenebilir

-- Başlık
Title.Parent = MainFrame
Title.Text = "> MAHO TEAM TERMINAL"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.Code
Title.TextSize = 20
Title.Size = UDim2.new(1, 0, 0, 40)

-- Bilgiler
InfoLabel.Parent = MainFrame
InfoLabel.Text = "Durum: Sistem Hazır. Veri bekleniyor..."
InfoLabel.TextColor3 = Color3.fromRGB(0, 200, 0)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Font = Enum.Font.Code
InfoLabel.TextSize = 14
InfoLabel.Position = UDim2.new(0, 10, 0, 45)
InfoLabel.Size = UDim2.new(1, -20, 0, 20)
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Liste Alanı
TeamListFrame.Parent = MainFrame
TeamListFrame.Position = UDim2.new(0, 10, 0, 120)
TeamListFrame.Size = UDim2.new(1, -20, 0, 310)
TeamListFrame.BackgroundTransparency = 1
TeamListFrame.ScrollBarThickness = 5

UIListLayout.Parent = TeamListFrame
UIListLayout.Padding = UDim.new(0, 5)

-- TAKIMLARI ÇEKME FONKSİYONU
local function fetchTeams()
    -- Mevcut listeyi temizle
    for _, child in pairs(TeamListFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    InfoLabel.Text = "Durum: Veriler çekildi. Takımlar listeleniyor..."
    
    for _, team in pairs(Teams:GetChildren()) do
        local TeamBtn = Instance.new("TextButton")
        TeamBtn.Parent = TeamListFrame
        TeamBtn.Size = UDim2.new(1, -10, 0, 35)
        TeamBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        TeamBtn.BorderColor3 = team.TeamColor.Color -- Takımın renginde kenarlık
        TeamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TeamBtn.Text = team.Name .. " | KATIL"
        TeamBtn.Font = Enum.Font.Code
        TeamBtn.TextSize = 14
        
        -- KATILMA OLAYI
        TeamBtn.MouseButton1Click:Connect(function()
            Player.Team = team
            InfoLabel.Text = "Durum: " .. team.Name .. " Takımına geçildi!"
        end)
    end
end

-- BİLGİ AL BUTONU
FetchButton.Parent = MainFrame
FetchButton.Position = UDim2.new(0, 10, 0, 75)
FetchButton.Size = UDim2.new(1, -20, 0, 35)
FetchButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
FetchButton.Text = "[ TEAM BILGI AL ]"
FetchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FetchButton.Font = Enum.Font.Code
FetchButton.TextSize = 16
FetchButton.MouseButton1Click:Connect(fetchTeams)
