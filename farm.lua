
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

			elseif v:IsA("Decal") or v:IsA("Texture") then
				v:Destroy()
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
				v.Lifetime = NumberRange.new(0)
			elseif v:IsA("Explosion") then
				v.BlastPressure = 1
				v.BlastRadius = 1
			elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
				v.Enabled = false
			elseif v:IsA("MeshPart") then
				v.Material = "SmoothPlastic"
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
	getgenv().Config={
		AutoAttack=false,
		AntiKnockback=false,
		BoostSpeed=false,
		FastBreak=false,
		AutoBlock=false,
	}
end

local canDebug = getgenv().canDebug or false	
local replicatedStorage=game:GetService("ReplicatedStorage")
local KnitInit, Knit
repeat
	KnitInit, Knit = pcall(function()
		return require(replicatedStorage.rbxts_include.node_modules['@easy-games'].knit.src).KnitClient
	end)
	if KnitInit then break end
	task.wait()
until KnitInit

if canDebug and not debug.getupvalue(Knit.Start, 1) then
	task.wait(1)
	repeat task.wait() until debug.getupvalue(Knit.Start, 1)
end

local Flamework = require(replicatedStorage['rbxts_include']['node_modules']['@flamework'].core.out).Flamework
local InventoryUtil = require(replicatedStorage.TS.inventory['inventory-util']).InventoryUtil
local Client = require(replicatedStorage.TS.remotes).default.Client
local OldGet, OldBreak = Client.Get, nil

bedwars = setmetatable({
	Flamework = Flamework,
	NotificationController = Flamework.resolveDependency('@easy-games/game-core:client/controllers/notification-controller@NotificationController'),
	AbilityController = Flamework.resolveDependency('@easy-games/game-core:client/controllers/ability/ability-controller@AbilityController'),
	AnimationType = require(replicatedStorage.TS.animation['animation-type']).AnimationType,
	AnimationUtil = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out['shared'].util['animation-util']).AnimationUtil,
	AppController = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out.client.controllers['app-controller']).AppController,
	BedBreakEffectMeta = require(replicatedStorage.TS.locker['bed-break-effect']['bed-break-effect-meta']).BedBreakEffectMeta,
	TaliyahUtil = require(replicatedStorage.TS.games.bedwars.kit.kits.taliyah['taliyah-util']).TaliyahUtil,
	BedwarsKitMeta = require(replicatedStorage.TS.games.bedwars.kit['bedwars-kit-meta']).BedwarsKitMeta,
	BedwarsKitClass = require(replicatedStorage.TS.games.bedwars.kit.class['bedwars-class']).BedwarsClass,

	BlockController = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['block-engine'].out).BlockEngine,
	
	BowConstantsTable = canDebug and debug.getupvalue(Knit.Controllers.ProjectileController.enableBeam, 8) or {
		RelZ = 0,
		CameraMultiplier = 10,
		RelX = 0.8,
		RelY = -0.6,
		YTargetOffset = 0.05,
		BeamGrowthMultiplier = 0.08
	},
	ClickHold = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out.client.ui.lib.util['click-hold']).ClickHold,
	Client = Client,
	ClientConstructor = require(replicatedStorage['rbxts_include']['node_modules']['@rbxts'].net.out.client),
	ClientDamageBlock = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['block-engine'].out.shared.remotes).BlockEngineRemotes.Client,
	CombatConstant = require(replicatedStorage.TS.combat['combat-constant']).CombatConstant,
	DamageIndicator = Knit.Controllers.DamageIndicatorController.spawnDamageIndicator,

	EmoteType = require(replicatedStorage.TS.locker.emote['emote-type']).EmoteType,
	EmoteImage = require(replicatedStorage.TS.locker.emote['emote-image']).EmoteImage,
	EmoteMeta = require(replicatedStorage.TS.locker.emote['emote-meta']).EmoteMeta,
	GamePlayer = require(replicatedStorage.TS.player['game-player']),
	EffectUtil = require(replicatedStorage.TS.util.effect['effect-util']).EffectUtil,
	GameAnimationUtil = require(replicatedStorage.TS.animation['animation-util']).GameAnimationUtil,
	getIcon = function(item, showinv)
		local itemmeta = bedwars.ItemMeta[item.itemType]
		return itemmeta and showinv and itemmeta.image or ''
	end,
	getInventory = function(plr)
		local suc, res = pcall(function()
			return InventoryUtil.getInventory(plr)
		end)
		return suc and res or {
			items = {},
			armor = {}
		}
	end,

	ItemMeta = require(replicatedStorage.TS.item['item-meta']).items,--debug.getupvalue(require(replicatedStorage.TS.item['item-meta']).getItemMeta, 1),
	RecipeMeta = require(replicatedStorage.TS.recipe['recipe-meta']).recipes,-- debug.getupvalue(require(replicatedStorage.TS.recipe['recipe-meta']).getRecipeMeta, 1),
	KillEffectMeta = require(replicatedStorage.TS.locker['kill-effect']['kill-effect-meta']).KillEffectMeta,

	Knit = Knit,
	KnockbackUtil = require(replicatedStorage.TS.damage['knockback-util']).KnockbackUtil,
	KnockbackUtilInstance = replicatedStorage.TS.damage['knockback-util'],
	NametagController = Knit.Controllers.NametagController,
	MageKitUtil = require(replicatedStorage.TS.games.bedwars.kit.kits.mage['mage-kit-util']).MageKitUtil,
	ProjectileMeta = require(replicatedStorage.TS.projectile['projectile-meta']).ProjectileMeta,

	Roact = require(replicatedStorage['rbxts_include']['node_modules']['@rbxts']['roact'].src),
	RuntimeLib = require(replicatedStorage['rbxts_include'].RuntimeLib),
	SoundList = require(replicatedStorage.TS.sound['game-sound']).GameSound,
	
}, {
	__index = function(self, ind)
		rawset(self, ind, Knit.Controllers[ind])
		return rawget(self, ind)
	end
})

