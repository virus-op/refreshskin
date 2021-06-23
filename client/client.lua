RegisterNetEvent('VIRUSFW:Client:Refreshskin')
AddEventHandler('VIRUSFW:Client:Refreshskin', function()
  
    Citizen.Wait(100)
    TriggerServerEvent("xyz-clothes:loadPlayerSkins")
end)

RegisterNetEvent("xyz-clothes:loadSkins")
AddEventHandler("xyz-clothes:loadSkins", function(new, model, data)
    model = model ~= nil and tonumber(model) or false
    
    Citizen.CreateThread(function()
        local pedhealth = GetEntityHealth(PlayerPedId())
        local armor = GetPedArmour(GetPlayerPed(-1))
        
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(0)
        end
        
        SetEntityHealth(PlayerPedId(), pedhealth)
        SetPedArmour(PlayerPedId(), armor)
        Citizen.Wait(10)
        TriggerServerEvent("xyz-clothing:saveSkin" , PlayerPedId())
        Citizen.Wait(100)

        local pedhealth2 = GetEntityHealth(PlayerPedId())
        SetPlayerModel(PlayerId(), model)
        SetEntityHealth(PlayerPedId(), pedhealth2)
        SetPedArmour(PlayerPedId(), armor)

        SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)
        data = json.decode(data)
        TriggerEvent('xyz-clothing:client:loadPlayerClothing', data, GetPlayerPed(-1))
    end)
end)
