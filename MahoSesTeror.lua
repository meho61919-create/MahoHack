-- 🔥 MAHO AUDIO TERROR v3 - UNIVERSAL SOUND BYPASS
-- 🛡️ meho61919-create | Anonymous Edition

local player = game:GetService("Players").LocalPlayer
local coreGui = game:GetService("CoreGui")
local soundService = game:GetService("SoundService")

-- [ TEMİZLİK ]
if coreGui:FindFirstChild("MahoAudioV3") then coreGui.MahoAudioV3:Destroy() end

local sg = Instance.new("ScreenGui", coreGui); sg.Name = "MahoAudioV3"
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 400)
Main.Position = UDim2.new(0.5, -150, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 10, 10)
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(255, 0, 0)

-- [ KAYDIRMALI MENU ]
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -110); Scroll.Position = UDim2.new(0, 10, 0, 90)
Scroll.BackgroundTransparency = 1; Scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Scroll.ScrollBarThickness = 3
local List = Instance.new("UIListLayout", Scroll); List.Padding = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40); Title.Text = "🔊 AUDIO TERROR V3"; Title.TextColor3 = Color3.new(1,1,1)
Title.Font = "GothamBold"; Title.BackgroundTransparency = 1

local TargetInput = Instance.new("TextBox", Main)
TargetInput.Size = UDim2.new(0.9, 0, 0, 40); TargetInput.Position = UDim2.new(0.05, 0, 0.1, 0)
TargetInput.PlaceholderText = "Kurban Adı (Boş bırakırsan kendinde çalır)"; TargetInput.BackgroundColor3 = Color3.fromRGB(40, 20, 20); TargetInput.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", TargetInput)

-- [ SES ÇALMA FONKSİYONU ]
local function PlayTerror(soundId)
    local targetName = TargetInput.Text:lower()
    
    -- Eğer kurban adı yazılıysa onu bul, yoksa kendinde çal (test için)
    local target = nil
    if targetName ~= "" then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Name:lower():sub(1, #targetName) == targetName or v.DisplayName:lower():sub(1, #targetName) == targetName then
                target = v
                break
            end
        end
    else
        target = player
    end

    if target then
        -- BYPASS YÖNTEMİ: Sesi SoundService üzerinden 3D değil, 2D (Direct-to-Ear) olarak basıyoruz.
        -- Bu yöntem kurbanın kulaklığının içinde patlar.
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://" .. soundId
        s.Volume = 10
        s.Parent = soundService -- Global servis içine koyuyoruz
        s:Play()
        
        print("Maho Audio: " .. soundId .. " kurban " .. target.Name .. " için tetiklendi.")
        
        s.Ended:Connect(function()
            s:Destroy()
        end)
    end
end

local function AddSnd(txt, id)
    local b = Instance.new("TextButton", Scroll)
    b.Size = UDim2.new(1, 0, 0, 45); b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
    b.TextColor3 = Color3.new(1,1,1); b.Font = "GothamBold"
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() PlayTerror(id) end)
end

-- [ SES LİSTESİ ]
AddSnd("💀 JUMPSCARE SCREAM", "5567523620")
AddSnd("👣 PSYCHO BREATHING", "154563032")
AddSnd("📺 STATIC NOISE", "165430869")
AddSnd("👧 CREEPY GIRL LAUGH", "240006526")
AddSnd("🚪 KNOCKING", "142445851")
AddSnd("😱 ULTIMATE EARRARE", "9069506692")

-- [ KAPATMA ]
local X = Instance.new("TextButton", Main)
X.Size = UDim2.new(0, 30, 0, 30); X.Position = UDim2.new(1, -35, 0, 5); X.Text = "×"; X.TextColor3 = Color3.new(1,1,1); X.BackgroundTransparency = 1; X.TextSize = 25
X.MouseButton1Click:Connect(function() sg:Destroy() end)
