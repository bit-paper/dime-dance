local dd = RegisterMod("Dime Dance", 1)
local musicManager = MusicManager()

function dd:StopSound()
    if musicManager:GetCurrentMusicID() == Isaac.GetMusicIdByName("CoinD") then
        if Epic then
            Epic:DoCostume(false)
        end

        musicManager:Fadeout()
    end
end

function dd:PlaySound()
    if musicManager:GetCurrentMusicID() ~= Isaac.GetMusicIdByName("CoinD") then
        local currentSongID = musicManager:GetCurrentMusicID()

        if Epic then
            Epic:DoCostume(true)
        end

        musicManager:Play(Isaac.GetMusicIdByName("CoinD"), 1)
        musicManager:UpdateVolume()
        musicManager:Queue(currentSongID)
    end
end

function dd:NewRoom()
    dd:StopSound()
end

function dd:CheckCoin()
    local dimeExists = false
    
    for i, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity.Type == 5 and entity.Variant == 20 and entity.SubType == 3 then -- 5.20.3: dime coin
            dd:PlaySound()
            dimeExists = true
        end
    end

    if not dimeExists then
        dd:StopSound()
    end
end

dd:AddCallback(ModCallbacks.MC_POST_UPDATE, dd.CheckCoin)
dd:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, dd.NewRoom)