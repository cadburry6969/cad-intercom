Add below code in `ox_inventory/data/items.lua`
```lua
    ["intercom"] = {
		label = "Intercom",
		description = "Device to communicate.",
		weight = 500,
		degrade = 4320,
		stack = false,
		close = true,
		client = {
			export = 'intercom.useItem'
		}
	},
```