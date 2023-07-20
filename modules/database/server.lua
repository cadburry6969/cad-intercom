local messages = {}

-- functions to get/update/delete data
function GetData(type)
	if not messages[type] then messages[type] = {} end
	return messages[type]
end

function UpdateData(type, data)
	if not messages[type] then messages[type] = {} end
	table.insert(messages[type], #messages[type]+1, data)
	return true
end

function DeleteData(type, index)
	if not messages[type] then return false end
	table.remove(messages[type], index)
	return true
end

if Config.SaveMessages then
-- fetch saved data if script/server has been restarted
CreateThread(function()
	Wait(100)
	local LoadJson = json.decode(LoadResourceFile(GetCurrentResourceName(), './messages.json'))
	if type(LoadJson) == 'table' then
		messages = LoadJson
		SaveResourceFile(GetCurrentResourceName(), "./messages.json", json.encode(messages), -1)
	else
		SaveResourceFile(GetCurrentResourceName(), "./messages.json", '[]', -1)
	end
end)

-- Save data
local function updateJson()
    SaveResourceFile(GetCurrentResourceName(), "./messages.json", json.encode(messages), -1)
end

AddEventHandler('txAdmin:events:serverShuttingDown', updateJson)
AddEventHandler('onResourceStop', function(res)
	if res ~= GetCurrentResourceName() then return end
	updateJson()
end)
end