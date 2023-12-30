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

RMenu.Add('assemblage', 'traitement', RageUI.CreateMenu("Assemblage", "Lancement du processus..."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('assemblage', 'traitement'), true, true, true, function()

                RageUI.ButtonWithStyle("Ajouter les ingrédients", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then              
                        traitementassemblage()
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
    
            local traitementpossible = false
            Citizen.CreateThread(function()
                local playerPed = PlayerPedId()
                while true do
                    Wait(0)
            
                        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                        if IsEntityAtCoord(PlayerPedId(), -0.0, -0.0, 0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 

                                    if IsControlJustPressed(1, 51) then
                                        RageUI.Visible(RMenu:Get('assemblage', 'traitement'), not RageUI.Visible(RMenu:Get('assemblage', 'traitement')))
                                    end
                                else
                                    traitementpossible = false
                                end
                            end    
                    end)
    

function notify(text)
   SetNotificationTextEntry('STRING')
   AddTextComponentString(text)
   DrawNotification(false, false)
end

function traitementassemblage()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
            Citizen.Wait(2000)
            ExecuteCommand('e mechanic')
            TriggerServerEvent('assemblage')
    end
    else
        traitementpossible = false
    end
end

----------------------------------------

local LEMENUESTLAA = {
    {x = -1257.24, y = -281.96, z = 37.35}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(LEMENUESTLAA) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'subway' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, LEMENUESTLAA[k].x, LEMENUESTLAA[k].y, LEMENUESTLAA[k].z)
			DrawMarker(20, -1257.24, -281.96, 36.35+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)

        
            if dist <= 1.0 then
				RageUI.Text({

					message = "Appuyez sur [~r~E~w~] pour commencer l'assemblage",
		
					time_display = 1
		
				})
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('assemblage', 'traitement'), not RageUI.Visible(RMenu:Get('assemblage', 'traitement')))
                end
            end
        end
    end
    end
end)

