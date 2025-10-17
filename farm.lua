
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
		["Name"] = "Window",
		["DisplayOrder"] = 0
	}, game:GetService("CoreGui").RobloxGui or game:GetService("CoreGui"))


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


local PathfindingService = game:GetService("PathfindingService")

function MoveTo2(targetPart)
	local character = plr.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Humanoid") then
		return
	end

	local humanoid = character:FindFirstChild("Humanoid")
	local hrp = character:FindFirstChild("HumanoidRootPart")

	-- Tạo đường đi
	local path = PathfindingService:CreatePath({
		AgentHeight = 5,
		AgentRadius = 2,
		AgentCanJump = true
	})
	path:ComputeAsync(hrp.Position, targetPart.Position)

	if path.Status == Enum.PathStatus.Success then
		local waypoints = path:GetWaypoints()
		for _, waypoint in ipairs(waypoints) do
			humanoid:MoveTo(waypoint.Position)
			humanoid.MoveToFinished:Wait()
		end
	else
		-- Nếu path bị lỗi thì MoveTo thẳng luôn
		humanoid:MoveTo(targetPart.Position)
	end
end
function MoveTo(targetPart)
    local character = plr.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Humanoid") then
        return
    end

    if not CheckInMid() then
        MoveToMiddle()
    end

    local humanoid = character:FindFirstChild("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")

    humanoid:MoveTo(targetPart.Position)
end
function CheckInMid()
    local carpet = workspace.Map.Carpet

    local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

    if root then
        local pos = root.Position
        local cpos = carpet.Position
        local size = carpet.Size / 2

        -- Kiểm tra theo X và Z (bỏ qua Y)
        local insideXZ =
            pos.X >= cpos.X - size.X and pos.X <= cpos.X + size.X and
            pos.Z >= cpos.Z - size.Z and pos.Z <= cpos.Z + size.Z

        if insideXZ then
           return true
        end
    end
    return false
end

function MoveToMiddle()
    local middle = workspace.Map.Carpet
    MoveTo2(middle)
end

local DataGame=require(game:GetService("ReplicatedStorage").Packages.Synchronizer)
local tem000 = require(game:GetService("ReplicatedStorage").Datas.Mutations)
local getmutations={}

for i,v in pairs(tem000) do
    getmutations[i]=v.Modifier
end

if not getgenv().Config then
    getgenv().Config = {}
end
local Animals=require(game:GetService("ReplicatedStorage").Datas.Animals)
local Rebirths=require(game:GetService("ReplicatedStorage").Datas.Rebirth)
local TS = game:GetService("TweenService")
local plr = game:GetService("Players").LocalPlayer
local Mouse = plr:GetMouse()
local UIS = game:GetService("UserInputService")
local Tweeninfo = TweenInfo.new
local vim = game:service('VirtualInputManager')
local TweenService = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
function GetMyBase()
    for i,v in pairs(workspace.Plots:GetChildren()) do
        if v:FindFirstChild("PlotSign") and v.PlotSign.YourBase.Enabled == true then
            return v
        end
    end
end


function LayConNhoNhat()
    local nhonhat=math.huge
    local charpet
    local petcantsell=Rebirths[plr.leaderstats.Rebirths.Value+1].Requirements.RequiredCharacters
    local pethave={}
	local petkothesell=getgenv().Config.PetChoose or {}

    for index,tab in pairs(DataGame:Get(game.Players.LocalPlayer):Get("AnimalPodiums")) do
		if tab~="Empty" then
			
			local animalname=tab.Index
			if table.find(petcantsell,animalname) and not pethave[animalname] then
				pethave[animalname]=true
				continue
			end
			if table.find(petkothesell,animalname) then
				continue
			end
			local animalValue=Animals[animalname].Generation
			if tab.Mutation then
				animalValue=animalValue+(animalValue*getmutations[tab.Mutation])
			end
			if animalValue<=nhonhat then
				nhonhat=animalValue
				charpet=GetMyBase().AnimalPodiums:FindFirstChild(index)
			end
			
		end
    end
    if not charpet then
        return 0,nil
    end

    return nhonhat,charpet
end

function LayConLonNhat()
    local lonnhat=0
    local charpet
    for index,tab in pairs(DataGame:Get(game.Players.LocalPlayer):Get("AnimalPodiums")) do
		if tab~="Empty" then
            local animalname=tab.Index
            local animalValue=Animals[animalname].Generation
            if tab.Mutation then
                animalValue=animalValue+(animalValue*getmutations[tab.Mutation])
            end
            if lonnhat==0 or animalValue>lonnhat then
                lonnhat=animalValue
                charpet=GetMyBase().AnimalPodiums:FindFirstChild(index)
            end
        end
    end
    return lonnhat,v
