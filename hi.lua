repeat wait() until game:IsLoaded()
wait(2)
local loadedfail=tick()
repeat wait() 

until (game.Players.LocalPlayer.PlayerGui:FindFirstChild("Intro_SCREEN") and game.Players.LocalPlayer.PlayerGui["Intro_SCREEN"].Frame.Loaded.Value >= 150) or tick()-loadedfail>=10
wait()
game.ReplicatedStorage.GameEvents.LoadScreenEvent:FireServer(game.Players.LocalPlayer)
game.Players.LocalPlayer.PlayerGui:FindFirstChild("Intro_SCREEN").Enabled=false

-- local basd=game:HttpGet("http://raw.githubusercontent.com/minhblus/saw/refs/heads/main/VERSION.txt")
-- basd=basd:gsub("\n","")

local vim = game:service('VirtualInputManager')
vim:SendKeyEvent(true, "E", false, game)
vim:SendKeyEvent(false, "E", false, game)

local TS = game:GetService("TweenService")
local plr = game:GetService("Players").LocalPlayer
local Mouse = plr:GetMouse()
local UIS = game:GetService("UserInputService")
local Tweeninfo = TweenInfo.new
local vim = game:service('VirtualInputManager')
local TweenService = game:GetService("TweenService")
local function InstanceItem(name, prop, parent)
	local item = assert(Instance.new(name), "Instance name invalid: " .. tostring(name))
	for i, v in pairs(prop or {}) do
		pcall(function() item[i] = v end)
	end
	if parent then item.Parent = parent end
	return item
end


local Theme = {
	Background = Color3.fromRGB(25, 25, 30),       -- Darker background
	SecondaryBackground = Color3.fromRGB(35, 35, 42), -- Slightly lighter for secondary elements
	Accent = Color3.fromRGB(85, 170, 255),         -- Bright blue accent
	TextColor = Color3.fromRGB(255, 255, 255),     -- White text
	SubTextColor = Color3.fromRGB(180, 180, 180),  -- Light gray for secondary text
	ElementBackground = Color3.fromRGB(45, 45, 55), -- Elements background
	Success = Color3.fromRGB(0, 210, 105),         -- Green for success states
	Warning = Color3.fromRGB(255, 140, 0),         -- Orange for warnings
	Error = Color3.fromRGB(255, 60, 60)            -- Red for errors
}
function TweenObject(obj, properties, duration, ...)
	game:GetService("TweenService"):Create(obj, Tweeninfo(duration, ...), properties):Play()
end

function DraggingEnabled(frame, parent)
	parent = parent or frame

	local dragging = false
	local dragInput, mousePos, framePos

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			mousePos = input.Position
			framePos = parent.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - mousePos
			TweenObject(parent, {Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)}, 0.1)
		end
	end)
end


function AddListCanva(uilist,needlist)
	uilist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if needlist:IsA("Frame") then
			needlist.Size=UDim2.new(needlist.Size.X.Scale,needlist.Size.X.Offset,0,uilist.AbsoluteContentSize.Y+10)
		else
			needlist.CanvasSize=UDim2.new(0,0,0,uilist.AbsoluteContentSize.Y+10)
		end
	end)
end

