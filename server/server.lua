--[[
    ORIGINAL CODE https://github.com/DevTestingPizza/vSync
    REVAMPED BY Kalinka https://github.com/KalinkaGit/vSyncR
]]--

CurrentWeather = Config.StartWeather
local baseTime = Config.BaseTime
local timeOffset = Config.TimeOffset
local freezeTime = Config.FreezeTime
local blackout = Config.Blackout
local newWeatherTimer = Config.NewWeatherTimer

RegisterServerEvent('vSync:requestSync')
AddEventHandler('vSync:requestSync', function()
    TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
end)

function isAllowedToChange(player)
    if Config.AdminById then
        for k, v in ipairs(Config.Admins) do
            for k2, v2 in ipairs(GetPlayerIdentifiers(player)) do
                if string.lower(v2) == string.lower(v) then
                    return true
                end
            end
        end
    else
        for k, v in ipairs(Config.Ace) do
            if IsPlayerAceAllowed(player, v) then
                return true
            end
        end
    end
    return false
end

RegisterCommand('freezetime', function(source, args)
    if source ~= 0 then
        if isAllowedToChange(source) then
            freezeTime = not freezeTime
            if freezeTime then
                TriggerClientEvent('vSync:notify', source, _U('time_frozenc'))
            else
                TriggerClientEvent('vSync:notify', source, _U('time_unfrozenc'))
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, _U('not_allowed'))
        end
    else
        freezeTime = not freezeTime
        if freezeTime then
            print(_U('time_now_frozen'))
        else
            print(_U('time_now_unfrozen'))
        end
    end
end)

RegisterCommand('freezeweather', function(source, args)
    if source ~= 0 then
        if isAllowedToChange(source) then
            Config.DynamicWeather = not Config.DynamicWeather
            if not Config.DynamicWeather then
                TriggerClientEvent('vSync:notify', source, _U('dynamic_weather_disabled'))
            else
                TriggerClientEvent('vSync:notify', source, _U('dynamic_weather_enabled'))
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, _U('not_allowed'))
        end
    else
        Config.DynamicWeather = not Config.DynamicWeather
        if not Config.DynamicWeather then
            print(_U('weather_now_frozen'))
        else
            print(_U('weather_now_unfrozen'))
        end
    end
end)

RegisterCommand('weather', function(source, args)
    if source == 0 then
        local validWeatherType = false
        if args[1] == nil then
            print(_U('weather_invalid_syntax'))
            return
        else
            for i,wtype in ipairs(Config.AvailableWeatherTypes) do
                if wtype == string.upper(args[1]) then
                    validWeatherType = true
                end
            end
            if validWeatherType then
                print(_U('weather_updated'))
                CurrentWeather = string.upper(args[1])
                newWeatherTimer = 10
                TriggerEvent('vSync:requestSync')
            else
                print(_U('weather_invalid'))
            end
        end
    else
        if isAllowedToChange(source) then
            local validWeatherType = false
            if args[1] == nil then
                TriggerClientEvent('chatMessage', source, '', {255,255,255}, _U('weather_invalid_syntaxc'))
            else
                for i,wtype in ipairs(Config.AvailableWeatherTypes) do
                    if wtype == string.upper(args[1]) then
                        validWeatherType = true
                    end
                end
                if validWeatherType then
                    TriggerClientEvent('vSync:notify', source, _U('weather_willchangeto', string.lower(args[1])))
                    CurrentWeather = string.upper(args[1])
                    newWeatherTimer = 10
                    TriggerEvent('vSync:requestSync')
                else
                    TriggerClientEvent('chatMessage', source, '', {255,255,255}, _U('weather_invalidc'))
                end
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, _U('not_access'))
            print(_U('weather_accessdenied'))
        end
    end
end, false)

RegisterCommand('blackout', function(source)
    if source == 0 then
        blackout = not blackout
        if blackout then
            print(_U('blackout_enabled'))
        else
            print(_U('blackout_disabled'))
        end
    else
        if isAllowedToChange(source) then
            blackout = not blackout
            if blackout then
                TriggerClientEvent('vSync:notify', source, _U('blackout_enabledc'))
            else
                TriggerClientEvent('vSync:notify', source, _U('blackout_disabledc'))
            end
            TriggerEvent('vSync:requestSync')
        end
    end
end)

RegisterCommand('morning', function(source)
    if source == 0 then
        print(_U('time_console'))
        return
    end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(9)
        TriggerClientEvent('vSync:notify', source, _U('time_morning'))
        TriggerEvent('vSync:requestSync')
    end
end)
RegisterCommand('noon', function(source)
    if source == 0 then
        print(_U('time_console'))
        return
    end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(12)
        TriggerClientEvent('vSync:notify', source, _U('time_noon'))
        TriggerEvent('vSync:requestSync')
    end
end)
RegisterCommand('evening', function(source)
    if source == 0 then
        print(_U('time_console'))
        return
    end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(18)
        TriggerClientEvent('vSync:notify', source, _U('time_evening'))
        TriggerEvent('vSync:requestSync')
    end
end)
RegisterCommand('night', function(source)
    if source == 0 then
        print(_U('time_console'))
        return
    end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(23)
        TriggerClientEvent('vSync:notify', source, _U('time_night'))
        TriggerEvent('vSync:requestSync')
    end
end)

function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

RegisterCommand('time', function(source, args, rawCommand)
    if source == 0 then
        if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
            local argh = tonumber(args[1])
            local argm = tonumber(args[2])
            if argh < 24 then
                ShiftToHour(argh)
            else
                ShiftToHour(0)
            end
            if argm < 60 then
                ShiftToMinute(argm)
            else
                ShiftToMinute(0)
            end
            print(_U('time_change', argh, argm))
            TriggerEvent('vSync:requestSync')
        else
            print(_U('time_invalid'))
        end
    elseif source ~= 0 then
        if isAllowedToChange(source) then
            if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
                local argh = tonumber(args[1])
                local argm = tonumber(args[2])
                if argh < 24 then
                    ShiftToHour(argh)
                else
                    ShiftToHour(0)
                end
                if argm < 60 then
                    ShiftToMinute(argm)
                else
                    ShiftToMinute(0)
                end
                local newtime = math.floor(((baseTime+timeOffset)/60)%24) .. ":"
				local minute = math.floor((baseTime+timeOffset)%60)
                if minute < 10 then
                    newtime = newtime .. "0" .. minute
                else
                    newtime = newtime .. minute
                end
                TriggerClientEvent('vSync:notify', source, _U('time_changec', newtime))
                TriggerEvent('vSync:requestSync')
            else
                TriggerClientEvent('chatMessage', source, '', {255,255,255}, _U('time_invalid'))
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, _U('not_access'))
            print(_U('time_access'))
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)
        TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    end
end)

Citizen.CreateThread(function()
    while true do
        newWeatherTimer = newWeatherTimer - 1
        Citizen.Wait(60000)
        if newWeatherTimer == 0 then
            if Config.DynamicWeather then
                NextWeatherStage()
            end
            newWeatherTimer = 10
        end
    end
end)

function NextWeatherStage()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
        local new = math.random(1,2)
        if new == 1 then
            CurrentWeather = "CLEARING"
        else
            CurrentWeather = "OVERCAST"
        end
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
        elseif new == 2 then
            CurrentWeather = "CLOUDS"
        elseif new == 3 then
            CurrentWeather = "CLEAR"
        elseif new == 4 then
            CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then
            CurrentWeather = "SMOG"
        else
            CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
        CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
        CurrentWeather = "CLEAR"
    end
    TriggerEvent("vSync:requestSync")
end

print("vSync Revamped by Kalinka loaded!")