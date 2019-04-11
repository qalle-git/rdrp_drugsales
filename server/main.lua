local ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

ESX.RegisterServerCallback("rdrp_drugsales:sellDrug", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player then
        local hasItem = player.getInventoryItem(Config.DrugItem)["count"]

        if hasItem > 0 then
            player.removeInventoryItem(Config.DrugItem, 1)

            player.addMoney(Config.Payment[1], Config.Payment[2])

            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)