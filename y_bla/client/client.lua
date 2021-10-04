------- Yamsoo Scripts -------
--- discord.gg/WqDvPcCw3S ---
-----------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

local cooldawn = false
local blanchi = RageUI.CreateMenu('Blanchissement', 'yamsoo script')

function OpenMenuBlanchisseur()
	if open then 
		open = false
		RageUI.Visible(blanchi, false)
		return
	else
		open = true 
		RageUI.Visible(blanchi, true)
		CreateThread(function()
		while open do 
			RageUI.IsVisible(blanchi,function() 
				FreezeEntityPosition(PlayerPedId(), true)
				RageUI.Separator('~s~Le Blanchissement prend ~r~30 %') -- A changé selon le pourcentage 


			RageUI.Button("Commencer le ~r~Blanchissement", nil, {RightLabel = "→"}, not cooldawn, {
				onSelected = function()
					cooldawn = true
					FreezeEntityPosition(PlayerPedId(), true)
					Startblanchi()
					
					Citizen.SetTimeout(1000, function()
						cooldawn = false
					end)
				end
			})

			RageUI.Button("Stopper le ~r~Blanchissement", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					Stopleblanchiss()
					FreezeEntityPosition(PlayerPedId(), false)
					RageUI.CloseAll()
				end
			})

			end)
		Wait(0)
		end
	end)
  	end
end


function Stopleblanchiss()
    if recoltyesblanch then
    	recoltyesblanch = false
    end
end

function Startblanchi()
    if not recoltyesblanch then
        recoltyesblanch = true
    while recoltyesblanch do
        Citizen.Wait(2000)
        TriggerServerEvent('yamsoo')
    end
    else
        recoltyesblanch = false
    end
end


local posblanch = {
	Config.Posblan
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(posblanch) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posblanch[k].x, posblanch[k].y, posblanch[k].z)

			

        
            if dist <= 3.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~r~[E]~s~ pour ~r~Blanchir", 1) 
                if IsControlJustPressed(1,51) then
					OpenMenuBlanchisseur()
				end
			end
			end
			Citizen.Wait(wait)
		end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("cs_stretch")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
      Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "cs_stretch", 166.87, 2229.15, 89.77, 57.06, false, true) -- remplacer x, y, z par coordonnés
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(Ped, true)
end)
