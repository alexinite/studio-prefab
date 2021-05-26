-- 25.05.2021

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunSerivce = game:GetService("RunService")

-- Variables
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local IsClient = RunSerivce:IsClient()

local Module = {}
local Functions = {}

-- Functions
if not IsClient then
    function Functions:SendAll(...)
        if self.Type == "Fire" then
            return Remotes.EventKey:FireAllClients(self.Name, ...)
        end
    end
end

function Functions:Send(...)
    local Key = Remotes:WaitForChild(self.Type == "Fire" and "Event" or "Function" .. "Key", 120)
    local Type = self.Is .. IsClient and "Server" or "Client"

    if IsClient then
        return Key[Type](Key, self.Name, ...)
    else
        local Player = ...
        return Key[Type](Key, Player, self.Name, ...)
    end
end

-- Main Module
function Module:GetEvent(Name)
    local MT = setmetatable(Functions, {})
    MT.Key = "Fire"
    MT.Name = Name
    return MT
end

function Module:GetFunction(Name)
    local MT = setmetatable(Functions, {})
    MT.Key = "Invoke"
    MT.Name = Name
    return MT
end

return Module
