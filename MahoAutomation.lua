-- 🛡️ MAHO AUTOMATION SYSTEM (JJ-GJ-HJ) v11.0
-- 🎯 JJ: BİR! | GJ: Bir! | HJ: B-İ-R-BİR!
-- 🚀 Ultra Sağlam Mantık & İnsansı Hız Modu

local player = game:GetService("Players").LocalPlayer
local tweenService = game:GetService("TweenService")
local isRunning = false
local selectedMode = ""

-- Sayı Tablosu (Tam Karakter Desteği)
local sayilar = {
    "BIR", "IKI", "UC", "DORT", "BES", "ALTI", "YEDI", "SEKIZ", "DOKUZ", "ON",
    "ON BIR", "ON IKI", "ON UC", "ON DORT", "ON BES", "ON ALTI", "ON YEDI", "ON SEKIZ", "ON DOKUZ", "YIRMI",
    "YIRMI BIR", "YIRMI IKI", "YIRMI UC", "YIRMI DORT", "YIRMI BES", "YIRMI ALTI", "YIRMI YEDI", "YIRMI SEKIZ", "YIRMI DOKUZ", "OTUZ",
    "OTUZ BIR", "OTUZ IKI", "OTUZ UC", "OTUZ DORT", "OTUZ BES", "OTUZ ALTI", "OTUZ YEDI", "OTUZ SEKIZ", "OTUZ DOKUZ", "KIRK",
    "KIRK BIR", "KIRK IKI", "KIRK UC", "KIRK DORT", "KIRK BES", "KIRK ALTI", "KIRK YEDI", "KIRK SEKIZ", "KIRK DOKUZ", "ELLI"
}

-- [ CHAT & JUMP FONKSİYONLARI ]
local function chat(msg)
    -- Türkçe harf düzeltici (Chatte sorun çıkmaması için)
    msg = msg:gsub("I", "İ"):gsub("UC", "ÜÇ"):gsub("DORT", "DÖRT"):gsub("BES", "BEŞ"):gsub("ALTI", "ALTI")
    
    if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(msg)
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end
end

local function jump()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Jump = true
    end
end

-- [ GRAMER FORMATI ]
local function formatGramer(str)
    str = str:lower()
    local first = str:sub(1,1):upper()
    local rest = str:sub(2)
    return first .. rest
end

-- [ UI SETUP ]
if game.CoreGui:FindFirstChild("MahoAutomationV11") then game.CoreGui.MahoAutomationV11:Destroy() end
local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "MahoAutomationV11"

local function createFrame(size, pos)
    local f = Instance.new("Frame", sg)
    f.Size = size; f.Position = pos; f.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
    f.Active = true; f.Draggable = true
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 15)
    local s = Instance.new("UIStroke", f); s.Color = Color3.fromRGB(130, 0, 255); s.Thickness = 2.5
    return f
end

local MainMenu = createFrame(UDim2.new(0, 300, 0, 320), UDim2.new(0.5, -150, 0.4, 0))
local TrainingFrame = createFrame(UDim2.new(0, 280, 0, 250), UDim2.new(0.5, -140, 0.4, 0))
TrainingFrame.Visible = false

local Title = Instance.new("TextLabel", MainMenu)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Text = "MAHO AUTOMATION"; Title.TextColor3 = Color3.new(1,1,1)
Title.Font = "GothamBold"; Title.TextSize = 18; Title.BackgroundTransparency = 1

