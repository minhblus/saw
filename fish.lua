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
    local v2 = {
        ["Basic Fish Luck Brew"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Uncommon",
            ["Desc"] = "Contains a strange liquid which attracts rarer fishes within the area until it fades. <Color=Yellow>1.2x Luck multiplier<Color=/> <Color=Red>does not stack with other brews. <Color=/>Lasts <Color=Blue>1 Min<Color=/>",
            ["Max"] = 5,
            ["Type"] = "Drink"
        },
        ["Rare Fish Luck Brew"] = {
            ["tradeLevel"] = 75,
            ["Rare"] = "Rare",
            ["Desc"] = "Contains a strange liquid which attracts rarer fishes within the area until it fades. <Color=Yellow>1.275x Luck multiplier<Color=/> <Color=Red>does not stack with other brews. <Color=/>Lasts <Color=Blue>2 Mins<Color=/>",
            ["Max"] = 5,
            ["Type"] = "Drink"
        },
        ["Tigerfin"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Common",
            ["Desc"] = "A common fish with tiger-like stripes.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Common Fish",
            ["Price"] = v1:NextInteger(0, 250)
        },
        ["Exotic Tigerfin"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Rare",
            ["Desc"] = "A rare variation of the striped Tigerfin.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Rare Fish",
            ["Price"] = v1:NextInteger(1000, 3000)
        },
        ["Golden Tigerfin"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Legendary",
            ["Desc"] = "A legendary Tigerfin with gleaming golden scales.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Legendary Fish",
            ["Price"] = v1:NextInteger(10000, 15000)
        },
        ["Zebra Ribbon Angelfish"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Rare",
            ["Desc"] = "A rare angelfish with zebra-like ribbons.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Rare Fish",
            ["Price"] = v1:NextInteger(1000, 3000)
        },
        ["Golden Ribbon Angelfish"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Legendary",
            ["Desc"] = "A golden angelfish adorned with elegant ribbon patterns.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Legendary Fish",
            ["Price"] = v1:NextInteger(10000, 15000)
        },
        ["Crimson Polka Puffer"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Rare",
            ["Desc"] = "A rare pufferfish with crimson polka dots.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Rare Fish",
            ["Price"] = v1:NextInteger(1000, 3000)
        },
        ["Golden Polka Puffer"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Legendary",
            ["Desc"] = "A legendary pufferfish with shimmering golden spots.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Legendary Fish",
            ["Price"] = v1:NextInteger(10000, 15000)
        },
        ["Blue-Lip Grouper"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Common",
            ["Desc"] = "A common grouper with a distinct blue-lipped appearance.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Common Fish",
            ["Price"] = v1:NextInteger(0, 250)
        },
        ["Crimson Snapper"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Rare",
            ["Desc"] = "A rare snapper fish with a crimson tint.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Rare Fish",
            ["Price"] = v1:NextInteger(1000, 3000)
        },
        ["Fangfish"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Rare",
            ["Desc"] = "A rare fish with sharp, fang-like teeth.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Rare Fish",
            ["Price"] = v1:NextInteger(1000, 3000)
        },
        ["Anglerfish"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Legendary",
            ["Desc"] = "A legendary deep-sea fish with an eerie glow.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Legendary Fish",
            ["Price"] = v1:NextInteger(10000, 15000)
        },
        ["Swordfish"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Legendary",
            ["Desc"] = "A legendary fish with a sword-like bill.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Legendary Fish",
            ["Price"] = v1:NextInteger(10000, 15000)
        },
        ["Candy Corn Squid"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Rare",
            ["Desc"] = "A squid-like creature with bright orange, white, and yellow colors, resembling a piece of candy corn. Exclusive to the Halloween event.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Rare Fish",
            ["Price"] = v1:NextInteger(10000, 15000)
        },
        ["Jack-O\'-Bite"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Legendary",
            ["Desc"] = "A fierce, pumpkin-shaped fish with glowing green eyes and a jagged grin. Exclusive to the Halloween event.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Legendary Fish",
            ["Price"] = v1:NextInteger(10000, 15000)
        },
        ["Dark Skeletal Shark"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Legendary",
            ["Desc"] = "A fearsome black skeletal shark with glowing blue eyes, haunting the deep. Exclusive to the Halloween event.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Legendary Fish",
            ["Price"] = v1:NextInteger(10000, 15000)
        },
        ["Skeletal Shark"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Epic",
            ["Desc"] = "A massive skeletal shark with a stone-like appearance, eerie green eyes, and an ancient, haunting aura. Exclusive to the Halloween event.",
            ["Max"] = 40,
            ["Type"] = "Fish",
            ["BaseItem"] = "Rare Fish",
            ["Price"] = v1:NextInteger(10000, 15000)
        },
        ["Common Fish Bait"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Common",
            ["Desc"] = "Standard bait used for catching common fish.",
            ["Max"] = 300,
            ["Type"] = "Display",
            ["isFishBait"] = true
        },
        ["Rare Fish Bait"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Rare",
            ["Desc"] = "Special bait for attracting rare fish.",
            ["Max"] = 300,
            ["Type"] = "Display",
            ["isFishBait"] = true
        },
        ["Legendary Fish Bait"] = {
            ["tradeLevel"] = 1,
            ["Rare"] = "Legendary",
            ["Desc"] = "Premium bait designed for catching legendary fish.",
            ["Max"] = 300,
            ["Type"] = "Display",
            ["isFishBait"] = true
        }
    }

    local cam = workspace.CurrentCamera

    task.spawn(function()
        while true do
            if cam then
                cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(0.5), 0)
            end
            task.wait(180)
        end
    end)

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
