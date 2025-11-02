local Config = require 'config'
local Utils = require 'modules.server.utils'

local Players = {}
local cachedPlayersArray = {}
local cacheValid = false

local framework = Utils.getFramework()

local function getJobData(job)
    if framework == 'qb' or framework == 'qbx' then
        return job.name, job.onduty or false
    elseif framework == 'esx' then
        if job.onDuty ~= nil then
            return job.name, job.onDuty
        else
            local jobName = job.name
            local onDuty = true
            if jobName:sub(1, 4) == 'off_' then
                jobName = jobName:sub(5)
                onDuty = false
            end
            return jobName, onDuty
        end
    end
    return nil, false
end

local function getPlayerJobData(playerId)
    if not framework then return nil, false end

    if framework == 'qb' then
        local QB = exports['qb-core']:GetCoreObject()
        local player = QB.Functions.GetPlayer(playerId)
        if not player or not player.PlayerData or not player.PlayerData.job then return nil, false end
        return getJobData(player.PlayerData.job)
    elseif framework == 'qbx' then
        local player = exports.qbx_core:GetPlayer(playerId)
        if not player or not player.PlayerData or not player.PlayerData.job then return nil, false end
        return getJobData(player.PlayerData.job)
    elseif framework == 'esx' then
        local ESX = exports.es_extended:getSharedObject()
        local player = ESX.GetPlayerFromId(playerId)
        if not player or not player.job then return nil, false end
        return getJobData(player.job)
    end

    return nil, false
end

local function doesGroupRequireOnDuty(jobName)
    for _, group in ipairs(Config.groups) do
        if group.onDutyRequired then
            for _, groupJob in ipairs(group.groups) do
                if groupJob == jobName then
                    return true
                end
            end
        end
    end
    return false
end

local function shouldShowPlayer(jobName, onDuty)
    if not jobName then return false end
    
    local requiresOnDuty = doesGroupRequireOnDuty(jobName)
    
    if requiresOnDuty then
        return onDuty
    else
        return true
    end
end

local function invalidateCache()
    cacheValid = false
end

local function rebuildCache()
    cachedPlayersArray = {}
    local index = 1

    for playerId, name in pairs(Players) do
        local jobName, onDuty = getPlayerJobData(playerId)
        
        if shouldShowPlayer(jobName, onDuty) then
            cachedPlayersArray[index] = {
                name = name,
                id = playerId,
            }
            index += 1
        end
    end

    cacheValid = true
end

CreateThread(function()
    for _, playerId in ipairs(GetPlayers()) do
        local playerIdNum = tonumber(playerId)
        Players[playerIdNum] = GetPlayerName(playerIdNum)
    end
    
    invalidateCache()
end)

local function handlePlayerDrop(playerId)
    if Players[playerId] then
        Players[playerId] = nil
        invalidateCache()
    end
end

AddEventHandler('playerJoining', function()
    local playerId = source
    if not Players[playerId] then
        Players[playerId] = GetPlayerName(playerId)
    end
end)

AddEventHandler('playerDropped', function()
    handlePlayerDrop(source)
end)

if framework == 'qb' or framework == 'qbx' then
    AddEventHandler('QBCore:Server:OnJobUpdate', function(playerId, job)
        if not Players[playerId] then
            Players[playerId] = GetPlayerName(playerId)
        end
        
        local newJobName, newOnDuty = getJobData(job)
        local requiresOnDuty = doesGroupRequireOnDuty(newJobName)
        
        if requiresOnDuty then
            if newOnDuty then
                invalidateCache()
            else
                invalidateCache()
            end
        else
            invalidateCache()
        end
    end)
    
    AddEventHandler('QBCore:Server:SetDuty', function(playerId, onDuty)
        if not Players[playerId] then return end
        
        local jobName, _ = getPlayerJobData(playerId)
        if not jobName then return end
        
        local requiresOnDuty = doesGroupRequireOnDuty(jobName)
        
        if requiresOnDuty then
            invalidateCache()
        end
    end)
    
elseif framework == 'esx' then
    AddEventHandler('esx:setJob', function(playerId, job)
        if not Players[playerId] then
            Players[playerId] = GetPlayerName(playerId)
        end
        
        local newJobName, newOnDuty = getJobData(job)
        local requiresOnDuty = doesGroupRequireOnDuty(newJobName)
        
        if requiresOnDuty then
            if newOnDuty then
                invalidateCache()
            else
                invalidateCache()
            end
        else
            invalidateCache()
        end
    end)
end

local function getPlayers(showPlayerNames, showPlayerIds)
    if not cacheValid then
        rebuildCache()
    end
    
    local result = {}
    
    for _, player in ipairs(cachedPlayersArray) do
        local data = {}
        
        if showPlayerNames then
            data.name = player.name
        end
        
        if showPlayerIds then
            data.id = player.id
        end
        
        result[#result + 1] = data
    end
    
    return result
end

return {
    getPlayers = getPlayers,
}
