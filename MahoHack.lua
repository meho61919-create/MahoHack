-- 🔥 MAHO ELITE v11.9 - SCRIPTBLOX ULTIMATE OPTIMIZED (ANIMATED)
-- 🛡️ meho61919-create | Ultra Quality UI & Animation System
-- 🌪️ Güncelleme: Işınlanma Aracı (Click TP) Modülü Entegre Edildi.

local player = game:GetService("Players").LocalPlayer
local coreGui = game:GetService("CoreGui")
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local ts = game:GetService("TeleportService")
local tweenService = game:GetService("TweenService")
local camera = workspace.CurrentCamera

-- [ TEMİZLİK ]
if coreGui:FindFirstChild("MahoEliteV11") then coreGui.MahoEliteV11:Destroy() end

-- [ ANA GUI ]
local sg = Instance.new("ScreenGui", coreGui); sg.Name = "MahoEliteV11"; sg.ResetOnSpawn = false
local Main = Instance.new("Frame", sg)

Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

local Canvas = Instance.new("CanvasGroup", Main)
Canvas.Size = UDim2.new(1, 0, 1, 0)
Canvas.BackgroundTransparency = 1
Canvas.GroupTransparency = 1
Instance.new("UICorner", Canvas).CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(130, 0, 255)
Stroke.Thickness = 2.5
Stroke.Transparency = 1

-- [ MINIMIZE & KAPATMA ]
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 0, 0, 0)
OpenBtn.Position = UDim2.new(1, -60, 1, -60)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 18); OpenBtn.Text = "M"; OpenBtn.TextColor3 = Color3.fromRGB(130, 0, 255)
OpenBtn.Font = "GothamBold"; OpenBtn.TextSize = 25; OpenBtn.Visible = false
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)
local OpenStroke = Instance.new("UIStroke", OpenBtn)
OpenStroke.Color = Color3.fromRGB(130, 0, 255); OpenStroke.Thickness = 2

local CloseBtn = Instance.new("TextButton", Canvas)
CloseBtn.Size = UDim2.new(0, 30, 0, 30); CloseBtn.Position = UDim2.new(1, -40, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0); CloseBtn.Text = "X"; CloseBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", CloseBtn)

-- [ ANIMASYON FONKSİYONLARI ]
local function OpenUI()
    Main.Visible = true
    OpenBtn:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true, function() OpenBtn.Visible = false end)
    tweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 380, 0, 520),
        Position = UDim2.new(0.5, -190, 0.5, -260)
    }):Play()
    task.wait(0.2)
    tweenService:Create(Canvas, TweenInfo.new(0.4), {GroupTransparency = 0}):Play()
    tweenService:Create(Stroke, TweenInfo.new(0.4), {Transparency = 0}):Play()
end

local function CloseUI()
    tweenService:Create(Canvas, TweenInfo.new(0.3), {GroupTransparency = 1}):Play()
    tweenService:Create(Stroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
    task.wait(0.1)
    tweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(1, -35, 1, -35)
    }):Play()
    task.wait(0.5)
    Main.Visible = false
    OpenBtn.Visible = true
    OpenBtn:TweenSize(UDim2.new(0, 50, 0, 50), "Out", "Elastic", 0.6)
end

CloseBtn.MouseButton1Click:Connect(CloseUI)
OpenBtn.MouseButton1Click:Connect(OpenUI)

-- [ HEADER ]
local Title = Instance.new("TextLabel", Canvas)
Title.Size = UDim2.new(1, 0, 0, 60); Title.Text = "MAHO ELITE v11.9"; Title.TextColor3 = Color3.new(1,1,1)
Title.Font = "GothamBold"; Title.TextSize = 22; Title.BackgroundTransparency = 1

-- [ SCROLLING FRAME ]
local Scroll = Instance.new("ScrollingFrame", Canvas)
Scroll.Size = UDim2.new(1, -20, 1, -80); Scroll.Position = UDim2.new(0, 10, 0, 70)
Scroll.BackgroundTransparency = 1; Scroll.CanvasSize = UDim2.new(0, 0, 0, 1500); Scroll.ScrollBarThickness = 3
local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0, 10); List.SortOrder = Enum.SortOrder.LayoutOrder

-- --- ⚙️ CORE LOGICS ---
local noclip, infJump, spinBot, magnet, flying = false, false, false, false, false
local orbitActive, flingActive, aimbotEnabled = false, false, false
local flySpeed = 50

local function AddButton(text, color, callback)
    local b = Instance.new("TextButton", Scroll)
    b.Size = UDim2.new(1, -10, 0, 48); b.BackgroundColor3 = color
    b.Text = text; b.TextColor3 = Color3.new(1,1,1); b.Font = "GothamBold"; b.TextSize = 14
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(callback)
    return b
end

