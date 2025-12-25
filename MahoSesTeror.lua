-- 🔥 MAHO AUDIO TERROR v2 - ATTACHMENT SYSTEM
local player = game:GetService("Players").LocalPlayer
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
sg.Name = "MahoAudioV2"

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 400)
Main.Position = UDim2.new(0.5, -150, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 10, 10)
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(255, 0, 0)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -60); Scroll.Position = UDim2.new(0, 10, 0, 50)
Scroll.BackgroundTransparency = 1; Scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Scroll.ScrollBarThickness = 3
local List = Instance.new("UIListLayout", Scroll); List.Padding = UDim.new(0, 8)

local TargetInput = Instance.new("TextBox", Scroll)
TargetInput.Size = UDim2.new(1, 0, 0, 40); TargetInput.PlaceholderText = "Kurban Adı..."
TargetInput.BackgroundColor3 = Color3.fromRGB(40, 20, 20); TargetInput.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", TargetInput)

local function PlayTerror(id)
    local targetName = TargetInput.Text:lower()
    local target = nil
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():sub(1, #targetName) == targetName then target = v break end
    end

    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        -- SESİ KENDİNE OLUŞTUR AMA KURBANA YAPIŞTIR
        local soundPart = Instance.new("Part", workspace)
        soundPart.Transparency = 1; soundPart.CanCollide = false; soundPart.Anchored = false
        
        local sound = Instance.new("Sound", soundPart)
        sound.SoundId = "rbxassetid://" .. id
        sound.Volume = 10; sound.Looped = false; sound:Play()
        
        -- Kurbanın kafasına takip ettir
        task.spawn(function()
            while sound.IsPlaying do
                if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    soundPart.CFrame = target.Character.HumanoidRootPart.CFrame
                end
                task.wait()
            end
            soundPart:Destroy()
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

AddSnd("💀 JUMPSCARE SCREAM", "5567523620")
AddSnd("👣 PSYCHO BREATHING", "154563032")
AddSnd("📺 STATIC NOISE", "165430869")
AddSnd("👻 CREEPY WHISPER", "142445851")
AddSnd("🚪 KNOCKING", "142445851")

local X = Instance.new("TextButton", Main)
X.Size = UDim2.new(0, 30, 0, 30); X.Position = UDim2.new(1, -35, 0, 5); X.Text = "X"; X.TextColor3 = Color3.new(1,1,1); X.BackgroundTransparency = 1
X.MouseButton1Click:Connect(function() sg:Destroy() end)