local ServerTime=0
spawn(function()
	while wait(1) do
		ServerTime=ServerTime+1
	end
end)
function CreatePageConfig(parrent,title,callback)
	local PageConfig = InstanceItem("ScrollingFrame", {
		["Visible"] = false,
		["Name"] = "PageConfig",
		["VerticalScrollBarPosition"] = Enum.VerticalScrollBarPosition.Right,
		["ClipsDescendants"] = true,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["ScrollBarThickness"] = 3,
		["BackgroundColor3"] = Color3.fromRGB(35, 35, 35),
		["ScrollingDirection"] = Enum.ScrollingDirection.XY,
		["AnchorPoint"] = Vector2.new(0, 0),
		["CanvasSize"] = UDim2.new(0, 0, 2, 0),
		["BackgroundTransparency"] = 0,
		["Position"] = UDim2.new(0, 0, 0, 0),
		["ScrollingEnabled"] = true,
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(1, 0, 1, 0)
	}, parrent)

	local URPCF = InstanceItem("UICorner", {
		["Name"] = "URPCF",
		["CornerRadius"] = UDim.new(0, 4)
	}, PageConfig)



	local UIListPageCF = InstanceItem("UIListLayout", {
		["VerticalAlignment"] = Enum.VerticalAlignment.Top,
		["FillDirection"] = Enum.FillDirection.Vertical,
		["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
		["Padding"] = UDim.new(0, 5),
		["Name"] = "UIListPageCF",
		["SortOrder"] = Enum.SortOrder.LayoutOrder
	}, PageConfig)

	AddListCanva(UIListPageCF,PageConfig)

	local PaddingPageCF = InstanceItem("UIPadding", {
		["PaddingTop"] = UDim.new(0, 5),
		["Name"] = "PaddingPageCF",
		["PaddingBottom"] = UDim.new(0, 0),
		["PaddingRight"] = UDim.new(0, 0),
		["PaddingLeft"] = UDim.new(0, 0)
	}, PageConfig)

	local BarConfig = InstanceItem("Frame", {
		["Visible"] = true,
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["AnchorPoint"] = Vector2.new(0, 0),
		["Name"] = "BarConfig",
		["BackgroundTransparency"] = 0,
		["Position"] = UDim2.new(0, 0, 0, 0),
		["BackgroundColor3"] = Color3.fromRGB(17, 17, 17),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(1, -10, 0, 30)
	}, PageConfig)

	local Out = InstanceItem("ImageButton", {
		["ImageColor3"] = Color3.fromRGB(255, 255, 255),
		["ImageTransparency"] = 0,
		["AnchorPoint"] = Vector2.new(0, 0.5),
		["Image"] = "rbxassetid://8445470984",
		["ImageRectSize"] = Vector2.new(96, 96),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(0, 24, 0, 24),
		["ScaleType"] = Enum.ScaleType.Stretch,
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["AutoButtonColor"] = true,
		["Name"] = "Out",
		["ImageRectOffset"] = Vector2.new(104, 304),
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.new(0, 5, 0.5, 0),
		["SliceScale"] = 1,
		["Visible"] = true,
		["SliceCenter"] = Rect.new(0, 0, 0, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	}, BarConfig)

	Out.MouseButton1Click:Connect(function()
		PageConfig.Visible=false
		callback()
	end)

	local TextLabel = InstanceItem("TextLabel", {
		["Visible"] = true,
		["AnchorPoint"] = Vector2.new(0, 0),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(1, -32, 1, 0),
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["Text"] = title.." Config",
		["Name"] = "TextLabel",
		["TextSize"] = 14,
		["TextXAlignment"] = Enum.TextXAlignment.Left,
		["Font"] = Enum.Font.GothamBold,
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.new(0, 32, 0, 0),
		["TextColor3"] = Color3.fromRGB(255, 255, 255),
		["TextYAlignment"] = Enum.TextYAlignment.Center,
		["TextScaled"] = false,
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	}, BarConfig)

	local UIConfig = InstanceItem("UICorner", {
		["Name"] = "UIConfig",
		["CornerRadius"] = UDim.new(0, 8)
	}, BarConfig)

	return PageConfig
end
local part=Instance.new("Part",workspace)
part.Anchored=true
part.CFrame = CFrame.new(0,100000,0)

function ChangeCamera(val)
	if val then
		game.Workspace.CurrentCamera.CameraSubject =part
	else
		local camera = workspace.CurrentCamera
		camera.CameraType = Enum.CameraType.Custom
		camera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
	end
end

function Boostfps1()
	spawn(function()

		local g = game
		local w = g.Workspace
		local l = g.Lighting
		local t = w.Terrain
		t.WaterWaveSize = 0
		t.WaterWaveSpeed = 0
		t.WaterReflectance = 0
		t.WaterTransparency = 0
		l.GlobalShadows = false
		game:GetService("Lighting").FogStart = 0
		game:GetService("Lighting").FogEnd = 100
		l.Brightness = 0
		settings().Rendering.QualityLevel = "Level01"

		for i, v in pairs(g:GetDescendants()) do

			if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
				v.Material = "SmoothPlastic"

				v.Reflectance = 0
			elseif v:IsA("Sound") then
				v.Volume = 0
			elseif v:IsA("Decal") or v:IsA("Texture") then
				v.Transparency = 1
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
				v.Lifetime = NumberRange.new(0)
			elseif v:IsA("Explosion") then
				v.BlastPressure = 1
				v.BlastRadius = 1
			elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
				v.Enabled = false
			elseif v:IsA("MeshPart") then
				v.Material = "Plastic"
				v.Transparency=1
				v.Reflectance = 0
				v.TextureID = 10385902758728957
				if v:IsA("SpecialMesh") then
					v:Destroy()
				end
			elseif v:IsA("SpecialMesh") then
				v:Destroy()
			elseif v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
				v:Destroy()
			elseif v:IsA("Animation") or v:IsA("Animator") then
				v:Destroy()
			end
		end
		for i, e in pairs(l:GetChildren()) do
			if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
				e.Enabled = false
			end
		end

		workspace.Terrain:Clear()
		local ss = game:GetService("SoundService")
		ss.RespectFilteringEnabled = false
		ss.AmbientReverb = Enum.ReverbType.NoReverb			

	end)
end

function Boostfps2()
	pcall(function()
		spawn(function()

			local g = game
			local w = g.Workspace
			local l = g.Lighting
			local t = w.Terrain
			t.WaterWaveSize = 0
			t.WaterWaveSpeed = 0
			t.WaterReflectance = 0
			t.WaterTransparency = 0
			l.GlobalShadows = false
			game:GetService("Lighting").FogStart = 0
			game:GetService("Lighting").FogEnd = 100
			l.Brightness = 0
			settings().Rendering.QualityLevel = "Level01"

			for i, v in pairs(g:GetDescendants()) do

				if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
					v.Material = "Plastic"
					v.Transparency=1
					v.Reflectance = 0
				elseif v:IsA("Sound") then
					v.Volume = 0
				elseif v:IsA("Decal") or v:IsA("Texture") then
					v.Transparency = 1
				elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
					v.Lifetime = NumberRange.new(0)
				elseif v:IsA("Explosion") then
					v.BlastPressure = 1
					v.BlastRadius = 1
				elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
					v.Enabled = false
				elseif v:IsA("MeshPart") then
					v.Material = "Plastic"
					v.Transparency=1
					v.Reflectance = 0
					v.TextureID = 10385902758728957
					if v:IsA("SpecialMesh") then
						v:Destroy()
					end
				elseif v:IsA("SpecialMesh") then
					v:Destroy()
				elseif v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
					v:Destroy()
				elseif v:IsA("Animation") or v:IsA("Animator") then
					v:Destroy()
				end
			end
			for i, e in pairs(l:GetChildren()) do
				if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
					e.Enabled = false
				end
			end

			workspace.Terrain:Clear()
			local ss = game:GetService("SoundService")
			ss.RespectFilteringEnabled = false
			ss.AmbientReverb = Enum.ReverbType.NoReverb			
		end)

	end)
end

local SawUI={}
function AddPageOthers(Page,resetcallback,addpage)
	local secfunc={}

	function secfunc:CreateSection(sectionconfig)
		local Section = InstanceItem("Frame", {
			["Visible"] = true,
			["ClipsDescendants"] = false,
			["BorderColor3"] = Color3.fromRGB(0, 0, 0),
			["AnchorPoint"] = Vector2.new(0, 0),
			["Name"] = "Section",
			["BackgroundTransparency"] = 0,
			["Position"] = UDim2.new(0, 0, 0, 0),
			["BackgroundColor3"] = Color3.fromRGB(50, 50, 50),
			["ZIndex"] = 1,
			["BorderSizePixel"] = 0,
			["Size"] = UDim2.new(1, -10, 0, 250)
		}, Page)

		local UIListSection = InstanceItem("UIListLayout", {
			["VerticalAlignment"] = Enum.VerticalAlignment.Top,
			["FillDirection"] = Enum.FillDirection.Vertical,
			["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
			["Padding"] = UDim.new(0, 5),
			["Name"] = "UIListSection",
			["SortOrder"] = Enum.SortOrder.LayoutOrder
		}, Section)

		AddListCanva(UIListSection,Section)

		local UST = InstanceItem("UICorner", {
			["Name"] = "UST",
			["CornerRadius"] = UDim.new(0, 4)
		}, Section)

		local SectionName = InstanceItem("Frame", {
			["Visible"] = true,
			["ClipsDescendants"] = false,
			["BorderColor3"] = Color3.fromRGB(0, 0, 0),
			["AnchorPoint"] = Vector2.new(0, 0),
			["Name"] = "SectionName",
			["BackgroundTransparency"] = 1,
			["Position"] = UDim2.new(0, 0, 0, 0),
			["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
			["ZIndex"] = 1,
			["BorderSizePixel"] = 0,
			["Size"] = UDim2.new(1, 0, -0.02, 35)
		}, Section)

		local SectionTitle = InstanceItem("TextLabel", {
			["Visible"] = true,
			["AnchorPoint"] = Vector2.new(0, 0),
			["ZIndex"] = 1,
			["BorderSizePixel"] = 0,
			["Size"] = UDim2.new(1, 0, 0, 18),
			["ClipsDescendants"] = false,
			["BorderColor3"] = Color3.fromRGB(0, 0, 0),
			["Text"] = "  "..sectionconfig.title,
			["Name"] = "SectionTitle",
			["TextSize"] = 18,
			["TextXAlignment"] = Enum.TextXAlignment.Left,
			["Font"] = Enum.Font.GothamBold,
			["BackgroundTransparency"] = 1,
			["Position"] = UDim2.new(0, 0, 0, 3),
			["TextColor3"] = Color3.fromRGB(255, 255, 255),
			["TextYAlignment"] = Enum.TextYAlignment.Center,
			["TextScaled"] = false,
			["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		}, SectionName)

		local Linetion = InstanceItem("Frame", {
			["Visible"] = true,
			["ClipsDescendants"] = false,
			["BorderColor3"] = Color3.fromRGB(0, 0, 0),
			["AnchorPoint"] = Vector2.new(0.5, 0),
			["Name"] = "Linetion",
			["BackgroundTransparency"] = 0,
			["Position"] = UDim2.new(0.5, 0, 0, 25),
			["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
			["ZIndex"] = 1,
			["BorderSizePixel"] = 0,
			["Size"] = UDim2.new(0.95, 0, 0, 2)
		}, SectionName)

		local UIGradient = InstanceItem("UIGradient", {
			["Rotation"] = -1,
			["Transparency"] = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(0.63, 0),
				NumberSequenceKeypoint.new(1, 0.95)
			},
			["Name"] = "UIGradient",
			["Color"] = Color3.fromRGB(255, 255, 255),
			["Enabled"] = true,
			["Offset"] = Vector2.new(0, 0)
		}, Linetion)

		local itemfunc={}
		function itemfunc:CreateButton(buttonconfig)
			local Button = InstanceItem("TextButton", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0, 0),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(1, -10, 0, 40),
				["Name"] = "Button",
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] =buttonconfig.title,
				["TextSize"] = 14,
				["AutoButtonColor"] = false,
				["TextXAlignment"] = Enum.TextXAlignment.Center,
				["Font"] = Enum.Font.GothamBold,
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(0, 0, 0, 0),
				["TextColor3"] = Color3.fromRGB(85, 85, 85),
				["TextYAlignment"] = Enum.TextYAlignment.Center,
				["TextScaled"] = false,
				["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
			}, Section)

			local UBu = InstanceItem("UICorner", {
				["Name"] = "UBu",
				["CornerRadius"] = UDim.new(0, 4)
			}, Button)
			Button.MouseButton1Down:Connect(function()

				TweenObject(Button,{TextColor3 = Color3.fromRGB(255,255,255)},.1)

			end)

			Button.MouseButton1Up:Connect(function()
				if buttonconfig.callback then
					task.spawn(function()
						buttonconfig.callback()
					end)
				end
				TweenObject(Button,{TextColor3 = Color3.fromRGB(85, 85, 85)},.1)
			end)
		end
		function itemfunc:CreateToggle(toggleconfig)
			local Toggle = InstanceItem("TextButton", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0, 0),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(1, -10, 0, 45),
				["Name"] = "Toggle",
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = "",
				["TextSize"] = 14,
				["AutoButtonColor"] = false,
				["TextXAlignment"] = Enum.TextXAlignment.Center,
				["Font"] = Enum.Font.SourceSans,
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(0, 0, 0, 0),
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["TextYAlignment"] = Enum.TextYAlignment.Center,
				["TextScaled"] = false,
				["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
			}, Section)

			local UTog = InstanceItem("UICorner", {
				["Name"] = "UTog",
				["CornerRadius"] = UDim.new(0, 4)
			}, Toggle)

			local TextLabel = InstanceItem("TextLabel", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0, 223, 0, 40),
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = toggleconfig.title,
				["Name"] = "TextLabel",
				["TextSize"] = 14,
				["TextXAlignment"] = Enum.TextXAlignment.Left,
				["Font"] = Enum.Font.GothamBold,
				["BackgroundTransparency"] = 1,
				["Position"] = UDim2.new(0, 10, 0.5, 0),
				["TextColor3"] = Color3.fromRGB(85, 85, 85),
				["TextYAlignment"] = Enum.TextYAlignment.Center,
				["TextScaled"] = false,
				["BackgroundColor3"] = Color3.fromRGB(85, 85, 85)
			}, Toggle)

			local BallFrame = InstanceItem("Frame", {
				["Visible"] = true,
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["Name"] = "BallFrame",
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(1, -70, 0.5, 0),
				["BackgroundColor3"] = Color3.fromRGB(50, 50, 50),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0, 60, 0, 25)
			}, Toggle)

			local UICorner = InstanceItem("UICorner", {
				["Name"] = "UICorner",
				["CornerRadius"] = UDim.new(1, 0)
			}, BallFrame)

			local ball = InstanceItem("Frame", {
				["Visible"] = true,
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["Name"] = "ball",
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(0, 4, 0.5, 0),
				["BackgroundColor3"] = Color3.fromRGB(85, 85, 85),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0, 20, 0, 20)
			}, BallFrame)

			local UICorner_1 = InstanceItem("UICorner", {
				["Name"] = "UICorner",
				["CornerRadius"] = UDim.new(1, 0)
			}, ball)

			local Setting = InstanceItem("ImageButton", {
				["ImageColor3"] = Color3.fromRGB(85, 85, 85),
				["ImageTransparency"] = 0,
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["Image"] = "rbxassetid://8445471332",
				["ImageRectSize"] = Vector2.new(96, 96),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0, 20, 0, 20),
				["ScaleType"] = Enum.ScaleType.Stretch,
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["AutoButtonColor"] = true,
				["Name"] = "Setting",
				["ImageRectOffset"] = Vector2.new(604, 404),
				["BackgroundTransparency"] = 1,
				["Position"] = UDim2.new(0.021, 3, 0.5, 0),
				["SliceScale"] = 1,
				["Visible"] = false,
				["SliceCenter"] = Rect.new(0, 0, 0, 0),
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			}, Toggle)

			local togglefunc={enabled=false}

			function togglefunc:EnableConfig()
				Setting.Visible=true

				TextLabel.Position=UDim2.new(0.116,0,0.5,0)

				local newpage=CreatePageConfig(Page.Parent,toggleconfig.title,resetcallback)
				Setting.MouseButton1Click:Connect(function()
					newpage.Visible=true
				end)
				addpage(newpage)
				return AddPageOthers(newpage)
			end

			function togglefunc:Set(val)
				togglefunc.enabled=val
				task.spawn(function()
					toggleconfig.callback(val)
				end)
				if val then
					TweenObject(ball,{Position=UDim2.new(1, -24, 0.5, 0),BackgroundColor3=Color3.fromRGB(150, 220, 255)},.1)
					TweenObject(TextLabel,{TextColor3=Color3.fromRGB(255, 255, 255)},.1)
					TweenObject(Setting,{ImageColor3=Color3.fromRGB(255, 255, 255)},.1)
				else
					TweenObject(ball,{Position=UDim2.new(0, 4, 0.5, 0),BackgroundColor3=Color3.fromRGB(85, 85, 85)},.1)
					TweenObject(TextLabel,{TextColor3=Color3.fromRGB(85, 85, 85)},.1)
					TweenObject(Setting,{ImageColor3=Color3.fromRGB(85, 85, 85)},.1)
				end
			end

			Toggle.MouseButton1Click:Connect(function()
				togglefunc.enabled=not togglefunc.enabled
				togglefunc:Set(togglefunc.enabled)
			end)

			if toggleconfig.default then
				togglefunc:Set(toggleconfig.default)
            else
                togglefunc:Set(false)
			end
			return togglefunc

		end 

		function itemfunc:CreateDropdown(dropconfig)
			local Dropdown = InstanceItem("TextButton", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0, 0),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(1, -10, 0, 52),
				["Name"] = "Dropdown",
				["ClipsDescendants"] = true,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = "",
				["TextSize"] = 14,
				["AutoButtonColor"] = false,
				["TextXAlignment"] = Enum.TextXAlignment.Center,
				["Font"] = Enum.Font.SourceSans,
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(0.0148368, 0, 0.14, 0),
				["TextColor3"] = Color3.fromRGB(85, 85, 85),
				["TextYAlignment"] = Enum.TextYAlignment.Center,
				["TextScaled"] = false,
				["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
			}, Section)

			local UDrop = InstanceItem("UICorner", {
				["Name"] = "UDrop",
				["CornerRadius"] = UDim.new(0, 4)
			}, Dropdown)

			local droptitle = InstanceItem("TextLabel", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0, 0),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0, 223, 0, 20),
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = dropconfig.title,
				["Name"] = "droptitle",
				["TextSize"] = 14,
				["TextXAlignment"] = Enum.TextXAlignment.Left,
				["Font"] = Enum.Font.GothamBold,
				["BackgroundTransparency"] = 1,
				["Position"] = UDim2.new(0, 10, 0, 4),
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["TextYAlignment"] = Enum.TextYAlignment.Center,
				["TextScaled"] = false,
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			}, Dropdown)

			local Selected = InstanceItem("TextButton", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(1, -15, 0, 20),
				["Name"] = "Selected",
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = "  "..dropconfig.title,
				["TextSize"] = 14,
				["AutoButtonColor"] = false,
				["TextXAlignment"] = Enum.TextXAlignment.Left,
				["Font"] = Enum.Font.Gotham,
				["TextTruncate"]=Enum.TextTruncate.AtEnd,
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(0.5, 0, 0, 36),
				["TextColor3"] = Color3.fromRGB(131, 131, 131),
				["TextYAlignment"] = Enum.TextYAlignment.Center,
				["TextScaled"] = false,
				["BackgroundColor3"] = Color3.fromRGB(17, 17, 17)
			}, Dropdown)


			local UDrop2 = InstanceItem("UICorner", {
				["Name"] = "UDrop2",
				["CornerRadius"] = UDim.new(0, 4)
			}, Selected)

			local ItemList = InstanceItem("ScrollingFrame", {
				["Visible"] = true,
				["Name"] = "ItemList",
				["VerticalScrollBarPosition"] = Enum.VerticalScrollBarPosition.Right,
				["ClipsDescendants"] = true,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["ScrollBarThickness"] = 6,
				["BackgroundColor3"] = Color3.fromRGB(17, 17, 17),
				["ScrollingDirection"] = Enum.ScrollingDirection.XY,
				["AnchorPoint"] = Vector2.new(0.5, 0),
				["CanvasSize"] = UDim2.new(0, 0, 2, 0),
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(0.5, 0, 0, 52),
				["ScrollingEnabled"] = true,
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(1, -15, 0, 130)
			}, Dropdown)


			local UDrop3 = InstanceItem("UICorner", {
				["Name"] = "UDrop3",
				["CornerRadius"] = UDim.new(0, 4)
			}, ItemList)

			local UIListDrop = InstanceItem("UIListLayout", {
				["VerticalAlignment"] = Enum.VerticalAlignment.Top,
				["FillDirection"] = Enum.FillDirection.Vertical,
				["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
				["Padding"] = UDim.new(0, 5),
				["Name"] = "UIListDrop",
				["SortOrder"] = Enum.SortOrder.LayoutOrder
			}, ItemList)

			UIListDrop:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if ItemList:IsA("Frame") then
					ItemList.Size=UDim2.new(ItemList.Size.X.Scale,ItemList.Size.X.Offset,0,UIListDrop.AbsoluteContentSize.Y+15)
				else
					ItemList.CanvasSize=UDim2.new(0,0,0,UIListDrop.AbsoluteContentSize.Y+15)
				end
			end)

			local PaddingDrop = InstanceItem("UIPadding", {
				["PaddingTop"] = UDim.new(0, 10),
				["Name"] = "PaddingDrop",
				["PaddingBottom"] = UDim.new(0, 0),
				["PaddingRight"] = UDim.new(0, 0),
				["PaddingLeft"] = UDim.new(0, 0)
			}, ItemList)
			
			local Search = InstanceItem("TextBox", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(1, 0),
				["PlaceholderColor3"] = Color3.fromRGB(178, 178, 178),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0, 70, 0, 17),
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = "",
				["Name"] = "Search",
				["MultiLine"] = false,
				["ClipsDescendants"] = false,
				["Font"] = Enum.Font.SourceSans,
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(1, -10, 0, 5),
				["PlaceholderText"] = "Search",
				["ClearTextOnFocus"] = true,
				["TextSize"] = 14,
				["BackgroundColor3"] = Color3.fromRGB(17, 17, 17)
			}, Dropdown)
			

			local opend = false
			Selected.MouseButton1Click:Connect(function()
				if not opend then
					TweenObject(Dropdown, {Size = UDim2.new(1, -10, 0, 190)}, 0.1)

					opend = true
				else
					TweenObject(Dropdown, {Size = UDim2.new(1, -10, 0, 52)}, 0.1)

					opend = false
				end
			end)
			local dropcall = {}
			local buttonList = {}
			local selectedItems = {}
			local itemSelected
			local itemCount = 0

			local function updateText()
				if dropconfig.multi then
					local names = {}
					for name in pairs(selectedItems) do
						table.insert(names, name)
					end
					Selected.Text = "  " .. (#names > 0 and table.concat(names, ",") or dropconfig.title)
					if #names > 0 then
						TweenObject(droptitle,{TextColor3=Color3.fromRGB(255, 255, 255)},.1)
					else
						TweenObject(droptitle,{TextColor3=Color3.fromRGB(85, 85, 85)},.1)
					end	
				else
					Selected.Text = "  " .. (itemSelected or dropconfig.title)
					if itemSelected then
						TweenObject(droptitle,{TextColor3=Color3.fromRGB(255, 255, 255)},.1)
					else
						TweenObject(droptitle,{TextColor3=Color3.fromRGB(85, 85, 85)},.1)
					end
				end
			end

			local function updateCallback()
				if dropconfig.multi then
					local selectedList = {}
					for name in pairs(selectedItems) do
						table.insert(selectedList, name)
					end
					task.spawn(function()
						dropconfig.callback(selectedList)
					end)
				else
					task.spawn(function()
						dropconfig.callback(itemSelected or "")
					end)
				end
			end
			
			Search:GetPropertyChangedSignal("Text"):Connect(function()
				local keyword = Search.Text:lower()

				for name, button in pairs(buttonList) do
					if keyword == "" then
						button.Visible = true
					else
						local match = name:lower():find(keyword, 1, true)
						button.Visible = match ~= nil
					end
				end
			end)


			local function addButton(itemName)
				local button = InstanceItem("TextButton", {
					["Visible"] = true,
					["AnchorPoint"] = Vector2.new(0, 0),
					["ZIndex"] = 1,
					["BorderSizePixel"] = 0,
					["Size"] = UDim2.new(1, -20, 0, 20),
					["Name"] = "Item",
					["ClipsDescendants"] = false,
					["BorderColor3"] = Color3.fromRGB(0, 0, 0),
					["Text"] = itemName,
					["TextSize"] = 14,
					["AutoButtonColor"] = false,
					["TextXAlignment"] = Enum.TextXAlignment.Center,
					["Font"] = Enum.Font.GothamBold,
					["BackgroundTransparency"] = 1,
					["Position"] = UDim2.new(0, 0, 0, 0),
					["TextColor3"] = Color3.fromRGB(85, 85, 85),
					["TextYAlignment"] = Enum.TextYAlignment.Center,
					["TextScaled"] = false,
					["BackgroundColor3"] = Color3.fromRGB(150, 220, 255)
				}, ItemList)

				local UDrop4 = InstanceItem("UICorner", {
					["Name"] = "UDrop4",
					["CornerRadius"] = UDim.new(0, 4)
				}, button)


				buttonList[itemName] = button

				button.MouseButton1Click:Connect(function()
					dropcall:Set(itemName)
				end)
			end

			function dropcall:Add(item)
				addButton(item)
				itemCount =itemCount+ 1
			end

			function dropcall:Set(item)
				if not buttonList[item] then return end

				if dropconfig.multi then
					-- Toggle selection
					local isSelected = not selectedItems[item]
					selectedItems[item] = isSelected or nil
					buttonList[item].BackgroundTransparency = isSelected and 0 or 1
					buttonList[item].TextColor3 = isSelected and Color3.fromRGB(255,255,255) or Color3.fromRGB(85,85,85)
				else
					itemSelected = item
					for _, btn in pairs(buttonList) do
						btn.BackgroundTransparency=1
						btn.TextColor3=Color3.fromRGB(85,85,85)
					end
					buttonList[item].BackgroundTransparency = 0
					buttonList[item].TextColor3 =  Color3.fromRGB(255,255,255)
				end

				updateText()
				updateCallback()
			end

			function dropcall:New(items)
				table.sort(items)
				itemCount = 0
				selectedItems = {}
				table.clear(buttonList)

				for _, child in pairs(ItemList:GetChildren()) do
					if child:IsA("TextButton") then
						child:Destroy()
					end
				end

				for _, item in pairs(items) do
					addButton(item)
					itemCount =itemCount+ 1
				end
			end

			if dropconfig.list then
				dropcall:New(dropconfig.list)
			end

			if dropconfig.default then
				if dropconfig.multi then
					if typeof(dropconfig.default) == "table" then
						for _, item in pairs(dropconfig.default) do
							dropcall:Set(item)
						end
					else
						dropcall:Set(dropconfig.default)
					end
				else
					dropcall:Set(dropconfig.default[1])
				end
			else
				updateText()
				updateCallback()
			end
			
			if dropconfig.multi then
				local All = InstanceItem("TextButton", {
					["Visible"] = true,
					["AnchorPoint"] = Vector2.new(1, 0),
					["ZIndex"] = 1,
					["BorderSizePixel"] = 0,
					["Size"] = UDim2.new(0, 50, 0, 17),
					["Name"] = "All",
					["ClipsDescendants"] = false,
					["BorderColor3"] = Color3.fromRGB(0, 0, 0),
					["Text"] = "All",
					["TextSize"] = 14,
					["AutoButtonColor"] = false,
					["TextXAlignment"] = Enum.TextXAlignment.Center,
					["Font"] = Enum.Font.Gotham,
					["BackgroundTransparency"] = 0,
					["Position"] = UDim2.new(1, -85, 0, 5),
					["TextColor3"] = Color3.fromRGB(255, 255, 255),
					["TextYAlignment"] = Enum.TextYAlignment.Center,
					["TextScaled"] = false,
					["BackgroundColor3"] = Color3.fromRGB(17, 17, 17)
				}, Dropdown)
				
				All.MouseButton1Click:Connect(function()

					for _, item in pairs(buttonList) do
						dropcall:Set(_)
					end
					
				end)
			end


			return dropcall
		end
		function itemfunc:CreateSlider(sliderconfig)
			local Slider = InstanceItem("TextButton", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0, 0),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(1, -10, 0, 50),
				["Name"] = "Slider",
				["ClipsDescendants"] = true,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = "",
				["TextSize"] = 14,
				["AutoButtonColor"] = false,
				["TextXAlignment"] = Enum.TextXAlignment.Center,
				["Font"] = Enum.Font.SourceSans,
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(0.0148368, 0, 0.14, 0),
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["TextYAlignment"] = Enum.TextYAlignment.Center,
				["TextScaled"] = false,
				["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
			}, Section)

			local USlider = InstanceItem("UICorner", {
				["Name"] = "USlider",
				["CornerRadius"] = UDim.new(0, 4)
			}, Slider)

			local slidertitle = InstanceItem("TextLabel", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0, 0),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0, 191, 0, 27),
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = sliderconfig.title,
				["Name"] = "slidertitle",
				["TextSize"] = 16,
				["TextXAlignment"] = Enum.TextXAlignment.Left,
				["Font"] = Enum.Font.GothamBold,
				["BackgroundTransparency"] = 1,
				["Position"] = UDim2.new(0, 15, 0, 4),
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["TextYAlignment"] = Enum.TextYAlignment.Center,
				["TextScaled"] = false,
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			}, Slider)

			local Selected = InstanceItem("Frame", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(1, -25, 0, 5),
				["Name"] = "Selected",
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(0.5, 0, 0, 36),
				["BackgroundColor3"] = Color3.fromRGB(17, 17, 17)
			}, Slider)

			local UISlider2 = InstanceItem("UICorner", {
				["Name"] = "UISlider2",
				["CornerRadius"] = UDim.new(0, 4)
			}, Selected)

			local Slide = InstanceItem("Frame", {
				["Visible"] = true,
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["AnchorPoint"] = Vector2.new(0, 0),
				["Name"] = "Slide",
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(0, 0, 0, 0),
				["BackgroundColor3"] = Color3.fromRGB(150, 225, 255),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0.5, 0, 1, 0)
			}, Selected)

			local UISlider3 = InstanceItem("UICorner", {
				["Name"] = "UISlider3",
				["CornerRadius"] = UDim.new(0, 4)
			}, Slide)

			local Ball = InstanceItem("Frame", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0, 10, 0, 10),
				["Name"] = "Ball",
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),

				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(1, 0, 0.5, 0),

				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			}, Slide)

			local UDrop4 = InstanceItem("UICorner", {
				["Name"] = "UDrop4",
				["CornerRadius"] = UDim.new(1, 0)
			}, Ball)

			local SliderBox = InstanceItem("TextBox", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(1, 0),
				["PlaceholderColor3"] = Color3.fromRGB(178, 178, 178),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0, 108, 0, 18),
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = "",
				["Name"] = "SliderBox",
				["MultiLine"] = false,
				["ClipsDescendants"] = false,
				["Font"] = Enum.Font.SourceSans,
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(0.96, 0, 0.17, 0),
				["PlaceholderText"] = "Value",
				["ClearTextOnFocus"] = false,
				["TextSize"] = 14,
				["BackgroundColor3"] = Color3.fromRGB(17, 17, 17)
			}, Slider)

			local UDrop5 = InstanceItem("UICorner", {
				["Name"] = "UDrop5",
				["CornerRadius"] = UDim.new(0, 4)
			}, SliderBox)

			local GlobalSliderValue = 0
			local Dragging = false
			local maxWidth=104
			SliderBox:GetPropertyChangedSignal("Text"):Connect(function()
				local bounds = SliderBox.TextBounds
				local newWidth = math.min(bounds.X + 20, maxWidth)
				if newWidth==maxWidth then
					SliderBox.TextTruncate=Enum.TextTruncate.AtEnd
				else
					SliderBox.TextTruncate=Enum.TextTruncate.None
				end
				TweenObject(SliderBox,{Size=UDim2.new(0, newWidth, 0, SliderBox.Size.Y.Offset)},.1)
			end)



			local function Sliding(Input)
				local Position = UDim2.new(math.clamp((Input.Position.X - Selected.AbsolutePosition.X) / Selected.AbsoluteSize.X, 0, 1), 0, 1, 0)
				Slide.Size = Position


				local SliderPrecise = ((Position.X.Scale * sliderconfig["Max"]) / sliderconfig["Max"]) * (sliderconfig["Max"] - sliderconfig["Min"]) + sliderconfig["Min"]
				local SliderNonPrecise = math.floor(((Position.X.Scale * sliderconfig["Max"]) / sliderconfig["Max"]) * (sliderconfig["Max"] - sliderconfig["Min"]) + sliderconfig["Min"])
				local SliderValue = sliderconfig["Precise"] and SliderNonPrecise or SliderPrecise
				SliderValue = tonumber(string.format("%.2f", SliderValue))

				GlobalSliderValue = SliderValue
				SliderBox.Text = tostring(SliderValue)
				task.spawn(function()
					sliderconfig["callback"](GlobalSliderValue)
				end)
			end

			local function SetValue(Value)
				Value = math.clamp(Value, sliderconfig["Min"], sliderconfig["Max"])
				GlobalSliderValue = Value
				local Position = UDim2.new((Value - sliderconfig["Min"]) / (sliderconfig["Max"] - sliderconfig["Min"]), 0, 1, 0)
				Slide.Size = Position

				SliderBox.Text = tostring(Value)
				task.spawn(function()
					sliderconfig["callback"](Value)
				end)
			end

			SetValue(sliderconfig["Precise"] or sliderconfig["Min"])

			SliderBox.FocusLost:Connect(function()
				if not tonumber(SliderBox.Text) then
					SliderBox.Text = tostring(GlobalSliderValue)
				else
					local Value = tonumber(SliderBox.Text)
					Value = math.clamp(Value, sliderconfig["Min"], sliderconfig["Max"])
					SetValue(Value)
				end
			end)

			Slider.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Sliding(Input)
					Dragging = true

					-- Animate the ball to appear larger when dragging
					TweenObject(Ball, {Size = UDim2.new(0, 15, 0, 15)}, 0.2, Enum.EasingStyle.Back)
				end
			end)

			Slider.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = false

					-- Animate the ball back to normal size
					TweenObject(Ball, {Size = UDim2.new(0, 10, 0, 10)}, 0.2, Enum.EasingStyle.Back)
				end
			end)

			UIS.InputChanged:Connect(function(Input)
				if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
					Sliding(Input)
				end
			end)
		end
		function itemfunc:CreateTextbox(boxconfig)
			local Box = InstanceItem("TextButton", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0, 0),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(1, -10, 0, 40),
				["Name"] = "Box",
				["ClipsDescendants"] = true,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = "",
				["TextSize"] = 14,
				["AutoButtonColor"] = false,
				["TextXAlignment"] = Enum.TextXAlignment.Center,
				["Font"] = Enum.Font.SourceSans,
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(-0.109792, 0, 0.348, 0),
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["TextYAlignment"] = Enum.TextYAlignment.Center,
				["TextScaled"] = false,
				["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
			}, Section)

			local UBoxT = InstanceItem("UICorner", {
				["Name"] = "UBoxT",
				["CornerRadius"] = UDim.new(0, 4)
			}, Box)

			local slidertitle = InstanceItem("TextLabel", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0, 0),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0, 178, 0, 40),
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = boxconfig.title,
				["Name"] = "slidertitle",
				["TextSize"] = 16,
				["TextXAlignment"] = Enum.TextXAlignment.Left,
				["Font"] = Enum.Font.GothamBold,
				["BackgroundTransparency"] = 1,
				["Position"] = UDim2.new(0, 10, 0, 0),
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["TextYAlignment"] = Enum.TextYAlignment.Center,
				["TextScaled"] = false,
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			}, Box)

			local SliderBox = InstanceItem("TextBox", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(1, 0.5),
				["PlaceholderColor3"] = Color3.fromRGB(178, 178, 178),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0, 131, 0, 20),
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = "",
				["Name"] = "SliderBox",
				["MultiLine"] = false,
				["ClipsDescendants"] = false,
				["Font"] = Enum.Font.SourceSans,
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(0.976, 0, 0.5, 0),
				["PlaceholderText"] = "Value",
				["ClearTextOnFocus"] = true,
				["TextSize"] = 14,
				["BackgroundColor3"] = Color3.fromRGB(17, 17, 17)
			}, Box)

			local UBoxT_1 = InstanceItem("UICorner", {
				["Name"] = "UBoxT",
				["CornerRadius"] = UDim.new(0, 4)
			}, SliderBox)

			SliderBox.FocusLost:Connect(function()
				task.spawn(function()
					boxconfig.callback(SliderBox.Text)
				end)
			end)

			local maxWidth=110
			SliderBox:GetPropertyChangedSignal("Text"):Connect(function()
				local bounds = SliderBox.TextBounds
				local newWidth = math.min(bounds.X + 20, maxWidth)
				if newWidth==maxWidth then
					SliderBox.TextTruncate=Enum.TextTruncate.AtEnd
				else
					SliderBox.TextTruncate=Enum.TextTruncate.None
				end
				TweenObject(SliderBox,{Size=UDim2.new(0, newWidth, 0, SliderBox.Size.Y.Offset)},.1)
			end)

			if boxconfig.default then
				SliderBox.Text=boxconfig.default
				task.spawn(function()
					boxconfig.callback(SliderBox.Text)
				end)
			end
		end
		function itemfunc:CreateLabel(labelconfig)
			local Label = InstanceItem("TextLabel", {
				["Visible"] = true,
				["AnchorPoint"] = Vector2.new(0, 0),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(1, -10, 0, 30),
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Text"] = labelconfig.title,
				["Name"] = "Label",
				["TextSize"] = 14,
				["TextXAlignment"] = Enum.TextXAlignment.Center,
				["Font"] = Enum.Font.GothamBold,
				["BackgroundTransparency"] = 0,
				["Position"] = UDim2.new(0, 0, 0, 0),
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["TextYAlignment"] = Enum.TextYAlignment.Center,
				["TextScaled"] = false,
				["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
			}, Section)

			local ConLbael = InstanceItem("UICorner", {
				["Name"] = "ConLbael",
				["CornerRadius"] = UDim.new(0, 4)
			}, Label)

			local Setting = InstanceItem("ImageButton", {
				["ImageColor3"] = Color3.fromRGB(255, 255, 255),
				["ImageTransparency"] = 0,
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["Image"] = "rbxassetid://8445471332",
				["ImageRectSize"] = Vector2.new(96, 96),
				["ZIndex"] = 1,
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.new(0, 20, 0, 20),
				["ScaleType"] = Enum.ScaleType.Stretch,
				["ClipsDescendants"] = false,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["AutoButtonColor"] = true,
				["Name"] = "Setting",
				["ImageRectOffset"] = Vector2.new(604, 404),
				["BackgroundTransparency"] = 1,
				["Position"] = UDim2.new(0.021, 3, 0.5, 0),
				["SliceScale"] = 1,
				["Visible"] = false,
				["SliceCenter"] = Rect.new(0, 0, 0, 0),
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			}, Label)

			local labelfunc={}
			function labelfunc:Set(text)
				Label.Text=text
			end

			function labelfunc:EnableConfig()
				Setting.Visible=true

				local newpage=CreatePageConfig(Page.Parent,labelconfig.title,resetcallback)
				Setting.MouseButton1Click:Connect(function()
					newpage.Visible=true
				end)
				addpage(newpage)
				return AddPageOthers(newpage)
			end

			return labelfunc
		end
		return itemfunc
	end
	return secfunc
end

function SawUI:CreateWindow(windowconfig)
	local UI = InstanceItem("ScreenGui", {
		["ResetOnSpawn"] = true,
		["IgnoreGuiInset"] = true,
		["Name"] = "UI",
		["DisplayOrder"] = 0
	}, game:GetService("CoreGui"))


	local Menu = InstanceItem("ImageButton", {
		["ImageColor3"] = Color3.fromRGB(255, 255, 255),
		["ImageTransparency"] = 0,
		["AnchorPoint"] = Vector2.new(0, 1),
		["Image"] = "rbxassetid://93980776776739",
		["ImageRectSize"] = Vector2.new(0, 0),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(0, 50, 0, 50),
		["ScaleType"] = Enum.ScaleType.Stretch,
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["AutoButtonColor"] = true,
		["Name"] = "Menu",
		["ImageRectOffset"] = Vector2.new(0, 0),
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.new(0, 0, 1, 0),
		["SliceScale"] = 1,
		["Visible"] = true,
		["SliceCenter"] = Rect.new(0, 0, 0, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	}, UI)

	local UIMenu = InstanceItem("UICorner", {
		["Name"] = "UIMenu",
		["CornerRadius"] = UDim.new(1, 0)
	}, Menu)


	local Main = InstanceItem("Frame", {
		["Visible"] = true,
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["Name"] = "Main",
		["BackgroundTransparency"] = 0,
		["Position"] = UDim2.new(0.5, 0, 0.5, 0),
		["BackgroundColor3"] = Color3.fromRGB(35, 35, 35),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(0, 500, 0, 350)
	}, UI)

	local UIScale = Instance.new("UIScale")
	UIScale.Parent=Main
	UIScale.Scale=1

	local UM = InstanceItem("UICorner", {
		["Name"] = "UM",
		["CornerRadius"] = UDim.new(0, 2)
	}, Main)

	local UISM = InstanceItem("UIStroke", {
		["Thickness"] = 3,
		["LineJoinMode"] = Enum.LineJoinMode.Round,
		["Name"] = "UISM",
		["Color"] = Color3.fromRGB(0, 0, 0),
		["Transparency"] = 0
	}, Main)

	local Bar = InstanceItem("Frame", {
		["Visible"] = true,
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["AnchorPoint"] = Vector2.new(0, 0),
		["Name"] = "Bar",
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.new(0, 0, 0, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(0, 500, 0, 35)
	}, Main)

	local Per = InstanceItem("ImageButton", {
		["ImageColor3"] = Color3.fromRGB(255, 255, 255),
		["ImageTransparency"] = 0,
		["AnchorPoint"] = Vector2.new(0, 0.5),
		["Image"] = "rbxassetid://8445470826",
		["ImageRectSize"] = Vector2.new(96, 96),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 1,
		["Size"] = UDim2.new(0, 24, 0, 24),
		["ScaleType"] = Enum.ScaleType.Stretch,
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Name"] = "Per",
		["ImageRectOffset"] = Vector2.new(904, 404),
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.new(0.862, 0, 0.5, 0),
		["SliceScale"] = 1,
		["Visible"] = true,
		["SliceCenter"] = Rect.new(0, 0, 0, 0),
		["BackgroundColor3"] = Color3.fromRGB(163, 162, 165)
	}, Bar)
	local Logo = InstanceItem("ImageLabel", {
		["ImageColor3"] = Color3.fromRGB(255, 255, 255),
		["ImageTransparency"] = 0,
		["AnchorPoint"] = Vector2.new(0, 0.5),
		["Image"] = "rbxassetid://94632832798803",
		["ImageRectSize"] = Vector2.new(500, 500),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(0, 35, 0, 35),
		["ScaleType"] = Enum.ScaleType.Stretch,
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["Name"] = "Logo",
		["ImageRectOffset"] = Vector2.new(0, 0),
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.new(0, 5, 0.5, 0),
		["SliceScale"] = 1,
		["Visible"] = true,
		["SliceCenter"] = Rect.new(0, 0, 0, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	}, Bar)

	local WindowName = InstanceItem("TextLabel", {
		["Visible"] = true,
		["AnchorPoint"] = Vector2.new(0, 0),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(0, 306, 0, 35),
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["Text"] = "<font color=\"rgb(150,220,255)\">"..windowconfig.title.."</font> | <font color=\"rgb(255,80,80)\">"..game.Name.."</font> | <font color=\"rgb(200,200,200)\">60 FPS</font>",
		["Name"] = "WindowName",
		["TextSize"] = 17,
		["TextXAlignment"] = Enum.TextXAlignment.Left,
		["RichText"]=true,
		["Font"] = Enum.Font.GothamBold,
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.new(0, 45, 0, 0),
		["TextColor3"] = Color3.fromRGB(255, 255, 255),
		["TextYAlignment"] = Enum.TextYAlignment.Center,
		["TextScaled"] = false,
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	}, Bar)

	local RunService = game:GetService("RunService")

	local fps = 0
	local frameCount = 0
	local lastTime = tick()

	RunService.RenderStepped:Connect(function()
		frameCount =frameCount+ 1
		local currentTime = tick()

		if currentTime - lastTime >= 1 then
			fps = frameCount
			frameCount = 0
			lastTime = currentTime

			WindowName.Text="<font color=\"rgb(150,220,255)\">"..windowconfig.title.."</font> | <font color=\"rgb(255,80,80)\">"..game.Name.."</font> | <font color=\"rgb(200,200,200)\">"..fps .." FPS</font>"
		end
	end)

	local Close = InstanceItem("ImageButton", {
		["ImageColor3"] = Color3.fromRGB(255, 255, 255),
		["ImageTransparency"] = 0,
		["AnchorPoint"] = Vector2.new(0, 0.5),
		["Image"] = "rbxassetid://8445470984",
		["ImageRectSize"] = Vector2.new(96, 96),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(0, 24, 0, 24),
		["ScaleType"] = Enum.ScaleType.Stretch,
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["AutoButtonColor"] = false,
		["Name"] = "Close",
		["ImageRectOffset"] = Vector2.new(304, 304),
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.new(1, -33, 0.5, 0),
		["SliceScale"] = 1,
		["Visible"] = true,
		["SliceCenter"] = Rect.new(0, 0, 0, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	}, Bar)

	local Line = InstanceItem("Frame", {
		["Visible"] = true,
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["AnchorPoint"] = Vector2.new(0, 0),
		["Name"] = "Line",
		["BackgroundTransparency"] = 0,
		["Position"] = UDim2.new(0, 0, 0.1, 0),
		["BackgroundColor3"] = Color3.fromRGB(0, 0, 0),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(0, 500, 0, 3)
	}, Main)

	local Bottom = InstanceItem("Frame", {
		["Visible"] = true,
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["AnchorPoint"] = Vector2.new(0, 0),
		["Name"] = "Bottom",
		["BackgroundTransparency"] = 0,
		["Position"] = UDim2.new(0, 0, 0, 38),
		["BackgroundColor3"] = Color3.fromRGB(0, 0, 0),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(1, 0, 0, 312)
	}, Main)


	DraggingEnabled(Bar,Main)
	DraggingEnabled(Menu,Menu)

	local Performance = InstanceItem("TextButton", {
		["Visible"] = true,
		["AnchorPoint"] = Vector2.new(0, 0),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(0, 150, 0, 30),
		["Name"] = "Performance",
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["Text"] = "00:00:00",
		["TextSize"] = 15,
		["AutoButtonColor"] = false,
		["TextXAlignment"] = Enum.TextXAlignment.Center,
		["Font"] = Enum.Font.GothamBold,
		["BackgroundTransparency"] = 0,
		["Position"] = UDim2.new(0, 0, 0, 282),
		["TextColor3"] = Color3.fromRGB(255, 255, 255),
		["TextYAlignment"] = Enum.TextYAlignment.Center,
		["TextScaled"] = false,
		["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
	}, Bottom)

	local function convertSecondsToTime(seconds)
		local hours = math.floor(seconds / 3600)
		local minutes = math.floor((seconds % 3600) / 60)
		local secs = seconds % 60
		return string.format("%02d:%02d:%02d", hours, minutes, secs)
	end

	spawn(function()
		while wait(1) do
			Performance.Text=convertSecondsToTime(ServerTime)
		end
	end)

	local Refresh = InstanceItem("ImageButton", {
		["ImageColor3"] = Color3.fromRGB(255, 255, 255),
		["ImageTransparency"] = 0,
		["AnchorPoint"] = Vector2.new(0, 0),
		["Image"] = "rbxassetid://8445471499",
		["ImageRectSize"] = Vector2.new(96, 96),
		["ZIndex"] = 1,
		["AutoButtonColor"]=false,
		["BorderSizePixel"] = 1,
		["Size"] = UDim2.new(0, 24, 0, 24),
		["ScaleType"] = Enum.ScaleType.Stretch,
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Name"] = "Refresh",
		["ImageRectOffset"] = Vector2.new(104, 704),
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.new(0.0333333, 0, 0.1, 0),
		["SliceScale"] = 1,
		["Visible"] = true,
		["SliceCenter"] = Rect.new(0, 0, 0, 0),
		["BackgroundColor3"] = Color3.fromRGB(163, 162, 165)
	}, Performance)

	Refresh.MouseButton1Click:Connect(function()
		game:GetService("TeleportService"):Teleport(game.PlaceId,plr)
	end)

	local UPer = InstanceItem("UICorner", {
		["Name"] = "UPer",
		["CornerRadius"] = UDim.new(0, 4)
	}, Performance)

	local LeftPage = InstanceItem("ScrollingFrame", {
		["Visible"] = true,
		["Name"] = "LeftPage",
		["VerticalScrollBarPosition"] = Enum.VerticalScrollBarPosition.Right,
		["ClipsDescendants"] = true,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["ScrollBarThickness"] = 0,
		["BackgroundColor3"] = Color3.fromRGB(35, 35, 35),
		["ScrollingDirection"] = Enum.ScrollingDirection.XY,
		["AnchorPoint"] = Vector2.new(0, 0),
		["CanvasSize"] = UDim2.new(0, 0, 2, 0),
		["BackgroundTransparency"] = 0,
		["Position"] = UDim2.new(0, 0, 0, 0),
		["ScrollingEnabled"] = true,
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(0, 150, 0, 279)
	}, Bottom)

	local Notify = Instance.new("Frame")
	local NotiList = Instance.new("UIListLayout")
	local NotiPadding = Instance.new("UIPadding")

	Notify.Name = "Notify"
	Notify.Parent = UI
	Notify.BackgroundTransparency = 1
	Notify.Size = UDim2.new(1, 0, 1, 0)
	Notify.ZIndex = 5

	NotiList.Name = "NotiList"
	NotiList.Parent = Notify
	NotiList.HorizontalAlignment = Enum.HorizontalAlignment.Right
	NotiList.SortOrder = Enum.SortOrder.LayoutOrder
	NotiList.VerticalAlignment = Enum.VerticalAlignment.Bottom
	NotiList.Padding = UDim.new(0, 10)

	NotiPadding.Name = "NotiPadding"
	NotiPadding.Parent = Notify
	NotiPadding.PaddingBottom = UDim.new(0, 20)
	NotiPadding.PaddingRight = UDim.new(0, 20)

	local UIListTab = InstanceItem("UIListLayout", {
		["VerticalAlignment"] = Enum.VerticalAlignment.Top,
		["FillDirection"] = Enum.FillDirection.Vertical,
		["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
		["Padding"] = UDim.new(0, 5),
		["Name"] = "UIListTab",
		["SortOrder"] = Enum.SortOrder.LayoutOrder
	}, LeftPage)

	AddListCanva(UIListTab,LeftPage)

	local PaddingTab = InstanceItem("UIPadding", {
		["PaddingTop"] = UDim.new(0, 5),
		["Name"] = "PaddingTab",
		["PaddingBottom"] = UDim.new(0, 0),
		["PaddingRight"] = UDim.new(0, 0),
		["PaddingLeft"] = UDim.new(0, 0)
	}, LeftPage)

	local ULP = InstanceItem("UICorner", {
		["Name"] = "ULP",
		["CornerRadius"] = UDim.new(0, 4)
	}, LeftPage)

	local RightPage = InstanceItem("Frame", {
		["Visible"] = true,
		["ClipsDescendants"] = false,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["AnchorPoint"] = Vector2.new(0, 0),
		["Name"] = "RightPage",
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.new(0.306, 0, 0, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["ZIndex"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.new(0, 347, 0, 312)
	}, Bottom)

	local pagefunc={start=false,tab={},page={}}
	function pagefunc:Notify(message, options)
		options = options or {}
		local color = options.color or Theme.Success
		local duration = options.duration or 3.5
		local title = options.title or "Notification"

		local NotificationFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local TitleLabel = Instance.new("TextLabel")
		local MessageLabel = Instance.new("TextLabel")
		local StatusBar = Instance.new("Frame")
		local StatusBarCorner = Instance.new("UICorner")
		local IconLabel = Instance.new("ImageLabel")

		NotificationFrame.Name = "NotificationFrame"
		NotificationFrame.BackgroundColor3 = Theme.SecondaryBackground
		NotificationFrame.BorderSizePixel = 0
		NotificationFrame.Position = UDim2.new(1, 20, 0, 0)  -- Start off-screen
		NotificationFrame.Size = UDim2.new(0, 0, 0, 70)  -- Start with zero width
		NotificationFrame.ClipsDescendants = true
		NotificationFrame.Parent = Notify

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = NotificationFrame

		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Color = color
		UIStroke.Thickness = 1
		UIStroke.Parent = NotificationFrame

		StatusBar.Name = "StatusBar"
		StatusBar.BackgroundColor3 = color
		StatusBar.BorderSizePixel = 0
		StatusBar.Position = UDim2.new(0, 0, 1, -3)
		StatusBar.Size = UDim2.new(1, 0, 0, 3)
		StatusBar.ZIndex = 5
		StatusBar.Parent = NotificationFrame

		StatusBarCorner.CornerRadius = UDim.new(0, 3)
		StatusBarCorner.Parent = StatusBar

		IconLabel.Name = "IconLabel"
		IconLabel.BackgroundTransparency = 1
		IconLabel.Position = UDim2.new(0, 10, 0, 10)
		IconLabel.Size = UDim2.new(0, 20, 0, 20)
		IconLabel.Image = "rbxassetid://7072718362"  -- Info icon
		IconLabel.ImageColor3 = color
		IconLabel.Parent = NotificationFrame

		TitleLabel.Name = "TitleLabel"
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Position = UDim2.new(0, 40, 0, 7)
		TitleLabel.Size = UDim2.new(1, -50, 0, 20)
		TitleLabel.Font = Enum.Font.GothamBold
		TitleLabel.Text = title
		TitleLabel.TextColor3 = Theme.TextColor
		TitleLabel.TextSize = 14
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		TitleLabel.Parent = NotificationFrame

		MessageLabel.Name = "MessageLabel"
		MessageLabel.BackgroundTransparency = 1
		MessageLabel.Position = UDim2.new(0, 40, 0, 27)
		MessageLabel.Size = UDim2.new(1, -50, 1, -37)
		MessageLabel.Font = Enum.Font.Gotham
		MessageLabel.Text = message
		MessageLabel.TextColor3 = Theme.SubTextColor
		MessageLabel.TextSize = 14
		MessageLabel.TextWrapped = true
		MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
		MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
		MessageLabel.Parent = NotificationFrame

		-- Calculate width based on text
		local textWidth = game:GetService("TextService"):GetTextSize(
			message, 
			14, 
			Enum.Font.Gotham, 
			Vector2.new(300, math.huge)
		).X

		local finalWidth = math.clamp(textWidth + 70, 200, 300)

		-- Animate in
		TweenObject(NotificationFrame, {Size = UDim2.new(0, finalWidth, 0, 70)}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		TweenObject(NotificationFrame, {Position = UDim2.new(1, -finalWidth - 20, 0, 0)}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

		-- Animate status bar for countdown
		TweenObject(StatusBar, {Size = UDim2.new(0, 0, 0, 3)}, duration, Enum.EasingStyle.Linear)

		-- Animate out after duration
		task.delay(duration, function()
			TweenObject(NotificationFrame, {Position = UDim2.new(1, 20, 0, 0)}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
			task.wait(0.3)
			NotificationFrame:Destroy()
		end)
	end
	local function ResetTabAndPage()
		for i,v in pairs(pagefunc.tab) do
			v.BackgroundTransparency=1
		end
		for i,v in pairs(pagefunc.page) do
			v.Visible=false
		end
	end
	local pageper=CreatePageConfig(RightPage,"Performance",function()
	end)

	pageper.ZIndex=2


	table.insert(pagefunc.page,pageper)

	local otherperfunc=AddPageOthers(pageper)
	Per.MouseButton1Click:Connect(function()

		pageper.Visible=true
	end)

	local boostfps = otherperfunc:CreateSection({title="Fps"})
	boostfps:CreateToggle({title="Boost Fps",default=getgenv().Config.BoostFps,callback=function(v)
		getgenv().Config.BoostFps=v
		if v then

			Boostfps1()

		end
	end})  
	boostfps:CreateToggle({title="[ULTRA] Boost Fps",default=getgenv().Config.UltraBoostFps,callback=function(v)
		getgenv().Config.UltraBoostFps=v
		if v then

			Boostfps2()


		end
	end})  

	local u= Instance.new("ScreenGui",game.CoreGui)
	u.Enabled=false
	local uu = Instance.new("TextButton",u)
	uu.Size=UDim2.new(0,100,0,20)
	uu.BackgroundColor3= Color3.fromRGB(20,20,20)
	uu.TextColor3= Color3.fromRGB(255,255,255)
	uu.Text="Toggle White Screen"
	uu.AnchorPoint=Vector2.new(0.5,0)
	uu.Position=UDim2.new(0.5,0,1,-24)

	local screenval=false

	uu.MouseButton1Click:Connect(function()
		screenval=not screenval
		game:GetService("RunService"):Set3dRenderingEnabled(screenval)
	end)


	local Rendertab = otherperfunc:CreateSection({title="Render"})
	Rendertab:CreateToggle({title="Clean Chunk (STRONG)",default=getgenv().Config.CleanChunk,callback=function(v)
		getgenv().Config.CleanChunk=v
		ChangeCamera(v)
		spawn(function()
			while wait() and getgenv().Config.CleanChunk do
				ChangeCamera(v)
			end
		end)
	end})
	Rendertab:CreateToggle({title="White Screen",default=getgenv().Config.WhiteScreen,callback=function(v)
		getgenv().Config.WhiteScreen=v
		screenval=v
		u.Enabled=v
		pcall(function()
			if v then
				game:GetService("RunService"):Set3dRenderingEnabled(false)
			else
				game:GetService("RunService"):Set3dRenderingEnabled(true)
			end
		end)
	end})

	for i,v in pairs(pageper:GetDescendants()) do
		pcall(function()
			v.ZIndex=2
		end)
	end

	local opendui=false
	Close.MouseButton1Click:Connect(function()
		TweenObject(UIScale,{Scale=0},.2)
		opendui=true
	end)

	Menu.MouseButton1Click:Connect(function()
		opendui=not opendui
		if opendui then
			TweenObject(UIScale,{Scale=0},.2)
		else
			TweenObject(UIScale,{Scale=1},.2)
		end
	end)


	UIS.InputBegan:Connect(function(i,u)
		if u then return end
		if i.KeyCode==Enum.KeyCode.RightControl then
			opendui=not opendui
			if opendui then
				TweenObject(UIScale,{Scale=0},.2)
			else
				TweenObject(UIScale,{Scale=1},.2)

			end
		end
	end)

	function pagefunc:CreatePage(pageconfig)
		local Tab = InstanceItem("TextButton", {
			["Visible"] = true,
			["AnchorPoint"] = Vector2.new(0, 0),
			["ZIndex"] = 1,
			["BorderSizePixel"] = 0,
			["Size"] = UDim2.new(1, -10, 0, 25),
			["Name"] = "Tab",
			["ClipsDescendants"] = false,
			["BorderColor3"] = Color3.fromRGB(0, 0, 0),
			["Text"] = pageconfig.title,
			["TextSize"] = 14,
			["AutoButtonColor"] = false,
			["TextXAlignment"] = Enum.TextXAlignment.Center,
			["Font"] = Enum.Font.GothamBold,
			["BackgroundTransparency"] = 1,
			["Position"] = UDim2.new(0, 0, 0, 0),
			["TextColor3"] = Color3.fromRGB(255, 255, 255),
			["TextYAlignment"] = Enum.TextYAlignment.Center,
			["TextScaled"] = false,
			["BackgroundColor3"] = Color3.fromRGB(150, 220, 255)
		}, LeftPage)

		local UICorner = InstanceItem("UICorner", {
			["Name"] = "UICorner",
			["CornerRadius"] = UDim.new(0, 4)
		}, LeftPage)

		local Page = InstanceItem("ScrollingFrame", {
			["Visible"] = false,
			["Name"] = "Page",
			["VerticalScrollBarPosition"] = Enum.VerticalScrollBarPosition.Right,
			["ClipsDescendants"] = true,
			["BorderColor3"] = Color3.fromRGB(0, 0, 0),
			["ScrollBarThickness"] = 3,
			["BackgroundColor3"] = Color3.fromRGB(35, 35, 35),
			["ScrollingDirection"] = Enum.ScrollingDirection.XY,
			["AnchorPoint"] = Vector2.new(0, 0),
			["CanvasSize"] = UDim2.new(0, 0, 2, 0),
			["BackgroundTransparency"] = 0,
			["Position"] = UDim2.new(0, 0, 0, 0),
			["ScrollingEnabled"] = true,
			["ZIndex"] = 1,
			["BorderSizePixel"] = 0,
			["Size"] = UDim2.new(1, 0, 1, 0)
		}, RightPage)

		if not pagefunc.start then
			pagefunc.start=true
			Page.Visible=true
			Tab.BackgroundTransparency=0
		end

		local URP = InstanceItem("UICorner", {
			["Name"] = "URP",
			["CornerRadius"] = UDim.new(0, 4)
		}, Page)

		local UIListPage = InstanceItem("UIListLayout", {
			["VerticalAlignment"] = Enum.VerticalAlignment.Top,
			["FillDirection"] = Enum.FillDirection.Vertical,
			["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
			["Padding"] = UDim.new(0, 5),
			["Name"] = "UIListPage",
			["SortOrder"] = Enum.SortOrder.LayoutOrder
		}, Page)
		AddListCanva(UIListPage,Page)

		local PaddingPage = InstanceItem("UIPadding", {
			["PaddingTop"] = UDim.new(0, 5),
			["Name"] = "PaddingPage",
			["PaddingBottom"] = UDim.new(0, 0),
			["PaddingRight"] = UDim.new(0, 0),
			["PaddingLeft"] = UDim.new(0, 0)
		}, Page)

		Tab.MouseButton1Click:Connect(function()
			ResetTabAndPage()
			Tab.Transparency=0
			Page.Visible=true
		end)
		table.insert(pagefunc.tab,Tab)
		table.insert(pagefunc.page,Page)

		local secfunc={}

		return AddPageOthers(Page,function()
			ResetTabAndPage()
			Tab.Transparency=0
			Page.Visible=true
		end,function(val)
			table.insert(pagefunc.page,val)
		end)
	end
	return pagefunc
end

if not getgenv().Config then
	getgenv().Config={}
end
local u3 = require(game:GetService("ReplicatedStorage").Modules.DataService)
local DataPlayer

repeat
	pcall(function()
		DataPlayer = u3:GetData(game.Players.LocalPlayer)
	end)
	wait(0.1)
until DataPlayer ~= nil

local allpets={}
local petmodu=require(game:GetService("ReplicatedStorage").Data.PetRegistry.PetList)
for i,v in pairs(petmodu) do
	table.insert(allpets,i)
end
local allseeds={}
local seeddata=require(game:GetService("ReplicatedStorage").Data.SeedData)
for i,v in pairs(seeddata) do
	table.insert(allseeds,i)
end
local plr = game.Players.LocalPlayer
function Get_Farm()
	for i,v in pairs(workspace.Farm:GetChildren()) do
		if v.Important.Data.Owner.Value == game.Players.LocalPlayer.Name then
			return v
		end
	end
end
local ModuleGears = require(game:GetService("ReplicatedStorage").Data.GearData)

local isMobile = UIS.TouchEnabled
local isPC = UIS.KeyboardEnabled and not isMobile

function UnLock_Moonlit()
	if isMobile then
		for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.BackpackGui.Backpack.Inventory.ScrollingFrame.UIGridFrame:GetChildren()) do
			if v.Name ~="UIGridLayout" and v:FindFirstChild("ToolName") and (string.find(v.ToolName.Text,"Moonlit") or string.find(v.ToolName.Text,"Bloodlit")) and v.FavIcon.Visible==true then
				for i,v in pairs(getconnections(v.MouseButton1Click)) do
					v.Function()
				end
				for i,v in pairs(getconnections(v.MouseButton1Click)) do
					v.Function()
				end
			end
		end
		for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.BackpackGui.Backpack.Hotbar:GetChildren()) do
			if v.Name ~="UIGridLayout" and v:FindFirstChild("ToolName") and (string.find(v.ToolName.Text,"Moonlit") or string.find(v.ToolName.Text,"Bloodlit")) and v.FavIcon.Visible==true then
				for i,v in pairs(getconnections(v.MouseButton1Click)) do
					v.Function()
				end
				for i,v in pairs(getconnections(v.MouseButton1Click)) do
					v.Function()
				end
			end
		end
	else
	
		for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.BackpackGui.Backpack.Inventory.ScrollingFrame.UIGridFrame:GetChildren()) do
			if v.Name ~="UIGridLayout" and v:FindFirstChild("ToolName") and (string.find(v.ToolName.Text,"Moonlit") or string.find(v.ToolName.Text,"Bloodlit"))and v.FavIcon.Visible==true then
				for i,v in pairs(getconnections(v.MouseButton2Click)) do
					v.Function()
				end

			end
		end
		for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.BackpackGui.Backpack.Hotbar:GetChildren()) do
			if v.Name ~="UIGridLayout" and v:FindFirstChild("ToolName") and (string.find(v.ToolName.Text,"Moonlit") or string.find(v.ToolName.Text,"Bloodlit")) and v.FavIcon.Visible==true then
				for i,v in pairs(getconnections(v.MouseButton2Click)) do
					v.Function()
				end

			end
		end
	end
	wait(1)
end 
local v1 = game:GetService("ReplicatedStorage")
local allmuta={}
local u3 = require(v1.Modules.MutationHandler)
for i,v in pairs(u3.MutationNames) do
	table.insert(allmuta,i)
end
local MyFarm=Get_Farm()

local u2 = require(v1.Item_Module)

function CalcPlantVal(p4)
	local v5 = p4.Name
	if not v5 then
		return 0
	end
	local v6 = p4:FindFirstChild("Variant")
	if not v6 then
		return 0
	end
	local v7 = p4:FindFirstChild("Weight")
	if not v7 then
		return 0
	end
	local v8 = u2.Return_Data(v5)
	if not v8 or #v8 < 3 then
		warn("CalculatePlantValue | ItemData is invalid")
		return 0
	end
	local v9 = v8[3]
	local v10 = v8[2]
	local v11 = u2.Return_Multiplier(v6.Value)
	local v12 = v9 * u3:CalcValueMulti(p4) * v11
	local v13 = v7.Value / v10
	local v14 = math.clamp(v13, 0.95, 100000000)
	local v15 = v12 * (v14 * v14)
	return math.round(v15)
end


local function round(num, decimalPlaces)
	return math.floor(num * 10^decimalPlaces + 0.5) / 10^decimalPlaces
end
function formatNumberWithCommas(n)
	local formatted = tostring(n)
	local k
	repeat
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
	until k == 0
	return formatted
end

function GetAsset(ty,name)
    if ty=="Pet" then
        return petmodu[name].Icon
    elseif ty=="Seed" then
        return seeddata[name].FruitIcon
    elseif ty=="Gear" then
        return ModuleGears[name].Asset
    end
end

function WebhookReward(val,imageurl)
    local msg2 = "**Account**\n||"..game.Players.LocalPlayer.Name.."||\n**Rewards**\n"
    msg2=msg2.."-"..val
    msg2=msg2.."\n**Info**\n-Sheckles: "..formatNumberWithCommas(game.Players.LocalPlayer.leaderstats.Sheckles.Value).."$"
    local a=request({
        Url ="https://thumbnails.roblox.com/v1/assets?assetIds="..string.match(imageurl, "rbxassetid://(%d+)").."&size=420x420&format=Png&isCircular=false",
        Method = "GET",
        Headers = {
            ["Content-Type"] = "application/json"
        }
    })
	local b=game:GetService("HttpService"):JSONDecode(a.Body).data[1].imageUrl
    local msg = {
        ["username"]= "Saw Notify",
        ["avatar_url"]= "https://raw.githubusercontent.com/minhblus/sawhub/refs/heads/main/removebg-preview.png",
        ["embeds"] = {{
            ["title"] = "Grow A Garden",
            ["description"]=msg2,
            ["thumbnail"] = {
                ["url"] = b
            },
            ["type"] = "rich",
            ["color"] = tonumber(47103),
            ["footer"] = {
                ["text"] = "Saw Hub",
                ["icon_url"] = "https://raw.githubusercontent.com/minhblus/sawhub/refs/heads/main/removebg-preview.png"
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    request({
        Url =getgenv().Config.WebhookUrl,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(msg)
    })
end


table.sort(allseeds)
local isMobile = UIS.TouchEnabled
local isPC = UIS.KeyboardEnabled and not isMobile
local tick_out=tick()
local tick_moonsell=tick()
local tick_sell=tick()

function Get_Fruit()
	local fruits={}
	for i,v in pairs(MyFarm.Important.Plants_Physical:GetChildren()) do
		if v:IsA("Model") and v:FindFirstChild("Fruit_Spawn") then
			for _,fruit in pairs(v.Fruits:GetChildren()) do
				table.insert(fruits,fruit)
			end
		elseif v:IsA("Model") then
			table.insert(fruits,v)
		end
	end
	return fruits
end


local function ShouldSell()
	local backpack = game.Players.LocalPlayer.Backpack
	return getgenv().Config.AutoSell and (#backpack:GetChildren() >= getgenv().Config.BackpackSell or tick() - tick_sell >= getgenv().Config.TimeSell)
end

local function SellInventory()
	tick_sell = tick()
	local sellCFrame = CFrame.new(86.4562073, 2.99999976, 0.257237494, -0.00981384888, 4.3232312e-08, -0.999951839, 4.1540843e-10, 1, 4.32303189e-08, 0.999951839, 8.86738252e-12, -0.00981384888)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = sellCFrame
	wait(1)
	game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
	wait(7)
end

local function Sell_Pet()
	for i,v in pairs(plr.Backpack:GetChildren()) do
		if v:GetAttribute("ItemType")=="Pet" and tonumber(string.match(v.Name, "%[Age (%d+)%]")) < 20 then 
			local cleaned = v.Name:gsub("%b[]", ""):gsub("%s%s+", " "):gsub("^%s*(.-)%s*$", "%1")
            if table.find(getgenv().Config.PetDelete,cleaned) then
                plr.Character.Humanoid:EquipTool(v)
                wait()
                local sellCFrame = CFrame.new(86.4562073, 2.99999976, 0.257237494, -0.00981384888, 4.3232312e-08, -0.999951839, 4.1540843e-10, 1, 4.32303189e-08, 0.999951839, 8.86738252e-12, -0.00981384888)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = sellCFrame
                wait()
                game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("SellPet_RE"):FireServer(v)
                wait(1)
            end
		end
	end

end


function CountPhysical(name)
	local c=0
	for i,v in pairs(MyFarm.Important.Objects_Physical:GetChildren()) do
		if v:GetAttribute("OBJECT_TYPE")==name then
			c=c+1
		end
	end
	return c
end

function CheckMutation(tool,muta)
    for i,vv in pairs(muta or {}) do
        if not tool:GetAttribute(vv) then
            return false
        end
    end
    return true
end

--Seed
local seedpos=Vector3.new(0,0,0)
local kcout
for i,v in pairs(MyFarm.Important.Plant_Locations:GetChildren()) do
    if v.Name=="Can_Plant" then
        seedpos=seedpos+v.Position
    end
end
local midpos=seedpos/2
seedpos=(seedpos/2) + (Vector3.new(-20,0,-10) * (MyFarm.Important.Data.Farm_Number.Value%2==0 and -1 or 1))
function Plant_Seed()
	if #MyFarm.Important.Plants_Physical:GetChildren() >= 780 or not getgenv().Config.AutoPuts then 
		return false
	end
    local allItems = {}

    for _, item in ipairs(plr.Backpack:GetChildren()) do
        if item:GetAttribute("b")=="n" then
            table.insert(allItems, item)
        end
    end

    for _, item in ipairs(plr.Character:GetChildren()) do
        if item:GetAttribute("b")=="n" then
            table.insert(allItems, item)
        end
    end
	for i,v in pairs(allItems) do
        local itemname=v:GetAttribute("f")
        if itemanme and not table.find(getgenv().Config.SeedPut,itemname) then
            continue
        end
        for k=1,v:GetAttribute("Quantity") do
            if v.Parent == plr.Backpack then
                plr.Character.Humanoid:EquipTool(v)
            end
            plr.Character.HumanoidRootPart.CFrame=CFrame.new(seedpos)*CFrame.new(0,2,-10)
            wait(0.05)
            local args = {
                [1] = seedpos,
                [2] = itemname
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Plant_RE"):FireServer(unpack(args))
            wait(0.15)
            if #MyFarm.Important.Plants_Physical:GetChildren() >= 780 or not getgenv().Config.AutoPuts then 
                return false
            end
        end
	end
end

function GetPrimaryPart(obj)
    if obj.PrimaryPart then
        return obj.PrimaryPart
    end

    for _, child in ipairs(obj:GetChildren()) do
        if child:IsA("BasePart") then
            return child
        end
    end

    return nil
end

local plr = game.Players.LocalPlayer

function CheckFav(v)
	if getgenv().Config.FavoriteMethod=="Multi" then
		return CheckMutation(v,getgenv().Config.MutationFavorite)
	else
		for i,vv in pairs(getgenv().Config.MutationFavorite or {}) do
			if v:GetAttribute(vv) then
				return true
			end
		end
		if not getgenv().Config.MutationFavorite or #getgenv().Config.MutationFavorite ==0 then
			return true
		end
	end
end

function CheckFav2(v)
	if getgenv().Config.CollectMethod=="Multi" then
		return CheckMutation(v,getgenv().Config.MutationsCollect)
	else
		for i,vv in pairs(getgenv().Config.MutationsCollect or {}) do
			if v:GetAttribute(vv) then
				return true
			end
		end
		if not getgenv().Config.MutationsCollect or #getgenv().Config.MutationsCollect ==0 then
			return true
		end
	end
end

function CheckFav3(v)
	if getgenv().Config.CollectMethodFast=="Multi" then
		return CheckMutation(v,getgenv().Config.MutationsCollectFast)
	else
		for i,vv in pairs(getgenv().Config.MutationsCollectFast or {}) do
			if v:GetAttribute(vv) then
	
				return true
			end
		end

		if not getgenv().Config.MutationsCollectFast or #getgenv().Config.MutationsCollectFast ==0 then
			return true
		end
	end
end

function OpenNightSeed()
	local player = game.Players.LocalPlayer
	local containers = {player.Backpack, player.Character}

	for _, container in ipairs(containers) do
		for _, tool in ipairs(container:GetChildren()) do
			if string.find(tool.Name, "Crafters Seed Pack") then
				if container == player.Backpack then
					player.Character.Humanoid:EquipTool(tool)
					wait()
				end
				tool:Activate()
			end
		end
	end
end

function CheckNoFavorite(item)
	if item:getAttribute("d") and table.find(getgenv().Config.FavoriteFruit,item:getAttribute("f")) then
		if not CheckFav(item) then
			return true
		end
	else
		return true
	end
end

-- Auto Collect
function CollectFruitFast()
    for i,v in pairs(Get_Fruit()) do
        if not getgenv().Config.AutoCollect then
            return false
        end
        if table.find(getgenv().Config.FruitCollectFast or {},v.Name) and CheckFav3(v) then 
			pcall(function()
				local pos=GetPrimaryPart(v).Position
				plr.Character.HumanoidRootPart.CFrame=CFrame.new(pos.X,pos.Y,pos.Z+5)
			end)
            local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
			if prompt then
				task.wait(0.05)
				fireproximityprompt(prompt, 1, true)
				task.wait(0.05)
			end
			wait(0.05)
            if ShouldSell() then
                wait(2.1)
                SellInventory()
            end
        end
    end
end

function CollectFruit()
    for i,v in pairs(Get_Fruit()) do
        if not getgenv().Config.AutoCollect then
            return false
        end
        if table.find(getgenv().Config.FruitCollect or {},v.Name) and CheckFav2(v) and v.Weight.Value <= getgenv().Config.MaxWeight then 
            pcall(function()
				local pos=GetPrimaryPart(v).Position
				plr.Character.HumanoidRootPart.CFrame=CFrame.new(pos.X,pos.Y,pos.Z+5)
			end)

            local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
			if prompt then
				task.wait(0.05)
				fireproximityprompt(prompt, 1, true)
				task.wait(0.05)
			end
			wait(0.05)
            if ShouldSell() then
                wait(2.1)
                SellInventory()
            end
        end
    end
end

local tickfeed=tick()
function CollectFood()
    for i,v in pairs(Get_Fruit()) do
        if not getgenv().Config.AutoFeed then
            return false
        end
        if table.find(getgenv().Config.PetFood,v.Name) and v.Weight.Value <= getgenv().Config.MaxWeight then
            
            plr.Character.HumanoidRootPart.CFrame=GetPrimaryPart(v).CFrame*CFrame.new(0,0,-5)

            local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
			if prompt then
				task.wait(0.01)
				fireproximityprompt(prompt, 1, true)
				task.wait(0.01)
			end
			wait(0.01)
            if ShouldSell() then
                wait(2.1)
                SellInventory()
            end
        end
    end
end

--Pet
function AutoFeed()
	for i,v in pairs(DataPlayer.PetsData.EquippedPets) do
		local obf=DataPlayer.PetsData.PetInventory.Data[v].PetData.Hunger
		local name=DataPlayer.PetsData.PetInventory.Data[v].PetType
		local def=petmodu[name].DefaultHunger
		local per=math.ceil(obf/def*100)
		if per <= 20 then
			repeat wait()
				CollectFood()
				wait(2.1)
				for _,fruit in pairs(plr.Backpack:GetChildren()) do
					if fruit:HasTag("FruitTool") and not fruit:GetAttribute("d") and CheckNoFavorite(fruit) and table.find(getgenv().Config.PetFood,fruit:GetAttribute("f")) then
						plr.Character.Humanoid:EquipTool(fruit)
						wait()
						local args = {
							[1] = "Feed",
							[2] = v
						}
						
						game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("ActivePetService"):FireServer(unpack(args))							
	
						if math.ceil(DataPlayer.PetsData.PetInventory.Data[v].PetData.Hunger/def*100) >= 80 then
							break
						end
						if not getgenv().Config.AutoFeed then
							return false
						end
					end
				end
			until math.ceil(DataPlayer.PetsData.PetInventory.Data[v].PetData.Hunger/def*100) >= 80 or not getgenv().Config.AutoFeed
		end
		if not getgenv().Config.AutoFeed then
			return false
		end
	end
end

-- Auto Favorite

function FavoriteFruit()
    for i,v in pairs(plr.Backpack:GetChildren()) do
        if not v:GetAttribute("d") then     
            if v:GetAttribute("f") and table.find(getgenv().Config.FruitFavorite,v:GetAttribute("f")) and CheckFav(v) then       
                game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Favorite_Item"):FireServer(v)
            end
        end
    end
end 

-- Egg
function TryPlaceEgg(tool)
    if (plr.Character.HumanoidRootPart.Position-seedpos).Magnitude <= 50 then
        for _, plot in pairs(MyFarm.Important.Plant_Locations:GetChildren()) do
            if not plot:IsA("BasePart") then continue end
            if not tool or CountPhysical("PetEgg") >= DataPlayer.PetsData.MutableStats.MaxEggsInFarm or not getgenv().Config.AutoEgg then
                break
            end

            local cf = plot.CFrame
            local fx = math.round(plot.Size.X / 2)
            local fz = math.round(plot.Size.Z / 2)

            for z = -fz, fz do
                for x = -fx, fx do
                    if tool.Parent == game.Players.LocalPlayer.Backpack then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                    end
                    local pos = Vector3.new(cf.X - x, 0.1355254054069519, cf.Z - z)
                    wait()

                    game.ReplicatedStorage.GameEvents.PetEggService:FireServer("CreateEgg", pos)

                    if not tool or CountPhysical("PetEgg") >= DataPlayer.PetsData.MutableStats.MaxEggsInFarm or not getgenv().Config.AutoEgg or (tool.Parent ~= game.Players.LocalPlayer.Character and tool.Parent ~= game.Players.LocalPlayer.Backpack) then
                        break
                    end

                    wait()
                end
                if not tool or CountPhysical("PetEgg") >= DataPlayer.PetsData.MutableStats.MaxEggsInFarm or not getgenv().Config.AutoEgg or (tool.Parent ~= game.Players.LocalPlayer.Character and tool.Parent ~= game.Players.LocalPlayer.Backpack) then
                    break
                end
            end
        end
    else
        plr.Character.HumanoidRootPart.CFrame=CFrame.new(seedpos)*CFrame.new(0,5,0)
    end
end

function Auto_Egg()
	if CountPhysical("PetEgg") >= DataPlayer.PetsData.MutableStats.MaxEggsInFarm then return end

	for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if string.find(tool.Name, "Egg") and tool:GetAttribute("ITEM_TYPE")=="PetEgg" then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
			repeat
				TryPlaceEgg(tool)
			until not tool or CountPhysical("PetEgg") >= DataPlayer.PetsData.MutableStats.MaxEggsInFarm or not getgenv().Config.AutoEgg or (tool.Parent ~= game.Players.LocalPlayer.Character and tool.Parent ~= game.Players.LocalPlayer.Backpack)
		end
	end

	for _, tool in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if string.find(tool.Name, "Egg") and tool:GetAttribute("ITEM_TYPE")=="PetEgg" then
			repeat
				TryPlaceEgg(tool)
			until not tool or CountPhysical("PetEgg") >= DataPlayer.PetsData.MutableStats.MaxEggsInFarm or not getgenv().Config.AutoEgg or tool.Parent ~= game.Players.LocalPlayer.Character
		end
	end
end

function HatchEgg()
	for i,v in pairs(MyFarm.Important.Objects_Physical:GetDescendants()) do
		if v.Name=="ProximityPrompt" and v.Enabled then
			pcall(function()
				fireproximityprompt(v,1,true)
			end)
		end
	end
end

function group_numbers(numbers, min_sum)
	min_sum=min_sum or 10
    table.sort(numbers, function(a, b) return a > b end)

    local used = {}
    local groups = {}

    for i = 1, #numbers do
        if not used[i] then
            local sum = numbers[i]
            local group = {numbers[i]}
            used[i] = true

            for j = #numbers, 1, -1 do
                if not used[j] and sum < min_sum then
                    sum = sum + numbers[j]
                    table.insert(group, numbers[j])
                    used[j] = true
                end
            end

            if sum >= min_sum then
                table.insert(groups, group)
            else
                for _, v in ipairs(group) do
                    for idx, num in ipairs(numbers) do
                        if num == v and used[idx] then
                            used[idx] = false
                            break
                        end
                    end
                end
            end
        end
    end

    return #groups
end

-- GUI


local Sawhub= SawUI:CreateWindow({title="Saw Hub"})
local HomeTab=Sawhub:CreatePage({title="Home"})
local StatusSec=HomeTab:CreateSection({title="Status"})
local PointMoonlit=StatusSec:CreateLabel({title="Honey: None"})
StatusSec:CreateLabel({title="Version Place: "..game.PlaceVersion})
local PointMoonConfig=PointMoonlit:EnableConfig()
local tmp=PointMoonConfig:CreateSection({title="Setting"})
tmp:CreateSlider({title="Delay Update",Min=1,Precise=getgenv().Config.DelayMoonlit or 10,Max=600,callback=function(v)
	getgenv().Config.DelayMoonlit=v
end})
StatusSec:CreateToggle({title="Click To get Values Fruit",default=getgenv().Config.ClickToGetValues,callback=function(v)
	getgenv().Config.ClickToGetValues= v
end})

local AutoCollectSec=HomeTab:CreateSection({title="Farm"})

local tmp1=AutoCollectSec:CreateToggle({title="Auto Collect",default=getgenv().Config.AutoCollect,callback=function(v)
	getgenv().Config.AutoCollect= v
end})
AutoCollectSec:CreateToggle({title="Auto Sell",default=getgenv().Config.AutoSell,callback=function(v)
	getgenv().Config.AutoSell= v
end})
AutoCollectSec:CreateSlider({title="Time Sell (s)",Min=60,Max=1800,Precise=getgenv().Config.TimeSell or 600,callback=function(v)
	getgenv().Config.TimeSell=v
end})
AutoCollectSec:CreateSlider({title="Time Collect (s)",Min=5,Max=10800,Precise=getgenv().Config.TimeCollect or 5,callback=function(v)
	getgenv().Config.TimeCollect=v
end})
AutoCollectSec:CreateSlider({title="Backpack Sell (Item)",Min=1,Max=199,Precise=getgenv().Config.BackpackSell or 199,callback=function(v)
	getgenv().Config.BackpackSell=v
end})

local tmp1Configs=tmp1:EnableConfig()

local FarmChoose=tmp1Configs:CreateSection({title="Farming"})
FarmChoose:CreateDropdown({title="Fruit Collect",list=allseeds,default=getgenv().Config.FruitCollect or {},multi=true,callback=function(v)
	getgenv().Config.FruitCollect=v
end})

FarmChoose:CreateDropdown({title="Mutations Collect",list=allmuta,default=getgenv().Config.MutationsCollect or {},multi=true,callback=function(v)
	getgenv().Config.MutationsCollect=v
end})
FarmChoose:CreateDropdown({title="Collect Method",list={"Single","Multi"},default={getgenv().Config.CollectMethod or "Single"},multi=false,callback=function(v)
	getgenv().Config.CollectMethod=v
end})

local FastCollectSec=tmp1Configs:CreateSection({title="Fast Collect"})
FastCollectSec:CreateDropdown({title="Fruit Collect",list=allseeds,default=getgenv().Config.FruitCollectFast or {},multi=true,callback=function(v)
	getgenv().Config.FruitCollectFast=v
end})
FastCollectSec:CreateDropdown({title="Mutations Collect",list=allmuta,default=getgenv().Config.MutationsCollectFast or {},multi=true,callback=function(v)
	getgenv().Config.MutationsCollectFast=v
end})
FastCollectSec:CreateDropdown({title="Collect Method",list={"Single","Multi"},default={getgenv().Config.CollectMethodFast or "Single"},multi=false,callback=function(v)
	getgenv().Config.CollectMethodFast=v
end})

AutoCollectSec:CreateSlider({title="Max Weight",Min=1,Max=15,Precise=getgenv().Config.MaxWeight or 5,callback=function(v)
	getgenv().Config.MaxWeight=v
end})

local SeedSec=HomeTab:CreateSection({title="Put"})
local tmp2=SeedSec:CreateToggle({title="Auto Put Seeds",default=getgenv().Config.AutoPuts,callback=function(v)
	getgenv().Config.AutoPuts=v    
end})
local tmp2Configs=tmp2:EnableConfig()
local PutSeedConfig=tmp2Configs:CreateSection({title="Choose Seed"})
PutSeedConfig:CreateDropdown({title="Seeds Put",list=allseeds,default=getgenv().Config.SeedPut,multi=true,callback=function(v)
	getgenv().Config.SeedPut=v
end})
local PetsTab=Sawhub:CreatePage({title="Pets"})
local EggSec=PetsTab:CreateSection({title="Egg"})
EggSec:CreateToggle({title="Auto Egg",default=getgenv().Config.AutoEgg,callback=function(v)
	getgenv().Config.AutoEgg=v    
	spawn(function()
		while wait(.5) and getgenv().Config.AutoEgg do
			HatchEgg()
		end
	end)
end})
local PetSec=PetsTab:CreateSection({title="Pets"})

PetSec:CreateDropdown({title="Select SELL Pet",list=allpets,default=getgenv().Config.PetDelete,multi=true,callback=function(v)
	getgenv().Config.PetDelete=v
end})
PetSec:CreateToggle({title="Auto Sell Pet",default=getgenv().Config.AutoDeletePet,callback=function(v)
	getgenv().Config.AutoDeletePet= v
end})

PetSec:CreateDropdown({title="Pet Food",list=allseeds,default=getgenv().Config.PetFood,multi=true,callback=function(v)
	getgenv().Config.PetFood=v
end})
PetSec:CreateToggle({title="Auto Feed",default=getgenv().Config.AutoFeed,callback=function(v)
	getgenv().Config.AutoFeed=v    
end})

PetSec:CreateSlider({title="Feed Delay (min)",Min=1,Max=60,Precise=getgenv().Config.FeedDelay or 10,callback=function(v)
	getgenv().Config.FeedDelay=v
end})


local ItemsTab=Sawhub:CreatePage({title="Items"})

local FavoriteSec=ItemsTab:CreateSection({title="Favorite"})
local tmp3=FavoriteSec:CreateToggle({title="Auto Favorite",default=getgenv().Config.AutoFavorite,callback=function(v)
	getgenv().Config.AutoFavorite=v    
    spawn(function()
        while task.wait(1) and getgenv().Config.AutoFavorite do
            FavoriteFruit()
        end
    end)
end})
FavoriteSec:CreateDropdown({title="Fruit Favorite",list=allseeds,default=getgenv().Config.FruitFavorite,multi=true,callback=function(v)
	getgenv().Config.FruitFavorite=v
end})
FavoriteSec:CreateDropdown({title="Mutation Favorite",list=allmuta,default=getgenv().Config.MutationFavorite,multi=true,callback=function(v)
	getgenv().Config.MutationFavorite=v
end})

FavoriteSec:CreateDropdown({title="Favorite Method",list={"Single","Multi"},default={getgenv().Config.FavoriteMethod or "Single"},multi=false,callback=function(v)
	getgenv().Config.FavoriteMethod=v
end})

FavoriteSec:CreateButton({title="Unlock Moonlit",callback=function()
	spawn(function()
		UnLock_Moonlit()
	end)
end})

local heli=0

local seeditem=ItemsTab:CreateSection({title="Seeds"})
seeditem:CreateDropdown({title="Seed Remove",list=allseeds,default=getgenv().Config.FruitDestroy,multi=true,callback=function(v)
	getgenv().Config.FruitDestroy=v
end})

seeditem:CreateButton({title="Remove Seed",callback=function()
	for i ,v in pairs(MyFarm.Important.Plants_Physical:GetChildren()) do
		if table.find(getgenv().Config.FruitDestroy or {},v.Name) then
			for _,part in v:GetChildren() do
				if part:IsA("BasePart") then
					game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Remove_Item"):FireServer(part)
				end
			end
		end
	end
end})


function Get_Item(typ)
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:GetAttribute("ITEM_TYPE") ==typ then
            return v
        end
    end
    if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):GetAttribute("ITEM_TYPE")==typ then
            return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        end
    end
    return false
end

function NuocDai(cay)
    local water_can=Get_Item("Watering Can")
    if water_can then
        if water_can.Parent==game.Players.LocalPlayer.Backpack then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(water_can)
        end
        if cay:FindFirstChild("1") then
            local pos = Vector3.new(cay["1"].Position.X,0.13552704453468323,cay["1"].Position.Z)
            game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Water_RE"):FireServer(pos)
        end
    end
end

function Auto_dai()
    if Get_Item("Watering Can") then
        for i,v in pairs(MyFarm.Important.Plants_Physical:GetChildren()) do
            if v.Grow.Age.Value/v:GetAttribute("MaxAge")*100 < 99 then
                repeat wait()
                    print(v.Name)
                    NuocDai(v)
                until not Get_Item("Watering Can") or v.Grow.Age.Value/v:GetAttribute("MaxAge")*100 >= 99
            end
        end
    end
end

local UseSec=ItemsTab:CreateSection({title="Use"})
UseSec:CreateToggle({title="Auto Watering Can",default=getgenv().Config.WateringCan,callback=function(cc)
	getgenv().Config.WateringCan=cc
end})
UseSec:CreateToggle({title="Open Crafters Seed Pack",default=getgenv().Config.NightSeedPack,callback=function(v)
	getgenv().Config.NightSeedPack=v
end})

UseSec:CreateToggle({title="Auto Feed Honey",default=getgenv().Config.AutoHoney,callback=function(v)
	getgenv().Config.AutoHoney=v
	spawn(function()
		while wait(.1) and getgenv().Config.AutoHoney do
			if workspace.HoneyEvent.HoneyCombpressor.Spout.Jar:FindFirstChild("HoneyCombpressorPrompt") then
				proxy=workspace.HoneyEvent.HoneyCombpressor.Spout.Jar:FindFirstChild("HoneyCombpressorPrompt")
				if proxy.Enabled then
					game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("HoneyMachineService_RE"):FireServer("MachineInteract")
				end
			end
			if workspace.HoneyEvent.HoneyCombpressor.Onett:FindFirstChild("HoneyCombpressorPrompt") then
				proxy=workspace.HoneyEvent.HoneyCombpressor.Onett:FindFirstChild("HoneyCombpressorPrompt")
				if proxy.Enabled then
					local target = GetHighPoint({})
					if target then
						if target:GetAttribute("d") then
							game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Favorite_Item"):FireServer(target)
							wait(.1)
						end
						game.Players.LocalPlayer.Character.Humanoid:EquipTool(target)
						wait(.1)
						game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("HoneyMachineService_RE"):FireServer("MachineInteract")
						wait(.5)
					end
				end
			end
		end
	end)
end})

UseSec:CreateToggle({title="Auto Craft Pack",default=getgenv().Config.CrafterPack,callback=function(v)
	getgenv().Config.CrafterPack=v
	spawn(function()
		while wait(.1) and getgenv().Config.CrafterPack do

			local pro= workspace.Interaction.UpdateItems.NewCrafting.SeedEventCraftingWorkBench.SeedEventCraftingWorkBench.Model.BenchTable:FindFirstChild("CraftingProximityPrompt")

			if pro and pro.Enabled and pro.ActionText~="Skip" and pro.ActionText~="Claim" then
				if pro.ActionText=="Select Recipe" then

					local args = {
						[1] = "SetRecipe",
						[2] = workspace:WaitForChild("Interaction"):WaitForChild("UpdateItems"):WaitForChild("NewCrafting"):WaitForChild("SeedEventCraftingWorkBench"),
						[3] = "SeedEventWorkbench",
						[4] = "Crafters Seed Pack"
					}

					game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))
				end
				
				local opend=false
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v:IsA("Tool") and v:GetAttribute("n") and v:GetAttribute("n")=="Flower Seed Pack" then
						local args = {
							[1] = "InputItem",
							[2] = workspace:WaitForChild("Interaction"):WaitForChild("UpdateItems"):WaitForChild("NewCrafting"):WaitForChild("SeedEventCraftingWorkBench"),
							[3] = "SeedEventWorkbench",
							[4] = 1,
							[5] = {
								["ItemType"] = "Seed Pack",
								["ItemData"] = {
									["UUID"] = v:GetAttribute("c")
								}
							}
						}
						game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))
						opend=true
						break
					end
				end

				if not opend then
					for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
						if v:IsA("Tool") and v:GetAttribute("n") and v:GetAttribute("n")=="Flower Seed Pack" then
							local args = {
								[1] = "InputItem",
								[2] = workspace:WaitForChild("Interaction"):WaitForChild("UpdateItems"):WaitForChild("NewCrafting"):WaitForChild("SeedEventCraftingWorkBench"),
								[3] = "SeedEventWorkbench",
								[4] = 1,
								[5] = {
									["ItemType"] = "Seed Pack",
									["ItemData"] = {
										["UUID"] = v:GetAttribute("c")
									}
								}
							}
							game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))
							break
						end
					end
				end
				


				local args = {
					[1] = "Craft",
					[2] = workspace:WaitForChild("Interaction"):WaitForChild("UpdateItems"):WaitForChild("NewCrafting"):WaitForChild("SeedEventCraftingWorkBench"),
					[3] = "SeedEventWorkbench"
				}

				game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))
			elseif pro and pro.Enabled and pro.ActionText=="Claim" then

				fireproximityprompt(pro)
			end
		end
	end)
end})

local PlayerTab=Sawhub:CreatePage({title="Players"})
local Tradesec=PlayerTab:CreateSection({title="Trade"})
local selectplayer
local function resetplayer()
	local bucu={}
	for i,v in pairs(game.Players:GetChildren()) do
		if v.Name ~= plr.Name then
			table.insert(bucu,v.Name)
		end
	end
	return bucu
end
local selectplr=Tradesec:CreateDropdown({title="Select Players",list={},callback=function(v)
	selectplayer=v
end})
Tradesec:CreateButton({title="Refesh Players",callback=function(v)
	selectplr:New(resetplayer())
end})
Tradesec:CreateSlider({title="Honey Point",Min=0,Max=1000,Precise=getgenv().Config.MoonlitPointTrade or 0,callback=function(v)
	getgenv().Config.MoonlitPointTrade=v
end})
local delaytrade=5
Tradesec:CreateSlider({title="Delay Trade",Min=0,Max=10,Precise=5,callback=function(v)
	delaytrade=v
end})

function GetHighPoint(blacklist)
	local min=0
	local target
	for i,v in pairs(plr.Backpack:GetChildren()) do
		if v:GetAttribute("Pollinated") and v:FindFirstChild("Weight") and not table.find(blacklist,v) then
			if v.Weight.Value > min then
				min=v.Weight.Value
				target=v
			end
		end
	end
	return target
end

function get_point(max)
	local out={}
	local count=0
	while count < max do
		local target=GetHighPoint(out)
		if not target then
			break
		end
		if target then
			table.insert(out,target)
			count=count+math.min(target.Weight.Value,10)
		end
	end

	return out
end
Tradesec:CreateButton({title="Trade",callback=function()
	if selectplayer and game.Players:FindFirstChild(selectplayer) and game.Players[selectplayer].Character and game.Players[selectplayer].Character:FindFirstChild("HumanoidRootPart") then
		for i,v in pairs(get_point(getgenv().Config.MoonlitPointTrade)) do
			if selectplayer and game.Players:FindFirstChild(selectplayer) and game.Players[selectplayer].Character and game.Players[selectplayer].Character:FindFirstChild("HumanoidRootPart") then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
				wait(.1)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[selectplayer].Character.HumanoidRootPart.CFrame
				wait(.05)
				fireproximityprompt(game.Players[selectplayer].Character.HumanoidRootPart.ProximityPrompt,1,true)
				wait(delaytrade/10)
			else
				Sawhub:Notify("Can't find player",{color=Theme.Error})
				break
			end
		end
	else
		Sawhub:Notify("Can't find player",{color=Theme.Error})
	end
end})

local PurchaseTab=Sawhub:CreatePage({title="Purchase"})
local eventpursec=PurchaseTab:CreateSection({title="Event"})
eventpursec:CreateToggle({title="Auto Reset Event",default=getgenv().Config.AutoResetEvent,callback=function(v)
	getgenv().Config.AutoResetEvent = v
	spawn(function()
		while wait(.5) and getgenv().Config.AutoResetEvent do
			if DataPlayer.NightQuestData.Experience >= 530 and DataPlayer.Sheckles >= 500000000 then
				local args = {
					[1] = "ResetQuestData"
				}
				
				game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("NightQuestRemoteEvent"):FireServer(unpack(args))
				wait(1)
			end
		end
	end)
end})

local ModuleSeeds=require(game:GetService("ReplicatedStorage").Data.SeedData)
local seedpursec=PurchaseTab:CreateSection({title="Seed"})

seedpursec:CreateToggle({title="Auto Buy Seeds",default=getgenv().Config.AutoBuySeeds,callback=function(v)
	getgenv().Config.AutoBuySeeds = v
	spawn(function()
		while wait(.1) and getgenv().Config.AutoBuySeeds do
			for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Seed_Shop.Frame.ScrollingFrame:GetChildren()) do
				if v:IsA("Frame") and not string.find(v.Name,"Padding") then
					if v.Main_Frame.Cost_Text.Text ~="NO STOCK" and table.find(getgenv().Config.Seeds or {},v.Name) and plr.leaderstats.Sheckles.Value >=  ModuleSeeds[v.Name].Price then
						Sawhub:Notify("Successfully purchased ["..v.Name.." Seed]")
                        if getgenv().Config.SeedNotify then
                            WebhookReward(v.Name.." Seed",GetAsset("Seed",v.Name))
                        end
						local args = {
							[1] = v.Name
						}
						
						game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(unpack(args))
						wait(.5)
					end
				end
			end
		end
	end)
end})

local seedshoplist={}

for i,v in pairs(require(game:GetService("ReplicatedStorage").Data.SeedData)) do
    if v.DisplayInShop then
        table.insert(seedshoplist,i)
    end
end

seedpursec:CreateDropdown({title="Select Seeds",list=seedshoplist,default=getgenv().Config.Seeds or {},multi=true,callback=function(v)
	getgenv().Config.Seeds=v
end})

local moduleegg=require(game:GetService("ReplicatedStorage").Data.PetEggData)
local eggpursec =PurchaseTab:CreateSection({title="Egg"})
eggpursec:CreateToggle({
	title = "Auto Buy Egg",
	default = getgenv().Config.AutoBuyEgg,
	callback = function(enabled)
		getgenv().Config.AutoBuyEgg = enabled

		if not enabled then return end

		task.spawn(function()
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local DataService = require(ReplicatedStorage.Modules.DataService)
			local PetEggStock = DataService:GetData()
			local BuyPetEggEvent = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyPetEgg")
			local player = game.Players.LocalPlayer
			local sheckles = player.leaderstats.Sheckles

			while getgenv().Config.AutoBuyEgg do
				for id, egg in pairs(PetEggStock.PetEggStock.Stocks) do
					pcall(function()
						local eggName = egg.EggName
						local eggPrice = moduleegg[eggName] and moduleegg[eggName].Price or math.huge
	
						if table.find(getgenv().Config.BuyEggSlot or {}, eggName) and egg.Stock > 0 and sheckles.Value >= eggPrice then
							Sawhub:Notify("Successfully purchased [" .. eggName .. "]")
                            if getgenv().Config.EggNotify then
                                WebhookReward(eggName,"rbxassetid://94632832798803")
                            end
							BuyPetEggEvent:FireServer(id)
							task.wait(0.5)
						end
					end)
					
				end
				task.wait(0.1)
			end
		end)
	end
})
local alleggs={}
for i,v in pairs(moduleegg) do
	table.insert(alleggs,i)
end
table.sort(alleggs)
eggpursec:CreateDropdown({title="Select Egg",list=alleggs,default=getgenv().Config.BuyEggSlot or {},multi=true,callback=function(v)
	getgenv().Config.BuyEggSlot=v
end})


local gearpursec=PurchaseTab:CreateSection({title="Gear"})
gearpursec:CreateToggle({title="Auto Buy Gears",default=getgenv().Config.AutoBuyGears,callback=function(v)
	getgenv().Config.AutoBuyGears = v
	spawn(function()
		while wait(.1) and getgenv().Config.AutoBuyGears do
			for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Gear_Shop.Frame.ScrollingFrame:GetChildren()) do
				if v:IsA("Frame") and not string.find(v.Name,"Padding") then
					if v.Main_Frame.Cost_Text.Text ~="NO STOCK" and table.find(getgenv().Config.Gears or {},v.Name) and plr.leaderstats.Sheckles.Value >=  ModuleGears[v.Name].Price then
						Sawhub:Notify("Successfully purchased ["..v.Name.."]")
                        if getgenv().Config.GearNotify then
                            WebhookReward(v.Name,GetAsset("Gear",v.Name))
                        end
						local args = {
							[1] = v.Name
						}
						
						game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer(unpack(args))
						wait(.5)
					end
				end
			end
		end
	end)
end})
local allgeears={}

for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Gear_Shop.Frame.ScrollingFrame:GetChildren()) do
	if v:IsA("Frame") and not string.find(v.Name,"Padding") then
		table.insert(allgeears,v.Name)
	end
end
table.sort(allgeears)
--"Basic Sprinkler","Godly Sprinkler","Master Sprinkler","Advanced Sprinkler"
gearpursec:CreateDropdown({title="Select Gears",list=allgeears,default=getgenv().Config.Gears or {},multi=true,callback=function(v)
	getgenv().Config.Gears=v
end})

local WebhookTab=Sawhub:CreatePage({title="Webhook"})
local Discordsec=WebhookTab:CreateSection({title="Discord"})
Discordsec:CreateTextbox({title="Webhook Url",default=getgenv().Config.WebhookUrl,callback=function(v)
    getgenv().Config.WebhookUrl=v
end})
Discordsec:CreateToggle({title="Open Egg Notify",default=getgenv().Config.OpenEggNotify,callback=function(v)
	getgenv().Config.OpenEggNotify=v
end})
Discordsec:CreateToggle({title="Buy Seed Notify",default=getgenv().Config.SeedNotify,callback=function(v)
	getgenv().Config.SeedNotify=v
end})
Discordsec:CreateToggle({title="Buy Egg Notify",default=getgenv().Config.EggNotify,callback=function(v)
	getgenv().Config.EggNotify=v
end})
Discordsec:CreateToggle({title="Buy Gear Notify",default=getgenv().Config.GearNotify,callback=function(v)
	getgenv().Config.GearNotify=v
end})
local SettingTab=Sawhub:CreatePage({title="Settings"})

local humanoidsec=SettingTab:CreateSection({title="Humanoid"})
local org_speed=32
humanoidsec:CreateToggle({title="Buff Walkspeed",default=getgenv().Config.Walkspeed,callback=function(v)
	getgenv().Config.Walkspeed=v
	spawn(function()
		if getgenv().Config.Walkspeed then
			org_speed=game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
			while wait(.1) and getgenv().Config.Walkspeed do
				pcall(function()
					game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=org_speed+getgenv().Config.WalkspeedVal
				end)
			end
		else
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=org_speed
		end
	end)
end})
humanoidsec:CreateSlider({title="Walkspeed",Min=10,Max=1000,Precise=getgenv().Config.WalkspeedVal or 20,callback=function(v)
	getgenv().Config.WalkspeedVal=v
end})
local Teleportsec=SettingTab:CreateSection({title="Teleport"})

Teleportsec:CreateButton({title="Copy JobID",callback=function()
    setclipboard(game.JobId)
end})
local idjoin
Teleportsec:CreateTextbox({title=" JobID",callback=function(v)
    idjoin=v
end})
Teleportsec:CreateButton({title="Join",callback=function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,idjoin, game.Players.LocalPlayer)
end})
local othersec=SettingTab:CreateSection({title="Others"})
othersec:CreateSlider({title="Lock Fps",Min=5,Precise=getgenv().Config.FpsCap or 120,Max=999,callback=function(v)
	getgenv().Config.FpsCap=v
	setfpscap(v)
end})
othersec:CreateToggle({title="Set Fps",default=getgenv().Config.LockFps,callback=function(v)
	getgenv().Config.SetFps=v
	spawn(function()
		while wait() and getgenv().Config.SetFps do
			setfpscap(getgenv().Config.FpsCap)
			wait(10)
		end
	end)
end})

function Convert_value(val)
    if type(val) == "table" then
        local str_list = {}
        for _, v in ipairs(val) do
            table.insert(str_list, '"' .. tostring(v) .. '"')
        end
        return "{" .. table.concat(str_list, ", ") .. "}"
    elseif type(val) == "string" then
        return '"' .. val .. '"'
    end
    return tostring(val)
end

othersec:CreateButton({title="Copy Config",callback=function()
    local save_configs = "getgenv().Config = {\n    "
    for i, v in pairs(getgenv().Config) do
        if type(i) == "string" then
            save_configs = save_configs .. "[" .. '"' .. i .. '"' .. "] = " .. Convert_value(v) .. ",\n    "
        else
            save_configs = save_configs .. "[" .. tostring(i) .. "] = " .. Convert_value(v) .. ",\n    "
        end
    end
    save_configs = save_configs:sub(1, -6) .. "\n}"
    setclipboard(save_configs)
end})
-- While func
-- spawn(function()
-- 	while wait() do

-- 		local out={}

-- 		for i,v in pairs(plr.Backpack:GetChildren()) do
-- 			if v:GetAttribute("Pollinated") and v:FindFirstChild("Weight") then
-- 				table.insert(out,v.Weight.Value)
-- 			end
-- 		end
-- 		for i,v in pairs(Get_Fruit()) do
-- 			if v:GetAttribute("Pollinated") then
-- 				if v:FindFirstChild("Weight") then
-- 					table.insert(out,v.Weight.Value)
-- 				end
-- 			end
-- 		end

-- 		local count=group_numbers(out)
-- 		PointMoonlit:Set("Honey: "..count*10)
-- 		wait(getgenv().Config.DelayMoonlit)
-- 	end
-- end)

local mouse = game.Players.LocalPlayer:GetMouse()

UIS.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and getgenv().Config.ClickToGetValues then
		local get_fruit = mouse.Target
		if not get_fruit.Parent:IsA("Model") then
			get_fruit=get_fruit.Parent
		end
		if get_fruit and get_fruit.Parent and get_fruit.Parent:IsA("Model") and get_fruit.Parent:FindFirstChild("Weight") then
			local huhe=get_fruit.Parent.Name..": "..formatNumberWithCommas(CalcPlantVal(get_fruit.Parent)).."$"

			spawn(function()
				Sawhub:Notify(huhe)
			end)
		end
	end
end)

local function run_pcall(callback)
	local suc, err = pcall(function()
		callback()
	end)
	if not suc then
		print(err)
	end
end

local knownPets = {}

for i,v in pairs(DataPlayer.PetsData.PetInventory.Data) do
    knownPets[i]=true
end


local function UpdatePetList()
    local current = {}

    for id, pet in pairs(DataPlayer.PetsData.PetInventory.Data) do
        current[id] = true
        if not knownPets[id] then


            local petname=pet.PetType.." ["..round(pet.PetData.BaseWeight,2).."kg] [Age "..pet.PetData.Level.."]"
            if getgenv().Config.OpenEggNotify then
                WebhookReward(petname,GetAsset("Pet",pet.PetType))
            end
            knownPets[id] = true
        end
    end

    for id in pairs(knownPets) do
        if not current[id] then
            knownPets[id] = nil
        end
    end
end

local function CheckNewPets()
    for id, pet in pairs(DataPlayer.PetsData.PetInventory.Data) do
        if not knownPets[id] then
            
            knownPets[id] = true
        end
    end
end

task.spawn(function()
    while true do
        UpdatePetList()
        task.wait(1.5)
    end
end)

local LP = game.Players.LocalPlayer
function getRoot(char)
	if char then
		local rootPart = char:FindFirstChild('HumanoidRootPart')
		return rootPart
	end
	return false
end

function TweenFloat()
	if getRoot(LP.Character) then
		if not getRoot(LP.Character):FindFirstChild("VelocityBody") then
			local BV = Instance.new("BodyVelocity")
			BV.Parent = getRoot(LP.Character)
			BV.Name = "VelocityBody"
			BV.MaxForce = Vector3.new(100000, 100000, 100000)
			BV.Velocity = Vector3.new(0, 0, 0)
		end
	end
end
function RemoveFloat()
	if getRoot(LP.Character) then
		if getRoot(LP.Character):FindFirstChild("VelocityBody") then
			getRoot(LP.Character).VelocityBody:Destroy()
		end
	end
end
game:GetService('RunService').Stepped:Connect(function()
	if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') and (getgenv().Config.AutoCollect or getgenv().Config.AutoPuts) then
		for k,v in next,game.Players.LocalPlayer.Character:GetChildren() do
			if v:IsA('BasePart') then
				v.CanCollide = false
			end
		end
	end
end)


task.spawn(function()
	while wait(1) do
		if (getgenv().Config.AutoCollect or getgenv().Config.AutoPuts) then
			TweenFloat()
		else

			RemoveFloat()
		end
	end
end)
game:GetService("Players").LocalPlayer.Idled:connect(function()
	game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

game.CoreGui.DescendantAdded:Connect(function()
	pcall(function()
		if game.CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt") then
			while wait() do
				game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
				wait(5)
			end
		end
	end)
end)

spawn(function()
    while wait() do
		if getgenv().Config.AutoCollect then
			run_pcall(function()
				CollectFruitFast()
            end)
		end
        if getgenv().Config.AutoCollect and tick()-tick_out >= getgenv().Config.TimeCollect then
            run_pcall(function()
                CollectFruit()
            end)
            tick_out=tick()
        end
        if getgenv().Config.AutoPuts then
            run_pcall(function()
                Plant_Seed()
            end)
        end
        if getgenv().Config.AutoEgg then
            run_pcall(function()
                Auto_Egg()
            end)
        end

		if getgenv().Config.WateringCan then
			run_pcall(function()
				Auto_dai()
			end)
		end

        if getgenv().Config.AutoFeed then
            run_pcall(function()
                AutoFeed()
            end)
        end
        if getgenv().Config.AutoDeletePet then
			run_pcall(function() Sell_Pet() end)
		end
        if getgenv().Config.NightSeedPack then
			run_pcall(function() OpenNightSeed() end)
		end
        if getgenv().Config.AutoSell then
			run_pcall(function() 
                if ShouldSell() then
                    wait(2.1)
                    SellInventory()
                end
            end)
		end
    end
end)