local GameData = {
    Controllers = {
        Balloon = Knit.Controllers.BalloonController,
        BlockBreaker = Knit.Controllers.BlockBreakController.blockBreaker,
        Chest = Knit.Controllers.ChestController,
        Dao = Knit.Controllers.DaoController,
        Place = Knit.Controllers.BlockPlacementController,
        Queue = Knit.Controllers.QueueController,
        SetInvItem = Knit.Controllers.SetInvItem,
        SpiritAssasin = Knit.Controllers.SpiritAssassinController,
        Sprint = Knit.Controllers.SprintController,
        Sword = Knit.Controllers.SwordController,
        TeamCrate = Knit.Controllers.TeamCrateController,
        TeamUpgrades = Knit.Controllers.TeamUpgradeController,
        ViewModel = Knit.Controllers.ViewmodelController,
        Wind = Knit.Controllers.WindWalkerController
    },
    Modules = {
        Animation = require(replicatedStorage.TS.animation["animation-util"]).GameAnimationUtil,
        AnimationTypes = require(replicatedStorage.TS.animation["animation-type"]).AnimationType,
        App = require(replicatedStorage.rbxts_include.node_modules["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController,
        ArmorSets = require(replicatedStorage.TS.games.bedwars["bedwars-armor-set"]),
        BlockEngine = require(replicatedStorage.rbxts_include.node_modules["@easy-games"]["block-engine"].out).BlockEngine,
       
        BlockRemotes = require(replicatedStorage.rbxts_include.node_modules["@easy-games"]["block-engine"].out.shared.remotes).BlockEngineRemotes,
        ChargeState = require(replicatedStorage.TS.combat["charge-state"]).ChargeState,
        DamageType = require(replicatedStorage.TS.damage["damage-type"]).DamageType,
        Inventory = require(replicatedStorage.TS.inventory["inventory-util"]).InventoryUtil,
      
        Network = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.lib.network),
        PlayerUtil = require(replicatedStorage.TS.player["player-util"]).GamePlayerUtil,
        
        ProjMeta = require(replicatedStorage.TS.projectile['projectile-meta']).ProjectileMeta,
        Promise = require(replicatedStorage.rbxts_include.node_modules["@easy-games"].knit.src.Knit.Util.Promise),
        Remotes = require(replicatedStorage.TS.remotes).default.Client,
        Shop = require(replicatedStorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop,
        ShopPurchase = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.shop.api["purchase-item"]).shopPurchaseItem,
        Sound = require(replicatedStorage.rbxts_include.node_modules["@easy-games"]["game-core"].out).SoundManager,
        Store = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.ui.store).ClientStore,
        SyncEvents = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS["client-sync-events"]).ClientSyncEvents,
        TeamUpgradeMeta = require(replicatedStorage.TS.games.bedwars["team-upgrade"]["team-upgrade-meta"]),
        UI = require(replicatedStorage.rbxts_include.node_modules["@easy-games"]["game-core"].out).UILayers
    },
    Remotes = {Set = replicatedStorage.rbxts_include.node_modules['@rbxts'].net.out._NetManaged.SetInvItem},
    Events = {
        Damage = Instance.new("BindableEvent"),
        Death = Instance.new("BindableEvent")
    },
    GameEvents = {}
}


-- local projectileRemote = {InvokeServer = function() end}
-- task.spawn(function()
-- 	projectileRemote = bedwars.Client:Get(remotes.FireProjectile).instance
-- end)

-- local function launchProjectile(item, pos, proj, speed, dir)
-- 	if not pos then return end

