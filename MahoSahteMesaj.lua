-- 🔥 MAHO GHOST CHAT v2 - HYBRID SYSTEM
local player = game:GetService("Players").LocalPlayer
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
sg.Name = "MahoGhostChatV2"

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 350)
Main.Position = UDim2.new(0.5, -150, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(0, 255, 150)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -50); Scroll.Position = UDim2.new(0, 10, 0, 40)
Scroll.BackgroundTransparency = 1; Scroll.CanvasSize = UDim2.new(0, 0, 1.2, 0)
Scroll.ScrollBarThickness = 2
local List = Instance.new("UIListLayout", Scroll); List.Padding = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40); Title.Text = "👻 GHOST CHAT V2"; Title.TextColor3 = Color3.new(1,1,1)
Title.Font = "GothamBold"; Title.BackgroundTransparency = 1

local TargetInput = Instance.new("TextBox", Scroll)
TargetInput.Size = UDim2.new(1, 0, 0, 40); TargetInput.PlaceholderText = "Kurban Adı..."
TargetInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35); TargetInput.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", TargetInput)

local MsgInput = Instance.new("TextBox", Scroll)
MsgInput.Size = UDim2.new(1, 0, 0, 80); MsgInput.PlaceholderText = "Mesaj..."; MsgInput.TextWrapped = true
MsgInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35); MsgInput.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", MsgInput)

local SendBtn = Instance.new("TextButton", Scroll)
SendBtn.Size = UDim2.new(1, 0, 0, 50); SendBtn.Text = "SEND SPOOF"
SendBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100); SendBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SendBtn)

SendBtn.MouseButton1Click:Connect(function()
    local msg = MsgInput.Text
    -- 1. Yöntem: Eski Chat Sistemi
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("SayMessageRequest", true)
    if remote then
        remote:FireServer(msg, "All")
    end
    
    -- 2. Yöntem: Yeni TextChatService
    local tcs = game:GetService("TextChatService")
    if tcs.ChatVersion == Enum.ChatVersion.TextChatService then
        local channel = tcs.TextChannels:FindFirstChild("RBXGeneral")
        if channel then channel:SendAsync(msg) end
    end
    
    SendBtn.Text = "DENENDİ!"; task.wait(1); SendBtn.Text = "SEND SPOOF"
end)

local X = Instance.new("TextButton", Main)
X.Size = UDim2.new(0, 30, 0, 30); X.Position = UDim2.new(1, -35, 0, 5); X.Text = "X"; X.TextColor3 = Color3.new(1,1,1); X.BackgroundTransparency = 1
X.MouseButton1Click:Connect(function() sg:Destroy() end)