-- [ ANA MANTIK DÖNGÜSÜ ]
local function runTraining(target)
    task.spawn(function()
        for i = 1, target do
            if not isRunning then break end
            local kelime = sayilar[i]
            
            if selectedMode == "JJ" then
                chat(kelime:upper() .. "!")
                jump()
                task.wait(2.2) -- İnsansı bekleme süresi (Normal/Yavaş)
            
            elseif selectedMode == "GJ" then
                chat(formatGramer(kelime) .. "!")
                jump()
                task.wait(2.2) -- İnsansı bekleme süresi
            
            elseif selectedMode == "HJ" then
                -- Harf harf zıplama (Hammer Jack özel)
                local harfler = kelime:gsub(" ", "") -- Boşlukları atla
                for j = 1, utf8.len(harfler) do
                    if not isRunning then break end
                    local harf = string.sub(harfler, j, j)
                    chat(harf:upper())
                    jump()
                    task.wait(1.5) -- Harf arası biraz daha hızlı ama dengeli
                end
                -- Final Kelime Vuruşu
                if isRunning then
                    chat(kelime:upper() .. "!")
                    jump()
                    task.wait(2.2)
                end
            end
        end
        isRunning = false
        TrainingFrame.Visible = false
        MainMenu.Visible = true
    end)
end

-- [ UI ELEMANLARI ]
local InputBox = Instance.new("TextBox", TrainingFrame)
InputBox.Size = UDim2.new(0.8, 0, 0, 45); InputBox.Position = UDim2.new(0.1, 0, 0.25, 0)
InputBox.PlaceholderText = "Sayı Gir (Max 50)"; InputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
InputBox.TextColor3 = Color3.new(1,1,1); InputBox.Font = "GothamBold"; Instance.new("UICorner", InputBox)

local StartBtn = Instance.new("TextButton", TrainingFrame)
StartBtn.Size = UDim2.new(0.4, 0, 0, 45); StartBtn.Position = UDim2.new(0.08, 0, 0.6, 0)
StartBtn.Text = "BAŞLAT"; StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
StartBtn.TextColor3 = Color3.new(1,1,1); StartBtn.Font = "GothamBold"; Instance.new("UICorner", StartBtn)

local StopBtn = Instance.new("TextButton", TrainingFrame)
StopBtn.Size = UDim2.new(0.4, 0, 0, 45); StopBtn.Position = UDim2.new(0.52, 0, 0.6, 0)
StopBtn.Text = "DURDUR"; StopBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 50)
StopBtn.TextColor3 = Color3.new(1,1,1); StopBtn.Font = "GothamBold"; Instance.new("UICorner", StopBtn)

-- [ MOD SEÇİM BUTONLARI ]
local function makeBtn(name, desc, pos)
    local b = Instance.new("TextButton", MainMenu)
    b.Size = UDim2.new(0.85, 0, 0, 60); b.Position = UDim2.new(0.075, 0, 0, pos)
    b.Text = name .. " MODU\n" .. desc; b.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    b.TextColor3 = Color3.new(1,1,1); b.Font = "GothamBold"; b.TextSize = 13
    Instance.new("UICorner", b)
    local s = Instance.new("UIStroke", b); s.Color = Color3.fromRGB(130, 0, 255); s.Transparency = 0.5
    
    b.MouseButton1Click:Connect(function()
        selectedMode = name
        MainMenu.Visible = false; TrainingFrame.Visible = true
    end)
end

makeBtn("JJ", "(Ör: BİR!, İKİ!)", 65)
makeBtn("GJ", "(Ör: Bir!, İki!)", 135)
makeBtn("HJ", "(Ör: B-İ-R-BİR!)", 205)

StartBtn.MouseButton1Click:Connect(function()
    local val = tonumber(InputBox.Text)
    if val and not isRunning then
        val = math.clamp(math.floor(val), 1, 50)
        isRunning = true
        runTraining(val)
    end
end)

StopBtn.MouseButton1Click:Connect(function() isRunning = false end)

local function addClose(parent)
    local x = Instance.new("TextButton", parent)
    x.Size = UDim2.new(0, 30, 0, 30); x.Position = UDim2.new(1, -35, 0, 7)
    x.Text = "X"; x.TextColor3 = Color3.new(1,1,1); x.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    Instance.new("UICorner", x)
    x.MouseButton1Click:Connect(function() isRunning = false; sg:Destroy() end)
end
addClose(MainMenu); addClose(TrainingFrame)