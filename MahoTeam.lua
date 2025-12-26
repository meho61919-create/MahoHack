-- 🔥 MAHO TEAM ELITE v13.5 (ULTRA INFILTRATOR)
-- 💎 NAME TAG + ESP + NOCLIP + CLOSE SYSTEM

local Player = game.Players.LocalPlayer
local Teams = game:GetService("Teams")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- ESKİ UI TEMİZLİĞİ
local old = game.CoreGui:FindFirstChild("MahoBabaUI")
if old then old:Destroy() end

-- DEĞİŞKENLER
local noclipActive = false

-- ANA UI BAŞLANGIÇ
local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "MahoBabaUI"; sg.ResetOnSpawn = false
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 320, 0, 440); main.Position = UDim2.new(0.5, -160, 0.5, -220)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 12); main.BorderSizePixel = 0; main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", main); stroke.Color = Color3.fromRGB(130, 0, 255); stroke.Thickness = 2

-- BAŞLIK (HEADER)
local header = Instance.new("Frame", main); header.Size = UDim2.new(1, 0, 0, 50); header.BackgroundColor3 = Color3.fromRGB(20, 20, 25); header.BorderSizePixel = 0
local title = Instance.new("TextLabel", header); title.Size = UDim2.new(1, 0, 1, 0); title.Text = "👑 MAHO ELITE v13.5"; title.TextColor3 = Color3.new(1, 1, 1); title.Font = "GothamBold"; title.TextSize = 16; title.BackgroundTransparency = 1

-- KAPATMA TUŞU (X)
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = "GothamBold"
closeBtn.TextSize = 14
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

-- DURUM PANELİ
local status = Instance.new("TextLabel", main); status.Size = UDim2.new(1, -20, 0, 20); status.Position = UDim2.new(0, 10, 0, 55); status.Text = "SUNUCU ANALİZİ BEKLENİYOR..."; status.TextColor3 = Color3.fromRGB(150, 150, 150); status.BackgroundTransparency = 1; status.Font = "GothamMedium"; status.TextSize = 10; status.TextXAlignment = "Left"

-- LİSTE
local scroll = Instance.new("ScrollingFrame", main); scroll.Size = UDim2.new(1, -20, 1, -145); scroll.Position = UDim2.new(0, 10, 0, 125); scroll.BackgroundTransparency = 1; scroll.ScrollBarThickness = 0
local layout = Instance.new("UIListLayout", scroll); layout.Padding = UDim.new(0, 8)

