local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🎯 MAHO ELITE | TA Desert Operation",
   LoadingTitle = "Maho Elite Güvenlik Sistemleri...",
   LoadingSubtitle = "Hacker Modu Aktif Ediliyor",
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
   KeySystem = false 
})

-- TEMA AYARI: Green (Hacker Teması)
Rayfield:SetTheme("Green")

-- SEKMELER
local MainTab = Window:CreateTab("💀 Ana Terminal", 4483345998) 
local InfoTab = Window:CreateTab("📜 Protokol", 4483362458)

-- BİLGİ SEKMESİ
InfoTab:CreateSection("Sistem Gereksinimleri")
InfoTab:CreateLabel("• Yetki Düzeyi: OR-2 (Zorunlu)")
InfoTab:CreateLabel("• Operasyon Alanı: Çöl (Desert)")
InfoTab:CreateParagraph({Title = "Maho Elite Talimatı", Content = "Metrodan Çöl haritasına giriş yaptıktan sonra 'Sistemi Başlat' komutunu verin. Anti-Ban protokolü gereği saniyede 5 NPC imha edilecektir."})

-- ANA MENÜ
MainTab:CreateSection("İmha Protokolleri")

local isOperating = false
MainTab:CreateButton({
   Name = "⚡ OPERASYONU (SİSTEMİ) BAŞLAT",
   Callback = function()
      if isOperating then 
         Rayfield:Notify({Title = "SİSTEM UYARISI", Content = "Zaten bir operasyon yürütülüyor!", Duration = 3, Image = 4483362458})
         return 
      end
      
      isOperating = true
      Rayfield:Notify({
         Title = "ERİŞİM SAĞLANDI",
         Content = "NPC imha protokolü devreye girdi...",
         Duration = 5,
         Image = 4483345998,
      })

      -- ANA MANTIK
      local npcFolder = workspace:FindFirstChild("NPCs") or workspace:FindFirstChild("Enemies")
      local damageRemote = game.ReplicatedStorage:FindFirstChild("DamageEvent") -- BURAYI DEX İLE GÜNCELLEMEYİ UNUTMA

      if not npcFolder then
         Rayfield:Notify({Title = "HATA", Content = "Hedef klasörü bulunamadı!", Duration = 5})
         isOperating = false
         return
      end

      local enemies = npcFolder:GetChildren()
      for i, npc in pairs(enemies) do
          if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
              
              local player = game.Players.LocalPlayer
              local root = player.Character.HumanoidRootPart
              
              -- Havada suikast pozisyonu
              root.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)
              
              -- İmha Sinyali
              if damageRemote then
                  damageRemote:FireServer(npc.Humanoid, 100)
              end

              task.wait(0.2) -- Saniyede 5 kişi (Hacker hızı)
          end
      end

      isOperating = false
      Rayfield:Notify({
         Title = "OPERASYON TAMAM",
         Content = "Tüm hedefler temizlendi. Sistem çıkışı yapılıyor.",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

MainTab:CreateSection("Manuel Ayarlar")
MainTab:CreateSlider({
   Name = "İmha Gecikmesi (Delay)",
   Range = {0.1, 1},
   Increment = 0.1,
   Suffix = "sn",
   CurrentValue = 0.2,
   Flag = "KillDelay", 
   Callback = function(Value)
      -- Bu değer ile hızı oyun içinde degiatirme
         
   end,
})

MainTab:CreateButton({
   Name = "❌ MENÜYÜ KAPAT",
   Callback = function()
      Rayfield:Destroy()
   end,
})
