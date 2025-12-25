-- 🔥 MAHO AUDIO TERROR MODULE
-- 🛡️ meho61919-create | Anonymous Edition
-- 🔊 Kurbana psikolojik ses saldırısı yapar.

local player = game:GetService("Players").LocalPlayer
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
sg.Name = "MahoAudioTerror"

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 280, 0, 250)
Main.Position = UDim2.new(0.5, -140, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 10, 10)
Instance.new("UICorner", Main)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 0, 0); Stroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 35); Title.Text = "🔊 AUDIO TERROR"; Title.TextColor3 = Color3.new(1,1,1)
Title.Font = "GothamBold"; Title.BackgroundTransparency = 1

local TargetInput = Instance.new("TextBox", Main)
TargetInput.Size = UDim2.new(0.9, 0, 0, 35); TargetInput.Position = UDim2.new(0.05, 0, 0.2, 0)
TargetInput.PlaceholderText = "Kurban Adı..."; TargetInput.BackgroundColor3 = Color3.fromRGB(30, 20, 20)
TargetInput.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", TargetInput)

-- [ SES FONKSİYONU ]
local function PlayTerror(soundId, volume)
    local targetName = TargetInput.Text:lower()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():sub(1, #targetName) == targetName and v.Character then
            local root = v.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local s = Instance.new("Sound", root)
                s.SoundId = "rbxassetid://" .. soundId
                s.Volume = volume or 5
                s.Pitch = 0.8 -- Daha korkunç ve kalın ses
                s:Play()
                s.Ended:Connect(function() s:Destroy() end)
            end
        end
    end
end

-- [ BUTONLAR ]
local function CreateBtn(text, id, pos, vol)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Position = pos
    btn.Text = text; btn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
    btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() PlayTerror(id, vol) end)
end

CreateBtn("💀 ÇIĞLIK (JUMPSCARE)", "5567523620", UDim2.new(0.05, 0, 0.4, 0), 10)
CreateBtn("👣 NEFES SESİ", "154563032", UDim2.new(0.05, 0, 0.58, 0), 3)
CreateBtn("📺 PARAZİT / STATIC", "165430869", UDim2.new(0.05, 0, 0.76, 0), 5)

-- Kapatma
local X = Instance.new("TextButton", Main)
X.Size = UDim2.new(0, 25, 0, 25); X.Position = UDim2.new(1, -30, 0, 5)
X.Text = "×"; X.TextColor3 = Color3.new(1,1,1); X.BackgroundTransparency = 1; X.TextSize = 25
X.MouseButton1Click:Connect(function() sg:Destroy() end)
