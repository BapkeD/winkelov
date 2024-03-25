local MarkerPos = vector3(-42.8475, -1749.4840, 29.4210)

local weaponHash = GetHashKey("weapon_pistol")

local PedHasWeapon = HasPedGotWeapon(GetPlayerPed(-1), weaponHash, false)
local OvervalGestart = false
function cooldown()
    Citizen.Wait(180000)
    OvervalGestart = false
    
end


function overvalvotooid()
    
    Citizen.Wait(180000)
    GiveWeaponToPed(1, weapon_pistol, 100, fasle, false)
    
end



        


Citizen.CreateThread(function ()
    local ped = GetPlayerPed(-1)

    while true do
        Citizen.Wait(1)
        local playerCoords = GetEntityCoords(ped)
        local distance = #(playerCoords - MarkerPos)
        local NuiOpen = false




        if  not OvervalGestart and distance  < 5.0 then
            -- Draw a simple red marker at the specified position
            DrawMarker(27, --[[ Type: Cylinder ]]
                       MarkerPos.x, MarkerPos.y, MarkerPos.z - 0.80, --[[ Position, adjusted Z for ground level ]]
                       0.0, 0.0, 0.0, --[[ Direction ]]
                       0, 0, 0, --[[ Rotation ]]
                       1.5, 1.5, 1.5, --[[ Scale ]]
                       255, 0, 0, 100, --[[ Color: Red with alpha of 100 ]]
                       false, --[[ bobUpAndDown ]]
                       true, --[[ faceCamera ]]
                       2, --[[ p19, unknown, use 2 based on community examples ]]
                       nil, nil, --[[ Texture Dictionary & Name, not needed for basic marker ]]
                       false --[[ Draw on entities, not needed for ground marker ]]

            )

            else
                Citizen.Wait(2000)
            end

            if distance < 2.0 and not OvervalGestart then
                if not NuiOpen then
                    NuiOpen = true
                    SendNuiMessage(json.encode({type = "showNui"}))
                end
            else
                if NuiOpen then
                    NuiOpen = false
                    SendNuiMessage(json.encode({type = "CloseNui"}))
                end
            end


            if PedHasWeapon and  IsControlJustPressed(1, 120) and not OvervalGestart   and distance < 2.0 then



                SendNuiMessage(json.encode({type = "Overvalgestart"}))
                OvervalGestart = true
                overvalvotooid()


            end


            if distance > 10.0 and OvervalGestart then



                SendNuiMessage(json.encode({type = "overvalgestopt"}))
                cooldown()



            end






    end
end)
