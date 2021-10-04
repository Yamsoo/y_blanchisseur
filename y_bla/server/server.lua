TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Compte Membre LSPD

local CopsConnected = 0

function CountCops()
	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer and xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()



-- Blanchissement

RegisterNetEvent('yamsoo')
AddEventHandler('yamsoo', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    local pourcentage = Config.sellblanc * Config.pourcent
    
    
    if CopsConnected < Config.Copsblanchisseur then
        TriggerClientEvent('esx:showNotification', source, "Il faut minimum ~r~"..Config.Copsblanchisseur.. " ~s~Membres de la LSPD en ville pour pouvoir ~r~Blanchir !") 
    elseif 0 < xPlayer.getAccount('black_money').money then
        xPlayer.removeAccountMoney('black_money', Config.sellblanc)
        xPlayer.addMoney(pourcentage)
        TriggerClientEvent('esx:showNotification', source, 'Numéro : ~o~' ..math.random(1, 999999).. '\n~s~Retiré en Sale: ~r~'..Config.sellblanc..' $\n~s~Recu en propre : ~g~' ..pourcentage.. ' $')
    else
        TriggerClientEvent('esx:showAdvancedNotification', source, 'Blanchisseur', nil, '~r~Tu n\'a plus d\'argent Sale', 'CHAR_STRETCH', 7)
    end
end)