end

function LaySoLuong()
    local nhonhat=0
    for index,tab in pairs(DataGame:Get(game.Players.LocalPlayer):Get("AnimalPodiums")) do
		if tab~="Empty" then
            nhonhat=nhonhat+1
        end
    end
    return nhonhat
end

function LayAllPetCo()
    local pethave={}
    for i,v in pairs(GetMyBase().AnimalPodiums:GetChildren()) do
        if v.Base.Spawn:FindFirstChild("Attachment") then
            table.insert(pethave,v.Base.Spawn.Attachment.AnimalOverhead.DisplayName.Text)
        end
    end
    return pethave
end

function SellNhonhat()
    local nhonhat,charpet=LayConNhoNhat()
	print(charpet)
    if charpet==nil then
        return
    end
	pcall(function()
		local namepet=charpet.Base.Spawn.Attachment.AnimalOverhead.DisplayName.Text
		local mutation=nil
		if charpet.Base.Spawn.Attachment.AnimalOverhead.Mutation.Visible then
			mutation=charpet.Base.Spawn.Attachment.AnimalOverhead.Mutation.Text
		end
		
	end)
    print(charpet)
	local args = {
		[1] = tonumber(charpet.Name)
	}

	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/PlotService/Sell"):FireServer(unpack(args))
end

function GetPetDaChon()
    local petneed=getgenv().Config.PetChoose or {}

    local CashValue=plr.leaderstats.Cash.Value

    for i,v in pairs(workspace:GetChildren()) do
        if v:GetAttribute("Index") and table.find(petneed,v:GetAttribute("Index")) and plr.leaderstats.Cash.Value >= Animals[v:GetAttribute("Index")].Price then
			if getgenv().Config.MutationChoose and #getgenv().Config.MutationChoose>0 then
				if v:GetAttribute("Mutation") and table.find(getgenv().Config.MutationChoose,v:GetAttribute("Mutation")) then
					return v
				elseif not v:GetAttribute("Mutation") and table.find(getgenv().Config.MutationChoose,"Normal") then
					return v
				end
			else
				return v
			end
		end
	end
	return false
end

function MuaPetDaChon()
    while wait() do
		local v=GetPetDaChon()
		if v and v:FindFirstChild("HumanoidRootPart") and plr.leaderstats.Cash.Value >= Animals[v:GetAttribute("Index")].Price then
			if LaySoLuong() >= #GetMyBase().AnimalPodiums:GetChildren() then
				SellNhonhat()

			end
			MoveTo(v.HumanoidRootPart)
			local prompt=v.Part.PromptAttachment.ProximityPrompt
			prompt:InputHoldBegin()
			task.wait(prompt.HoldDuration)
			prompt:InputHoldEnd()
			wait(0.1)
			if not v or v.HumanoidRootPart.PromptAttachment.ProximityPrompt:GetAttribute("TargetPlayer") == plr.UserId then
				
				break
			end
		else
			break
		end
	end
--	MoveTo(GetMyBase().AnimalTarget)
end

function GetPetRebirth()
    local petneed=Rebirths[plr.leaderstats.Rebirths.Value+1].Requirements.RequiredCharacters

    local pethave=LayAllPetCo()
    for i,v in pairs(pethave) do
        print(i,v)
    end
    local CashValue=plr.leaderstats.Cash.Value

    for i,v in pairs(workspace:GetChildren()) do
        if v:GetAttribute("Index") and table.find(petneed,v:GetAttribute("Index")) and not table.find(pethave,v:GetAttribute("Index")) and plr.leaderstats.Cash.Value >= Animals[v:GetAttribute("Index")].Price then
			return v
		end
	end
	return false
end

function MuaPetRebirth()
    while wait() do
		local v=GetPetRebirth()
		if v and v:FindFirstChild("Part") and plr.leaderstats.Cash.Value >= Animals[v:GetAttribute("Index")].Price  and v.Part.PromptAttachment.ProximityPrompt:GetAttribute("TargetPlayer") ~= plr.UserId then
			if LaySoLuong() >= #GetMyBase().AnimalPodiums:GetChildren() then
				SellNhonhat()

			end
			MoveTo(v.Part)
			local prompt=v.Part.PromptAttachment.ProximityPrompt
			prompt:InputHoldBegin()
			task.wait(prompt.HoldDuration)
			prompt:InputHoldEnd()
			wait(0.1)
			
		else
			break
		end
	end
