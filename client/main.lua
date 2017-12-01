ESX = nil
local showGps = false
local keepHealthBar = true

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer

	TriggerEvent('esx_gps:removeGPS')

	for i=1, #PlayerData.inventory, 1 do
		if PlayerData.inventory[i].name == 'gps' then
			if PlayerData.inventory[i].count > 0 then
				TriggerEvent('esx_gps:addGPS')
			end
		end
	end

end)

RegisterNetEvent('esx_gps:addGPS')
AddEventHandler('esx_gps:addGPS', function()
	if keepHealthBar == true then
		showGps = true
	else
		DisplayRadar(true)
	end
end)

RegisterNetEvent('esx_gps:removeGPS')
AddEventHandler('esx_gps:removeGPS', function()
	if keepHealthBar == true then
		showGps = false
	else
		DisplayRadar(false)
	end
end)

Citizen.CreateThread(function()
	while keepHealthBar do
		Wait(0)
            if showGps == false then
            	DrawRect(0.085, 0.890, 0.14, 0.160, 0, 0, 0, 255);
            	SetRadarBigmapEnabled( false, false )
            end

        end
end)