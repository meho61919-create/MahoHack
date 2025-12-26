-- MAHO TEAM ELITE v5.0 (Rank & Nametag Spoofing)
local Player = game.Players.LocalPlayer
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")

-- [Önceki UI Kodlarını Koru, Sadece forceJoin Fonksiyonunu ve Altını Güncelle]

local function applyFakeRank(targetTeam)
    task.spawn(function()
        local char = Player.Character or Player.CharacterAdded:Wait()
        local head = char:WaitForChild("Head")
        
        -- Mevcut nametagleri temizle (Çakışmasın)
        for _, v in pairs(head:GetChildren()) do
            if v:IsA("BillboardGui") then v:Destroy() end
        end

        -- OYUNDAKİ DİĞER OYUNCULARDAN ETİKET ÖRNEĞİ AL
        local templateTag = nil
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and p.Character and p.Character:FindFirstChild("Head") then
                templateTag = p.Character.Head:FindFirstChildOfClass("BillboardGui")
                if templateTag then break end
            end
        end

        -- ETİKETİ KENDİNE UYARLA
        if templateTag then
            local newTag = templateTag:Clone()
            newTag.Parent = head
            newTag.Adornee = head
            
            -- Etiket içindeki metinleri bul ve değiştir (Genel isimler: Rank, Name, Role)
            for _, txt in pairs(newTag:GetDescendants()) do
                if txt:IsA("TextLabel") then
                    if txt.Name:lower():find("rank") or txt.Name:lower():find("role") then
                        txt.Text = "ELITE COMMANDER" -- Buraya istediğin rütbeyi yazabilirsin
                        txt.TextColor3 = targetTeam.TeamColor.Color
                    elseif txt.Name:lower():find("name") or txt.Text == Player.Name then
                        txt.Text = Player.Name
                    end
                end
            end
        end
    end)
end

local function forceJoin(targetTeam)
    Status.Text = "PROTOKOL: " .. targetTeam.Name:upper() .. " AKTİF EDİLDİ"
    Status.TextColor3 = Color3.fromRGB(0, 255, 255)

    -- 1. Takım Değişimi
    Player.Team = targetTeam
    
    -- 2. Brute Force Remotes
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and (v.Name:lower():find("team") or v.Name:lower():find("change")) then
            pcall(function() v:FireServer(targetTeam) end)
        end
    end

    -- 3. Reset ve Spawn Işınlanma
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.Health = 0 -- Reset çekerek sunucuya takımı kabullendir
    end

    Player.CharacterAdded:Connect(function(char)
        task.wait(0.5) -- Karakterin tam yüklenmesini bekle
        
        -- Işınlanma
        for _, spawn in pairs(workspace:GetDescendants()) do
            if spawn:IsA("SpawnLocation") and spawn.TeamColor == targetTeam.TeamColor then
                char:WaitForChild("HumanoidRootPart").CFrame = spawn.CFrame * CFrame.new(0, 5, 0)
                break
            end
        end
        
        -- Sahte Rütbe Uygula
        applyFakeRank(targetTeam)
    end)
end
