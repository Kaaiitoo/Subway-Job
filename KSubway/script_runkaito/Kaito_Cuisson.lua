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

RMenu.Add('wraps', 'creation', RageUI.CreateMenu("Wraps", "Lancement du processus.."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('wraps', 'creation'), true, true, true, function()

                RageUI.ButtonWithStyle("Commencer la cuisson des wraps", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then              
                        traitementwraps()
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
    
            local traitementpossible2 = false
            Citizen.CreateThread(function()
                local playerPed = PlayerPedId()
                while true do
                    Wait(0)
            
                        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                        if IsEntityAtCoord(PlayerPedId(), -0.0, -0.0, 0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 

                                   RageUI.Text({
                                    message = "Appuyez sur [~b~E~w~] pour faire vos wraps",
                                    time_display = 1
                                })
                                    if IsControlJustPressed(1, 51) then
                                        RageUI.Visible(RMenu:Get('wraps', 'creation'), not RageUI.Visible(RMenu:Get('wraps', 'creation')))
                                    end
                                else
                                    traitementpossible2 = false
                                end
                            end    
                    end)
    

function notify(text)
   SetNotificationTextEntry('STRING')
   AddTextComponentString(text)
   DrawNotification(false, false)
end

function traitementwraps()
    if not traitementpossible2 then
        traitementpossible2= true
    while traitementpossible2 do
            Citizen.Wait(2000)
            ExecuteCommand('e mechanic')
            TriggerServerEvent('cwraps')
    end
    else
        traitementpossible2 = false
    end
end

----------------------------------------

local LEMENUESTLAAAAA = {
    {x = -1255.74, y = -280.61, z = 37.35}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(LEMENUESTLAAAAA) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'subway' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, LEMENUESTLAAAAA[k].x, LEMENUESTLAAAAA[k].y, LEMENUESTLAAAAA[k].z)
			DrawMarker(20, -1255.74, -280.61, 36.35+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)

        
            if dist <= 1.0 then
				RageUI.Text({

					message = "Appuyez sur [~r~E~w~] pour faire vos wraps",
		
					time_display = 1
		
				})
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('wraps', 'creation'), not RageUI.Visible(RMenu:Get('wraps', 'creation')))
                end
            end
        end
    end
    end
end)

