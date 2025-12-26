-- MAHO TEAM LITE (Sıfır Hata Versiyonu)
local Player = game.Players.LocalPlayer
local Teams = game:GetService("Teams")

-- ESKİ UI VARSA YOK ET
local old = game.CoreGui:FindFirstChild("MahoLite")
if old then old:Destroy() end

-- ANA EKRAN
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "MahoLite"

-- ANA KUTU
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 250, 0, 350)
frame.Position = UDim2.new(0.5, -125, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.Active = true
frame.Draggable = true -- Menüyü sürükleyebilirsin

-- BAŞLIK
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "MAHO TEAM ELITE"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
title.Font = Enum.Font.GothamBold

-- LİSTE ALANI
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -20, 1, -100)
scroll.Position = UDim2.new(0, 10, 0, 90)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 2, 0)

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 5)

-- TAKIMLARI ÇEK BUTONU
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(1, -20, 0, 40)
btn.Position = UDim2.new(0, 10, 0, 45)
btn.Text = "TAKIMLARI ANALİZ ET"
btn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamSemibold

-- FONKSİYON: TAKIM SEÇ VE IŞINLA
local function join(t)
    Player.Team = t
    -- Işınlanma ve Reset Mantığı
    if Player.Character then
        Player.Character:BreakJoints() -- Reset atar
    end
    
    Player.CharacterAdded:Connect(function(char)
        task.wait(1)
        for _, s in pairs(workspace:GetDescendants()) do
            if s:IsA("SpawnLocation") and s.TeamColor == t.TeamColor then
                char:MoveTo(s.Position + Vector3.new(0, 3, 0))
                break
            end
        end
    end)
end

-- BUTON TIKLAMA
btn.MouseButton1Click:Connect(function()
    for _, v in pairs(scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    
    for _, t in pairs(Teams:GetChildren()) do
        local tbtn = Instance.new("TextButton", scroll)
        tbtn.Size = UDim2.new(1, 0, 0, 35)
        tbtn.Text = t.Name
        tbtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        tbtn.TextColor3 = t.TeamColor.Color
        tbtn.Font = Enum.Font.Gotham
        
        tbtn.MouseButton1Click:Connect(function()
            join(t)
        end)
    end
end)

print("Maho Elite Lite Yüklendi!")
