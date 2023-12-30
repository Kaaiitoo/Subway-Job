ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('rpate')
AddEventHandler('rpate', function()
    local item = "pate"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "T\'as pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('assemblage')
AddEventHandler('assemblage', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local pate = xPlayer.getInventoryItem('pate').count
    local pateg = xPlayer.getInventoryItem('pateg').count

    if pateg > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter d\'ingrédients ...')
    elseif pate < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de pâte à wrap pour traiter')
    else
        xPlayer.removeInventoryItem('pate', 1)
        xPlayer.addInventoryItem('pateg', 2)    
    end
end)

RegisterNetEvent('cwraps')
AddEventHandler('cwraps', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local pateg = xPlayer.getInventoryItem('pateg').count
    local wrap = xPlayer.getInventoryItem('wrap').count

    if wrap > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que ton sac est plein ...')
    elseif pateg < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez d\'ingrédients pour faire des wraps')
    else
        xPlayer.removeInventoryItem('pateg', 5)
        xPlayer.addInventoryItem('wrap', 1)    
    end
end)

local argent = math.random(50,75)


RegisterServerEvent('ventewraps')
AddEventHandler('ventewraps', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local wrap = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "wrap" then
			wrap = item.count
		end
	end
    
    if wrap > 0 then
        xPlayer.removeInventoryItem('wrap', 1)
        xPlayer.addMoney(argent)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'T\'as finis de vendre tes wrap akhy, cavale sans rouspester')
    end
end)