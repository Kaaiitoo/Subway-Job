ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('esx_phone:registerNumber', 'subway', _U('alert_subway'), true, true)
TriggerEvent('esx_society:registerSociety', 'subway', 'subway', 'society_subway', 'society_subway', 'society_subway', {type = 'private'})

RegisterNetEvent('KSubway:getStockItem')
AddEventHandler('KSubway:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_subway', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				xPlayer.showNotification(_U('have_withdrawn', count, inventoryItem.label))
			else
				xPlayer.showNotification(_U('quantity_invalid'))
			end
		else
			xPlayer.showNotification(_U('quantity_invalid'))
		end
	end)
end)


RegisterServerEvent('KSubway:putStockItems')
AddEventHandler('KSubway:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_subway', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
	end)
end)

ESX.RegisterServerCallback('KSubway:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_subway', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('KSubway:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)


RegisterServerEvent('KSubway:message')
AddEventHandler('KSubway:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

RegisterServerEvent('KSubway:annoncerecrutementsubway')
AddEventHandler('KSubway:annoncerecrutementsubway', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Subway', '~b~Annonce Subway', '~y~Recrutement en cours, rendez-vous à l\'entreprise !', 'CHAR_STRETCH', 8)

    end
end)