-- [ 🛡️ NOCLIP SİSTEMİ ]
RunService.Stepped:Connect(function()
    if noclipActive and Player.Character then
        for _, part in pairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- [ 👑 MAHO BABA NAME TAG ]
local function applyMahoTag()
    local char = Player.Character or Player.CharacterAdded:Wait()
    local head = char:WaitForChild("Head", 10)
    if head then
        for _, v in pairs(head:GetChildren()) do if v:IsA("BillboardGui") then v:Destroy() end end
        local tag = Instance.new("BillboardGui", head)
        tag.Size = UDim2.new(0, 200, 0, 50); tag.AlwaysOnTop = true; tag.ExtentsOffset = Vector3.new(0, 4, 0)
        local txt = Instance.new("TextLabel", tag)
        txt.Size = UDim2.new(1, 0, 1, 0); txt.Text = "👑 MAHO BABA"; txt.TextColor3 = Color3.fromRGB(130, 0, 255)
        txt.BackgroundTransparency = 1; txt.Font = "GothamBold"; txt.TextSize = 25
        task.spawn(function()
            while tag and tag.Parent do
                pcall(function()
                    TweenService:Create(txt, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {TextSize = 32, TextColor3 = Color3.new(1,1,1)}):Play()
                    task.wait(0.8)
                    TweenService:Create(txt, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {TextSize = 24, TextColor3 = Color3.fromRGB(130, 0, 255)}):Play()
                    task.wait(0.8)
                end)
            end
        end)
    end
end

-- [ 👁️ ESP SİSTEMİ ]
local function applyESP()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= Player then
            local function createESP(char)
                if not char then return end
                local highlight = char:FindFirstChild("MahoESP") or Instance.new("Highlight")
                highlight.Name = "MahoESP"
                highlight.Parent = char
                highlight.FillColor = p.TeamColor.Color
                highlight.OutlineColor = Color3.new(1, 1, 1)
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
            end
            createESP(p.Character)
            p.CharacterAdded:Connect(createESP)
        end
    end
end

-- [ 🚀 KRİTİK IŞINLANMA MOTORU ]
local function safeTeleport(targetCFrame)
    local char = Player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if hrp and hum then
        hrp.Velocity = Vector3.new(0, 0, 0)
        hrp.RotVelocity = Vector3.new(0, 0, 0)
        char:MoveTo(targetCFrame.Position)
        task.wait(0.05)
        hrp.CFrame = targetCFrame * CFrame.new(0, 3, 0)
        hum.Sit = false
    end
end

local function instantTeleport(targetTeam)
    local found = false
    for _, s in pairs(workspace:GetDescendants()) do
        if s:IsA("SpawnLocation") and s.TeamColor == targetTeam.TeamColor then
            safeTeleport(s.CFrame)
            status.Text = "SİSTEM: " .. targetTeam.Name:upper() .. " BÖLGESİNE SIZILDI."
            found = true
            break
        end
    end
    if not found then status.Text = "HATA: SPAWN NOKTASI BULUNAMADI!" end
end

-- [ 🔍 ANALİZ VE TARAMA ]
local scanBtn = Instance.new("TextButton", main); scanBtn.Size = UDim2.new(1, -20, 0, 40); scanBtn.Position = UDim2.new(0, 10, 0, 80); scanBtn.Text = "OYUNU VE TAKIMLARI ANALİZ ET"; scanBtn.BackgroundColor3 = Color3.fromRGB(130, 0, 255); scanBtn.TextColor3 = Color3.new(1, 1, 1); scanBtn.Font = "GothamBold"; Instance.new("UICorner", scanBtn)

scanBtn.MouseButton1Click:Connect(function()
    status.Text = "ANALİZ EDİLİYOR... LÜTFEN BEKLEYİN..."
    for _, v in pairs(scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    task.wait(0.5)
    local teamList = Teams:GetChildren()
    if #teamList == 0 then status.Text = "SİSTEM: TAKIM SİSTEMİ YOK!"; return end

    for i, t in pairs(teamList) do
        local b = Instance.new("TextButton", scroll)
        b.Size = UDim2.new(1, 0, 0, 45); b.Text = t.Name:upper(); b.BackgroundColor3 = Color3.fromRGB(25, 25, 30); b.TextColor3 = t.TeamColor.Color; b.Font = "GothamSemibold"; b.TextSize = 14; Instance.new("UICorner", b)
        local bS = Instance.new("UIStroke", b); bS.Thickness = 1.5; bS.Color = t.TeamColor.Color; bS.Transparency = 0.4

        b.MouseButton1Click:Connect(function()
            noclipActive = true
            applyESP()
            applyMahoTag()
            
            pcall(function()
                Player.Team = t
                for _, r in pairs(game:GetDescendants()) do
                    if r:IsA("RemoteEvent") and (r.Name:lower():find("team") or r.Name:lower():find("change")) then
                        r:FireServer(t)
                    end
                end
            end)
            
            instantTeleport(t)
            task.delay(0.2, function() instantTeleport(t) end)
            status.Text = "SİSTEM: TÜM MODLAR AKTİF!"
        end)
    end
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    status.Text = "SİSTEM: " .. #teamList .. " ADET TAKIM ANALİZ EDİLDİ."
end)

-- SÜRÜKLENEBİLİR YAPMA
local dragging, dragStart, startPos
header.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = input.Position; startPos = main.Position end end)
UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then local delta = input.Position - dragStart; main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
