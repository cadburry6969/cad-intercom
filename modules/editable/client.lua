function Notify(msg)
    lib.notify({description = msg})
end
RegisterNetEvent('intercom:showNotify', Notify)

function HasJob(name)
    return true
end

function HasIntercom(type)
    local result = exports[Config.InventoryName]:Search('slots', Config.ItemName)
    local count = 0
    local hasType = false
    for _, info in pairs(result) do
        local hasDurability = info.metadata.durability
        if hasDurability and hasDurability[1] > 0 or not hasDurability then count += 1 end
        if (info.metadata.type == type) and not hasType then hasType = true end
    end
    return (count > 0) and hasType
end

RegisterNetEvent('intercom:displayMessage', function(type, data)
    -- data.message, data.date, data.name
    if not HasIntercom(type) or not HasJob(type) then return end
    TriggerEvent('chat:addMessage', {
        color = { 255, 155, 155},
        multiline = true,
        args = {"("..Config.Types[type]..") "..data.name..":", data.message}
    })
end)

CreateThread(function()
    for _, v in pairs(Config.Shop) do
        lib.zones.box({
            coords = v.zone.coords,
            size = v.zone.size,
            rotation = v.zone.rotation,
            inside = function()
                if IsControlJustPressed(0, 38) or IsDisabledControlJustPressed(0, 38) then
                    if HasJob(v.job) then
                        TriggerServerEvent('intercom:buyItem', v)
                    end
                end
            end,
            onEnter = function()
                if HasJob(v.job) then
                    lib.showTextUI(Lang.purchase_intercom)
                end
            end,
            onExit = function()
                lib.hideTextUI()
            end
        })
    end
end)

if Config.SendMessageCommand then
    for index, data in pairs(Config.SendMessageCommands) do
        RegisterCommand(data.command, function(source, args)
            if not HasJob(data.job) then return end
            local message = table.concat(args, ' ')
            if message ~= '' then
                TriggerServerEvent('intercom:sendMessage', index, message)
            end
        end, false)
        TriggerEvent('chat:addSuggestion', '/'..data.command, data.suggestion.help, data.suggestion.arguments)
    end
end