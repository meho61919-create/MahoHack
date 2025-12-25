-- 🛡️ MAHO GRAMMAR CHECKER v10.0 (PROFESSIONAL FIXED)
-- 🎯 Askeri Disiplin & Gelişmiş Yazım Kuralları

local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui")

-- Eski UI temizle
if coreGui:FindFirstChild("MahoGrammarUI") then coreGui.MahoGrammarUI:Destroy() end

local sg = Instance.new("ScreenGui", coreGui)
sg.Name = "MahoGrammarUI"

-- [ TEMA ]
local ACCENT_COLOR = Color3.fromRGB(0, 255, 150)
local MAIN_BLUE = Color3.fromRGB(0, 120, 255)
local BG_DARK = Color3.fromRGB(15, 15, 20)

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 400, 0, 300)
Main.Position = UDim2.new(0.6, 0, 0.4, 0) -- Hub ile çakışmaması için sağa çekildi
Main.BackgroundColor3 = BG_DARK
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = MAIN_BLUE
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "🎖️ KURMAY GRAMER SİSTEMİ v10"
Title.TextColor3 = ACCENT_COLOR
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0, 35, 0, 35)
Close.Position = UDim2.new(1, -40, 0, 5)
Close.Text = "×"
Close.TextColor3 = Color3.new(1,0,0)
Close.BackgroundTransparency = 1
Close.TextSize = 30
Close.MouseButton1Click:Connect(function() sg:Destroy() end)

local InputBox = Instance.new("TextBox", Main)
InputBox.Size = UDim2.new(0.9, 0, 0, 50)
InputBox.Position = UDim2.new(0.05, 0, 0.2, 0)
InputBox.PlaceholderText = "Metni yazın: (örn: selam komutanim tmm)"
InputBox.Text = ""
InputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
InputBox.TextColor3 = Color3.new(1,1,1)
InputBox.TextWrapped = true
InputBox.ClearTextOnFocus = false
Instance.new("UICorner", InputBox)

local OutputLabel = Instance.new("TextBox", Main)
OutputLabel.Size = UDim2.new(0.9, 0, 0, 60)
OutputLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
OutputLabel.Text = "Bekleniyor..."
OutputLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
OutputLabel.TextColor3 = ACCENT_COLOR
OutputLabel.TextWrapped = true
OutputLabel.TextEditable = false
Instance.new("UICorner", OutputLabel)

-- [ 🧠 GELİŞMİŞ GRAMER MOTORU ]
local function kurmayDuzelt(str)
    if #str == 0 then return "" end
    str = str:lower()

    local sozluk = {
        ["komutanim"] = "komutanım",
        ["saol"] = "sağ ol",
        ["emret"] = "emredersiniz",
        ["tamam"] = "anlaşıldı",
        ["tsk"] = "Türk Silahlı Kuvvetleri",
        ["tmm"] = "anlaşıldı",
        ["slm"] = "selam",
        ["mrb"] = "merhaba",
        ["nasil"] = "nasıl",
        ["napion"] = "ne yapıyorsunuz",
        ["iyiyim"] = "iyiyim"
    }

    for bozuk, duzgun in pairs(sozluk) do
        str = str:gsub(bozuk, duzgun)
    end

    -- Gramer Kuralları
    str = str:gsub("(%w)mi([%s%?%.])", "%1 mi%2")
    str = str:gsub("(%w)mısınız", "%1 mısınız")
    str = str:gsub("(%w)misiniz", "%1 misiniz")

    local hitaplar = {"komutanım", "efendim", "asker", "devrem"}
    for _, h in pairs(hitaplar) do
        str = str:gsub(" " .. h, ", " .. h)
    end

    str = str:gsub(" ,", ",")
    str = str:sub(1,1):upper() .. str:sub(2)

    for _, h in pairs(hitaplar) do
        str = str:gsub(h, h:sub(1,1):upper() .. h:sub(2))
    end

    if not str:match("[%?%.%!]$") then
        str = str .. "!"
    end

    return str
end

local FixBtn = Instance.new("TextButton", Main)
FixBtn.Size = UDim2.new(0.44, 0, 0, 45)
FixBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
FixBtn.Text = "DÜZELT"
FixBtn.BackgroundColor3 = MAIN_BLUE
FixBtn.TextColor3 = Color3.new(1,1,1)
FixBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", FixBtn)

local SendBtn = Instance.new("TextButton", Main)
SendBtn.Size = UDim2.new(0.44, 0, 0, 45)
SendBtn.Position = UDim2.new(0.51, 0, 0.75, 0)
SendBtn.Text = "SOHBETE AT"
SendBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
SendBtn.TextColor3 = Color3.new(1,1,1)
SendBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SendBtn)

FixBtn.MouseButton1Click:Connect(function()
    OutputLabel.Text = kurmayDuzelt(InputBox.Text)
end)

SendBtn.MouseButton1Click:Connect(function()
    local finalMsg = OutputLabel.Text
    if finalMsg ~= "" and finalMsg ~= "Bekleniyor..." then
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(finalMsg, "All")
    end
end)
