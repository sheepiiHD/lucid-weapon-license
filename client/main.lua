
Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)


function openMenu()
    SendNUIMessage(
        {
            type = "open",
            menu = "application"
            meta_data = 
        }
    )
    SetNuiFocus(true, true)
    Anim()
end


function SendApplication(data)
    TriggerServerEvent("lucid-weapon-licenses:submitApplication", data)
end

RegisterNUICallback(
    "submitApplication",
    function(data, cb)
        SendApplication(data)
        SetNuiFocus(false, false)
    end
)

RegisterNUICallback(
    "getInfo",
    function(cb)
            TriggerServerEvent("lucid-weapon-license:getInfo")
    end
)

--- HANDLE CLOSE/OPEN ----
function OpenMenu(cb)
    SendNUIMessage(
        {
            type = "open",
            menu = "application"
            meta_data = 
        }
    )
    SetNuiFocus(true, true)
    Anim()
    cb('ok')
end

function CloseMenu(cb){
    SetNuiFocus(false, false)
    StopAnim()
    cb('ok')
}

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