-- 	pos = pos - dir * 0.1
-- 	local shootPosition = (CFrame.lookAlong(pos, Vector3.new(0, -speed, 0)) * CFrame.new(Vector3.new(-bedwars.BowConstantsTable.RelX, -bedwars.BowConstantsTable.RelY, -bedwars.BowConstantsTable.RelZ)))
-- 	switchItem(item.tool, 0)
-- 	task.wait(0.1)
-- 	bedwars.ProjectileController:createLocalProjectile(bedwars.ProjectileMeta[proj], proj, proj, shootPosition.Position, '', shootPosition.LookVector * speed, {drawDurationSeconds = 1})
-- 	if projectileRemote:InvokeServer(item.tool, proj, proj, shootPosition.Position, pos, shootPosition.LookVector * speed, httpService:GenerateGUID(true), {shotId = httpService:GenerateGUID(false), drawDurationSec = 1}, workspace:GetServerTimeNow() - 0.045) then
-- 		local shoot = bedwars.ItemMeta[item.itemType].projectileSource.launchSound
-- 		shoot = shoot and shoot[math.random(1, #shoot)] or nil
-- 		if shoot then
-- 			bedwars.SoundManager:playSound(shoot)
-- 		end
-- 	end
-- end

function load()
	if isfolder("Sawhub") == false then
		makefolder("Sawhub")
	end
	if isfile("/Sawhub/Bedwar-" .. game.Players.LocalPlayer.Name .. ".json") == false then
		writefile("/Sawhub/Bedwar-" .. game.Players.LocalPlayer.Name .. ".json", game:GetService("HttpService"):JSONEncode(getgenv().Config))
	else
		local Decode = game:GetService("HttpService"):JSONDecode(readfile("/Sawhub/Bedwar-" .. game.Players.LocalPlayer.Name .. ".json"))
		for i,v in pairs(Decode) do
			getgenv().Config[i] = v
		end
	end
end

function Save()
	writefile("/Sawhub/Bedwar-" .. game.Players.LocalPlayer.Name .. ".json", game:GetService("HttpService"):JSONEncode(getgenv().Config))
end

load()

local function getOrCreateAttachment(part)
	local att = part:FindFirstChild("BeamAttachment")
	if not att then
		att = Instance.new("Attachment")
		att.Name = "BeamAttachment"
		att.Parent = part
	end
	return att
end

local function createBeam(player1, player2)
	local hrp1 = player1.Character and player1.Character:FindFirstChild("HumanoidRootPart")
	local hrp2 = player2.Character and player2.Character:FindFirstChild("HumanoidRootPart")

	if not hrp1 or not hrp2 then return end

	local att1 = getOrCreateAttachment(hrp1)
	local att2 = getOrCreateAttachment(hrp2)

	local beam = Instance.new("Beam")
	beam.Attachment0 = att1
	beam.Attachment1 = att2
	beam.Width0 = 0.1
	beam.Width1 = 0.1
	beam.Color = ColorSequence.new(player2.Team and player2.Team.TeamColor.Color or Color3.fromRGB(0, 255, 255))
	beam.Transparency = NumberSequence.new(0)
	beam.FaceCamera = true
	beam.Parent = hrp1
end


local Sawhub= SawUI:CreateWindow({title="Saw Hub"})

local CombatTab=Sawhub:CreatePage({title="Combat"})
local OffenseSec=CombatTab:CreateSection({title="Offense"})
local BowSec=CombatTab:CreateSection({title="Bow"})
local DefenseSec=CombatTab:CreateSection({title="Defense"})

local PlayerTab=Sawhub:CreatePage({title="Player"})
local MovementSec=PlayerTab:CreateSection({title="Movement"})
local SafetySec=PlayerTab:CreateSection({title="Safety"})

local UtilityTab=Sawhub:CreatePage({title="Utility"})
local BlockSec=UtilityTab:CreateSection({title="Block"})
local MiscSec=UtilityTab:CreateSection({title="Misc"})

local VisualTab=Sawhub:CreatePage({title="Visual"})
local EspSec=VisualTab:CreateSection({title="Esp"})

local Config = Sawhub:CreatePage({title="Config"})
local ConfigSec=Config:CreateSection({title="Config"})

OffenseSec:CreateToggle({title="Click No Delay",default=getgenv().Config.NoClickDelay,callback=function(v)
    getgenv().Config.NoClickDelay=v
	if v then
		old = bedwars.SwordController.isClickingTooFast
		bedwars.SwordController.isClickingTooFast = function(self)
			self.lastSwing = os.clock()
			return false
		end
	else
		bedwars.SwordController.isClickingTooFast = old
	end
end})

OffenseSec:CreateToggle({title="Auto Attack",default=getgenv().Config.AutoAttack,callback=function(v)
    getgenv().Config.AutoAttack=v
end})

BowSec:CreateToggle({title="Auto Bow",default=getgenv().Config.AutoBow,callback=function(v)
    getgenv().Config.AutoBow=v
end})

BowSec:CreateSlider({title="Fov",Min=1,Max=180,Precise=getgenv().Config.Fov or 180,callback=function(v)
    getgenv().Config.Fov=v
end})

BowSec:CreateToggle({title="Show FOV",default=getgenv().Config.ShowFOV,callback=function(v)
    getgenv().Config.ShowFOV=v
end})


local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 460
FOVCircle.Filled = false
FOVCircle.Transparency = 0.5
FOVCircle.Radius = 200
FOVCircle.Color = Color3.fromRGB(255, 0, 0)

game:GetService("RunService").Stepped:Connect(function()
    FOVCircle.Radius = getgenv().Config.Fov
    FOVCircle.Thickness = 1
    FOVCircle.NumSides = 11
    FOVCircle.Position = game:GetService('UserInputService'):GetMouseLocation()
    if getgenv().Config.ShowFOV then
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end
end)

-- OffenseSec:CreateToggle({title="Auto Kill Void",default=getgenv().Config.KillVoid,callback=function(v)
--     getgenv().Config.KillVoid=v
-- end})

DefenseSec:CreateToggle({title="Anti Knockback",default=getgenv().Config.AntiKnockback,callback=function(v)
    getgenv().Config.AntiKnockback=v
end})

MovementSec:CreateSlider({title="Speed",Min=16,Max=50,Precise=getgenv().Config.Speed or 20,callback=function(v)
    getgenv().Config.Speed=v
end})

MovementSec:CreateSlider({title="Jump Height",Min=5,Max=100,Precise=getgenv().Config.JumpHeight or 30,callback=function(v)
    getgenv().Config.JumpHeight=v
end})

MovementSec:CreateToggle({title="Boost Speed Jump",default=getgenv().Config.BoostSpeed,callback=function(v)
    getgenv().Config.BoostSpeed=v
    task.spawn(function()
        while wait() and getgenv().Config.BoostSpeed do
            pcall(function()
                game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().Config.Speed
                game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = getgenv().Config.JumpHeight * 10
                game:GetService("Players").LocalPlayer.Character.Humanoid.JumpHeight = getgenv().Config.JumpHeight
            end)
        end
    end)
end})

SafetySec:CreateToggle({title="Anti Void",default=getgenv().Config.AntiVoid,callback=function(v)
    getgenv().Config.AntiVoid=v
    task.spawn(function()
        if getgenv().Config.AntiVoid then
            local part = Instance.new("Part")
            part.Name="AntiVVV"
            part.Size=Vector3.new(2024,5,2024)
            part.Anchored=true
            part.Position = Vector3.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.X,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Y-10,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Z)
            part.Parent=workspace
        else
            local part = workspace:FindFirstChild("AntiVVV")
            if part then
                part:Destroy()
            end
        end
    end)
end})

local rayParams = RaycastParams.new()

SafetySec:CreateToggle({title="Anti Fall",default=getgenv().Config.AntiFall,callback=function(v)
    getgenv().Config.AntiFall=v
	task.spawn(function()
		local tracked, extraGravity, velocity = 0, 0, 0
		local antiFall
		antiFall = game:GetService("RunService").PreSimulation:Connect(function(dt)
			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				if not getgenv().Config.AntiFall then antiFall:Disconnect() return end
				local root = plr.Character.HumanoidRootPart
				if root.AssemblyLinearVelocity.Y < -85 then
					rayParams.FilterDescendantsInstances = {plr.Character, workspace.CurrentCamera}
					rayParams.CollisionGroup = root.CollisionGroup

					local rootSize = root.Size.Y / 2.5 + plr.Character.Humanoid.HipHeight
					local ray = workspace:Blockcast(root.CFrame, Vector3.new(3, 3, 3), Vector3.new(0, (tracked * 0.1) - rootSize, 0), rayParams)
					if not ray then
						local Failed = 100
						local velo = root.AssemblyLinearVelocity.Y

						root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, -86, root.AssemblyLinearVelocity.Z)
						

						velocity = velo
						root.CFrame = root.CFrame + Vector3.new(0, (Failed and -extraGravity or extraGravity) * dt, 0)
						extraGravity = extraGravity + (Failed and workspace.Gravity or -workspace.Gravity) * dt
					else
						velocity = root.AssemblyLinearVelocity.Y
					end
				else
					extraGravity = 0
				end
			end
		end)
	end)
end})

