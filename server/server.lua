local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Commands.Add(Config.tpname, 'Telport to Saved Location', {{name='Name', help='Name of saved location'}}, false, function(source, args)
    if args[1] then
        local name = args[1]
        if name ~= nil then
            local result = MySQL.Sync.fetchAll('SELECT * FROM mxd_teleport WHERE name = ?', {name})
            if result[1] then
                coords = vector3(result[1].x, result[1].y, result[1].z)
                TriggerClientEvent('QBCore:Command:TeleportToPlayer', source, coords)
                TriggerClientEvent('QBCore:Notify', source, 'Teleported', 'success')
            else
                TriggerClientEvent('QBCore:Notify', source,'No such name Found', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source,'Incorrect format', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', 'All Arguments must be filled', 'error')
    end
end, 'admin')


QBCore.Commands.Add(Config.tpsavecoords, 'Save Location By Coords (Admin Only)', { { name = 'Name', help = 'Name of location to save' }, { name = 'x', help = 'X position' }, { name = 'y', help = 'Y position' }, { name = 'z', help = 'Z position' } }, false, function(source, args)
    if args[1] and args[2] and args[3] and args[4] then
        local name = args[1]
        local x = tonumber((args[2]:gsub(",",""))) + .0
        local y = tonumber((args[3]:gsub(",",""))) + .0
        local z = tonumber((args[4]:gsub(",",""))) + .0
        if name ~= nil and x ~= 0 and y ~= 0 and z ~= 0 then
            local result = MySQL.Sync.fetchAll('SELECT * FROM mxd_teleport WHERE name = ?', {name})
            if result[1] then
                TriggerClientEvent('QBCore:Notify', source,'Name already exists', 'error')
            else
                MySQL.Async.insert('INSERT INTO mxd_teleport (name, x, y, z) VALUES (?, ?, ?, ?)', {
                    name,
                    x,
                    y,
                    z,
                })
                TriggerClientEvent('QBCore:Notify', source, 'Saved', 'success')
            end
        else
            TriggerClientEvent('QBCore:Notify', source,'Incorrect format', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', 'All Arguments must be filled', 'error')
    end
end, 'admin')


QBCore.Commands.Add(Config.tpsavehere, 'Save Location of Where You are Standing (Admin Only)', { { name = 'Name', help = 'Name of location to save' } }, false, function(source, args)
    if args[1] then
        local name = args[1]
        local src = source 
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local x = coords.x
        local y = coords.y
        local z = coords.z
        if name ~= nil and x ~= 0 and y ~= 0 and z ~= 0 then
            local result = MySQL.Sync.fetchAll('SELECT * FROM mxd_teleport WHERE name = ?', {name})
            if result[1] then
                TriggerClientEvent('QBCore:Notify', source,'Name already exists', 'error')
            else
                MySQL.Async.insert('INSERT INTO mxd_teleport (name, x, y, z) VALUES (?, ?, ?, ?)', {
                    name,
                    x,
                    y,
                    z,
                })
                TriggerClientEvent('QBCore:Notify', source, 'Saved', 'success')
            end
        else
            TriggerClientEvent('QBCore:Notify', source,'Incorrect format', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', 'All Arguments must be filled', 'error')
    end
end, 'admin')


QBCore.Commands.Add(Config.tpdelete, 'Delete Location (Admin Only)', { { name = 'Name', help = 'Name of location to delete' } }, false, function(source, args)
    if args[1] then
        local name = args[1]
        if name ~= nil then
            local result = MySQL.Sync.fetchAll('SELECT * FROM mxd_teleport WHERE name = ?', {name})
            if result[1] then
                MySQL.Async.execute('DELETE FROM mxd_teleport WHERE name = ?', { name }, function()
                    TriggerClientEvent('QBCore:Notify', source, 'Deleted', 'success')
                end)
            else
                TriggerClientEvent('QBCore:Notify', source,'No such name Found', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source,'Incorrect format', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', 'All Arguments must be filled', 'error')
    end
end, 'admin')