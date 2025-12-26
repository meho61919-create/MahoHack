-- MAHO TEAM TERMINAL v2.0 (Gerçek Geçiş Protokolü)
local Player = game.Players.LocalPlayer
local Teams = game:GetService("Teams")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- [UI KODLARI AYNI KALACAK - SADECE FONKSİYONU GÜNCELLİYORUZ]

local function tryJoinTeam(team)
    -- 1. YÖNTEM: Standart Geçiş (Senin denediğin)
    Player.Team = team
    
    -- 2. YÖNTEM: Sunucuya Sinyal Gönder (RemoteEvent Avcısı)
    -- Çoğu oyun takımı değiştirmek için bu yolları kullanır:
    local remotePaths = {
        ReplicatedStorage:FindFirstChild("TeamEvent"),
        ReplicatedStorage:FindFirstChild("ChangeTeam"),
        ReplicatedStorage:FindFirstChild("JoinTeam"),
        ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("ChangeTeam")
    }

    for _, remote in pairs(remotePaths) do
        if remote and remote:IsA("RemoteEvent") then
            remote:FireServer(team) -- Sunucuya "Ben bu takıma geçtim" haberi yolla
        end
    end

    -- 3. YÖNTEM: Karakteri Yenile (Base'de doğması için)
    -- Takım değiştikten sonra reset atarsan base'de doğarsın.
    -- Bunu otomatik yapmak için:
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.Health = 0 -- Otomatik Reset
    end
end

-- Buton oluşturma kısmında TeamBtn.MouseButton1Click içine bunu yaz:
-- tryJoinTeam(team)