local function AddLabel(text)
    local l = Instance.new("TextLabel", Scroll)
    l.Size = UDim2.new(1, -10, 0, 30); l.BackgroundTransparency = 1
    l.Text = "-- " .. text .. " --"; l.TextColor3 = Color3.fromRGB(130, 0, 255)
    l.Font = "GothamBold"; l.TextSize = 14
    return l
end

local function AddToggle(text, color, callback)
    local state = false
    local b = AddButton(text .. " : PASİF", Color3.fromRGB(25, 25, 30), function() end)
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = text .. (state and " : AKTİF" or " : PASİF")
        b.BackgroundColor3 = state and color or Color3.fromRGB(25, 25, 30)
        callback(state)
    end)
end

-- --- 📋 KOMUTLAR ---

-- 0. TARGETING SYSTEM (TP & BRING)
local TargetContainer = Instance.new("Frame", Scroll)
TargetContainer.Size = UDim2.new(1, -10, 0, 110); TargetContainer.BackgroundTransparency = 1

local TPInput = Instance.new("TextBox", TargetContainer)
TPInput.Size = UDim2.new(0.65, -5, 0, 110); TPInput.PlaceholderText = "Kurban Adı..."; TPInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30); TPInput.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", TPInput)

local TPBtn = Instance.new("TextButton", TargetContainer)
TPBtn.Size = UDim2.new(0.35, 0, 0, 50); TPBtn.Position = UDim2.new(0.65, 5, 0, 0); TPBtn.Text = "TP TO"; TPBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255); TPBtn.TextColor3 = Color3.new(1,1,1); TPBtn.Font = "GothamBold"; Instance.new("UICorner", TPBtn)

local BringBtn = Instance.new("TextButton", TargetContainer)
BringBtn.Size = UDim2.new(0.35, 0, 0, 50); BringBtn.Position = UDim2.new(0.65, 5, 0, 60); BringBtn.Text = "BRING"; BringBtn.BackgroundColor3 = Color3.fromRGB(130, 0, 255); BringBtn.TextColor3 = Color3.new(1,1,1); BringBtn.Font = "GothamBold"; Instance.new("UICorner", BringBtn)

