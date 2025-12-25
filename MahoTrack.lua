-- 🛡️ MAHO PLAYER TRACKER v1.0
-- 🎯 Single & Mass Tracking System
-- 🚀 Ultra Visual ESP & Tracer Support

local player = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")

-- [ TEMİZLİK ]
if coreGui:FindFirstChild("MahoTrackerUI") then coreGui.MahoTrackerUI:Destroy() end

-- [ UI SETUP ]
local sg = Instance.new("ScreenGui", coreGui); sg.Name = "MahoTrackerUI"
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 320, 0, 250); Main.Position = UDim2.new(0.5, 50, 0.5, -125)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local Stroke = Instance.new("UIStroke", Main); Stroke.Color = Color3.fromRGB(255, 150, 0); Stroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40); Title.Text = "MAHO TRACKER SYSTEM"; Title.TextColor3 = Color3.new(1,1,1)
Title.Font = "GothamBold"; Title.TextSize = 16; Title.BackgroundTransparency = 1

-- [ INPUT VE TEKLİ TRACK ]
local Input = Instance.new("TextBox", Main)
Input.Size = UDim2.new(0.65, -10, 0, 40); Input.Position = UDim2.new(0.05, 0, 0.25, 0)
Input.PlaceholderText = "Username..."; Input.BackgroundColor3 = Color3.fromRGB(25, 25, 30); Input.TextColor3 = Color3.new(1,1,1)
Input.Font = "GothamBold"; Instance.new("UICorner", Input)

local TrackBtn = Instance.new("TextButton", Main)
TrackBtn.Size = UDim2.new(0.25, 0, 0, 40); TrackBtn.Position = UDim2.new(0.7, 0, 0.25, 0)
TrackBtn.Text = "TRACK"; TrackBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0); TrackBtn.TextColor3 = Color3.new(1,1,1)
TrackBtn.Font = "GothamBold"; Instance.new("UICorner", TrackBtn)

-- [ HERKESİ TRACKLA BUTONU ]
local MassBtn = Instance.new("TextButton", Main)
MassBtn.Size = UDim2.new(0.9, 0, 0, 45); MassBtn.Position = UDim2.new(0.05, 0, 0.5, 0)
MassBtn.Text = "📡 HERKESİ TRACKLA (MASS)"; MassBtn.BackgroundColor3 = Color3.fromRGB(130, 0, 255); MassBtn.TextColor3 = Color3.new(1,1,1)
MassBtn.Font = "GothamBold"; Instance.new("UICorner", MassBtn)

local CleanBtn = Instance.new("TextButton", Main)
CleanBtn.Size = UDim2.new(0.9, 0, 0, 35); CleanBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
CleanBtn.Text = "TEMİZLE"; CleanBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55); CleanBtn.TextColor3 = Color3.new(1,1,1)
CleanBtn.Font = "GothamBold"; Instance.new("UICorner", CleanBtn)

-- [ FONKSİYONLAR ]
local function createTracker(target)
    if not target or not target.Character or target == player then return end
    local char = target.Character
    local head = char:FindFirstChild("Head")
    if not head or head:FindFirstChild("MahoTrack") then return end

    -- Billboard GUI (Kafa üstü isim)
    local bg = Instance.new("BillboardGui", head)
    bg.Name = "MahoTrack"; bg.Size = UDim2.new(0, 200, 0, 50); bg.Adornee = head; bg.AlwaysOnTop = true; bg.ExtentsOffset = Vector3.new(0, 3, 0)
    local tl = Instance.new("TextLabel", bg)
    tl.Size = UDim2.new(1, 0, 1, 0); tl.BackgroundTransparency = 1; tl.Text = target.DisplayName .. " (@" .. target.Name .. ")"
    tl.TextColor3 = Color3.fromRGB(255, 150, 0); tl.Font = "GothamBold"; tl.TextSize = 14; tl.TextStrokeTransparency = 0

    -- Tracer (İp/Çizgi efekti)
    local beam = Instance.new("Beam", player.Character:WaitForChild("HumanoidRootPart"))
    beam.Name = "Tracer_" .. target.Name
    local a0 = Instance.new("Attachment", player.Character.HumanoidRootPart)
    local a1 = Instance.new("Attachment", char:WaitForChild("HumanoidRootPart"))
    beam.Attachment0 = a0; beam.Attachment1 = a1
    beam.Width0 = 0.1; beam.Width1 = 0.1
    beam.Color = ColorSequence.new(Color3.fromRGB(255, 150, 0))
    beam.Transparency = NumberSequence.new(0.5) -- Şeffaf ip efekti
    beam.FaceCamera = true
end

local function clearTrackers()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character then
            if v.Character:FindFirstChild("Head") and v.Character.Head:FindFirstChild("MahoTrack") then v.Character.Head.MahoTrack:Destroy() end
            if player.Character and player.Character.HumanoidRootPart:FindFirstChild("Tracer_" .. v.Name) then
                player.Character.HumanoidRootPart["Tracer_" .. v.Name]:Destroy()
            end
        end
    end
end

-- [ BUTON TIKLAMALARI ]
TrackBtn.MouseButton1Click:Connect(function()
    local name = Input.Text:lower()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():sub(1, #name) == name or v.DisplayName:lower():sub(1, #name) == name then
            createTracker(v)
            break
        end
    end
end)

MassBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(game.Players:GetPlayers()) do
        createTracker(v)
    end
end)

CleanBtn.MouseButton1Click:Connect(clearTrackers)

local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0, 30, 0, 30); Close.Position = UDim2.new(1, -35, 0, 5); Close.Text = "X"; Close.BackgroundColor3 = Color3.fromRGB(200, 0, 0); Close.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", Close)
Close.MouseButton1Click:Connect(function() sg:Destroy() end)