TryToSell = function(pedId)
    if not DoesEntityExist(pedId) or IsPedDeadOrDying(pedId) or IsPedAPlayer(pedId) or IsPedFalling(pedId) or GetPedType(pedId) == 28 then
        Citizen.Trace("rdrp_drugsales: ped: " .. pedId .. " not able to sell to.")

        return
    end

    ESX.ShowNotification("You wan't to buy some stuff?")

    cachedPeds[pedId] = true

    TaskStandStill(pedId, Config.DiscussTime)

    Citizen.Wait(Config.DiscussTime)

    math.randomseed(GetGameTimer())

    local canSell = math.random(1, 6)

    if canSell > 3 then
        Sell()
    else
        ESX.ShowNotification("Are you stupid? Don't ever contact me again.")
    end

    SetPedAsNoLongerNeeded(pedId)
end

Sell = function()
    ESX.TriggerServerCallback("rdrp_drugsales:sellDrug", function(soldDrug)
        if soldDrug then
            ESX.ShowNotification("Thanks!")
        else
            ESX.ShowNotification("Well don't try to waste my time if you don't even have something to sell?")
        end
    end)
end