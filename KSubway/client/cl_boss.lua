ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societykaitomoney = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


---------------- FONCTIONS ------------------

RMenu.Add('kaitosubway', 'boss', RageUI.CreateMenu("Subway", "Options administratives.."))
Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('kaitosubway', 'boss'), true, true, true, function()

            RageUI.Separator("↓ ~r~  Montant du Subway ~s~↓")

            if societykaitomoney ~= nil then
                RageUI.ButtonWithStyle("Argent de societé :", nil, {RightLabel = "~b~$" .. societykaitomoney}, true, function()
                end)
            end
            RageUI.Separator("↓ ~y~  Panel de comptabilité  ~s~↓")

            
            RageUI.ButtonWithStyle("Déposer de l'argent",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. 'subway',
                    {
                        title = ('Montante')
                    }, function(data, menu)
        
                        local amount = tonumber(data.value)
        
                        if amount == nil then
                            ESX.ShowNotification('Montante Invalide')
                        else
                            menu.close()
                            TriggerServerEvent('esx_society:depositMoney', 'subway', amount)
                            RefreshemsMoney()
                        end
                    end)
                end
            end) 

            RageUI.ButtonWithStyle("Retirer de l'argent",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. 'subway',
                    {
                        title = ('Montante')
                    }, function(data, menu)
                    local amount = tonumber(data.value)

                if amount == nil then
                    ESX.ShowNotification('Montante Invalide')
                else
                    menu.close()
                    TriggerServerEvent('esx_society:withdrawMoney', 'subway', amount)
                    RefreshemsMoney()
                        end
                    end)
                end
            end)

            RageUI.Separator("↓ ~g~  Management  ~s~↓")

            RageUI.ButtonWithStyle("Gestion de l'entreprise",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    aboss()
                    RageUI.CloseAll()
                end
            end)


        end, function()
        end, 1)
                        Citizen.Wait(0)
                                end
                            end)

---------------------------------------------

local position = {
    {x = -1255.02, y = -284.51, z = 37.36}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'subway' and ESX.PlayerData.job.grade_name == 'boss' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
            DrawMarker(20, -1255.02, -284.51, 37.00, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)

        
            if dist <= 1.0 then
                RageUI.Text({

                    message = "Appuyez sur [~r~E~w~] pour accéder au panel administratif",

                    time_display = 1

                })
                if IsControlJustPressed(1,51) then
                    RefreshemsMoney()
                    RageUI.Visible(RMenu:Get('kaitosubway', 'boss'), not RageUI.Visible(RMenu:Get('kaitosubway', 'boss')))
                end
            end
        end
    end
    end
end)

function RefreshemsMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            Updatesocietykaitomoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function Updatesocietykaitomoney(money)
    societykaitomoney = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'subway', function(data, menu)
        menu.close()
    end, {wash = false})
end



----------------------------------------------------------------------
--######################### BLIPS #####################

PlayerData = {}

local done = false

ESX = nil
 Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    done = true
end)
--==============subway!================---

local subwayblips = { 
	 {title="Récolte de la pâte", colour=1, id=478, x = -62.38, y = 6239.85, z = 31.09},
}
local subwayblips2 = { 
  {title="Vente des Wraps", colour=1, id=478, x = 410.32, y = -1910.62, z = 25.45},
}
local subwayblips3 = { 
    {title="Achat des aliments", colour=1, id=478,   x = -1451.61, y = -694.65, z =  25.33}, 
}

--subway blips
 Citizen.CreateThread(function() 
    while not done do
        Citizen.Wait(10)
    end
    if PlayerData.job.name == 'subway' then 
        for _, info in pairs(subwayblips) do 
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, false)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
      done = true
    end
end
end)

Citizen.CreateThread(function() 
  while not done do
      Citizen.Wait(10)
  end
  if PlayerData.job.name == 'subway' then 
      for _, info in pairs(subwayblips2) do 
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 0.8)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
    done = true
  end
end
end)


Citizen.CreateThread(function() 
    while not done do
        Citizen.Wait(10)
    end
    if PlayerData.job.name == 'subway' then 
        for _, info in pairs(subwayblips3) do 
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, false)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
      done = true
    end
end
end)