--	MoveTo(GetMyBase().AnimalTarget)
end

function GetConManhHon()
    local CashValue=plr.leaderstats.Cash.Value
    local conlonnhat,charpet1=LayConLonNhat()
    local connhonhat,charpet2=LayConNhoNhat()

    local consechon
    local speedgen=connhonhat

    for i,v in pairs(workspace:GetChildren()) do
        if not v:GetAttribute("Index") or not v:FindFirstChild("Part") or v.Part.PromptAttachment.ProximityPrompt:GetAttribute("TargetPlayer") == plr.UserId  then
            continue
        end
        local animalvalue = Animals[v:GetAttribute("Index")].Generation
        local animalcash=Animals[v:GetAttribute("Index")].Price
        if v:GetAttribute("Mutation") and false then
            animalvalue = animalvalue + (animalvalue * getmutations[v:GetAttribute("Mutation")])
        end

        if animalvalue>=speedgen and CashValue >= animalcash then
            consechon=v
            speedgen=animalvalue
        end
    end

   

    if not consechon then
        return false
    end

	if connhonhat==speedgen and LaySoLuong() < #GetMyBase().AnimalPodiums:GetChildren() then
		return consechon
	end

	return consechon
end

function MuaConManhHon()
	local consechon=GetConManhHon()
	if not consechon then
		return
	end

    if LaySoLuong() >= #GetMyBase().AnimalPodiums:GetChildren() then
        SellNhonhat()
    end


    while wait() do
        if consechon and consechon:FindFirstChild("Part") and plr.leaderstats.Cash.Value >= Animals[consechon:GetAttribute("Index")].Price and consechon.Part.PromptAttachment.ProximityPrompt:GetAttribute("TargetPlayer") ~= plr.UserId then
            if LaySoLuong() >= #GetMyBase().AnimalPodiums:GetChildren() then
                SellNhonhat()
                wait(0.5)
            end
            MoveTo(consechon.Part)
			local prompt=consechon.Part.PromptAttachment.ProximityPrompt
            prompt:InputHoldBegin()
			task.wait(prompt.HoldDuration)
			prompt:InputHoldEnd()
            wait(0.1)
            
        else
            break
        end
    end
    -- MoveTo(GetMyBase().AnimalTarget)
end



-- local conmanhhon = GetConManhHon()
-- if conmanhhon and conmanhhon:FindFirstChild("Part") then
-- 	print("Đang đi tới:", conmanhhon:GetAttribute("Index"))
-- 	MoveTo(conmanhhon.Part)
--     local prompt = workspace.Part.ProximityPrompt
-- prompt:InputHoldBegin()
-- task.wait(prompt.HoldDuration)
-- prompt:InputHoldEnd()

-- else
-- 	print("Không tìm thấy con mạnh hơn nào.")
-- end
local md5 = {}
local hmac = {}
local base64 = {}

