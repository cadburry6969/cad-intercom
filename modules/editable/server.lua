local inventory = exports[Config.InventoryName]

function GetName(src)
    return 'Unknown'
end

function RemoveMoney(src, amount)
    if inventory:RemoveItem(src, 'money', amount) then
        return true
    end
    return false
end

RegisterNetEvent('intercom:buyItem', function(data)
    if not Config.Types[data.type] then return end
    local _source = source
    if inventory:CanCarryItem(_source, Config.ItemName, 1) then
        if RemoveMoney(_source, data.price) then
            inventory:AddItem(_source, Config.ItemName, 1, {
                type = data.type,
                typeName = Config.Types[data.type],
            })
        else
            TriggerClientEvent('intercom:showNotify', _source, Lang.not_enough_money)
        end
    end
end)