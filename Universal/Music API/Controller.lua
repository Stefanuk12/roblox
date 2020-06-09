getgenv().ValiantMusicAPI = {}
ValiantMusicAPI.GHMusicTable = 'https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/MusicTable.json'
ValiantMusicAPI.musicTable = {}
ValiantMusicAPI.oldMusicTable = {}

ValiantMusicAPI.removedAssets = {
    'https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059',
    'https://t5.rbxcdn.com/d28c1b5eed271a7aa76f16689e74ca04',
    'This audio asset has been blocked due to copyright violations.',
}
function ValiantMusicAPI.checkBadSound(SoundId)
    local url = game:HttpGetAsync('https://www.roblox.com/library/'..SoundId)
    if url then
        for i,v in pairs(removedAssets) do
            if string.match(url, v) then
                return true
            end
        end
    end
    if SoundId then
        return (game:GetService("MarketplaceService"):GetProductInfo(SoundId, Enum.InfoType.Asset).Description == '(Removed for copyright)' or game:GetService("MarketplaceService"):GetProductInfo(SoundId, Enum.InfoType.Asset).Description == '[ Content Deleted ]')
    end
    return false
end

function ValiantMusicAPI.testAllSounds(mode)
    warn('--~~-- Commencing Music Checks - Allow upto 30 seconds! --~~--')
    ValiantMusicAPI.oldMusicTable = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync(ValiantMusicAPI.GHMusicTable))
    for i,v in pairs(ValiantMusicAPI.oldMusicTable) do
        coroutine.wrap(function()
            wait(1)
            if checkBadSound(v.SoundId) then
                wait(1)
                ValiantMusicAPI.oldMusicTable[i] = nil
                if mode then print('Removed:', v.Name) end
            end
        end)()
    end
    wait(30)
    ValiantMusicAPI.musicTable = {}
    for i,v in pairs(ValiantMusicAPI.oldMusicTable) do
        table.insert(ValiantMusicAPI.musicTable, v)
    end
    warn('--~~-- Music Checks Finished! --~~--')
    ValiantMusicAPI.musicChecks = true
end

function ValiantMusicAPI.returnMusic(mode)
    if not ValiantMusicAPI.musicChecks then
        ValiantMusicAPI.testAllSounds(mode)
    end
    wait(0.5)
    for i,v in pairs(ValiantMusicAPI.musicTable) do
        print(i, "|", v.Name)
    end
end