do
	do
		local T = {
			0xd76aa478,
			0xe8c7b756,
			0x242070db,
			0xc1bdceee,
			0xf57c0faf,
			0x4787c62a,
			0xa8304613,
			0xfd469501,
			0x698098d8,
			0x8b44f7af,
			0xffff5bb1,
			0x895cd7be,
			0x6b901122,
			0xfd987193,
			0xa679438e,
			0x49b40821,
			0xf61e2562,
			0xc040b340,
			0x265e5a51,
			0xe9b6c7aa,
			0xd62f105d,
			0x02441453,
			0xd8a1e681,
			0xe7d3fbc8,
			0x21e1cde6,
			0xc33707d6,
			0xf4d50d87,
			0x455a14ed,
			0xa9e3e905,
			0xfcefa3f8,
			0x676f02d9,
			0x8d2a4c8a,
			0xfffa3942,
			0x8771f681,
			0x6d9d6122,
			0xfde5380c,
			0xa4beea44,
			0x4bdecfa9,
			0xf6bb4b60,
			0xbebfbc70,
			0x289b7ec6,
			0xeaa127fa,
			0xd4ef3085,
			0x04881d05,
			0xd9d4d039,
			0xe6db99e5,
			0x1fa27cf8,
			0xc4ac5665,
			0xf4292244,
			0x432aff97,
			0xab9423a7,
			0xfc93a039,
			0x655b59c3,
			0x8f0ccc92,
			0xffeff47d,
			0x85845dd1,
			0x6fa87e4f,
			0xfe2ce6e0,
			0xa3014314,
			0x4e0811a1,
			0xf7537e82,
			0xbd3af235,
			0x2ad7d2bb,
			0xeb86d391,
		}

		local function add(a, b)
			local lsw = bit32.band(a, 0xFFFF) + bit32.band(b, 0xFFFF)
			local msw = bit32.rshift(a, 16) + bit32.rshift(b, 16) + bit32.rshift(lsw, 16)
			return bit32.bor(bit32.lshift(msw, 16), bit32.band(lsw, 0xFFFF))
		end

		local function rol(x, n)
			return bit32.bor(bit32.lshift(x, n), bit32.rshift(x, 32 - n))
		end

		local function F(x, y, z)
			return bit32.bor(bit32.band(x, y), bit32.band(bit32.bnot(x), z))
		end
		local function G(x, y, z)
			return bit32.bor(bit32.band(x, z), bit32.band(y, bit32.bnot(z)))
		end
		local function H(x, y, z)
			return bit32.bxor(x, bit32.bxor(y, z))
		end
		local function I(x, y, z)
			return bit32.bxor(y, bit32.bor(x, bit32.bnot(z)))
		end

		function md5.sum(message)
			local a, b, c, d = 0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476

			local message_len = #message
			local padded_message = message .. "\128"
			while #padded_message % 64 ~= 56 do
				padded_message = padded_message .. "\0"
			end

			local len_bytes = ""
			local len_bits = message_len * 8
			for i = 0, 7 do
				len_bytes = len_bytes .. string.char(bit32.band(bit32.rshift(len_bits, i * 8), 0xFF))
			end
			padded_message = padded_message .. len_bytes

			for i = 1, #padded_message, 64 do
				local chunk = padded_message:sub(i, i + 63)
				local X = {}
				for j = 0, 15 do
					local b1, b2, b3, b4 = chunk:byte(j * 4 + 1, j * 4 + 4)
					X[j] = bit32.bor(b1, bit32.lshift(b2, 8), bit32.lshift(b3, 16), bit32.lshift(b4, 24))
				end

				local aa, bb, cc, dd = a, b, c, d

				local s = { 7, 12, 17, 22, 5, 9, 14, 20, 4, 11, 16, 23, 6, 10, 15, 21 }

				for j = 0, 63 do
					local f, k, shift_index
					if j < 16 then
						f = F(b, c, d)
						k = j
						shift_index = j % 4
					elseif j < 32 then
						f = G(b, c, d)
						k = (1 + 5 * j) % 16
						shift_index = 4 + (j % 4)
					elseif j < 48 then
						f = H(b, c, d)
						k = (5 + 3 * j) % 16
						shift_index = 8 + (j % 4)
					else
						f = I(b, c, d)
						k = (7 * j) % 16
						shift_index = 12 + (j % 4)
					end

					local temp = add(a, f)
					temp = add(temp, X[k])
					temp = add(temp, T[j + 1])
					temp = rol(temp, s[shift_index + 1])

					local new_b = add(b, temp)
					a, b, c, d = d, new_b, b, c
				end

				a = add(a, aa)
				b = add(b, bb)
				c = add(c, cc)
				d = add(d, dd)
			end

			local function to_le_hex(n)
				local s = ""
				for i = 0, 3 do
					s = s .. string.char(bit32.band(bit32.rshift(n, i * 8), 0xFF))
				end
				return s
			end

			return to_le_hex(a) .. to_le_hex(b) .. to_le_hex(c) .. to_le_hex(d)
		end
	end

	do
		function hmac.new(key, msg, hash_func)
			if #key > 64 then
				key = hash_func(key)
			end

			local o_key_pad = ""
			local i_key_pad = ""
			for i = 1, 64 do
				local byte = (i <= #key and string.byte(key, i)) or 0
				o_key_pad = o_key_pad .. string.char(bit32.bxor(byte, 0x5C))
				i_key_pad = i_key_pad .. string.char(bit32.bxor(byte, 0x36))
			end

			return hash_func(o_key_pad .. hash_func(i_key_pad .. msg))
		end
	end

	do
		local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

		function base64.encode(data)
			return (
				(data:gsub(".", function(x)
					local r, b_val = "", x:byte()
					for i = 8, 1, -1 do
						r = r .. (b_val % 2 ^ i - b_val % 2 ^ (i - 1) > 0 and "1" or "0")
					end
					return r
				end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
					if #x < 6 then
						return ""
					end
					local c = 0
					for i = 1, 6 do
						c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
					end
					return b:sub(c + 1, c + 1)
				end) .. ({ "", "==", "=" })[#data % 3 + 1]
			)
		end
	end
end

local function GenerateReservedServerCode(placeId)
	local uuid = {}
	for i = 1, 16 do
		uuid[i] = math.random(0, 255)
	end

	uuid[7] = bit32.bor(bit32.band(uuid[7], 0x0F), 0x40) -- v4
	uuid[9] = bit32.bor(bit32.band(uuid[9], 0x3F), 0x80) -- RFC 4122

	local firstBytes = ""
	for i = 1, 16 do
		firstBytes = firstBytes .. string.char(uuid[i])
	end

	local gameCode =
		string.format("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x", table.unpack(uuid))

	local placeIdBytes = ""
	local pIdRec = placeId
	for _ = 1, 8 do
		placeIdBytes = placeIdBytes .. string.char(pIdRec % 256)
		pIdRec = math.floor(pIdRec / 256)
	end

	local content = firstBytes .. placeIdBytes

	local SUPERDUPERSECRETROBLOXKEYTHATTHEYDIDNTCHANGEEVERSINCEFOREVER = "e4Yn8ckbCJtw2sv7qmbg" -- legacy leaked key from ages ago that still works due to roblox being roblox.
	local signature = hmac.new(SUPERDUPERSECRETROBLOXKEYTHATTHEYDIDNTCHANGEEVERSINCEFOREVER, content, md5.sum)

	local accessCodeBytes = signature .. content

	local accessCode = base64.encode(accessCodeBytes)
	accessCode = accessCode:gsub("+", "-"):gsub("/", "_")

	local pdding = 0
	accessCode, _ = accessCode:gsub("=", function()
		pdding = pdding + 1
		return ""
	end)

	accessCode = accessCode .. tostring(pdding)

	return accessCode, gameCode
end


local Sawhub= SawUI:CreateWindow({title="Saw Hub"})
local HomeTab=Sawhub:CreatePage({title="Home"})
local AutoTabBuy=HomeTab:CreateSection({title="Auto Buy"})
AutoTabBuy:CreateToggle({
    title="Auto Buy Pet Rebirth",
    default=getgenv().Config.AutoBuyPetRebirth,
    callback=function(v)
        getgenv().Config.AutoBuyPetRebirth=v
        if v then
            spawn(function()
                while wait() and getgenv().Config.AutoBuyPetRebirth do
                    MuaPetRebirth()
                end
            end)
        end
    end
})

AutoTabBuy:CreateToggle({
    title="Auto AutoUpgrade Pet",
    default=getgenv().Config.AutoUpgradePet,
    callback=function(v)
        getgenv().Config.AutoUpgradePet=v
        if v then
            spawn(function()
                while wait() and getgenv().Config.AutoUpgradePet do
                    MuaConManhHon()
                end
            end)
        end
    end
})

do
    local OthersTab=Sawhub:CreatePage({title="Plot"})
    local plots={}
    for index=1,30 do
        local v=GetMyBase().AnimalPodiums:FindFirstChild(tostring(index))
        if not v then continue end
        local indexplot = OthersTab:CreateSection({title="Plot "..index})
        local titleplot = indexplot:CreateLabel({title="Empty"})
        local generateplot = indexplot:CreateLabel({title="Empty"})
        local sellbutton = indexplot:CreateButton({title="Sell",callback=function()
            game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/PlotService/Sell"):FireServer(index)
        end})
        plots[index]={
            title=titleplot,
            generate=generateplot,
            section=indexplot
        }
    end

    task.spawn(function()
        while wait(.5) do
            for i,v in pairs(GetMyBase().AnimalPodiums:GetChildren()) do

                plots[tonumber(v.Name)].title:Set("Pet: "..(v.Base.Spawn:FindFirstChild("Attachment") and v.Base.Spawn.Attachment.AnimalOverhead.DisplayName.Text or "Empty"))
                plots[tonumber(v.Name)].generate:Set("Generation: "..(v.Base.Spawn:FindFirstChild("Attachment") and v.Base.Spawn.Attachment.AnimalOverhead.Generation.Text or "Empty"))
            end
        end
    end)

end

local OthersTab=Sawhub:CreatePage({title="Others"})
local ServerTab=OthersTab:CreateSection({title="Servers"})
ServerTab:CreateButton({title="Join Private Server",callback=function()
    local accessCode, _ = GenerateReservedServerCode(game.PlaceId)
	print(accessCode)
    game.RobloxReplicatedStorage.ContactListIrisInviteTeleport:FireServer(game.PlaceId, "", accessCode)
end})
