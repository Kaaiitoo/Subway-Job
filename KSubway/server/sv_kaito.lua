ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_society:registerSociety', 'subway', 'subway', 'society_subway', 'society_subway', 'society_subway', {type = 'public'})

RegisterServerEvent('KSubway:getStockItem')
AddEventHandler('KSubway:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_subway', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then
		
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
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
RegisterServerEvent('KSubway:putStockItems')
AddEventHandler('KSubway:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_subway', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
	end)
end)

RegisterServerEvent('AnnonceOuvertsubway')
AddEventHandler('AnnonceOuvertsubway', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Subway', '~b~Annonce', 'Le Subway est ouvert!', 'CHAR_STRETCH', 8)
	end
end)

RegisterServerEvent('AnnonceFermersubway')
AddEventHandler('AnnonceFermersubway', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Subway', '~b~Annonce', 'Le Subway est fermé !', 'CHAR_STRETCH', 8)
	end
end)


RegisterServerEvent('kaitoo:subwayjob')
AddEventHandler('kaitoo:subwayjob', function(PriseOuFin, message)
    local _source = source
    local _raison = PriseOuFin
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = xPlayer.getName(_source)


    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'subway' then
            TriggerClientEvent('kaitoo:subwayjob', xPlayers[i], _raison, name, message)
        end
    end
end)


RegisterCommand('reze', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "subway" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Subway', '~b~Annonce', ''..msg..'', 'CHAR_STRETCH', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_STRETCH', 0)
    end
else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_STRETCH', 0)
end
end, false)

RegisterNetEvent('subwaykaito:achatbar')
AddEventHandler('subwaykaito:achatbar', function(v, quantite)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    local playerlimite = xPlayer.getInventoryItem(v.item).count

    if playerlimite >= 10 then
        TriggerClientEvent('esx:showNotification', source, "Ton inventaire est plein!")
    
    else
    if playerMoney >= v.prix * quantite then
        xPlayer.addInventoryItem(v.item, quantite)
        xPlayer.removeMoney(v.prix * quantite)

       TriggerClientEvent('esx:showNotification', source, "Tu as acheté ~g~x"..quantite.." ".. v.nom .."~s~ pour ~g~" .. v.prix * quantite.. "$")
    else
        TriggerClientEvent('esx:showNotification', source, "T'as pas assez de sous pour acheter ~g~"..quantite.." "..v.nom)
    end
end
end)