BlockSec:CreateSlider({title="Fast Break Cooldown",Precise=getgenv().Config.FastBreakCooldown or 25,Min=0,Max=30,callback=function(v)
    getgenv().Config.FastBreakCooldown=v
end})

BlockSec:CreateToggle({title="Fast Break",default=getgenv().Config.FastBreak,callback=function(v)
    getgenv().Config.FastBreak=v
	task.spawn(function()
		if getgenv().Config.FastBreak then
			repeat
				bedwars.BlockBreakController.blockBreaker:setCooldown(getgenv().Config.FastBreakCooldown/100)
				task.wait(0.1)
			until not getgenv().Config.FastBreak
		else
			bedwars.BlockBreakController.blockBreaker:setCooldown(0.3)
		end
	end)
end})

local autoblock = BlockSec:CreateToggle({title="Auto Block",default=getgenv().Config.AutoBlock,callback=function(v)
    getgenv().Config.AutoBlock=v
end})

MiscSec:CreateToggle({title="Auto Collect",default=getgenv().Config.AutoCollect,callback=function(v)
    getgenv().Config.AutoCollect=v
end})

EspSec:CreateToggle({title="Highlight Players",default=getgenv().Config.HighlightPlayers,callback=function(v)
    getgenv().Config.HighlightPlayers=v
end})