local function getTarget()
    local targetName = TPInput.Text:lower()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():sub(1, #targetName) == targetName or v.DisplayName:lower():sub(1, #targetName) == targetName then
            return v
        end
    end
    return nil
end

TPBtn.MouseButton1Click:Connect(function()
    local target = getTarget()
    if target and target.Character then
        player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
    end
end)

BringBtn.MouseButton1Click:Connect(function()
    local target = getTarget()
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        target.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
    end
end)

-- 1. ANA PANELLER
AddLabel("ANA SİSTEMLER")
AddButton("🔞 | 18+ ANIMASYON PANELİ", Color3.fromRGB(200, 0, 50), function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/meho61919-create/MahoHack/main/Maho18.lua"))() 
end)
AddButton("👤 | PLAYER STICKER PANELİ", Color3.fromRGB(255, 0, 100), function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/meho61919-create/MahoHack/main/MahoStick.lua"))() 
end)
AddButton("🌌 | CHAT LOGS PANELİ", Color3.fromRGB(0, 255, 120), function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/meho61919-create/MahoHack/main/Maho_Phantom.lua"))() 
end)
AddButton("🎖️ | JACK AUTO PANELİ", Color3.fromRGB(130, 0, 255), function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/meho61919-create/MahoHack/main/MahoAutomation.lua"))() 
end)
AddButton("📝 | GRAMER PANELİ", Color3.fromRGB(0, 120, 255), function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/meho61919-create/MahoHack/main/MahoGrammar.lua"))() 
end)
AddButton("🎭 | TRACK PANELİ", Color3.fromRGB(255, 200, 50), function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/meho61919-create/MahoHack/refs/heads/main/MahoTrack.lua"))() 
end)
AddButton("✍️ | SAHTE MESAJ PANELİ", Color3.fromRGB(150, 150, 255), function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/meho61919-create/MahoHack/refs/heads/main/MahoSahteMesaj.lua"))() 
end)

-- 2. ÖZEL HİLELER (YENİ)
AddLabel("ELITE HİLELER")

local function getClosestPlayer()
    local closest, dist = nil, math.huge
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local screenPos, onScreen = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
            if onScreen then
                local d = (Vector2.new(uis:GetMouseLocation().X, uis:GetMouseLocation().Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                if d < dist then closest = v; dist = d end
            end
        end
    end
    return closest
end

AddToggle("🎯 | LEGIT AIMBOT", Color3.fromRGB(255, 50, 50), function(v)
    aimbotEnabled = v
    task.spawn(function()
        while aimbotEnabled do
            local target = getClosestPlayer()
            if target and target.Character and target.Character:FindFirstChild("Head") then
                camera.CFrame = CFrame.new(camera.CFrame.Position, target.Character.Head.Position)
            end
            rs.RenderStepped:Wait()
        end
    end)
end)

-- 3. GENEL HİLELER
AddLabel("GENEL HİLELER")

local currentDetain = nil
AddToggle("⛓️ | GET DETAIN TOOL", Color3.fromRGB(100, 100, 110), function(v)
    if v then
        currentDetain = Instance.new("Tool")
        currentDetain.Name = "Maho Detain"; currentDetain.RequiresHandle = false; currentDetain.Parent = player.Backpack
        currentDetain.Activated:Connect(function()
            local mouse = player:GetMouse()
            local target = mouse.Target
            if target and target.Parent:FindFirstChild("Humanoid") then
                local targetChar = target.Parent
                task.spawn(function()
                    while currentDetain and currentDetain.Parent == player.Character do
                        targetChar.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4)
                        targetChar.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                        task.wait()
                    end
                end)
            end
        end)
    else
        if currentDetain then currentDetain:Destroy(); currentDetain = nil end
    end
end)

local tpTool = nil
AddToggle("📍 | IŞINLANMA ARACI", Color3.fromRGB(0, 255, 150), function(v)
    if v then
        tpTool = Instance.new("Tool")
        tpTool.Name = "Maho Işınlan"; tpTool.RequiresHandle = false; tpTool.Parent = player.Backpack
        tpTool.Activated:Connect(function()
            local mouse = player:GetMouse()
            if mouse.Target then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
            end
        end)
    else
        if tpTool then tpTool:Destroy(); tpTool = nil end
    end
end)

AddToggle("🌀 ORBIT (HEDEFE YAPIŞ)", Color3.fromRGB(130, 0, 255), function(v)
    orbitActive = v
    local angle = 0
    task.spawn(function()
        while orbitActive do
            local target = getTarget()
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                angle = angle + 0.15
                player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, angle, 0) * CFrame.new(0, 0, 5)
            end
            rs.Stepped:Wait()
        end
    end)
end)

AddToggle("🚀 INVISIBLE FLING", Color3.fromRGB(255, 0, 0), function(v)
    flingActive = v
    if v then
        task.spawn(function()
            while flingActive do
                local target = getTarget()
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                if target and target.Character and hrp then
                    hrp.Velocity = Vector3.new(500000, 500000, 500000)
                    hrp.CFrame = target.Character.HumanoidRootPart.CFrame
                end
                rs.Stepped:Wait()
            end
            if player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            end
        end)
    end
end)

AddToggle("🦅 FLY MODE", Color3.fromRGB(180, 0, 50), function(v)
    flying = v
    local char = player.Character
    if flying and char then
        local bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
        local bg = Instance.new("BodyGyro", char.HumanoidRootPart)
        bv.Name = "MahoFly_BV"; bg.Name = "MahoFly_BG"
        bv.MaxForce = Vector3.new(1e8, 1e8, 1e8); bg.MaxTorque = Vector3.new(1e8, 1e8, 1e8)
        task.spawn(function()
            while flying do
                bv.Velocity = camera.CFrame.LookVector * (uis:IsKeyDown(Enum.KeyCode.W) and flySpeed or 0)
                bg.CFrame = camera.CFrame
                task.wait()
            end
            bv:Destroy(); bg:Destroy()
        end)
    end
end)

AddToggle("👻 Infinite Jump", Color3.fromRGB(200, 150, 0), function(v) infJump = v end)
AddToggle("🌀 Spin Bot", Color3.fromRGB(200, 150, 0), function(v) spinBot = v end)
AddToggle("🧲 Item Magnet", Color3.fromRGB(200, 150, 0), function(v) magnet = v end)
AddToggle("🏃 Speed Hack", Color3.fromRGB(0, 180, 120), function(v) player.Character.Humanoid.WalkSpeed = v and 80 or 16 end)
AddToggle("🧱 NoClip", Color3.fromRGB(200, 100, 0), function(v) noclip = v end)

-- 4. REJOIN
AddButton("🔄 REJOIN SERVER", Color3.fromRGB(40, 40, 45), function() ts:Teleport(game.PlaceId) end)

-- --- 🚀 EXECUTION (INTRO) ---
OpenUI()

-- --- 🚀 LOOP ---
uis.JumpRequest:Connect(function() if infJump then player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end)
rs.Stepped:Connect(function()
    if noclip and player.Character then for _, v in pairs(player.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
    if spinBot and player.Character:FindFirstChild("HumanoidRootPart") then player.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(30), 0) end
    if magnet then
        for _, i in pairs(workspace:GetDescendants()) do
            if i:IsA("TouchTransmitter") then pcall(function() firetouchinterest(player.Character.HumanoidRootPart, i.Parent, 0); firetouchinterest(player.Character.HumanoidRootPart, i.Parent, 1) end) end
        end
    end
end)

print("MAHO ELITE v11.9: TELEPORT TOOL & UPDATES READY!")
