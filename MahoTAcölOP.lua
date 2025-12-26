local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🎯 MAHO ELITE | TA Desert Operation",
   LoadingTitle = "Maho Elite Sistemleri Yükleniyor...",
   LoadingSubtitle = "by Maho",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "MahoElite", 
      FileName = "TA_Config"
   },
   Discord = {
      Enabled = false,
      Invite = "", 
      RememberJoins = true 
   },
   KeySystem = false -- Burayı true yaparsan anahtar ekleyebiliriz
})

-- SEKMELER
local InfoTab = Window:CreateTab("📜 Bilgiler", 4483362458) -- İkon: Dosya
local MainTab = Window:CreateTab("🚀 Operasyon", 4483345998) -- İkon: Roket

-- BİLGİ SEKMESİ İÇERİĞİ
InfoTab:CreateSection("Gereksinimler")
InfoTab:CreateLabel("• Rütbe: OR-2 Zorunludur")
InfoTab:CreateLabel("• Harita: Çöl (Desert)")
InfoTab:CreateParagraph({Title = "Nasıl Çalışır?", Content = "Metrodan Çöl haritasına girin. Operasyonu başlat butonuna basın. Karakteriniz otomatik olarak her saniye 5 NPC'yi etkisiz hale getirecektir."})

-- ANA MENÜ İÇERİĞİ
MainTab:CreateSection("Otomasyon Kontrolleri")

local isOperating = false
MainTab:CreateButton({
   Name = "⚡ OPERASYONU BAŞLAT",
   Callback = function()
      if isOperating then 
         Rayfield:Notify({Title = "Uyarı", Content = "Operasyon zaten devam ediyor!", Duration = 3})
         return 
      end
      
      isOperating = true
      Rayfield:Notify({
         Title = "OPERASYON BAŞLADI",
         Content = "Maho Elite birimleri bölgeyi temizliyor...",
         Duration = 5,
         Image = 4483345998,
      })

      -- ANA MANTIK
      local npcFolder = workspace:FindFirstChild("NPCs") or workspace:FindFirstChild("Enemies")
      local damageRemote = game.ReplicatedStorage:FindFirstChild("DamageEvent") -- DEX İLE BURAYI KONTROL ET

      if not npcFolder then
         Rayfield:Notify({Title = "HATA", Content = "NPC Klasörü Bulunamadı!", Duration = 5})
         isOperating = false
         return
      end

      local enemies = npcFolder:GetChildren()
      for i, npc in pairs(enemies) do
          if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
              
              -- Karakter ve Pozisyon
              local player = game.Players.LocalPlayer
              local root = player.Character.HumanoidRootPart
              
              -- Havada süzülme efekti (Tween ile daha profesyonel)
              local tween = game:GetService("TweenService"):Create(root, TweenInfo.new(0.5), {CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)})
              tween:Play()
              
              -- Öldürme sinyali
              if damageRemote then
                  damageRemote:FireServer(npc.Humanoid, 100)
              end

              task.wait(0.2) -- Saniyede 5 kişi hızı
          end
      end

      isOperating = false
      Rayfield:Notify({
         Title = "GÖREV TAMAMLANDI",
         Content = "Bölge temizlendi, Maho Elite gururla sunar.",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

MainTab:CreateSection("Ayarlar")
MainTab:CreateSlider({
   Name = "Öldürme Hızı (Saniye)",
   Range = {0.1, 1},
   Increment = 0.1,
   Suffix = "sn",
   CurrentValue = 0.2,
   Flag = "KillDelay", 
   Callback = function(Value)
      -- Bu değer yukarıdaki task.wait(0.2) yerine kullanılabilir
   end,
})