local function clearBeams()
	for k,c in pairs(game.Players:GetPlayers()) do
		if c.Character then 
			for huhu,char in pairs(c.Character:GetDescendants()) do
				if char:IsA("Beam") then
					char:Destroy()
				end
			end
		end
	end
end

EspSec:CreateToggle({
	title="Tracker",
	default=getgenv().Config.Tracker,
	callback=function(v)
		getgenv().Config.Tracker=v
		task.spawn(function()
			local myPlayer = game:GetService("Players").LocalPlayer
			while getgenv().Config.Tracker do
				for _, otherPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
					if otherPlayer ~= myPlayer and otherPlayer.TeamColor ~= myPlayer.TeamColor then
						createBeam(myPlayer, otherPlayer)
					end
				end
				task.wait(1)
			end
			clearBeams()
		end)

	end
})

EspSec:CreateToggle({title="Esp Bee",default=getgenv().Config.EspBee,callback=function(v)
    getgenv().Config.EspBee=v
    task.spawn(function()
        while wait() and getgenv().Config.EspBee do
            pcall(function()
                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v.Name=="Bee" and not v:FindFirstChild("EspHl") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "EspHl"
                        hl.Parent = v
                        hl.FillColor = Color3.new(1, 0, 0)
                        hl.Adornee = v
                        if v:FindFirstChild("Root") and v.Root:FindFirstChild("ProximityPrompt") then
                            v.Root.ProximityPrompt.MaxActivationDistance = 100
                        end
                    end
                end
            end)
        end
    end)
end})

ConfigSec:CreateButton({title="Save Config",callback=Save})


game:GetService("UserInputService").InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Q then
		getgenv().Config.AutoBlock=not getgenv().Config.AutoBlock
		if getgenv().Config.AutoBlock then
			Sawhub:Notify("Auto Block:".."Enabled",{color=Theme.Success})
		else
			Sawhub:Notify("Auto Block:".."Disabled",{color=Theme.Error})
		end
		autoblock:Set(getgenv().Config.AutoBlock)
	end
end)


local function getClosestToMouse()
    local mousePos = game:GetService("UserInputService"):GetMouseLocation()
    local closestPlr, closestDist = nil, getgenv().Config.Fov

    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= plr and p.Character and p.Character:FindFirstChild("Head") and p.Team ~= plr.Team then
            local head = p.Character.Head
            local head3D, onScreen = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
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



