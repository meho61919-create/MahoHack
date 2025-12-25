-- 🔥 MAHO ELITE - PLAYER STICK MODULE (v10.0)
-- 🛡️ meho61919-create | Harici Yapışma & Takip Paneli

local player = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")

-- [ HARİCİ PANEL UI ]
local StickGui = Instance.new("ScreenGui", coreGui)
StickGui.Name = "MahoStickPanel"

local SMain = Instance.new("Frame", StickGui)
SMain.Size = UDim2.new(0, 250, 0, 200)
SMain.Position = UDim2.new(0.1, 0, 0.5, -100)
SMain.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
SMain.Active = true; SMain.Draggable = true
Instance.new("UICorner", SMain)
local Stroke = Instance.new("UIStroke", SMain)
Stroke.Color = Color3.fromRGB(255, 0, 100); Stroke.Thickness = 2

local STitle = Instance.new("TextLabel", SMain)
STitle.Size = UDim2.new(1, 0, 0, 40)
STitle.Text = "👤 MAHO STICKER"; STitle.TextColor3 = Color3.new(1,1,1)
STitle.Font = "GothamBold"; STitle.TextSize = 16; STitle.BackgroundTransparency = 1

-- Bilgi Etiketi
local InfoLabel = Instance.new("TextLabel", SMain)
InfoLabel.Size = UDim2.new(1, -20, 0, 30); InfoLabel.Position = UDim2.new(0, 10, 0, 40)
InfoLabel.Text = "Hedef Kullanıcı Adı Gir:"; InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoLabel.Font = "Gotham"; InfoLabel.TextSize = 12; InfoLabel.BackgroundTransparency = 1

-- Kullanıcı Adı Giriş Yeri
local UserInput = Instance.new("TextBox", SMain)
UserInput.Size = UDim2.new(1, -40, 0, 35); UserInput.Position = UDim2.new(0, 20, 0, 75)
UserInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45); UserInput.TextColor3 = Color3.new(1,1,1)
UserInput.PlaceholderText = "Kullanıcı adı..."; UserInput.Text = ""; UserInput.Font = "GothamBold"
Instance.new("UICorner", UserInput)

-- Yapış Butonu
local StickBtn = Instance.new("TextButton", SMain)
StickBtn.Size = UDim2.new(1, -40, 0, 40); StickBtn.Position = UDim2.new(0, 20, 0, 120)
StickBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 100); StickBtn.Text = "YAPIŞ: PASİF"
StickBtn.TextColor3 = Color3.new(1,1,1); StickBtn.Font = "GothamBold"; Instance.new("UICorner", StickBtn)

-- Kapatma (X)
local SClose = Instance.new("TextButton", SMain)
SClose.Size = UDim2.new(0, 25, 0, 25); SClose.Position = UDim2.new(1, -30, 0, 5)
SClose.Text = "X"; SClose.BackgroundColor3 = Color3.fromRGB(200, 0, 0); SClose.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SClose)
SClose.MouseButton1Click:Connect(function() StickGui:Destroy() end)

-- [ LOGIC ]
local sticking = false
local targetPlayer = nil

StickBtn.MouseButton1Click:Connect(function()
    sticking = not sticking
    if sticking then
        local targetName = UserInput.Text:lower()
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Name:lower():sub(1, #targetName) == targetName or v.DisplayName:lower():sub(1, #targetName) == targetName then
                targetPlayer = v
                break
            end
        end
        if targetPlayer then
            StickBtn.Text = "YAPIŞ: AKTİF ("..targetPlayer.DisplayName..")"
            StickBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        else
            sticking = false
            StickBtn.Text = "OYUNCU BULUNAMADI!"
            task.wait(1)
            StickBtn.Text = "YAPIŞ: PASİF"
        end
    else
        targetPlayer = nil
        StickBtn.Text = "YAPIŞ: PASİF"
        StickBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
    end
end)

rs.RenderStepped:Connect(function()
    if sticking and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        -- Karakteri hedefin tam arkasına (3 birim gerisine) yapıştırır
        player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end
end)
