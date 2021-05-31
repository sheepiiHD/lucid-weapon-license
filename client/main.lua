
--- HANDLE SUBMITTING APPLICATION --- 
RegisterNUICallback("submitApplication", function(data, cb)
    TriggerServerEvent("lucid-weapon-licenses:submitApplication", data);
    TriggerClientEvent("lucid-weapon-license:closeMenu", {});
    cb("ok")
end)

--- HANDLE ACCEPT APPLICATION ---
RegisterNUICallback("acceptApplication", function(data, cb)
    TriggerServerEvent("lucid-weapon-license:acceptApplication", data);
    cb("ok")
end)

--- HANDLE DENY APPLICATION --- 
RegisterNUICallback("denyApplication", function(data, cb)
    TriggerServerEvent("lucid-weapon-license:denyApplication", data)
    cb("ok")
end)

--- HANDLE CLOSE/OPEN ----
RegisterNetEvent("lucid-weapon-license:openMenu")
AddEventHandler("lucid-weapon-license", function(menu, data, cb)
    SendNUIMessage({
        type = "open",
        menu = menu
        meta_data = data
    })  
    
    SetNuiFocus(true, true)
    Anim()
    cb('ok')
end)

RegisterNetEvent("lucid-weapon-license:closeMenu")
AddEventHandler("lucid-weapon-license:closeMenu", function()
    SetNuiFocus(false, false)
    StopAnim()
end)

--- HANDLE ANIMATION (holding and dropping clipboard)----
local prop = nil
function Anim()
    while not HasAnimDictLoaded('missfam4') do
        RequestAnimDict('missfam4')
        Wait(10)
    end

    TaskPlayAnim(GetPlayerPed(-1), 'missfam4', '"base"', 2.0, 2.0, -1, 51, 0, false, false, false)
    RemoveAnimDict('missfam4')

    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))

    if not HasModelLoaded("p_amb_clipboard_01") then
        while not HasModelLoaded(GetHashKey("p_amb_clipboard_01")) do
            RequestModel(GetHashKey("p_amb_clipboard_01"))
            Wait(10)
        end
    end

    prop = CreateObject(GetHashKey("p_amb_clipboard_01"), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, 36029), 0.16, 0.08, 0.1, -130.0, -50.0, 0.0, true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded("p_amb_clipboard_01")
end

function StopAnim()
    ClearPedTasks(GetPlayerPed(-1))
    if prop then
        DeleteEntity(prop)
    end
end