-- MAHO TEAM TERMINAL v3.0 (Premium & Disciplined)
local Player = game.Players.LocalPlayer
local Teams = game:GetService("Teams")
local TweenService = game:GetService("TweenService")

-- ESKİ UI VARSA TEMİZLE
local oldUI = game.CoreGui:FindFirstChild("MahoPremiumUI")
if oldUI then oldUI:Destroy() end

-- ANA YAPI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MahoPremiumUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Modern & Soft Design)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30) -- Derin Lacivert/Gri
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
MainFrame.Size = UDim2.new(0, 350, 0, 450)
MainFrame.ClipsDescendants = true

-- KÖŞE YUMUŞATMA
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- ÜST ŞERİT (Header)
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Text = "MAHO TEAM TERMINAL"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- BİLGİ PANELİ
local InfoBox = Instance.new("TextLabel")
InfoBox.Parent = MainFrame
InfoBox.Position = UDim2.new(0, 20, 0, 65)
InfoBox.Size = UDim2.new(1, -40, 0, 30)
InfoBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
InfoBox.Text = "Sistem Hazır: Veri Alınması Bekleniyor..."
InfoBox.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoBox.Font = Enum.Font.Gotham
InfoBox.TextSize = 12

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 6)
InfoCorner.Parent = InfoBox

-- TEAM LİSTESİ (Kaydırmalı)
local Scroll = Instance.new("ScrollingFrame")
Scroll.Parent = MainFrame
Scroll.Position = UDim2.new(0, 20, 0, 160)
Scroll.Size = UDim2.new(1, -40, 0, 270)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local Layout = Instance.new("UIListLayout")
Layout.Parent = Scroll
Layout.Padding = UDim.new(0, 8)

-- TEAM BİLGİ AL BUTONU (Modern Buton)
local FetchBtn = Instance.new("TextButton")
FetchBtn.Parent = MainFrame
FetchBtn.Position = UDim2.new(0, 20, 0, 105)
FetchBtn.Size = UDim2.new(1, -40, 0, 40)
FetchBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- Profesyonel Mavi
FetchBtn.Text = "TAKIM BİLGİLERİNİ SORGULA"
FetchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FetchBtn.Font = Enum.Font.GothamSemibold
FetchBtn.TextSize = 14
FetchBtn.AutoButtonColor = true

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = FetchBtn

-- FONKSİYONLAR
local function createTeamButton(team)
    local TBtn = Instance.new("TextButton")
    TBtn.Size = UDim2.new(1, -5, 0, 45)
    TBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TBtn.Text = team.Name .. " TAKIMINA KATIL"
    TBtn.TextColor3 = team.TeamColor.Color
    TBtn.Font = Enum.Font.GothamMedium
    TBtn.TextSize = 13
    TBtn.Parent = Scroll
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 6)
    TCorner.Parent = TBtn
    
    TBtn.MouseButton1Click:Connect(function()
        -- Gerçek geçiş denemesi
        Player.Team = team
        InfoBox.Text = "İşlem: " .. team.Name .. " denendi. Reset atmanız gerekebilir."
        
        -- Profesyonel Tıklama Animasyonu
        local push = TweenService:Create(TBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.95, 0, 0, 40)})
        push:Play()
        push.Completed:Wait()
        TBtn.Size = UDim2.new(1, -5, 0, 45)
    end)
end

FetchBtn.MouseButton1Click:Connect(function()
    -- Listeyi Temizle
    for _, v in pairs(Scroll:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    
    -- Takımları Bul
    local allTeams = Teams:GetChildren()
    if #allTeams == 0 then
        InfoBox.Text = "Hata: Oyunda aktif takım sistemi bulunamadı!"
    else
        InfoBox.Text = "Başarılı: " .. #allTeams .. " takım listelendi."
        for _, team in pairs(allTeams) do
            createTeamButton(team)
        end
        Scroll.CanvasSize = UDim2.new(0, 0, 0, #allTeams * 55)
    end
end)

-- SÜRÜKLENEBİLİR YAPMA
local dragging, dragInput, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
Header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
