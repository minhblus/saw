-- game:GetService("Players").LocalPlayer.PlayerGui.FishingUIBill.Frame.Player
-- game:GetService("Players").LocalPlayer.PlayerGui.FishingUIBill.Frame.Goal
-- game:GetService("Players").LocalPlayer.PlayerGui.FishingUIBill
if game.PlaceId==3978370137 then
    repeat wait()
    until game:IsLoaded()
    repeat wait()
    until game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    wait(10)
    getgenv().Config={
        AutoFish = true,
        AutoSell = {
            Enable=true,
            Rarity={"Common","Rare"}
        },
        AutoBuy = false,
        Rod="Rare Fishing Rod",
        Bait="Common Fish Bait",
    }

    local posfish=CFrame.new(-1331.32605, 4.12502337, -4958.8667, -0.999929011, -2.90768991e-08, 0.0119130174, -2.89806596e-08, 1, 8.25119972e-09, -0.0119130174, 7.90536703e-09, -0.999929011)
    local posbuy=CFrame.new(-1342.987548828125, 4.125025272369385, -4982.90087890625)
    local possell=CFrame.new(-1327.6944580078125, 4.125023365020752, -4977.693359375)

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    function TweenTo(cf)
        local dist=(cf.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        local tween = game:GetService("TweenService"):Create(LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(dist/15,Enum.EasingStyle.Linear),{CFrame=cf})
        tween:Play()
        tween.Completed:Wait()
    end

    local data=game.ReplicatedStorage:WaitForChild("Stats"..game:GetService("Players").LocalPlayer.Name)

    function CheckInven(item) 
        local cac = game:GetService("HttpService"):JSONDecode(data.Inventory.Inventory.Value)
        for k,v in pairs(cac) do 
            if k==item then 
                return v
            end
        end
        return 0
    end


    local v1 = Random.new(workspace:GetAttribute("RNGSeed"))
    local v2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Fishing"):WaitForChild("Data"):WaitForChild("Items")  )

    function SellFish(dontneedmax)
        local cac = game:GetService("HttpService"):JSONDecode(data.Inventory.Inventory.Value)
        for k,v in pairs(cac) do 
            if v2[k] and (dontneedmax or tonumber(v) >= v2[k]["Max"]) and table.find(getgenv().Config.AutoSell.Rarity, v2[k]["Rare"]) and v2[k]["Type"] == "Fish" then 
                if (LocalPlayer.Character.HumanoidRootPart.Position-possell.Position).Magnitude >= 2 then
                    TweenTo(possell)
                    wait(.5) 
                end
                local args = {
                    [1] = {
                        ["Fish"] = k,
                        ["All"] = true,
                        ["Method"] = "SellFish"
                    }
                }

                game:GetService("ReplicatedStorage"):WaitForChild("FishingShopRemote"):InvokeServer(unpack(args))
                wait(math.random(1,2))
            end
        end
    end

    function BuyBait()
        local baitstill=tonumber(CheckInven(getgenv().Config.Bait)) or 0
        if baitstill < 1 then
            local canbuybait = math.min(math.floor(data.Stats.Peli.Value/45),300-baitstill)
            if canbuybait < 1 then 
                SellFish(true)
                wait(.5) 
                return
            end
            TweenTo(posbuy)
            wait(.1)
            local args = {
                [1] = workspace:WaitForChild("BuyableItems"):WaitForChild("Common Fish Bait"),
                [2] = canbuybait
            }

            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Shop"):InvokeServer(unpack(args))
            wait(.5)
            
        end
    end


    function RandomSoThuc(minn,maxx)
        return minn+(math.random()*(maxx-minn))
    end

    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local ActionRemote = ReplicatedStorage:WaitForChild("Fishing"):WaitForChild("Remotes"):WaitForChild("Action")
    local RunService = game:GetService("RunService")


    local function GuiTinHieu(data)
        ActionRemote:InvokeServer({ [1] = data })
    end

    function GetRodName()
        local tier1="Rare Fishing Rod"
        local tier2="Fishing Rod"
        if LocalPlayer.Backpack:FindFirstChild(tier1) then
            return tier1
        end
        if LocalPlayer.Character:FindFirstChild(tier1) then
            return tier1
        end
        if LocalPlayer.Backpack:FindFirstChild(tier2) then
            return tier2
        end
        if LocalPlayer.Character:FindFirstChild(tier2) then
            return tier2
        end
    end

    while getgenv().Config.AutoFish and task.wait() do

        local character = LocalPlayer.Character
        if character then
            local rod = character:FindFirstChild(GetRodName())
            if rod then

                BuyBait()
                if getgenv().Config.AutoSell then
                    SellFish()
                end

                if (LocalPlayer.Character.HumanoidRootPart.CFrame.Position - posfish.Position).magnitude >= 2 then
                    TweenTo(posfish)
                    wait(.1)
                end
            
                local lastbait=tonumber(CheckInven("Common Fish Bait")) or 0

                local args = {
                    [1] = {
                        ["Goal"] = Vector3.new(RandomSoThuc(-1339, -1330), RandomSoThuc(-99, -19), RandomSoThuc(-4946, -4772)),
                        ["Action"] = "Throw",
                        ["Bait"] = "Common Fish Bait"
                    }
                }

                ActionRemote:InvokeServer(unpack(args))

                task.wait(RandomSoThuc(1.5, 2))
                local args = {
                    [1] = {
                        ["Action"] = "Landed"
                    }
                }

                ActionRemote:InvokeServer(unpack(args))


                task.wait(0.1)
                local hookName = LocalPlayer.Name .. "'s hook"

                while true do
                    local currentBait = tonumber(CheckInven("Common Fish Bait")) or 0
                    local hookExists = workspace.Effects:FindFirstChild(hookName)
                    
                    if not hookExists then break end
                    if currentBait < lastbait then break end
                    
                    timer = timer + 0.5
                    if timer > 25 then break end 
                    task.wait(0.5)
                end

                task.wait(RandomSoThuc(9, 11))
                local args = {
                    [1] = {
                        ["Action"] = "Reel"
                    }
                }

                ActionRemote:InvokeServer(unpack(args))

                task.wait()
                local args = {
                    [1] = {
                        ["Action"] = "HookReturning"
                    }
                }

                ActionRemote:InvokeServer(unpack(args))
                task.wait()
                local args = {
                    [1] = {
                        ["Action"] = "Cancel"
                    }
                }

                ActionRemote:InvokeServer(unpack(args))
                task.wait(RandomSoThuc(1, 2))
            else
                local rod = LocalPlayer.Backpack:FindFirstChild(GetRodName())
                if rod then
                    rod.Parent = LocalPlayer.Character
                end
            end
        end
    end
end
