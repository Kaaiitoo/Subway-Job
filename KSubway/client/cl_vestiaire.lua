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



RMenu.Add('kaito0511', 'subway', RageUI.CreateMenu("Vestaire", "Ouverture du cassier.."))



Citizen.CreateThread(function()

    while true do



        RageUI.IsVisible(RMenu:Get('kaito0511', 'subway'), true, true, true, function()

            RageUI.Separator("↓ ~y~   Vestiaire  ~s~↓")

            RageUI.ButtonWithStyle("Mettre sa tenue : ~r~Civile",nil, {nil}, true, function(Hovered, Active, Selected)

                if Selected then

                    vcivil()

                end

            end)



            RageUI.ButtonWithStyle("Mettre sa tenue : ~g~Subway",nil, {nil}, true, function(Hovered, Active, Selected)

                if Selected then

                    subway()

                end

            end)



        end, function()

        end, 1)

                        Citizen.Wait(0)

                                end

                            end)



---------------------------------------------





local position = {

    {x = -1257.32, y = -277.24, z = 37.35}
}



Citizen.CreateThread(function()

    while true do

        Citizen.Wait(0)



        for k in pairs(position) do

            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'subway' then 

                DrawMarker(20, -1257.32,  -277.24, 36.35+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)







            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

        

            if dist <= 1.0 then

                RageUI.Text({

                    message = "Appuyez sur [~r~E~w~] pour accéder au vestiaire",

                    time_display = 1

                })

                if IsControlJustPressed(1,51) then

                    RageUI.Visible(RMenu:Get('kaito0511', 'subway'), not RageUI.Visible(RMenu:Get('kaito0511', 'subway')))

                end

            end

        end

    end

    end

end)



function subway()

                local model = GetEntityModel(GetPlayerPed(-1))

                TriggerEvent('skinchanger:getSkin', function(skin)

                    if model == GetHashKey("mp_m_freemode_01") then

                        clothesSkin = {

                            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,

			['torso_1'] = 26,   ['torso_2'] = 0,

			['arms'] = 11,      ['helmet_1'] = 58,

			['pants_1'] = 22,   ['pants_2'] = 0,

			['shoes_1'] = 21,   ['shoes_2'] = 0,

                        }

                    else

                        clothesSkin = {

                            ['tshirt_1'] = 36,  ['tshirt_2'] = 0,

			['torso_1'] = 141,   ['torso_2'] = 0,

			['arms'] = 72,

			['pants_1'] = 35,   ['pants_2'] = 0,

			['shoes_1'] = 52,   ['shoes_2'] = 0,

                        }

                    end

                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

                end)

            end



function vcivil()

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

        TriggerEvent('skinchanger:loadSkin', skin)

       end)

    end

