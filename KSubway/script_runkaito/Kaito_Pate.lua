ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

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

RMenu.Add('pate', 'recolte', RageUI.CreateMenu("Pâte", "Lancement du processus.."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('pate', 'recolte'), true, true, true, function()

                RageUI.ButtonWithStyle("Récolte de la pâte", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then              
                        recoltepate()
                        RageUI.CloseAll()
                    end
                end)
            end, function()
            end)
    
            Citizen.Wait(0)
        end
    end)

---------------------------------------------

    ---------------------------------------- Position du Menu --------------------------------------------

    local recoltepossible = false
    Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            while true do
                Wait(0)
        
                    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                    if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                                if IsControlJustPressed(1, 51) then
                                    RageUI.Visible(RMenu:Get('pate', 'recolte'), not RageUI.Visible(RMenu:Get('pate', 'recolte')))
                                end
                         else
                        recoltepossible = false
                            end
                    end    
            end)
    

function notify(text)
   SetNotificationTextEntry('STRING')
   AddTextComponentString(text)
   DrawNotification(false, false)
end

function recoltepate()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Citizen.Wait(2000)
        ExecuteCommand('e parkingmeter')
        TriggerServerEvent('rpate')
    end
    else
        recoltepossible = false
    end
end
----------------------------------------

local LEMENUESTLA = {
    {x = -62.38, y = 6239.85, z = 31.09}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(LEMENUESTLA) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'subway' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, LEMENUESTLA[k].x, LEMENUESTLA[k].y, LEMENUESTLA[k].z)
			DrawMarker(20, -62.38, 6239.85, 30.09+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)

        
            if dist <= 1.0 then
				RageUI.Text({

					message = "Appuyez sur [~r~E~w~] pour ramasser des pâtes ",
		
					time_display = 1
		
				})
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('pate', 'recolte'), not RageUI.Visible(RMenu:Get('pate', 'recolte')))
                end
            end
        end
    end
    end
end)

