local function sendMessage(type)
    local input = lib.inputDialog(Config.InputBox.title, {
        {type = Config.InputBox.type, label = Config.InputBox.label, required = true, min = Config.InputBox.minText},
    })
    if not input or not input[1] then return end
    TriggerServerEvent('intercom:sendMessage', type, input[1])
end

local function showIntercomMenu(type)
    lib.registerMenu({
        id = 'intercom:showMenu',
        title = Config.MainMenu.title,
        position = Config.MainMenu.position,
        options = {
            { label = Config.MainMenu.showMessage },
            { label = Config.MainMenu.sendMessage },
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            TriggerServerEvent('intercom:showMessages', type)
        end
        if selected == 2 then
            sendMessage(type)
        end
    end)
    lib.showMenu('intercom:showMenu')
end

RegisterNetEvent('intercom:showMessage', function(type, data)
    local options = {}
    for pos, val in ipairs(data) do
        options[pos] = { label = val.message, description = string.format("%s | %s", val.name, val.date) }
    end
    if #options < 1 then return Notify(Lang.no_messages) end
    lib.registerMenu({
        id = 'intercom:showMessages',
        title = Config.ShowMenu.title,
        position = Config.ShowMenu.position,
        options = options
    }, function(selected, scrollIndex, args)
        if selected and Config.DeleteMessages then
            local alert = lib.alertDialog({
                content = Lang.are_you_sure,
                centered = true,
                cancel = true
            })
            if alert == 'confirm' then
                TriggerServerEvent('intercom:deleteMessage', type, selected)
            end
        end
    end)
    lib.showMenu('intercom:showMessages')
end)

exports('useItem', function(data, item)
    local hasDurability = item.metadata.durability[1]
    if hasDurability < 1 then return end
    if not item.metadata.type or not item.metadata.typeName then return Notify(Lang.invalid_type) end
    if not HasJob(item.metadata.type) then return Notify(Lang.not_authorized) end
    showIntercomMenu(item.metadata.type)
end)
exports[Config.InventoryName]:displayMetadata('typeName', Config.InventoryMetaType)