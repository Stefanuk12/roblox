-- // Dependencies
local MusicAPI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/Controller.lua"))()
MusicAPI.CheckAllSounds()

-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Prefix = "."

-- // CMD Handlers
local Commands = {}
local function addCommand(Command, Function)
    Commands[#Commands + 1] = {
        Name = Command,
        Function = Function
    }
end

LocalPlayer.Chatted:Connect(function(message)
    if (message:sub(1, 1) ~= Prefix) then return end
    for i = 1, #Commands do
        local v = Commands[i];
        
        if (message:sub(#Prefix + 1, #v.Name) == v.Name) then
            v.Function(message:sub(#v.Name + #Prefix))
        end
    end
end)

-- // Commands
addCommand("play", function(message)
    local songNumber = tonumber(message)
    local SoundObject = MusicAPI.musicTable[songNumber]
    if (songNumber and SoundObject) then
        Players:Chat(":music " .. SoundObject.SoundId)
        print('Now Playing: ' .. SoundObject.Name)
    end
end)

addCommand("music", function(message)
    print(MusicAPI.GetAll())
end)

addCommand("refresh", function(message)
    MusicAPI.CheckAllSounds()
end)

print('Loaded Music Commands')