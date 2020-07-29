local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
--| ARRAY |------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "Taxista"},
	{ item = "Mecanico"},
	{ item = "Lixeiro"},
	{ item = "Motorista"}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- |ENTRAR NO EMPREGO|
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("emprego-entrar")
AddEventHandler("emprego-entrar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.hasGroup(user_id,item) then
					TriggerClientEvent("Notify",source,"negado","Você já trabalha nessa empresa.")
				elseif user_id then
					TriggerClientEvent("Notify",source,"sucesso","Você mandou seu curriculo e o mesmo foi aprovado no emprego de <b>"..item.."</b>.")
					TriggerClientEvent("Notify",source,"sucesso","Em algumas horas você ja poderá começar a trabalhar.")
					vRP.addUserGroup(user_id,item)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- |SAIR DO EMPREGO|
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("emprego-sair")
AddEventHandler("emprego-sair",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Civil") then
			TriggerClientEvent("Notify",source,"negado","Você ja esta <b>Desempregado</b>")
		else
			vRP.addUserGroup(user_id,"Civil")
			TriggerClientEvent("Notify",source,"sucesso","Você pediu contas da empresa e agora esta <b>Desempregado</b>")
		end
	end
end)