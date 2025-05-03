local hehehe={"Common","Uncommon","Epic","Unique","Rare"}

repeat wait(1) until game:IsLoaded()
wait(10)

local vietnamOffset = 7 * 60 * 60
local petall=require(game:GetService("ReplicatedStorage").Shared.Data.Pets)
local v_u_14 = require(game:GetService("ReplicatedStorage").Client.Framework.Services.LocalData)
function Get_Data()
    return v_u_14:Get()
end

function update()
    local vnTimestamp = os.time() + vietnamOffset
    local vnTime = os.date("!*t", vnTimestamp)
    local formatted = string.format("%04d-%02d-%02d %02d:%02d:%02d",vnTime.year, vnTime.month, vnTime.day,vnTime.hour, vnTime.min, vnTime.sec)
    local pets={}
    for i,v in pairs(Get_Data().Pets) do
        if not table.find(hehehe,petall[v.Name].Rarity) then
            local shiny = (v.Shiny and "[Shiny] ") or ""
            local mythic = (v.Mythic and "[Mythic] ") or ""
            local fullname=shiny..mythic..v.Name
            local count=v.Amount or 1
            if pets[fullname] then
                pets[fullname]+=count
            else
                pets[fullname]=count
            end
        end
    end

        
    local msg = {
        account=game.Players.LocalPlayer.Name,
        total_gems=Get_Data().Gems,
        total_coin=Get_Data().Coins,
        total_hatch=Get_Data().Stats.Hatches,
        pets=pets,
        last_update=formatted,
    }

    request({
        Url ="http://67.220.85.157:6336/api/data",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(msg)
    })
end

while wait() do
    update()
    wait(30)
end