local Aim = function(start, speed, gravity, pos, velo, prediction, height, params)
    local eps = 1/1000000000
    local getVal = function(d) return math.abs(d) < eps end
    local getNrRoot = function(x) return x^(1/3) * (x < 0 and -1 or 1) end

    local getPrediction = function(a, b, c)
        local half_b, constant = b / (2 * a), c / a
        local discriminant = half_b * half_b - constant

        if getVal(discriminant) then
            return -half_b
        elseif discriminant > 0 then
            local sqrt_discriminant = math.sqrt(discriminant)
            return sqrt_discriminant - half_b, -sqrt_discriminant - half_b
        end
        return 0
    end

    local getSqrt = function(a, b, c, d)
        local root0, root1, root2
        local numRoots, sub
        local A, B, C = b / a, c / a, d / a
        local sqA = A * A
        local p, q = (1/3) * (-(1/3) * sqA + B), 0.5 * ((2/27) * A * sqA - (1/3) * A * B + C)
        local cbP = p * p * p
        local discriminant = q * q + cbP

        if getVal(discriminant) then
            if getVal(q) then
                root0, numRoots = 0, 1
            else
                local u = getNrRoot(-q)
                root0, root1, numRoots = 2 * u, -u, 2
            end
        elseif discriminant < 0 then
            local phi = (1/3) * math.acos(-q / math.sqrt(-cbP))
            local t = 2 * math.sqrt(-p)
            root0, root1, root2 = t * math.cos(phi), -t * math.cos(phi + math.pi/3), -t * math.cos(phi - math.pi/3)
            numRoots = 3
        else
            local sqrtDiscriminant = math.sqrt(discriminant)
            local u, v = getNrRoot(sqrtDiscriminant - q), -getNrRoot(sqrtDiscriminant + q)
            root0, numRoots = u + v, 1
        end

        sub = (1/3) * A
        if numRoots > 0 then root0 = root0 - sub end
        if numRoots > 1 then root1 = root1 - sub end
        if numRoots > 2 then root2 = root2 - sub end

        return root0, root1, root2
    end

    local getNewPred = function(a, b, c, d, e)
        local root0, root1, root2, root3
        local coeffs = {}
        local z, u, v, sub
        local A, B, C, D = b / a, c / a, d / a, e / a
        local sqA = A * A
        local p, q, r = -0.375 * sqA + B, 0.125 * sqA * A - 0.5 * A * B + C, -(3/256) * sqA * sqA + 0.0625 * sqA * B - 0.25 * A * C + D
        local numRoots

        if getVal(r) then
            coeffs[3], coeffs[2], coeffs[1], coeffs[0] = q, p, 0, 1
            local results = {getSqrt(coeffs[0], coeffs[1], coeffs[2], coeffs[3])}
            numRoots = #results
            root0, root1, root2 = results[1], results[2], results[3]
        else
            coeffs[3], coeffs[2], coeffs[1], coeffs[0] = 0.5 * r * p - 0.125 * q * q, -r, -0.5 * p, 1
            root0, root1, root2 = getSqrt(coeffs[0], coeffs[1], coeffs[2], coeffs[3])
            z = root0

            u, v = z * z - r, 2 * z - p
            u = getVal(u) and 0 or (u > 0 and math.sqrt(u) or nil)
            v = getVal(v) and 0 or (v > 0 and math.sqrt(v) or nil)
            if not u or not v then return end

            coeffs[2], coeffs[1], coeffs[0] = z - u, q < 0 and -v or v, 1
            local results = {getPrediction(coeffs[0], coeffs[1], coeffs[2])}
            numRoots = #results
            root0, root1 = results[1], results[2]

            coeffs[2], coeffs[1], coeffs[0] = z + u, q < 0 and v or -v, 1
            if numRoots < 4 then
                local results1 = {getPrediction(coeffs[0], coeffs[1], coeffs[2])}
                if numRoots == 0 then
                    root0, root1 = results1[1], results1[2]
                elseif numRoots == 1 then
                    root1, root2 = results1[1], results1[2]
                elseif numRoots == 2 then
                    root2, root3 = results1[1], results1[2]
                end
                numRoots = numRoots + #results1
            end
        end

        sub = 0.25 * A
        if numRoots > 0 then root0 = root0 - sub end
        if numRoots > 1 then root1 = root1 - sub end
        if numRoots > 2 then root2 = root2 - sub end
        if numRoots > 3 then root3 = root3 - sub end

        return {root3, root2, root1, root0}
    end

    local displacement = pos - start
    local velX, velY, velZ = velo.X, velo.Y, velo.Z
    local dispX, dispY, dispZ = displacement.X, displacement.Y, displacement.Z
    local halfGravity = -0.5 * gravity

    if math.abs(velY) > 0.01 and prediction and prediction > 0 then
        local estTime = displacement.Magnitude / speed
        for _ = 1, 100 do
            velY = velY - (0.5 * prediction) * estTime
            local velocity = velo * 0.016
            local ray = workspace.Raycast(workspace, Vector3.new(pos.X, pos.Y, pos.Z), Vector3.new(velocity.X, (velY * estTime) - height, velocity.Z), params)
            if ray then
                local newTarget = ray.Position + Vector3.new(0, height, 0)
                estTime = estTime - math.sqrt(((pos - newTarget).Magnitude * 2) / prediction)
                pos = newTarget
                dispY = (pos - start).Y
                velY = 0
                break
            else
                break
            end
        end
    end

    local solutions = getNewPred(
        halfGravity * halfGravity,
        -2 * velY * halfGravity,
        velY * velY - 2 * dispY * halfGravity - speed * speed + velX * velX + velZ * velZ,
        2 * dispY * velY + 2 * dispX * velX + 2 * dispZ * velZ,
        dispY * dispY + dispX * dispX + dispZ * dispZ
    )

    if solutions then
        local posRoots = {}
        for _, v in next, solutions do
            if v > 0 then
                table.insert(posRoots, v)
            end
        end
        if posRoots[1] then
            local t = posRoots[1]
            local d = (dispX + velX * t) / t
            local e = (dispY + velY * t - halfGravity * t * t) / t
            local f = (dispZ + velZ * t) / t
            return start + Vector3.new(d, e, f)
        end
        return 0
    elseif gravity == 0 then
        local t = displacement.Magnitude / speed
        local d = (dispX + velX * t) / t
        local e = (dispY + velY * t - halfGravity * t * t) / t
        local f = (dispZ + velZ * t) / t
        return start + Vector3.new(d, e, f)
    end
    return 0
end

local GetInventory = function(plr: Player)
    plr = plr or game.Players.LocalPlayer
    return GameData.Modules.Inventory.getInventory(plr)
end

local GetAmmo = function(Check)
    if not Check.ammoItemTypes then return nil end
    local Inv = GetInventory().items
    for i = 1, #Inv do
        local Obj = Inv[i]
        for j = 1, #Check.ammoItemTypes do
            if Obj.itemType == Check.ammoItemTypes[j] then
                return Check.ammoItemTypes[j]
            end
        end
    end
    return nil
end

