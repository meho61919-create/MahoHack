--[[ 
    MAHO ELITE - TA CÖL OPERASYONU
    Hız: Saniyede 5 NPC (0.2s Delay)
    Durum: Anti-Ban Optimize Edildi
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Maho Elite - TA Operasyon", "BloodTheme")

-- BİLGİ SEKMESİ
local InfoTab = Window:NewTab("Önemli Bilgiler")
local InfoSection = InfoTab:NewSection("Gereksinimler")
InfoSection:NewLabel("• En az OR-2 rütbesi gereklidir.")
InfoSection:NewLabel("• Metrodan Çöl haritasını seçip girin.")
InfoSection:NewLabel("• Hız: 5 NPC / Saniye (Güvenli)")

-- ANA MENÜ
local MainTab = Window:NewTab("Operasyon")
local MainSection = MainTab:NewSection("Otomasyon")

MainSection:NewButton("Operasyonu Başlat", "Hızlı ve Güvenli Temizlik", function()
    -- NPC KLASÖRÜ (Dex ile bulduğun ismi buraya yaz)
    local npcFolder = workspace:FindFirstChild("NPCs") or workspace:FindFirstChild("Enemies")
    
    -- REMOTE EVENT (Dex ile bulduğun yolu buraya yaz)
    local damageRemote = game.ReplicatedStorage:FindFirstChild("DamageEvent") 

    if not npcFolder then
        print("Hata: NPC klasörü bulunamadı!")
        return
    end

    print("Operasyon Başladı...")
    
    local enemies = npcFolder:GetChildren()
    for i, npc in pairs(enemies) do
        if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
            
            -- 1. Karakteri NPC'nin üstüne sabitle (Menzil kontrolü için)
            local root = game.Players.LocalPlayer.Character.HumanoidRootPart
            root.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)

            -- 2. Öldürme Sinyali
            if damageRemote then
                -- Bazı oyunlar (Humanoid, Damage) bekler
                damageRemote:FireServer(npc.Humanoid, 100)
            end

            -- 3. HIZ AYARI: Saniyede 5 kişi için 0.2 saniye bekleme
            task.wait(0.2) 
        end
    end
    
    print("Operasyon bitti! Maho Elite başarıyla tamamladı.")
end)
