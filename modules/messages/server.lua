RegisterNetEvent('intercom:sendMessage', function(type, message)
    if not type or not message then return end
    if not Config.Types[type] then return end
    local _source = source
    local curTime = os.time()
    local time = os.date("%x", curTime)..' '..os.date("%X", curTime)
    local data = { name = GetName(_source), message = message, date = time }
    UpdateData(type, data)
    TriggerClientEvent('intercom:showNotify', _source, Lang.sent_message)
    TriggerClientEvent('intercom:displayMessage', -1, type, data)
end)

RegisterNetEvent('intercom:showMessages', function(type)
    if not type or not Config.Types[type] then return end
    local _source = source
    local data = GetData(type)
    TriggerClientEvent('intercom:showMessage', _source, type, data)
end)

RegisterNetEvent('intercom:deleteMessage', function(type, position)
    local _source = source
    DeleteData(type, position)
    TriggerClientEvent('intercom:showNotify', _source, Lang.delete_message)
end)