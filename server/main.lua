ESX = nil

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

-- Pay for the application
ESX.RegisterServerCallback('lucid-weapon-license:pay', function(source, cb, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= price then
        xPlayer.removeMoney(price)
        TriggerClientEvent('esx:showNotification', _source, _U('You paid', ESX.Math.GroupDigits(price)))
        cb(true)
    else
        cb(false)
    end
end)


-- Check if they have an application pending
ESX.RegisterServerCallback('lucid-weapon-license:hasAppOpen', function(citizenID, cb)
    MySQL.Async.fetchAll('SELECT * FROM weapon_license_apps WHERE id = @citizenID', { ['@citizenID'] = citizenID }, function(result)
        if json.encode(result).length > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
end)

-- Submit Application to DB
ESX.RegisterServerCallback('lucid-weapon-license:submitToDB', function(data, cb)
    MySQL.Async.execute("INSERT INTO weapon_license_apps (citizenID, description, crime_check, time) VALUES (@citizenID, @description, @crime_check, @time",
        {['citizenID'] = data.citizenID, ['description'] = data.description, ['crime_check'] = data.crime_check, ['time'] = os.time(os.date("!*t"))},
        function(results)
          if results then
            cb(true)
          else
            cb(false)
          end
    end)
end)

-- Send an application,
ESX.RegisterServerCallback("lucid-weapon-license:sendApplication", function(data, cb, price)

        -- Check if they have an application pending
        ESX.TriggerServerCallback('lucid-weapon-license:hasAppOpen', data.citizenID, function(result)
            if result then
                cb(false, "Failed: You have an application open already")
                return;
            end
        end)

        -- Check if they can pay
        ESX.TriggerServerCallback('lucid-weapon-license:pay', data.source, function(result)
            if not result then
                cb(false, "Failed: You do not have enough money.")
                return;
            end
        end, price)

        --Deposit it in the society fund bby :) ez money #pdOnTop
        TriggerServerEvent('esx_society:depositMoney', 'police', price);
        sendWebhook()

        cb(true, "Success: You have made a weapon license application")
    end
)


RegisterServerEvent("lucid-weapon-license:acceptApplication")
AddEventHandler(
    "lucid-weapon-license:acceptApplication",
    function(data)
        -- Remove entry to database
        TriggerServerEvent("whatever-event-to-accept-gunlicense", {data: data.id})
    end    
)

RegisterServerEvent("lucid-weapon-license:denyApplication")
AddEventHandler("lucid-weapon-license:denyApplication", 
    function(data)
        -- Remove entry to database
    end
)

function sendWebhook(message)
    local send = {
        {
            ["color"] = 65280,
            ["title"] = DISCORD_TITLE,
            ["description"] = message,
            ["footer"] = {
                ["text"] = DISCORD_FOOTER,
            },
        }
    }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = send}), { ['Content-Type'] = 'application/json' })
end