local ProjNames = {arrow = true, snowball = true}
local GetTools = function()
    local Found = {}
    local Inv = GetInventory().items
    for i = 1, #Inv do
        local It = Inv[i]

        local Data = bedwars.ItemMeta[It.itemType]
        local Src = Data and Data.projectileSource
        if Src then
            local Ammo = GetAmmo(Src)
            if Ammo and ProjNames[Ammo] then
                Found[#Found + 1] = {
                    Item = It,
                    Ammo = Ammo,
                    Proj = Src.projectileType(Ammo),
                    Meta = Src
                }
            end
        end
    end
    return Found
end
local HttpService= game:GetService("HttpService")
local GroundRay = RaycastParams.new()
GroundRay.FilterType = Enum.RaycastFilterType.Include
GroundRay.FilterDescendantsInstances = {workspace:WaitForChild("Map")}
function firebow(pos2)
    local Pos=game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
	print(GetTools())
    for i,v in pairs(GetTools()) do

		if game:GetService("Players").LocalPlayer.Character:FindFirstChild(v.Item.tool.Name) then
    
			local ProjData = GameData.Modules.ProjMeta[v.Proj]
			local AimPos = Aim(Pos, ProjData.launchVelocity, ProjData.gravitationalAcceleration or 196.2, pos2.HumanoidRootPart.Position, pos2.HumanoidRootPart.Velocity, workspace.Gravity,pos2.Humanoid.HipHeight, GroundRay)
			local Args = {
				v.Item.tool,
				v.Ammo,
				v.Proj,
				CFrame.new(Pos, AimPos).Position,
				Pos,
				(CFrame.new(Pos, AimPos)).LookVector * ProjData.launchVelocity,
				HttpService:GenerateGUID(true),
				{drawDurationSec = 1, shotId = HttpService:GenerateGUID(false)},
				workspace:GetServerTimeNow() - (math.pow(10, -2) * ((50 - 5) / 2))
			}

			replicatedStorage.rbxts_include.node_modules["@rbxts"].net.out._NetManaged.ProjectileFire:InvokeServer(Args[1], Args[2], Args[3], Args[4], Args[5], Args[6], Args[7], Args[8], Args[9], Args[10])
		end
    end
end

task.spawn(function()
	while wait(.3) do
		if getgenv().Config.AutoBow then
			if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
				local closestPlr = getClosestToMouse()
				if  closestPlr then
					local suc,err = pcall(function()
						firebow(closestPlr.Character)
					end)
					if not suc then
						warn(err)
					end
				end
			end
		end
	end
end)

local player = game.Players.LocalPlayer

-- local function setupAntiFall(character)
--     local hrp = character:WaitForChild("HumanoidRootPart")
--     local humanoid = character:WaitForChild("Humanoid")

--     local bodyVelocity = Instance.new("BodyVelocity")
--     bodyVelocity.MaxForce = Vector3.new(0, 0, 0) 
--     bodyVelocity.Velocity = Vector3.new(0, 0, 0)
--     bodyVelocity.Parent = hrp

--     humanoid.StateChanged:Connect(function(_, newState)
--         if getgenv().Config.AntiFall then 
--             if newState == Enum.HumanoidStateType.Freefall then
--                 bodyVelocity.MaxForce = Vector3.new(0, 5000, 0) 
--                 bodyVelocity.Velocity = Vector3.new(0, -30, 0) 
--             elseif newState == Enum.HumanoidStateType.Landed then
--                 bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
--             end
--         end
--     end)
-- end


-- if player.Character then
--     setupAntiFall(player.Character)
-- end


-- player.CharacterAdded:Connect(setupAntiFall)


local mt = getrawmetatable(game)
local oldIndex = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    
    if tostring(method) == "ApplyImpulse" and self.Parent == game.Players.LocalPlayer.Character and getgenv().Config.AntiKnockback then
        return nil 
    end
    
    return oldIndex(self, unpack(args))
end)
setreadonly(mt, true)


function Find2(a,b)
    for i,v in pairs(a:GetChildren()) do
        if string.find(v.Name,b) then
            return v
        end
    end
    return nil
end



local Mouse=game:GetService("Players").LocalPlayer:GetMouse()
local UIS=game:GetService("UserInputService")


task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Config.HighlightPlayers then
            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character then
                    local char = v.Character
					
                    local isEnemy = (v.Team ~= game.Players.LocalPlayer.Team)
                    if isEnemy then
                        if not char:FindFirstChild("EspHl") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "EspHl"
                            hl.Parent = char
                            hl.FillTransparency = 0.5 
                            hl.OutlineTransparency = 0
                            hl.FillColor = (v.Team and v.Team.TeamColor.Color) or Color3.new(1, 0, 0)
                        end
                    end
                end
            end
        else
            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                if v.Character and v.Character:FindFirstChild("EspHl") then
                    v.Character.EspHl:Destroy()
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if getgenv().Config.AutoCollect then
            for i,v in pairs(workspace.ItemDrops:GetChildren()) do
                if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (v.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 30 then
                local args = {
						[1] = {
							["itemDrop"] = v
						}
					}

					game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("PickupItemDrop"):InvokeServer(unpack(args))
                end
            end
        end

    end 
end)


