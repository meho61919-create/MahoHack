-- 🔥 MAHO 18+ ANIMATION MODULE - PRO EDITION
-- 🛡️ meho61919-create | ScriptBlox Ultimate
-- ⚠️ UYARI: Bu script "R6" karakter tipinde en iyi sonucu verir.

local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local tweenService = game:GetService("TweenService")

-- [ ESKİ MENÜYÜ TEMİZLE ]
if game:GetService("CoreGui"):FindFirstChild("Maho18Menu") then 
    game:GetService("CoreGui").Maho18Menu:Destroy() 
end

-- [ UI OLUŞTURMA ]
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
sg.Name = "Maho18Menu"

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 350) -- UI büyütüldü
Main.Position = UDim2.new(0.5, -150, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 0, 80)
Stroke.Thickness = 2.5

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🔞 MAHO 18+ CONTROL"; Title.TextColor3 = Color3.new(1,1,1)
Title.Font = "GothamBold"; Title.TextSize = 16; Title.BackgroundTransparency = 1

local TargetBox = Instance.new("TextBox", Main)
TargetBox.Size = UDim2.new(0.9, 0, 0, 40); TargetBox.Position = UDim2.new(0.05, 0, 0.15, 0)
TargetBox.PlaceholderText = "Kurban Adı Giriniz..."; TargetBox.Text = ""
TargetBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30); TargetBox.TextColor3 = Color3.new(1,1,1)
TargetBox.Font = "Gotham"; TargetBox.TextSize = 14
Instance.new("UICorner", TargetBox)

-- [ GİZLİ ANIMASYON VERİTABANI ]
local AnimList = {
    ["🔥 BANG"] = "148840371",
    ["👅 SUCK"] = "204328711",
    ["💋 KISS"] = "1215722202",
    ["💃 LAPDANCE"] = "1215722202" -- Yedek animasyon
}

local active = false
local currentAnim = nil

-- [ ANA FONKSİYON ]
local function StartAction(mode, btn)
    local targetName = TargetBox.Text:lower()
    local targetPlayer = nil
    
    if targetName == "" then 
        btn.Text = "AD YAZMADIN!"; task.wait(1); btn.Text = mode; return 
    end

    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():sub(1, #targetName) == targetName or v.DisplayName:lower():sub(1, #targetName) == targetName then
            targetPlayer = v
            break
        end
    end

    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if active then -- Öncekini durdur
            active = false
            if currentAnim then currentAnim:Stop() end
        end
        
        active = true
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. AnimList[mode]
        currentAnim = hum:LoadAnimation(anim)
        currentAnim:Play()
        currentAnim.Looped = true
        currentAnim:AdjustSpeed(2.5)

        task.spawn(function()
            while active and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") do
                root.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.1)
                task.wait()
            end
        end)
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    else
        btn.Text = "OYUNCU BULUNAMADI!"; task.wait(1); btn.Text = mode
    end
end

-- [ BUTON OLUŞTURUCU ]
local function CreateAnimBtn(name, pos)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = "GothamBold"
    btn.TextSize = 14
    Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function()
        StartAction(name, btn)
    end)
    
    -- Hover efekti
    btn.MouseEnter:Connect(function()
        tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 50)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play()
    end)
end

-- Butonları Diz
CreateAnimBtn("🔥 BANG", UDim2.new(0.05, 0, 0.32, 0))
CreateAnimBtn("👅 SUCK", UDim2.new(0.05, 0, 0.47, 0))
CreateAnimBtn("💋 KISS", UDim2.new(0.05, 0, 0.62, 0))

local StopBtn = Instance.new("TextButton", Main)
StopBtn.Size = UDim2.new(0.9, 0, 0, 40); StopBtn.Position = UDim2.new(0.05, 0, 0.82, 0)
StopBtn.Text = "🛑 DURDUR VE AYRIL"; StopBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
StopBtn.TextColor3 = Color3.new(1,1,1); StopBtn.Font = "GothamBold"
Instance.new("UICorner", StopBtn)

StopBtn.MouseButton1Click:Connect(function()
    active = false
    if currentAnim then currentAnim:Stop() end
end)

-- Kapatma
local X = Instance.new("TextButton", Main)
X.Size = UDim2.new(0, 30, 0, 30); X.Position = UDim2.new(1, -35, 0, 5)
X.Text = "×"; X.TextColor3 = Color3.new(1,1,1); X.TextSize = 30; X.BackgroundTransparency = 1
X.MouseButton1Click:Connect(function() sg:Destroy() end)

print("Maho18 Pro Modülü Aktif! Hedefini seç ve eğlenceye başla.")
