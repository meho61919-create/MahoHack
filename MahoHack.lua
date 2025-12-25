-- 🔥 MAHO ELITE v11.9 - SCRIPTBLOX ULTIMATE OPTIMIZED (ANIMATED)
-- 🛡️ meho61919-create | Ultra Quality UI & Animation System
-- 🌪️ Yeni: Detain (Kelepçele-Götür) Modülü Eklendi.

local player = game:GetService("Players").LocalPlayer
local coreGui = game:GetService("CoreGui")
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local ts = game:GetService("TeleportService")
local tweenService = game:GetService("TweenService")

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
        Size = UDim2.new(0, 380, 0, 500),
        Position = UDim2.new(0.5, -190, 0.5, -250)
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
Scroll.BackgroundTransparency = 1; Scroll.CanvasSize = UDim2.new(0, 0, 0, 1150); Scroll.ScrollBarThickness = 3
local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0, 10); List.SortOrder = Enum.SortOrder.LayoutOrder

-- --- ⚙️ CORE LOGICS ---
local noclip, infJump, spinBot, magnet, flying = false, false, false, false, false
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

-- 0. TP SYSTEM
local TPFrame = Instance.new("Frame", Scroll)
TPFrame.Size = UDim2.new(1, -10, 0, 50); TPFrame.BackgroundTransparency = 1
local TPInput = Instance.new("TextBox", TPFrame)
TPInput.Size = UDim2.new(0.65, -5, 1, 0); TPInput.PlaceholderText = "Kullanıcı Adı..."; TPInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30); TPInput.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", TPInput)
local TPBtn = Instance.new("TextButton", TPFrame)
TPBtn.Size = UDim2.new(0.35, 0, 1, 0); TPBtn.Position = UDim2.new(0.65, 5, 0, 0); TPBtn.Text = "TP TO"; TPBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255); TPBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", TPBtn)

TPBtn.MouseButton1Click:Connect(function()
    local targetName = TPInput.Text:lower()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():sub(1, #targetName) == targetName or v.DisplayName:lower():sub(1, #targetName) == targetName then
            player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
        end
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
    loadstring(game:HttpGet("https://raw.githubusercontent.com/meho61919-create/MahoHack/main/MahoTrack.lua"))() 
end)

-- 2. GENEL HİLELER
AddLabel("GENEL HİLELER")

AddButton("⛓️ | GET DETAIN TOOL", Color3.fromRGB(100, 100, 110), function()
    local tool = Instance.new("Tool")
    tool.Name = "Maho Detain"
    tool.RequiresHandle = false
    tool.Parent = player.Backpack
    
    tool.Activated:Connect(function()
        local mouse = player:GetMouse()
        local target = mouse.Target
        if target and target.Parent:FindFirstChild("Humanoid") then
            local targetChar = target.Parent
            task.spawn(function()
                while tool.Parent == player.Character do
                    targetChar.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4)
                    task.wait()
                end
            end)
        end
    end)
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
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * (uis:IsKeyDown(Enum.KeyCode.W) and flySpeed or 0)
                bg.CFrame = workspace.CurrentCamera.CFrame
                task.wait()
            end
            bv:Destroy(); bg:Destroy()
        end)
    end
end)

AddToggle("🎁 Infinite Jump", Color3.fromRGB(200, 150, 0), function(v) infJump = v end)
AddToggle("🌀 Spin Bot", Color3.fromRGB(200, 150, 0), function(v) spinBot = v end)
AddToggle("🧲 Item Magnet", Color3.fromRGB(200, 150, 0), function(v) magnet = v end)
AddToggle("🏃 Speed Hack", Color3.fromRGB(0, 180, 120), function(v) player.Character.Humanoid.WalkSpeed = v and 80 or 16 end)
AddToggle("🧱 NoClip", Color3.fromRGB(200, 100, 0), function(v) noclip = v end)

-- 3. REJOIN
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

print("MAHO ELITE v11.9: ANIMATED & READY!")
