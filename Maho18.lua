-- 🔥 MAHO 18+ ANIMATION MODULE - ANONYMOUS EDITION
-- 🛡️ meho61919-create | ScriptBlox Ultimate
-- ⚠️ UYARI: Bu script "R6" karakter tipinde en iyi sonucu verir.

local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- [ UI OLUŞTURMA ]
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
sg.Name = "Maho18Menu"

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 250, 0, 180)
Main.Position = UDim2.new(0.5, -125, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(255, 0, 50)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "🔞 MAHO 18+ CONTROL"; Title.TextColor3 = Color3.new(1,1,1)
Title.Font = "GothamBold"; Title.TextSize = 14; Title.BackgroundTransparency = 1

local TargetBox = Instance.new("TextBox", Main)
TargetBox.Size = UDim2.new(0.9, 0, 0, 35); TargetBox.Position = UDim2.new(0.05, 0, 0.25, 0)
TargetBox.PlaceholderText = "Kurban Adı..."; TargetBox.Text = ""
TargetBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35); TargetBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", TargetBox)

-- [ GİZLİ ANIMASYON VERİTABANI ]
-- Not: Bunlar şu an aktif olanlar. Silinirse script otomatik "Lay" animasyonuna geçer.
local AnimList = {
    ["Bang"] = "148840371",
    ["Suck"] = "204328711",
    ["Kiss"] = "1215722202"
}

local active = false
local currentAnim = nil

-- [ ANA FONKSİYON ]
local function StartAction(mode)
    local targetName = TargetBox.Text:lower()
    local targetPlayer = nil
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():sub(1, #targetName) == targetName or v.DisplayName:lower():sub(1, #targetName) == targetName then
            targetPlayer = v
            break
        end
    end

    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        active = true
        
        -- Animasyon Hazırlığı
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. AnimList[mode]
        currentAnim = hum:LoadAnimation(anim)
        currentAnim:Play()
        currentAnim.Looped = true
        currentAnim:AdjustSpeed(2) -- Hız ayarı

        -- Arkasına Işınlanma ve Kilitlenme (Loop)
        task.spawn(function()
            while active and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") do
                -- Hedefin tam arkasına (offset) yapışma
                root.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.1)
                task.wait()
            end
        end)
    end
end

-- [ BUTONLAR ]
local ActionBtn = Instance.new("TextButton", Main)
ActionBtn.Size = UDim2.new(0.9, 0, 0, 40); ActionBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
ActionBtn.Text = "BAŞLAT (BANG)"; ActionBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ActionBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", ActionBtn)

local StopBtn = Instance.new("TextButton", Main)
StopBtn.Size = UDim2.new(0.9, 0, 0, 30); StopBtn.Position = UDim2.new(0.05, 0, 0.8, 0)
StopBtn.Text = "DURDUR / TEMİZLE"; StopBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
StopBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", StopBtn)

ActionBtn.MouseButton1Click:Connect(function()
    if not active then
        StartAction("Bang")
        ActionBtn.Text = "SİSTEM ÇALIŞIYOR..."
    end
end)

StopBtn.MouseButton1Click:Connect(function()
    active = false
    if currentAnim then currentAnim:Stop() end
    ActionBtn.Text = "BAŞLAT (BANG)"
end)

-- Kapatma Butonu
local X = Instance.new("TextButton", Main)
X.Size = UDim2.new(0, 20, 0, 20); X.Position = UDim2.new(1, -25, 0, 5)
X.Text = "X"; X.BackgroundColor3 = Color3.new(1,0,0); X.TextColor3 = Color3.new(1,1,1)
X.MouseButton1Click:Connect(function() sg:Destroy() end)

print("Maho18 Modülü Yüklendi! Kurbanını seç ve Anonymous ol.")
