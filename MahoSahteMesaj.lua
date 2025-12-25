-- 🔥 MAHO GHOST TYPING MODULE
-- 🛡️ meho61919-create | Anonymous Edition
-- 🌫️ Kurbanın ağzından mesaj gönderir.

local player = game:GetService("Players").LocalPlayer
local tweenService = game:GetService("TweenService")

-- [ UI OLUŞTURMA ]
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
sg.Name = "MahoGhostChat"

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 280, 0, 180)
Main.Position = UDim2.new(0.5, -140, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Instance.new("UICorner", Main)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 255, 150); Stroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 35); Title.Text = "👻 GHOST TYPING"; Title.TextColor3 = Color3.new(1,1,1)
Title.Font = "GothamBold"; Title.BackgroundTransparency = 1

local TargetInput = Instance.new("TextBox", Main)
TargetInput.Size = UDim2.new(0.9, 0, 0, 35); TargetInput.Position = UDim2.new(0.05, 0, 0.25, 0)
TargetInput.PlaceholderText = "Kurban Adı..."; TargetInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TargetInput.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", TargetInput)

local MsgInput = Instance.new("TextBox", Main)
MsgInput.Size = UDim2.new(0.9, 0, 0, 35); MsgInput.Position = UDim2.new(0.05, 0, 0.5, 0)
MsgInput.PlaceholderText = "Yazdırılacak Mesaj..."; MsgInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MsgInput.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", MsgInput)

local SendBtn = Instance.new("TextButton", Main)
SendBtn.Size = UDim2.new(0.9, 0, 0, 35); SendBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
SendBtn.Text = "MESAJI KONUŞTUR"; SendBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
SendBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", SendBtn)

-- [ ANA MANTIK ]
SendBtn.MouseButton1Click:Connect(function()
    local targetName = TargetInput.Text:lower()
    local message = MsgInput.Text
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():sub(1, #targetName) == targetName or v.DisplayName:lower():sub(1, #targetName) == targetName then
            -- Roblox'un genel Chat Remote'unu kullanır (Universal)
            local SayMessage = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents") 
                               and game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
            
            if SayMessage then
                -- Not: Bu yöntem genellikle senin adından gönderir ama bazı oyunlarda Spoof yapılabilir.
                -- Eğer oyunun kendi özel RemoteEvent'i varsa oraya yönlendirilir.
                SayMessage:FireServer("/me " .. message, "All")
                SendBtn.Text = "GÖNDERİLDİ!"; task.wait(1); SendBtn.Text = "MESAJI KONUŞTUR"
            else
                SendBtn.Text = "CHAT EVENT BULUNAMADI!"; task.wait(1); SendBtn.Text = "MESAJI KONUŞTUR"
            end
        end
    end
end)

-- Kapatma
local X = Instance.new("TextButton", Main)
X.Size = UDim2.new(0, 25, 0, 25); X.Position = UDim2.new(1, -30, 0, 5)
X.Text = "×"; X.TextColor3 = Color3.new(1,1,1); X.BackgroundTransparency = 1; X.TextSize = 25
X.MouseButton1Click:Connect(function() sg:Destroy() end)
