local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData, CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask, spawnedVehicles = {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, IsHandcuffed, hasAlreadyJoined, playerInService, isInShopMenu = false, false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged = false
blip = nil

local attente = 0

function OpenBillingMenu()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Facture"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		  else
			local playerPed        = GetPlayerPed(-1)
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_subway', ('subway'), amount)
			  Citizen.Wait(100)
			  ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
		  end
  
		else
		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
  end


  ESX = nil

  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local PlayerData = {}
local ped = PlayerPedId()
local vehicle = GetVehiclePedIsIn( ped, false )
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



RMenu.Add('kaito0511', 'main', RageUI.CreateMenu("Subway", "Intéraction..."))
RMenu.Add('kaito0511', 'inter', RageUI.CreateMenu("Subway", "Intéraction..."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('kaito0511', 'main'), true, true, true, function()

			RageUI.Checkbox("Prendre/Quitter son service",nil, service,{},function(Hovered,Ative,Selected,Checked)
                if Selected then

                    service = Checked


                    if Checked then
                        onservice = true
						RageUI.Popup({
							message = "Vous avez pris votre service !"})

                        
                    else
                        onservice = false
						RageUI.Popup({
							message = "Vous avez quitter votre service !"})

                    end
                end
            end)

			if onservice then

				RageUI.Separator("↓ ~y~   Facture  ~s~↓")
					
				RageUI.ButtonWithStyle("Donner une facture",nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()        
						OpenBillingMenu() 
					end
				end)
		
				RageUI.Separator("↓ ~r~ Gestion Annonce  ~s~↓")

				RageUI.ButtonWithStyle("Annonce Ouverture",nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
					if Selected then       
						TriggerServerEvent('AnnonceOuvertsubway')
					end
				end)
		
				RageUI.ButtonWithStyle("Annonce Fermeture",nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
					if Selected then      
						TriggerServerEvent('AnnonceFermersubway')
					end
				end)

				RageUI.ButtonWithStyle("Annonce Recrutement", "Pour annoncer des recrutements au Subway", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
					if (Selected) then   
					TriggerServerEvent('KSubway:annoncerecrutementsubway')
				end
				end)

				RageUI.Separator("↓ ~b~     Message    ~s~↓")

				RageUI.ButtonWithStyle("Message aux Employés", "Pour écrire un message aux Employés", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
					if (Selected) then   
					local info = 'patron'
					local message = KeyboardInput('Veuillez mettre le messsage à envoyer', '', 40)
					TriggerServerEvent('kaitoo:subwayjob', info, message)
				end
				end)
		
				RageUI.ButtonWithStyle("Message Personnalisé",nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
					if Selected then
						local te = KeyboardInput("Message", "", 100)
						ExecuteCommand("reze " ..te)
					end
				end)
			end
		
			end, function()
			end)

Citizen.Wait(0)
end
end)

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'subway' then 
            if IsControlJustReleased(0 ,167) then
                RageUI.Visible(RMenu:Get('kaito0511', 'main'), not RageUI.Visible(RMenu:Get('kaito0511', 'main')))
            end
        end
        end
    end)

    RegisterNetEvent('openf6')
    AddEventHandler('openf6', function()
    RageUI.Visible(RMenu:Get('kaito0511', 'main'), not RageUI.Visible(RMenu:Get('kaito0511', 'main')))
    end)
    


		function demenotter()
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
            local target, distance = ESX.Game.GetClosestPlayer()
            playerheading = GetEntityHeading(GetPlayerPed(-1))
            playerlocation = GetEntityForwardVector(PlayerPedId())
            playerCoords = GetEntityCoords(GetPlayerPed(-1))
            local target_id = GetPlayerServerId(target)
            TriggerServerEvent('KSubway:requestrelease', target_id, playerheading, playerCoords, playerlocation)
            Wait(5000)
			TriggerServerEvent('KSubway:handcuff', GetPlayerServerId(closestPlayer))
		else
			ESX.ShowNotification('~r~Aucun joueurs à proximité')
			end
        end
	  


		Citizen.CreateThread(function()

			local subwaymap = AddBlipForCoord(-1253.18, -296.84, 37.32)
			SetBlipSprite(subwaymap, 570)
			SetBlipColour(subwaymap, 2)
            SetBlipScale(subwaymap, 0.7)
			SetBlipAsShortRange(subwaymap, true)
	
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString("Subway")
			EndTextCommandSetBlipName(subwaymap)
	
	
	end)

	-------garage

RMenu.Add('garageKaito', 'main', RageUI.CreateMenu("Garage", "Garage du Subway...."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('garageKaito', 'main'), true, true, true, function() 

            
            RageUI.Separator("↓ ~y~     Camion Disponible    ~s~↓")

            RageUI.ButtonWithStyle("Sortir un Taco", "Vous sortez un camion...", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            ESX.ShowAdvancedNotification("Garagiste Nate", "Le camion arrive mon reuf !..", "", "CHAR_STRETCH", 1) 
            Citizen.Wait(2000)   
            spawnuniCar("taco")
            ESX.ShowAdvancedNotification("Garagiste Nate", "Par contre fait gaffe gros !", "", "CHAR_STRETCH", 1) 
            end
            end)

                    RageUI.Separator("↓ ~r~     Ranger les voitures    ~s~↓")

                    RageUI.ButtonWithStyle("Mettre le camion dans le garage", "Pour ranger le camion.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            ESX.ShowAdvancedNotification("Garagiste Nate", "Le camion est de retour merci!", "", "CHAR_STRETCH", 1)
                            DeleteEntity(veh)
                        end 
                        end
                        end)   
            

            
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.garage.position.x, Config.pos.garage.position.y, Config.pos.garage.position.z)
            if dist3 <= 3.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'subway' then    
                RageUI.Text({

                    message = "[~r~E~w~] Pour parler avec Neji",
        
                    time_display = 1
        
                })
                    if IsControlJustPressed(1,51) then           
                        RageUI.Visible(RMenu:Get('garageKaito', 'main'), not RageUI.Visible(RMenu:Get('garageKaito', 'main')))
                    end   
                end
               end 
        end
end)

function spawnuniCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, Config.pos.spawnvoiture.position.x, Config.pos.spawnvoiture.position.y, Config.pos.spawnvoiture.position.z, Config.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "KAITO"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1) 
end


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)


    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

RegisterNetEvent('kaitoo:subwayjob')
AddEventHandler('kaitoo:subwayjob', function(service, nom, message)
	if service == 'patron' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('INFO SUBWAY', '~b~A lire', 'Patron: ~g~'..nom..'\n~w~Message: ~g~'..message..'', 'CHAR_STRETCH', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)	
	end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("a_m_y_ktown_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "a_m_y_ktown_01", -1253.3, -296.15, 36.32, 178.07,  true, true, true) 
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
end)

