-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNCTION ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "emprego-taxista" then
		TriggerServerEvent("emprego-entrar","Taxista")
		ToggleActionMenu()
	elseif data == "emprego-mecanico" then
		TriggerServerEvent("emprego-entrar","Mecanico")
		ToggleActionMenu()
	elseif data == "emprego-lixeiro" then
		TriggerServerEvent("emprego-entrar","Lixeiro")
		ToggleActionMenu()
	elseif data == "emprego-motorista" then
		TriggerServerEvent("emprego-entrar","Motorista")
		ToggleActionMenu()
	elseif data == "emprego-pedircontas" then
		TriggerServerEvent("emprego-sair","Civil")
		ToggleActionMenu()
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ -267.27,-959.25,31.23 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BLIP ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do

		local sleep = 1000
		
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 5 then
				sleep = 1
				DrawMarker(23,x,y,z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,150,20,20,240,0,0,0,0)
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)