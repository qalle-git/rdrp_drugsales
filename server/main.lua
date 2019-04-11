local ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

ESX.RegisterServerCallback("rdrp_drugsales:sellDrug", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player then
        local hasItem = DoPlayerHaveItems(player)

        if hasItem then
            math.randomseed(os.time())
            local randomPayment = math.random(Config.Payment[1], Config.Payment[2])

            player.removeInventoryItem(hasItem, 1)

            player.addMoney(randomPayment)

            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

DoPlayerHaveItems = function(player)
    local hasItem = false

    for i = 1, #Config.DrugItems do
        local itemName = Config.DrugItems[i]
        local itemInformation = player.getInventoryItem(itemName)

        if itemInformation and itemInformation["count"] > 0 then
            hasItem = itemName

            break
        end
    end

    return hasItem
end