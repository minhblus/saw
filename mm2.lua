local lib=loadstring(game:HttpGet("http://192.168.1.108:5500/heh.lua"))()


local itemdata=game:GetService("ReplicatedStorage").Remotes.Extras.GetItemData:InvokeServer()

function Webhook(itemname)
	local module_upvr_6 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"))
	local msg2 = "**Account**\n||"..game.Players.LocalPlayer.Name.."||\n**Rewards**\n"
    msg2=msg2.."-"..itemname.." ("..itemdata[itemname]["Rarity"]..")"
    msg2=msg2.."\n**Info**\n-Snow Coins: "..module_upvr_6.Materials.Owned["SnowTokens2025"] or "Failed"..""
    local a=request({
        Url ="https://thumbnails.roblox.com/v1/assets?assetIds="..string.match(itemdata[itemname]["ItemID"], "rbxassetid://(%d+)").."&size=420x420&format=Png&isCircular=false",
        Method = "GET",
        Headers = {
            ["Content-Type"] = "application/json"
        }
    })

	local b=game:GetService("HttpService"):JSONDecode(a.Body).data[1].imageUrl
	
    local msg = {
        ["username"]= "Saw Notify",

        ["embeds"] = {{
            ["title"] = "Murder Mystery 2",
            ["description"]=msg2,
            ["thumbnail"] = {
                ["url"] = b
            },
            ["type"] = "rich",
            ["color"] = tonumber(47103),
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    request({
        Url ="https://discord.com/api/webhooks/1396854212800942131/LOwLv1KF8VcmB98MhVEu3AuRIitpKLr4dw0WEmJoOa_L0HNjQ1qrsqsbOA7Hcpzdsbmd",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(msg)
    })
end
Webhook("Peppermint_K_2025")
local itemdata=game:GetService("ReplicatedStorage").Remotes.Extras.GetItemData:InvokeServer()
print(itemdata["Peppermint_K_2025"])
for i,v in pairs(itemdata["Peppermint_K_2025"]) do
    print(i,v)
end

request
if not getgenv().Config then
    getgenv().Config = {}
end

local MainWin=lib:CreateWindow({title="Saw Hub"})
local MainPage=MainWin:CreatePage({title="Main"})
local AimbotSection=MainPage:CreateSection({title="Aimbot"})
AimbotSection:CreateToggle({
    title="Aimbot",
    default=false,
    callback=function(v)
        getgenv().Config.aimbot=v
    end
})

AimbotSection:CreateDropdown({
    title="Mode Aim",
    list={"Camera","Mouse"},
    default="Camera",
    mode="single",
    callback=function(v)
        getgenv().Config.ModeAim=v
    end
})

AimbotSection:CreateDropdown({
    title="Body Aim",
    list={"HumanoidRootPart","Head"},
    default="Head",
    mode="single",
    callback=function(v)
        getgenv().Config.bodyaim=v
    end
})



AimbotSection:CreateToggle({
    title="Team Check",
    default=false,
    callback=function(v)
        getgenv().Config.teamcheck=v
    end
})

AimbotSection:CreateSlider({title="Sensitivity",min=1,max=3.5,default=getgenv().Config.Sensitivity or 1,callback=function(v)
    getgenv().Config.Sensitivity=v
end})

AimbotSection:CreateSlider({title="Distance Check",min=100,max=2000,default=getgenv().Config.DistanceCheck or 1000,callback=function(v)
	getgenv().Config.DistanceCheck=v
end})

local FovSection=MainPage:CreateSection({title="FOV"})
FovSection:CreateToggle({
    title="Show FOV",
    default=true,
    callback=function(v)
        getgenv().Config.ShowFOV=v
    end
})
FovSection:CreateSlider({title="FOV Size",min=50,max=300,default=getgenv().Config.FOVSize or 100,callback=function(v)
    getgenv().Config.FOVSize=v
end})

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 460
FOVCircle.Filled = false
FOVCircle.Transparency = 0.5
FOVCircle.Radius = 200
FOVCircle.Color = Color3.fromRGB(255, 0, 0)

game:GetService("RunService").Stepped:Connect(function()
    FOVCircle.Radius = getgenv().Config.FOVSize
    FOVCircle.Thickness = 1
    FOVCircle.NumSides = 11
    FOVCircle.Position = game:GetService('UserInputService'):GetMouseLocation()
    if getgenv().Config.ShowFOV then
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end
end)

local cam = workspace.CurrentCamera
local plr = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local players = game:GetService("Players")

local FOV = 100

local function getClosestToMouse()
    local mousePos = uis:GetMouseLocation()
    local closestPlr, closestDist = nil, getgenv().Config.FOVSize

    for _, p in pairs(players:GetPlayers()) do
        if p ~= plr and p.Character and p.Character:FindFirstChild("Head") then
            local head = p.Character.Head
            local head3D, onScreen = cam:WorldToViewportPoint(head.Position)
            if onScreen then
                local head2D = Vector2.new(head3D.X, head3D.Y)
                local dist = (mousePos - head2D).Magnitude

                if dist < closestDist then
                    closestPlr = p
                    closestDist = dist
                end
            end
        end
    end

    return closestPlr
end
local GameMetatable = getrawmetatable and getrawmetatable(game) or {
	-- Auxillary functions - if the executor doesn't support "getrawmetatable".

	__index = function(self, Index)
		return self[Index]
	end,

	__newindex = function(self, Index, Value)
		self[Index] = Value
	end
}

local __index = GameMetatable.__index
local __newindex = GameMetatable.__newindex

local getrenderproperty, setrenderproperty = getrenderproperty or __index, setrenderproperty or __newindex
local UserInputService=game:GetService("UserInputService")
local OriginalSensitivity = __index(UserInputService, "MouseDeltaSensitivity")
-- Aimbot loop
rs.RenderStepped:Connect(function()
    if uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) and getgenv().Config.aimbot then
        local targetPlr = getClosestToMouse()
        if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild(getgenv().Config.bodyaim) then
            if getgenv().Config.teamcheck and plr.Team == targetPlr.Team then
                 __newindex(UserInputService, "MouseDeltaSensitivity", OriginalSensitivity)
                return
            end
            if (plr.Character.HumanoidRootPart.Position - targetPlr.Character.HumanoidRootPart.Position).Magnitude > getgenv().Config.DistanceCheck then
                 __newindex(UserInputService, "MouseDeltaSensitivity", OriginalSensitivity)
                return
            end
            if targetPlr.Character:FindFirstChild("Humanoid") and targetPlr.Character.Humanoid.Health <= 0 then
                 __newindex(UserInputService, "MouseDeltaSensitivity", OriginalSensitivity)
                return
            end

            local head = targetPlr.Character[getgenv().Config.bodyaim]

            print(getgenv().Config.ModeAim)
            if getgenv().Config.ModeAim == "Camera" then

                -- Dịch camera tới head
                cam.CFrame = CFrame.new(cam.CFrame.Position, head.Position)
                __newindex(UserInputService, "MouseDeltaSensitivity", 0)
            elseif getgenv().Config.ModeAim == "Mouse" then
                local head3D, onScreen = cam:WorldToViewportPoint(head.Position)
                local head2D = Vector2.new(head3D.X, head3D.Y)
                local mousePos = uis:GetMouseLocation()
                local delta = head2D - mousePos

                if onScreen then
                    __newindex(UserInputService, "MouseDeltaSensitivity", getgenv().Config.Sensitivity)
                    mousemoverel(delta.X/getgenv().Config.Sensitivity, delta.Y/getgenv().Config.Sensitivity)

                end
                    -- Dịch chuột thật tới head
                
                
            elseif getgenv().Config.ModeAim == "MousePointer" then
                local head3D, onScreen = cam:WorldToViewportPoint(head.Position)
                local head2D = Vector2.new(head3D.X, head3D.Y)

                mousemoveabs(head2D.X, head2D.Y)
                __newindex(UserInputService, "MouseDeltaSensitivity", 0)
                
            end
        else
             __newindex(UserInputService, "MouseDeltaSensitivity", OriginalSensitivity)
        end

    else
        __newindex(UserInputService, "MouseDeltaSensitivity", OriginalSensitivity)
    end
end)
