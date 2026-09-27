-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function src.paymentCheckin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		--[[ if vRP.getHealth(source) <= 101 then ]]
			if vRP.request(source,"Prosseguir o tratamento por <b>$750</b> dólares?","Sim","Não") then
				if vRP.paymentFull(user_id,750) then
					vRP.upgradeHunger(user_id,20)
					vRP.upgradeThirst(user_id,20)
					vRP.upgradeStress(user_id,10)
					TriggerEvent("Repose",source,user_id,900)

					return true
				else

					TriggerClientEvent("Notify",source,"cancel","Negado","<b>Dólares</b> insuficientes.","vermelho",5000)
				end
			end
		--[[ end ]]
	end

	return false
end


function src.checkParamedicServices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local copAmount = vRP.numPermission("Paramedic")
		if parseInt(#copAmount)>= 2 then 
			TriggerClientEvent("Notify",source,"important","Negado","Existem paramedicos em serviço","amarelo",5000)
			return true
		end
	end
	return false
end

function src.tryTreatmentPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local valor  =  1000
		if vRP.request(source,"Desejar pagar <strong>$"..valor.."</strong> para iniciar o Tratamento?") then
			return vRP.paymentFull(user_id,valor)
		end
	end
	return false 
end	