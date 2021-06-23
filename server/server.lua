RegisterServerEvent("xyz-clothes:loadPlayerSkins")
AddEventHandler('xyz-clothes:loadPlayerSkins', function()
    local src = source
    local Player = VIRUSFW.Functions.GetPlayer(src)
    VIRUSFW.Functions.ExecuteSql(false, "SELECT * FROM `playerskins` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `active` = 1", function(result)
        if result[1] ~= nil then
            TriggerClientEvent("xyz-clothes:loadSkins", src, false, result[1].model, result[1].skin)
        else
            TriggerClientEvent("xyz-clothes:loadSkins", src, true)
        end
    end)
end)
