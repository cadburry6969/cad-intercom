Config = {}

Config.Types = {
    ['police'] = 'LSPD',
}

Config.SaveMessages = false
Config.DeleteMessages = false

Config.InventoryName = 'ox_inventory'
Config.InventoryMetaType = 'Channel'
Config.ItemName = 'intercom'

Config.MainMenu = {
    title = 'Intercom',
    position = 'top-right',
    showMessage = 'Show Messages',
    sendMessage = 'Send Message'
}

Config.ShowMenu = {
    title = 'Intercom Messages',
    position = 'top-right'
}

Config.InputBox = {
    type = 'input',
    title = 'Message Box',
    label = 'Input Message',
    minText = 4
}

Config.SendMessageCommand = true
Config.SendMessageCommands = {
    -- type = { command, suggestion, job _check }
    ['police'] = {
        command = 'pd',
        suggestion = {
            help = 'Police Intercom Chat',
            arguments = {
                { name = 'message', help = 'message to send' },
            }
        },
        job = 'police'
    }
}

Config.Shop = {
    {
        zone = {
            coords = vec3(441.5, -978.8, 30.75),
            size = vec3(3.0, 3.0, 2),
            rotation = 0.0,
        },
        type = 'police',
        job = 'police',
        price = 100
    }
}