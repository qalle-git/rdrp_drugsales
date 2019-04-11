ESX = nil

cachedPeds = {}

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(5)

		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

Citizen.CreateThread(function()
	Citizen.Wait(100)

	while true do
		local sleepThread = 500

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		local closestPed, closestPedDst = ESX.Game.GetClosestPed(pedCoords)

		if closestPedDst <= Config.SellDistance then
			sleepThread = 5

			if IsControlJustReleased(0, 38) then
				if not cachedPeds[closestPed] then
					TryToSell(closestPed)
				else
					ESX.ShowNotification("You've already talked to me? Don't come up to me again.")
				end
			end
		end

		Citizen.Wait(sleepThread)
	end
end)