task.spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if getgenv().Config.AutoAttack then
            for i,v in pairs(game:GetService("Players"):GetChildren()) do
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Team ~= game:GetService("Players").LocalPlayer.Team and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Name ~= game:GetService("Players").LocalPlayer.Name then
                    local sw=Find2(game:GetService("ReplicatedStorage").Inventories[plr.Name],"sword")
                    if sw and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and (v.Character.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 30 then
                        local args = {
                            [1] = {
                                ["chargedAttack"] = {
                                ["chargeRatio"] = 0
                            },
                            ["entityInstance"] = v.Character,
                            ["validate"] = {
                                ["targetPosition"] = {
                                    ["value"] = v.Character.HumanoidRootPart.Position
                                },
                                ["raycast"] = {
                                    ["cameraPosition"] = {
                                        ["value"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
                                    },
                                    ["cursorDirection"] = {
                                        ["value"] = (v.Character.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).unit
                                    }
                                },
                                ["selfPosition"] = {
                                    ["value"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
                                }
                            },
                            ["weapon"] = sw
                        }
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("SwordHit"):FireServer(unpack(args))
                end
            end
        end 
	end
    end)
end)


function RayCast(origin, direction)
    local ignored = {game:GetService("Players").LocalPlayer.Character,workspace:FindFirstChild("AntiVVV")}
    local raycastParameters = RaycastParams.new()
    raycastParameters.FilterDescendantsInstances = ignored
    raycastParameters.FilterType = Enum.RaycastFilterType.Exclude
    raycastParameters.IgnoreWater = true
    
    return workspace:Raycast(origin, direction, raycastParameters)
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local inventories = ReplicatedStorage:WaitForChild("Inventories")

local placeBlockRemote = ReplicatedStorage:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@easy-games"):WaitForChild("block-engine"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("PlaceBlock")

local function placeBlock(gridPos, blockType)
    local args = {
        [1] = {
            ["position"] = gridPos,
            ["blockType"] = blockType,
            ["blockData"] = 0,
            ["mouseBlockInfo"] = {
                ["placementPosition"] = gridPos
            }
        }
    }
    placeBlockRemote:InvokeServer(unpack(args))
end

local ttpp={{1,0,0},{-1,0,0},{0,0,1},{0,0,-1},{1,1,0},{-1,1,0},{0,1,1},{0,1,-1}}



-- task.spawn(function()
--     game:GetService("RunService").RenderStepped:Connect(function()
--         if not getgenv().Config.KillVoid then return end
-- 		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
-- 			if v.Name ~= player.Name and v.Team ~= player.Team then
-- 				local character = v.Character
-- 				if character and character:FindFirstChild("HumanoidRootPart") and (character.HumanoidRootPart.Position-player.Character.HumanoidRootPart.Position).magnitude < 30 then
-- 					local blockType = "wool_" .. string.lower(player.Team.Name)
-- 					local inventory = inventories:FindFirstChild(player.Name)
-- 					if inventory and inventory:FindFirstChild(blockType) then
-- 						for _,cc in pairs(ttpp) do
-- 							if RayCast(v.Character.HumanoidRootPart.Position, Vector3.new(cc[1], -3, cc[2])) then
-- 								task.spawn(function()
-- 									placeBlock(Vector3.new(math.round((v.Character.HumanoidRootPart.Position.X+cc[1]*3) / 3), math.round((v.Character.HumanoidRootPart.Position.Y-2+cc[3]*3) / 3), math.round((v.Character.HumanoidRootPart.Position.Z+cc[2]*3) / 3)), blockType)
-- 								end)
-- 							end
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
--     end)	
-- end)

task.spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if not getgenv().Config.AutoBlock then return end

        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") or not player.Team then return end

        local blockType = "wool_" .. string.lower(player.Team.Name)
        local inventory = inventories:FindFirstChild(player.Name)

        if inventory and inventory:FindFirstChild(blockType) then
            local hrp = character.HumanoidRootPart
            local velocity = hrp.AssemblyLinearVelocity

            if not RayCast(hrp.Position, Vector3.new(0, -5, 0)) then
                local posX = hrp.Position.X + (velocity.X * 0.06)
                local posZ = hrp.Position.Z + (velocity.Z * 0.06)
                local gridPos = Vector3.new(math.round(posX / 3), math.round((hrp.Position.Y - 4.5) / 3), math.round(posZ / 3))
                task.spawn(placeBlock, gridPos, blockType)
            end

            local lookDirection = velocity.Magnitude < 0.1 and hrp.CFrame.LookVector or velocity.Unit
            for i=1,3 do
				local checkPos = hrp.Position + (lookDirection * (i*3))

                if not RayCast(checkPos, Vector3.new(0, -5, 0)) then
                    local gridPos = Vector3.new(math.round(checkPos.X / 3), math.round((checkPos.Y - 4.5) / 3), math.round(checkPos.Z / 3))
                    task.spawn(placeBlock, gridPos, blockType)
                end
			end
        end
    end)
end)
