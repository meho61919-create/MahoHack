-- 🔊 MAHO LOUD SOUND SYSTEM v1.0
-- 🛡️ meho61919-create | Universal Audio Injector

local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui")

-- [ TEMİZLİK ]
if coreGui:FindFirstChild("MahoSoundUI") then coreGui.MahoSoundUI:Destroy() end

local sg = Instance.new("ScreenGui", coreGui)
sg.Name = "MahoSoundUI"

-- [ TEMA ]
local ACCENT = Color3.fromRGB(255, 0, 100) -- Agresif Pembe/Kırmızı
local BG_DARK = Color3.fromRGB(15, 15, 20)

-- [ ANA FRAME ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 350)
Main.Position = UDim2.new(0.5, -150, 0.5, -175)
Main.BackgroundColor3 = BG_DARK
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = ACCENT
Stroke.Thickness = 2

-- [ BAŞLIK VE AÇIKLAMA ]
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "🔊 SES SİSTEMİ"
Title.TextColor3 = ACCENT
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

local Desc = Instance.new("TextLabel", Main)
Desc.Size = UDim2.new(0.9, 0, 0, 40)
Desc.Position = UDim2.new(0.05, 0, 0.15, 0)
Desc.Text = "Müzik ID girin ve başlatın. Eğer oyunda ses yetkiniz varsa herkes duyacaktır."
Desc.TextColor3 = Color3.fromRGB(180, 180, 180)
Desc.Font = Enum.Font.Gotham
Desc.TextSize = 12
Desc.TextWrapped = true
Desc.BackgroundTransparency = 1

-- [ INPUT ]
local IdInput = Instance.new("TextBox", Main)
IdInput.Size = UDim2.new(0.8, 0, 0, 45)
IdInput.Position = UDim2.new(0.1, 0, 0.35, 0)
IdInput.PlaceholderText = "Müzik ID (Örn: 1837320)"
IdInput.Text = ""
IdInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
IdInput.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", IdInput)

-- [ VOLUME SLIDER / LABEL ]
local VolLabel = Instance.new("TextLabel", Main)
VolLabel.Size = UDim2.new(1, 0, 0, 30)
VolLabel.Position = UDim2.new(0, 0, 0.5, 0)
VolLabel.Text = "Ses Seviyesi: 10"
VolLabel.TextColor3 = Color3.new(1,1,1)
VolLabel.BackgroundTransparency = 1

-- [ BUTONLAR ]
local PlayBtn = Instance.new("TextButton", Main)
PlayBtn.Size = UDim2.new(0.8, 0, 0, 50)
PlayBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
PlayBtn.Text = "MÜZİĞİ BAŞLAT"
PlayBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
PlayBtn.TextColor3 = Color3.new(1,1,1)
PlayBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", PlayBtn)

local StopBtn = Instance.new("TextButton", Main)
StopBtn.Size = UDim2.new(0.8, 0, 0, 40)
StopBtn.Position = UDim2.new(0.1, 0, 0.82, 0)
StopBtn.Text = "DURDUR"
StopBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
StopBtn.TextColor3 = Color3.new(1,1,1)
StopBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", StopBtn)

-- Kapatma X
local X = Instance.new("TextButton", Main)
X.Size = UDim2.new(0, 30, 0, 30); X.Position = UDim2.new(1, -35, 0, 5); X.Text = "X"; X.TextColor3 = Color3.new(1,0,0); X.BackgroundTransparency = 1
X.MouseButton1Click:Connect(function() sg:Destroy() end)

-- [ MANTIK ]
local currentSound = nil

PlayBtn.MouseButton1Click:Connect(function()
    local id = IdInput.Text
    if id ~= "" then
        -- Varsa eski sesi sil
        if currentSound then currentSound:Destroy() end
        
        -- Yeni ses objesi yarat (Karakterin içinde)
        local sound = Instance.new("Sound")
        sound.Name = "MahoGlobalSound"
        sound.SoundId = "rbxassetid://" .. id
        sound.Volume = 10
        sound.Looped = true
        
        -- Herkesin duyması için sesin karakterin içinde olması gerekir
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            sound.Parent = player.Character.HumanoidRootPart
            sound:Play()
            currentSound = sound
            PlayBtn.Text = "ÇALIYOR..."
            PlayBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end
end)

StopBtn.MouseButton1Click:Connect(function()
    if currentSound then
        currentSound:Stop()
        currentSound:Destroy()
        currentSound = nil
        PlayBtn.Text = "MÜZİĞİ BAŞLAT"
        PlayBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
    end
end)
