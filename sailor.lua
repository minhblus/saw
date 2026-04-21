repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("CoreGui")
local TS = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local plr = Players.LocalPlayer
local Mouse = plr:GetMouse()
local UIS = game:GetService("UserInputService")
local Tweeninfo = TweenInfo.new
local vim = game:GetService('VirtualInputManager')
local Camera = workspace.CurrentCamera
local UI={}

local Theme = {
	Background = Color3.fromRGB(24, 26, 30),
	SecondaryBackground = Color3.fromRGB(30, 33, 39),
	Accent = Color3.fromRGB(90, 175, 255),
	TextColor = Color3.fromRGB(238, 242, 248),
	SubTextColor = Color3.fromRGB(168, 176, 190),
	ElementBackground = Color3.fromRGB(38, 42, 50),
	StrokeColor = Color3.fromRGB(56, 62, 74),
	Success = Color3.fromRGB(52, 199, 121),
	Warning = Color3.fromRGB(255, 170, 75),
	Error = Color3.fromRGB(255, 95, 95)
}

local function softTween(target, properties, duration, easingStyle, easingDirection)
	TS:Create(
		target,
		TweenInfo.new(duration or 0.12, easingStyle or Enum.EasingStyle.Quad, easingDirection or Enum.EasingDirection.Out),
		properties
	):Play()
end

local function styleModernSurface(frame, cornerRadius)
	frame.BackgroundColor3 = Theme.SecondaryBackground
	local corner = frame:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, cornerRadius or 8)
	corner.Parent = frame

	local stroke = frame:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Color = Theme.StrokeColor
	stroke.Thickness = 1
	stroke.Transparency = 0
	stroke.LineJoinMode = Enum.LineJoinMode.Round
	stroke.Parent = frame
end

function TweenObject(obj, properties, duration, ...)
	TS:Create(obj, Tweeninfo(duration, ...), properties):Play()
end

function DraggingEnabled(frame, parent)
	parent = parent or frame

	local dragging = false
	local mousePos, framePos
	local dragConnection

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			mousePos = input.Position
			framePos = parent.Position
			if dragConnection then
				dragConnection:Disconnect()
				dragConnection = nil
			end

			dragConnection = UIS.InputChanged:Connect(function(changedInput)
				if not dragging then
					return
				end
				if changedInput.UserInputType ~= Enum.UserInputType.MouseMovement and changedInput.UserInputType ~= Enum.UserInputType.Touch then
					return
				end
				local delta = changedInput.Position - mousePos
				parent.Position = UDim2.new(
					framePos.X.Scale,
					framePos.X.Offset + delta.X,
					framePos.Y.Scale,
					framePos.Y.Offset + delta.Y
				)
			end)

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					if dragConnection then
						dragConnection:Disconnect()
						dragConnection = nil
					end
				end
			end)
		end
	end)
end


function AddListCanva(uilist,needlist)
	if needlist:IsA("Frame") then
		needlist.Size=UDim2.new(needlist.Size.X.Scale,needlist.Size.X.Offset,0,uilist.AbsoluteContentSize.Y+10)
	else
		needlist.CanvasSize=UDim2.new(0,0,0,uilist.AbsoluteContentSize.Y+10)
	end
	uilist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if needlist:IsA("Frame") then
			needlist.Size=UDim2.new(needlist.Size.X.Scale,needlist.Size.X.Offset,0,uilist.AbsoluteContentSize.Y+10)
		else
			needlist.CanvasSize=UDim2.new(0,0,0,uilist.AbsoluteContentSize.Y+10)
		end
	end)
end

local serverStartTime = os.clock()

local Notify = Instance.new("ScreenGui")
Notify.Name = "NotifySystem"
Notify.IgnoreGuiInset = true
Notify.Parent = game:GetService("CoreGui")

local Container = Instance.new("Frame")
Container.Parent = Notify
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(1, 0, 1, 0)
Container.Position = UDim2.new(0, 0, 0.045, 0)

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = Container
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 8)

function CreateNotify(text, timee)
	local Noti = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TextLabel = Instance.new("TextLabel")
	local TextStroke = Instance.new("UIStroke")

	Noti.Name = "Noti"
	Noti.Parent = Container
	Noti.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	Noti.Size = UDim2.new(0, 0, 0, 40)
	Noti.ClipsDescendants = true

	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = Noti

	TextLabel.Parent = Noti
	TextLabel.BackgroundTransparency = 1
	TextLabel.Size = UDim2.new(1, 0, 1, 0)
	TextLabel.Font = Enum.Font.Montserrat
	TextLabel.Text = text
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 14
	TextLabel.TextTransparency = 1

	TextStroke.Parent = Noti
	TextStroke.Color = Color3.fromRGB(0, 170, 0)
	TextStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	local textWidth = TextLabel.TextBounds.X + 50

	TS:Create(Noti, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, textWidth, 0, 40)}):Play()
	TS:Create(TextLabel, TweenInfo.new(0.2), {TextTransparency = 0}):Play()

	local fc = {}

	function fc:Set(text)
		if not Noti then return end
		TextLabel.Text = text
		local newWidth = TextLabel.TextBounds.X + 50
		TS:Create(Noti, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, newWidth, 0, 40)}):Play()
	end

	function fc:Destroy()
		if not Noti then return end
		local outTween = TS:Create(Noti, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 40)})
		TS:Create(TextLabel, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
		outTween:Play()
		outTween.Completed:Connect(function()
			if Noti then Noti:Destroy() end
		end)
	end

	function fc:Check()
		return Noti and Noti.Parent ~= nil
	end

	if timee then
		task.delay(timee, function()
			fc:Destroy()
		end)
	end

	return fc
end

function UI:CreateWindow(options)
	local UI_1 = Instance.new("ScreenGui")
	UI_1.Name = "UI"
	UI_1.ResetOnSpawn = true
	UI_1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	UI_1.IgnoreGuiInset = false
	UI_1.Parent = game:GetService("CoreGui")

	local Frame_2 = Instance.new("Frame")
	Frame_2.Name = "Frame"
	Frame_2.Position = UDim2.new(0.500000, 0, 0.500000, 0)
	Frame_2.Size = UDim2.new(0, 750,0, 500)
	Frame_2.AnchorPoint = Vector2.new(0.500000, 0.500000)
	Frame_2.BackgroundColor3 = Theme.Background
	Frame_2.BackgroundTransparency = 0
	Frame_2.BorderSizePixel = 0
	Frame_2.ClipsDescendants = false
	Frame_2.Visible = true
	Frame_2.ZIndex = 1
	Frame_2.Parent = UI_1

	local UIU_3 = Instance.new("UICorner")
	UIU_3.Name = "UIU"
	UIU_3.CornerRadius = UDim.new(0.000000, 8)
	UIU_3.Parent = Frame_2

	local page_4 = Instance.new("Frame")
	page_4.Name = "page"
	page_4.Position = UDim2.new(0.271190, 0, 0.100000, 0)
	page_4.Size = UDim2.new(0.714667, 0, 0.880000, 0)
	page_4.AnchorPoint = Vector2.new(0.000000, 0.000000)
	page_4.BackgroundColor3 = Theme.SecondaryBackground
	page_4.BackgroundTransparency = 0
	page_4.BorderSizePixel = 0
	page_4.ClipsDescendants = false
	page_4.Visible = true
	page_4.ZIndex = 1
	page_4.Parent = Frame_2

	local UIStroke_5 = Instance.new("UIStroke")
	UIStroke_5.Name = "UIStroke"
	UIStroke_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_5.Color = Theme.StrokeColor
	UIStroke_5.Thickness = 1
	UIStroke_5.Transparency = 0
	UIStroke_5.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke_5.Parent = page_4

	local UICorner_6 = Instance.new("UICorner")
	UICorner_6.Name = "UICorner"
	UICorner_6.CornerRadius = UDim.new(0.000000, 8)
	UICorner_6.Parent = page_4

	local PageName_7 = Instance.new("TextLabel")
	PageName_7.Name = "PageName"
	PageName_7.Position = UDim2.new(0.027000, 0, 0.006818, 0)
	PageName_7.Size = UDim2.new(0.891791, 0, 0.061364, 0)
	PageName_7.AnchorPoint = Vector2.new(0.000000, 0.000000)
	PageName_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PageName_7.BackgroundTransparency = 1
	PageName_7.BorderSizePixel = 0
	PageName_7.Visible = true
	PageName_7.ZIndex = 1
	PageName_7.Text = "..."
	PageName_7.TextColor3 = Theme.TextColor
	PageName_7.TextScaled = false
	PageName_7.TextSize = 18
	PageName_7.Font = Enum.Font.Montserrat
	PageName_7.TextXAlignment = Enum.TextXAlignment.Left
	PageName_7.TextYAlignment = Enum.TextYAlignment.Center
	PageName_7.TextWrapped = false
	PageName_7.TextTransparency = 0
	PageName_7.Parent = page_4

	local search_8 = Instance.new("Frame")
	search_8.Name = "search"
	search_8.Position = UDim2.new(0.271190, 0, 0.022000, 0)
	search_8.Size = UDim2.new(0.714667, 0, 0.060000, 0)
	search_8.AnchorPoint = Vector2.new(0.000000, 0.000000)
	search_8.BackgroundColor3 = Theme.SecondaryBackground
	search_8.BackgroundTransparency = 0
	search_8.BorderSizePixel = 0
	search_8.ClipsDescendants = false
	search_8.Visible = true
	search_8.ZIndex = 1
	search_8.Parent = Frame_2

	local UICorner_9 = Instance.new("UICorner")
	UICorner_9.Name = "UICorner"
	UICorner_9.CornerRadius = UDim.new(0.000000, 8)
	UICorner_9.Parent = search_8

	local UIStroke_10 = Instance.new("UIStroke")
	UIStroke_10.Name = "UIStroke"
	UIStroke_10.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_10.Color = Theme.StrokeColor
	UIStroke_10.Thickness = 1
	UIStroke_10.Transparency = 0
	UIStroke_10.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke_10.Parent = search_8

	local Search_11 = Instance.new("ImageLabel")
	Search_11.Name = "Search"
	Search_11.Position = UDim2.new(0.015000, 0, 0.500000, 0)
	Search_11.Size = UDim2.new(0.037313, 0, 0.666667, 0)
	Search_11.AnchorPoint = Vector2.new(0.000000, 0.500000)
	Search_11.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	Search_11.BackgroundTransparency = 1
	Search_11.BorderSizePixel = 1
	Search_11.Visible = true
	Search_11.ZIndex = 1
	Search_11.Image = "rbxassetid://8445471332"
	Search_11.ImageColor3 = Theme.SubTextColor
	Search_11.ImageTransparency = 0
	Search_11.ScaleType = Enum.ScaleType.Stretch
	Search_11.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	Search_11.SliceScale = 1
	Search_11.ImageRectOffset = Vector2.new(204.000000, 104.000000)
	Search_11.ImageRectSize = Vector2.new(96.000000, 96.000000)
	Search_11.ResampleMode = Enum.ResamplerMode.Default
	Search_11.Parent = search_8

	local UIAspectRatioConstraint_12 = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint_12.Name = "UIAspectRatioConstraint"
	UIAspectRatioConstraint_12.AspectRatio = 1
	UIAspectRatioConstraint_12.AspectType = Enum.AspectType.FitWithinMaxSize
	UIAspectRatioConstraint_12.DominantAxis = Enum.DominantAxis.Height
	UIAspectRatioConstraint_12.Parent = Search_11

	local searchbox_13 = Instance.new("TextBox")
	searchbox_13.Name = "searchbox"
	searchbox_13.Position = UDim2.new(0.070000, 0, 0.000000, 0)
	searchbox_13.Size = UDim2.new(0.867537, 0, 1.000000, 0)
	searchbox_13.AnchorPoint = Vector2.new(0.000000, 0.000000)
	searchbox_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	searchbox_13.BackgroundTransparency = 1
	searchbox_13.BorderSizePixel = 0
	searchbox_13.Visible = true
	searchbox_13.ZIndex = 1
	searchbox_13.Text = ""
	searchbox_13.TextColor3 = Theme.TextColor
	searchbox_13.PlaceholderText = "Search..."
	searchbox_13.PlaceholderColor3 = Theme.SubTextColor
	searchbox_13.TextScaled = false
	searchbox_13.TextSize = 14
	searchbox_13.Font = Enum.Font.Montserrat
	searchbox_13.TextXAlignment = Enum.TextXAlignment.Left
	searchbox_13.TextYAlignment = Enum.TextYAlignment.Center
	searchbox_13.TextWrapped = false
	searchbox_13.TextTransparency = 0
	searchbox_13.ClearTextOnFocus = true
	searchbox_13.MultiLine = false
	searchbox_13.Parent = search_8

	local NameHub_14 = Instance.new("Frame")
	NameHub_14.Name = "NameHub"
	NameHub_14.Position = UDim2.new(0.015476, 0, 0.022000, 0)
	NameHub_14.Size = UDim2.new(0.230667, 0, 0.120000, 0)
	NameHub_14.AnchorPoint = Vector2.new(0.000000, 0.000000)
	NameHub_14.BackgroundColor3 = Theme.SecondaryBackground
	NameHub_14.BackgroundTransparency = 0
	NameHub_14.BorderSizePixel = 0
	NameHub_14.ClipsDescendants = false
	NameHub_14.Visible = true
	NameHub_14.ZIndex = 1
	NameHub_14.Parent = Frame_2

	local UIStroke_15 = Instance.new("UIStroke")
	UIStroke_15.Name = "UIStroke"
	UIStroke_15.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_15.Color = Theme.StrokeColor
	UIStroke_15.Thickness = 1
	UIStroke_15.Transparency = 0
	UIStroke_15.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke_15.Parent = NameHub_14

	local UICorner_16 = Instance.new("UICorner")
	UICorner_16.Name = "UICorner"
	UICorner_16.CornerRadius = UDim.new(0.000000, 8)
	UICorner_16.Parent = NameHub_14

	local ImageLabel_17 = Instance.new("ImageLabel")
	ImageLabel_17.Name = "ImageLabel"
	ImageLabel_17.Position = UDim2.new(0.050000, 0, 0.500000, 0)
	ImageLabel_17.Size = UDim2.new(0.231214, 0, 0.666667, 0)
	ImageLabel_17.AnchorPoint = Vector2.new(0.000000, 0.500000)
	ImageLabel_17.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	ImageLabel_17.BackgroundTransparency = 0
	ImageLabel_17.BorderSizePixel = 0
	ImageLabel_17.Visible = true
	ImageLabel_17.ZIndex = 1
	ImageLabel_17.Image = "rbxassetid://94632832798803"
	ImageLabel_17.ImageColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel_17.ImageTransparency = 0
	ImageLabel_17.ScaleType = Enum.ScaleType.Stretch
	ImageLabel_17.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	ImageLabel_17.SliceScale = 1
	ImageLabel_17.ImageRectOffset = Vector2.new(0.000000, 0.000000)
	ImageLabel_17.ImageRectSize = Vector2.new(0.000000, 0.000000)
	ImageLabel_17.ResampleMode = Enum.ResamplerMode.Default
	ImageLabel_17.Parent = NameHub_14

	local UICorner_18 = Instance.new("UICorner")
	UICorner_18.Name = "UICorner"
	UICorner_18.CornerRadius = UDim.new(0.000000, 8)
	UICorner_18.Parent = ImageLabel_17

	local TextLabel_19 = Instance.new("TextLabel")
	TextLabel_19.Name = "TextLabel"
	TextLabel_19.Position = UDim2.new(0.352601, 0, 0.166667, 0)
	TextLabel_19.Size = UDim2.new(0.606936, 0, 0.400000, 0)
	TextLabel_19.AnchorPoint = Vector2.new(0.000000, 0.000000)
	TextLabel_19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_19.BackgroundTransparency = 1
	TextLabel_19.BorderSizePixel = 0
	TextLabel_19.Visible = true
	TextLabel_19.ZIndex = 1
	TextLabel_19.Text = "Saw Hub"
	TextLabel_19.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_19.TextScaled = false
	TextLabel_19.TextSize = 18
	TextLabel_19.Font = Enum.Font.Montserrat
	TextLabel_19.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_19.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel_19.TextWrapped = false
	TextLabel_19.TextTransparency = 0
	TextLabel_19.Parent = NameHub_14

	local TextLabel_20 = Instance.new("TextLabel")
	TextLabel_20.Name = "TextLabel"
	TextLabel_20.Position = UDim2.new(0.352601, 0, 0.416667, 0)
	TextLabel_20.Size = UDim2.new(0.468208, 0, 0.283333, 0)
	TextLabel_20.AnchorPoint = Vector2.new(0.000000, 0.000000)
	TextLabel_20.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_20.BackgroundTransparency = 1
	TextLabel_20.BorderSizePixel = 0
	TextLabel_20.Visible = true
	TextLabel_20.ZIndex = 1
	TextLabel_20.Text = "minhblus"
	TextLabel_20.TextColor3 = Color3.fromRGB(83, 83, 83)
	TextLabel_20.TextScaled = false
	TextLabel_20.TextSize = 14
	TextLabel_20.Font = Enum.Font.Montserrat
	TextLabel_20.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_20.TextYAlignment = Enum.TextYAlignment.Bottom
	TextLabel_20.TextWrapped = false
	TextLabel_20.TextTransparency = 0
	TextLabel_20.Parent = NameHub_14

	local ListTab_21 = Instance.new("ScrollingFrame")
	ListTab_21.Name = "ListTab"
	ListTab_21.Position = UDim2.new(0.014286, 0, 0.212000, 0)
	ListTab_21.Size = UDim2.new(0.229333, 0, 0.676000, 0)
	ListTab_21.AnchorPoint = Vector2.new(0.000000, 0.000000)
	ListTab_21.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ListTab_21.BackgroundTransparency = 1
	ListTab_21.BorderSizePixel = 0
	ListTab_21.ClipsDescendants = true
	ListTab_21.Visible = true
	ListTab_21.ZIndex = 1
	ListTab_21.CanvasSize = UDim2.new(0.000000, 0, 0.000000, 0)
	ListTab_21.ScrollBarThickness = 0
	ListTab_21.ScrollingDirection = Enum.ScrollingDirection.XY
	ListTab_21.Parent = Frame_2

	local Home_22 = Instance.new("TextButton")
	Home_22.Name = "Home"
	Home_22.Position = UDim2.new(0.000000, 0, 0.000000, 0)
	Home_22.Size = UDim2.new(1.000000, -2, 0.000000, 35)
	Home_22.AnchorPoint = Vector2.new(0.000000, 0.000000)
	Home_22.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Home_22.BackgroundTransparency = 1
	Home_22.BorderSizePixel = 0
	Home_22.Visible = true
	Home_22.ZIndex = 1
	Home_22.Text = ""
	Home_22.TextColor3 = Color3.fromRGB(0, 0, 0)
	Home_22.TextScaled = false
	Home_22.TextSize = 14
	Home_22.Font = Enum.Font.SourceSans
	Home_22.TextXAlignment = Enum.TextXAlignment.Center
	Home_22.TextYAlignment = Enum.TextYAlignment.Center
	Home_22.TextWrapped = false
	Home_22.TextTransparency = 0
	Home_22.AutoButtonColor = true
	Home_22.Parent = ListTab_21

	local ImageLabel_23 = Instance.new("ImageLabel")
	ImageLabel_23.Name = "ImageLabel"
	ImageLabel_23.Position = UDim2.new(0.047000, 0, 0.500000, 0)
	ImageLabel_23.Size = UDim2.new(0.147059, 0, 0.714286, 0)
	ImageLabel_23.AnchorPoint = Vector2.new(0.000000, 0.500000)
	ImageLabel_23.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel_23.BackgroundTransparency = 1
	ImageLabel_23.BorderSizePixel = 0
	ImageLabel_23.Visible = true
	ImageLabel_23.ZIndex = 1
	ImageLabel_23.Image = "rbxassetid://16781150100"
	ImageLabel_23.ImageColor3 = Color3.fromRGB(200, 200, 200)
	ImageLabel_23.ImageTransparency = 0
	ImageLabel_23.ScaleType = Enum.ScaleType.Fit
	ImageLabel_23.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	ImageLabel_23.SliceScale = 1
	ImageLabel_23.ImageRectOffset = Vector2.new(0.000000, 0.000000)
	ImageLabel_23.ImageRectSize = Vector2.new(0.000000, 0.000000)
	ImageLabel_23.ResampleMode = Enum.ResamplerMode.Default
	ImageLabel_23.Parent = Home_22

	local TextLabel_24 = Instance.new("TextLabel")
	TextLabel_24.Name = "TextLabel"
	TextLabel_24.Position = UDim2.new(0.235294, 0, 0.142857, 0)
	TextLabel_24.Size = UDim2.new(0.735294, 0, 0.714286, 0)
	TextLabel_24.AnchorPoint = Vector2.new(0.000000, 0.000000)
	TextLabel_24.BackgroundColor3 = Color3.fromRGB(207, 207, 207)
	TextLabel_24.BackgroundTransparency = 1
	TextLabel_24.BorderSizePixel = 0
	TextLabel_24.Visible = true
	TextLabel_24.ZIndex = 1
	TextLabel_24.Text = "Home"
	TextLabel_24.TextColor3 = Color3.fromRGB(162, 162, 162)
	TextLabel_24.TextScaled = false
	TextLabel_24.TextSize = 14
	TextLabel_24.Font = Enum.Font.Montserrat
	TextLabel_24.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_24.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel_24.TextWrapped = false
	TextLabel_24.TextTransparency = 0
	TextLabel_24.Parent = Home_22

	local UIListLayout_25 = Instance.new("UIListLayout")
	UIListLayout_25.Name = "UIListLayout"
	UIListLayout_25.Padding = UDim.new(0.000000, 5)
	UIListLayout_25.FillDirection = Enum.FillDirection.Vertical
	UIListLayout_25.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_25.VerticalAlignment = Enum.VerticalAlignment.Top
	UIListLayout_25.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_25.Parent = ListTab_21

	local UIPadding_26 = Instance.new("UIPadding")
	UIPadding_26.Name = "UIPadding"
	UIPadding_26.PaddingBottom = UDim.new(0.000000, 0)
	UIPadding_26.PaddingLeft = UDim.new(0.000000, 0)
	UIPadding_26.PaddingRight = UDim.new(0.000000, 0)
	UIPadding_26.PaddingTop = UDim.new(0.000000, 1)
	UIPadding_26.Parent = ListTab_21

	local Combat_27 = Instance.new("TextButton")
	Combat_27.Name = "Combat"
	Combat_27.Position = UDim2.new(0.000000, 0, 0.000000, 0)
	Combat_27.Size = UDim2.new(1.000000, -2, 0.000000, 35)
	Combat_27.AnchorPoint = Vector2.new(0.000000, 0.000000)
	Combat_27.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Combat_27.BackgroundTransparency = 1
	Combat_27.BorderSizePixel = 0
	Combat_27.Visible = true
	Combat_27.ZIndex = 1
	Combat_27.Text = ""
	Combat_27.TextColor3 = Color3.fromRGB(0, 0, 0)
	Combat_27.TextScaled = false
	Combat_27.TextSize = 14
	Combat_27.Font = Enum.Font.SourceSans
	Combat_27.TextXAlignment = Enum.TextXAlignment.Center
	Combat_27.TextYAlignment = Enum.TextYAlignment.Center
	Combat_27.TextWrapped = false
	Combat_27.TextTransparency = 0
	Combat_27.AutoButtonColor = true
	Combat_27.Parent = ListTab_21

	local ImageLabel_28 = Instance.new("ImageLabel")
	ImageLabel_28.Name = "ImageLabel"
	ImageLabel_28.Position = UDim2.new(0.047000, 0, 0.500000, 0)
	ImageLabel_28.Size = UDim2.new(0.147059, 0, 0.714286, 0)
	ImageLabel_28.AnchorPoint = Vector2.new(0.000000, 0.500000)
	ImageLabel_28.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel_28.BackgroundTransparency = 1
	ImageLabel_28.BorderSizePixel = 0
	ImageLabel_28.Visible = true
	ImageLabel_28.ZIndex = 1
	ImageLabel_28.Image = "rbxassetid://10455604811"
	ImageLabel_28.ImageColor3 = Color3.fromRGB(200, 200, 200)
	ImageLabel_28.ImageTransparency = 0
	ImageLabel_28.ScaleType = Enum.ScaleType.Fit
	ImageLabel_28.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	ImageLabel_28.SliceScale = 1
	ImageLabel_28.ImageRectOffset = Vector2.new(0.000000, 0.000000)
	ImageLabel_28.ImageRectSize = Vector2.new(0.000000, 0.000000)
	ImageLabel_28.ResampleMode = Enum.ResamplerMode.Default
	ImageLabel_28.Parent = Combat_27

	local TextLabel_29 = Instance.new("TextLabel")
	TextLabel_29.Name = "TextLabel"
	TextLabel_29.Position = UDim2.new(0.235294, 0, 0.142857, 0)
	TextLabel_29.Size = UDim2.new(0.735294, 0, 0.714286, 0)
	TextLabel_29.AnchorPoint = Vector2.new(0.000000, 0.000000)
	TextLabel_29.BackgroundColor3 = Color3.fromRGB(207, 207, 207)
	TextLabel_29.BackgroundTransparency = 1
	TextLabel_29.BorderSizePixel = 0
	TextLabel_29.Visible = true
	TextLabel_29.ZIndex = 1
	TextLabel_29.Text = "Combat"
	TextLabel_29.TextColor3 = Color3.fromRGB(162, 162, 162)
	TextLabel_29.TextScaled = false
	TextLabel_29.TextSize = 14
	TextLabel_29.Font = Enum.Font.Montserrat
	TextLabel_29.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_29.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel_29.TextWrapped = false
	TextLabel_29.TextTransparency = 0
	TextLabel_29.Parent = Combat_27

	local Items_30 = Instance.new("TextButton")
	Items_30.Name = "Items"
	Items_30.Position = UDim2.new(0.000000, 0, 0.000000, 0)
	Items_30.Size = UDim2.new(1.000000, -2, 0.000000, 35)
	Items_30.AnchorPoint = Vector2.new(0.000000, 0.000000)
	Items_30.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Items_30.BackgroundTransparency = 1
	Items_30.BorderSizePixel = 0
	Items_30.Visible = true
	Items_30.ZIndex = 1
	Items_30.Text = ""
	Items_30.TextColor3 = Color3.fromRGB(0, 0, 0)
	Items_30.TextScaled = false
	Items_30.TextSize = 14
	Items_30.Font = Enum.Font.SourceSans
	Items_30.TextXAlignment = Enum.TextXAlignment.Center
	Items_30.TextYAlignment = Enum.TextYAlignment.Center
	Items_30.TextWrapped = false
	Items_30.TextTransparency = 0
	Items_30.AutoButtonColor = true
	Items_30.Parent = ListTab_21

	local ImageLabel_31 = Instance.new("ImageLabel")
	ImageLabel_31.Name = "ImageLabel"
	ImageLabel_31.Position = UDim2.new(0.047000, 0, 0.500000, 0)
	ImageLabel_31.Size = UDim2.new(0.147059, 0, 0.714286, 0)
	ImageLabel_31.AnchorPoint = Vector2.new(0.000000, 0.500000)
	ImageLabel_31.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel_31.BackgroundTransparency = 1
	ImageLabel_31.BorderSizePixel = 0
	ImageLabel_31.Visible = true
	ImageLabel_31.ZIndex = 1
	ImageLabel_31.Image = "rbxassetid://75691853201877"
	ImageLabel_31.ImageColor3 = Color3.fromRGB(200, 200, 200)
	ImageLabel_31.ImageTransparency = 0
	ImageLabel_31.ScaleType = Enum.ScaleType.Fit
	ImageLabel_31.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	ImageLabel_31.SliceScale = 1
	ImageLabel_31.ImageRectOffset = Vector2.new(0.000000, 0.000000)
	ImageLabel_31.ImageRectSize = Vector2.new(0.000000, 0.000000)
	ImageLabel_31.ResampleMode = Enum.ResamplerMode.Default
	ImageLabel_31.Parent = Items_30

	local TextLabel_32 = Instance.new("TextLabel")
	TextLabel_32.Name = "TextLabel"
	TextLabel_32.Position = UDim2.new(0.235294, 0, 0.142857, 0)
	TextLabel_32.Size = UDim2.new(0.735294, 0, 0.714286, 0)
	TextLabel_32.AnchorPoint = Vector2.new(0.000000, 0.000000)
	TextLabel_32.BackgroundColor3 = Color3.fromRGB(207, 207, 207)
	TextLabel_32.BackgroundTransparency = 1
	TextLabel_32.BorderSizePixel = 0
	TextLabel_32.Visible = true
	TextLabel_32.ZIndex = 1
	TextLabel_32.Text = "Items"
	TextLabel_32.TextColor3 = Color3.fromRGB(162, 162, 162)
	TextLabel_32.TextScaled = false
	TextLabel_32.TextSize = 14
	TextLabel_32.Font = Enum.Font.Montserrat
	TextLabel_32.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_32.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel_32.TextWrapped = false
	TextLabel_32.TextTransparency = 0
	TextLabel_32.Parent = Items_30

	local Players_33 = Instance.new("TextButton")
	Players_33.Name = "Players"
	Players_33.Position = UDim2.new(0.000000, 0, 0.000000, 0)
	Players_33.Size = UDim2.new(1.000000, -2, 0.000000, 35)
	Players_33.AnchorPoint = Vector2.new(0.000000, 0.000000)
	Players_33.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Players_33.BackgroundTransparency = 1
	Players_33.BorderSizePixel = 0
	Players_33.Visible = true
	Players_33.ZIndex = 1
	Players_33.Text = ""
	Players_33.TextColor3 = Color3.fromRGB(0, 0, 0)
	Players_33.TextScaled = false
	Players_33.TextSize = 14
	Players_33.Font = Enum.Font.SourceSans
	Players_33.TextXAlignment = Enum.TextXAlignment.Center
	Players_33.TextYAlignment = Enum.TextYAlignment.Center
	Players_33.TextWrapped = false
	Players_33.TextTransparency = 0
	Players_33.AutoButtonColor = true
	Players_33.Parent = ListTab_21

	local ImageLabel_34 = Instance.new("ImageLabel")
	ImageLabel_34.Name = "ImageLabel"
	ImageLabel_34.Position = UDim2.new(0.047000, 0, 0.500000, 0)
	ImageLabel_34.Size = UDim2.new(0.147059, 0, 0.714286, 0)
	ImageLabel_34.AnchorPoint = Vector2.new(0.000000, 0.500000)
	ImageLabel_34.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel_34.BackgroundTransparency = 1
	ImageLabel_34.BorderSizePixel = 0
	ImageLabel_34.Visible = true
	ImageLabel_34.ZIndex = 1
	ImageLabel_34.Image = "rbxassetid://15781236851"
	ImageLabel_34.ImageColor3 = Color3.fromRGB(200, 200, 200)
	ImageLabel_34.ImageTransparency = 0
	ImageLabel_34.ScaleType = Enum.ScaleType.Fit
	ImageLabel_34.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	ImageLabel_34.SliceScale = 1
	ImageLabel_34.ImageRectOffset = Vector2.new(0.000000, 0.000000)
	ImageLabel_34.ImageRectSize = Vector2.new(0.000000, 0.000000)
	ImageLabel_34.ResampleMode = Enum.ResamplerMode.Default
	ImageLabel_34.Parent = Players_33

	local TextLabel_35 = Instance.new("TextLabel")
	TextLabel_35.Name = "TextLabel"
	TextLabel_35.Position = UDim2.new(0.235294, 0, 0.142857, 0)
	TextLabel_35.Size = UDim2.new(0.735294, 0, 0.714286, 0)
	TextLabel_35.AnchorPoint = Vector2.new(0.000000, 0.000000)
	TextLabel_35.BackgroundColor3 = Color3.fromRGB(207, 207, 207)
	TextLabel_35.BackgroundTransparency = 1
	TextLabel_35.BorderSizePixel = 0
	TextLabel_35.Visible = true
	TextLabel_35.ZIndex = 1
	TextLabel_35.Text = "Players"
	TextLabel_35.TextColor3 = Color3.fromRGB(162, 162, 162)
	TextLabel_35.TextScaled = false
	TextLabel_35.TextSize = 14
	TextLabel_35.Font = Enum.Font.Montserrat
	TextLabel_35.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_35.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel_35.TextWrapped = false
	TextLabel_35.TextTransparency = 0
	TextLabel_35.Parent = Players_33

	local Visuals_36 = Instance.new("TextButton")
	Visuals_36.Name = "Visuals"
	Visuals_36.Position = UDim2.new(0.000000, 0, 0.000000, 0)
	Visuals_36.Size = UDim2.new(1.000000, -2, 0.000000, 35)
	Visuals_36.AnchorPoint = Vector2.new(0.000000, 0.000000)
	Visuals_36.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Visuals_36.BackgroundTransparency = 1
	Visuals_36.BorderSizePixel = 0
	Visuals_36.Visible = true
	Visuals_36.ZIndex = 1
	Visuals_36.Text = ""
	Visuals_36.TextColor3 = Color3.fromRGB(0, 0, 0)
	Visuals_36.TextScaled = false
	Visuals_36.TextSize = 14
	Visuals_36.Font = Enum.Font.SourceSans
	Visuals_36.TextXAlignment = Enum.TextXAlignment.Center
	Visuals_36.TextYAlignment = Enum.TextYAlignment.Center
	Visuals_36.TextWrapped = false
	Visuals_36.TextTransparency = 0
	Visuals_36.AutoButtonColor = true
	Visuals_36.Parent = ListTab_21

	local ImageLabel_37 = Instance.new("ImageLabel")
	ImageLabel_37.Name = "ImageLabel"
	ImageLabel_37.Position = UDim2.new(0.047000, 0, 0.500000, 0)
	ImageLabel_37.Size = UDim2.new(0.147059, 0, 0.714286, 0)
	ImageLabel_37.AnchorPoint = Vector2.new(0.000000, 0.500000)
	ImageLabel_37.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel_37.BackgroundTransparency = 1
	ImageLabel_37.BorderSizePixel = 0
	ImageLabel_37.Visible = true
	ImageLabel_37.ZIndex = 1
	ImageLabel_37.Image = "rbxassetid://551406114"
	ImageLabel_37.ImageColor3 = Color3.fromRGB(200, 200, 200)
	ImageLabel_37.ImageTransparency = 0
	ImageLabel_37.ScaleType = Enum.ScaleType.Fit
	ImageLabel_37.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	ImageLabel_37.SliceScale = 1
	ImageLabel_37.ImageRectOffset = Vector2.new(0.000000, 0.000000)
	ImageLabel_37.ImageRectSize = Vector2.new(0.000000, 0.000000)
	ImageLabel_37.ResampleMode = Enum.ResamplerMode.Default
	ImageLabel_37.Parent = Visuals_36

	local TextLabel_38 = Instance.new("TextLabel")
	TextLabel_38.Name = "TextLabel"
	TextLabel_38.Position = UDim2.new(0.235294, 0, 0.142857, 0)
	TextLabel_38.Size = UDim2.new(0.735294, 0, 0.714286, 0)
	TextLabel_38.AnchorPoint = Vector2.new(0.000000, 0.000000)
	TextLabel_38.BackgroundColor3 = Color3.fromRGB(207, 207, 207)
	TextLabel_38.BackgroundTransparency = 1
	TextLabel_38.BorderSizePixel = 0
	TextLabel_38.Visible = true
	TextLabel_38.ZIndex = 1
	TextLabel_38.Text = "Visuals"
	TextLabel_38.TextColor3 = Color3.fromRGB(162, 162, 162)
	TextLabel_38.TextScaled = false
	TextLabel_38.TextSize = 14
	TextLabel_38.Font = Enum.Font.Montserrat
	TextLabel_38.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_38.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel_38.TextWrapped = false
	TextLabel_38.TextTransparency = 0
	TextLabel_38.Parent = Visuals_36

	local Settings_39 = Instance.new("TextButton")
	Settings_39.Name = "Settings"
	Settings_39.Position = UDim2.new(0.000000, 0, 0.000000, 0)
	Settings_39.Size = UDim2.new(1.000000, -2, 0.000000, 35)
	Settings_39.AnchorPoint = Vector2.new(0.000000, 0.000000)
	Settings_39.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Settings_39.BackgroundTransparency = 1
	Settings_39.BorderSizePixel = 0
	Settings_39.Visible = true
	Settings_39.ZIndex = 1
	Settings_39.Text = ""
	Settings_39.TextColor3 = Color3.fromRGB(0, 0, 0)
	Settings_39.TextScaled = false
	Settings_39.TextSize = 14
	Settings_39.Font = Enum.Font.SourceSans
	Settings_39.TextXAlignment = Enum.TextXAlignment.Center
	Settings_39.TextYAlignment = Enum.TextYAlignment.Center
	Settings_39.TextWrapped = false
	Settings_39.TextTransparency = 0
	Settings_39.AutoButtonColor = true
	Settings_39.Parent = ListTab_21

	local ImageLabel_40 = Instance.new("ImageLabel")
	ImageLabel_40.Name = "ImageLabel"
	ImageLabel_40.Position = UDim2.new(0.047000, 0, 0.500000, 0)
	ImageLabel_40.Size = UDim2.new(0.147059, 0, 0.714286, 0)
	ImageLabel_40.AnchorPoint = Vector2.new(0.000000, 0.500000)
	ImageLabel_40.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel_40.BackgroundTransparency = 1
	ImageLabel_40.BorderSizePixel = 0
	ImageLabel_40.Visible = true
	ImageLabel_40.ZIndex = 1
	ImageLabel_40.Image = "rbxassetid://138028255370142"
	ImageLabel_40.ImageColor3 = Color3.fromRGB(200, 200, 200)
	ImageLabel_40.ImageTransparency = 0
	ImageLabel_40.ScaleType = Enum.ScaleType.Fit
	ImageLabel_40.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	ImageLabel_40.SliceScale = 1
	ImageLabel_40.ImageRectOffset = Vector2.new(0.000000, 0.000000)
	ImageLabel_40.ImageRectSize = Vector2.new(0.000000, 0.000000)
	ImageLabel_40.ResampleMode = Enum.ResamplerMode.Default
	ImageLabel_40.Parent = Settings_39

	local TextLabel_41 = Instance.new("TextLabel")
	TextLabel_41.Name = "TextLabel"
	TextLabel_41.Position = UDim2.new(0.235294, 0, 0.142857, 0)
	TextLabel_41.Size = UDim2.new(0.735294, 0, 0.714286, 0)
	TextLabel_41.AnchorPoint = Vector2.new(0.000000, 0.000000)
	TextLabel_41.BackgroundColor3 = Color3.fromRGB(207, 207, 207)
	TextLabel_41.BackgroundTransparency = 1
	TextLabel_41.BorderSizePixel = 0
	TextLabel_41.Visible = true
	TextLabel_41.ZIndex = 1
	TextLabel_41.Text = "Settings"
	TextLabel_41.TextColor3 = Color3.fromRGB(162, 162, 162)
	TextLabel_41.TextScaled = false
	TextLabel_41.TextSize = 14
	TextLabel_41.Font = Enum.Font.Montserrat
	TextLabel_41.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_41.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel_41.TextWrapped = false
	TextLabel_41.TextTransparency = 0
	TextLabel_41.Parent = Settings_39

	local others_42 = Instance.new("Frame")
	others_42.Name = "others"
	others_42.Position = UDim2.new(0.014048, 0, 0.910000, 0)
	others_42.Size = UDim2.new(0.222667, 0, 0.070000, 0)
	others_42.AnchorPoint = Vector2.new(0.000000, 0.000000)
	others_42.BackgroundColor3 = Color3.fromRGB(18, 20, 22)
	others_42.BackgroundTransparency = 0
	others_42.BorderSizePixel = 0
	others_42.ClipsDescendants = false
	others_42.Visible = true
	others_42.ZIndex = 1
	others_42.Parent = Frame_2

	local UIStroke_43 = Instance.new("UIStroke")
	UIStroke_43.Name = "UIStroke"
	UIStroke_43.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_43.Color = Color3.fromRGB(37, 37, 37)
	UIStroke_43.Thickness = 1
	UIStroke_43.Transparency = 0
	UIStroke_43.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke_43.Parent = others_42

	local UICorner_44 = Instance.new("UICorner")
	UICorner_44.Name = "UICorner"
	UICorner_44.CornerRadius = UDim.new(0.000000, 8)
	UICorner_44.Parent = others_42

	local TextLabel_45 = Instance.new("TextLabel")
	TextLabel_45.Name = "TextLabel"
	TextLabel_45.Position = UDim2.new(0.027833, 0, 0.160000, 0)
	TextLabel_45.Size = UDim2.new(0.217333, 0, 0.052000, 0)
	TextLabel_45.AnchorPoint = Vector2.new(0.000000, 0.000000)
	TextLabel_45.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_45.BackgroundTransparency = 1
	TextLabel_45.BorderSizePixel = 0
	TextLabel_45.Visible = true
	TextLabel_45.ZIndex = 1
	TextLabel_45.Text = "Category"
	TextLabel_45.TextColor3 = Color3.fromRGB(126, 126, 126)
	TextLabel_45.TextScaled = false
	TextLabel_45.TextSize = 14
	TextLabel_45.Font = Enum.Font.Montserrat
	TextLabel_45.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_45.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel_45.TextWrapped = false
	TextLabel_45.TextTransparency = 0
	TextLabel_45.Parent = Frame_2

	local Bar_46 = Instance.new("Frame")
	Bar_46.Name = "Bar"
	Bar_46.Position = UDim2.new(0.5, 0, 0.000000, -39)
	Bar_46.Size = UDim2.new(0.000000, 749, 0.000000, 30)
	Bar_46.AnchorPoint = Vector2.new(0.5, 0.000000)
	Bar_46.BackgroundColor3 = Color3.fromRGB(17, 19, 21)
	Bar_46.BackgroundTransparency = 0
	Bar_46.BorderSizePixel = 0
	Bar_46.ClipsDescendants = false
	Bar_46.Visible = true
	Bar_46.ZIndex = 1
	Bar_46.Parent = Frame_2

	local UUU_47 = Instance.new("UICorner")
	UUU_47.Name = "UUU"
	UUU_47.CornerRadius = UDim.new(0.000000, 8)
	UUU_47.Parent = Bar_46

	local U1_48 = Instance.new("UIStroke")
	U1_48.Name = "U1"
	U1_48.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	U1_48.Color = Color3.fromRGB(37, 37, 37)
	U1_48.Thickness = 1
	U1_48.Transparency = 0
	U1_48.LineJoinMode = Enum.LineJoinMode.Round
	U1_48.Parent = Bar_46

	local TextLabel_49 = Instance.new("TextLabel")
	TextLabel_49.Name = "TextLabel"
	TextLabel_49.Position = UDim2.new(0.015476, 0, 0.000000, 0)
	TextLabel_49.Size = UDim2.new(0.345333, 0, 0.900000, 0)
	TextLabel_49.AnchorPoint = Vector2.new(0.000000, 0.000000)
	TextLabel_49.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_49.BackgroundTransparency = 1
	TextLabel_49.BorderSizePixel = 0
	TextLabel_49.Visible = true
	TextLabel_49.ZIndex = 1
	TextLabel_49.Text = "Bedwars | 240 FPS | 00:00:00 | v1.0.0"
	TextLabel_49.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_49.TextScaled = true
	TextLabel_49.TextSize = 14
	TextLabel_49.Font = Enum.Font.MontserratBold
	TextLabel_49.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_49.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel_49.TextWrapped = false
	TextLabel_49.TextTransparency = 0
	TextLabel_49.Parent = Bar_46

	local Notify = Instance.new("Frame")
	local NotiList = Instance.new("UIListLayout")
	local NotiPadding = Instance.new("UIPadding")

	Notify.Name = "Notify"
	Notify.Parent = UI_1
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

	local lib={}
	function lib:Notify(message, options)
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

	local fps = 0
	local frameCount = 0
	local gameName = "Unknown Game"
	local lastTime = os.clock()
	local MarketplaceService = game:GetService("MarketplaceService")

	local success, info = pcall(function()
		return MarketplaceService:GetProductInfo(game.PlaceId)
	end)

	if success and info then
		gameName = info.Name
		print(gameName)
	end

	local function convertSecondsToTime(seconds)
		local hours = math.floor(seconds / 3600)
		local minutes = math.floor((seconds % 3600) / 60)
		local secs = seconds % 60
		return string.format("%02d:%02d:%02d", hours, minutes, secs)
	end

	local statusUpdateAccumulator = 0
	RunService.Heartbeat:Connect(function(deltaTime)
		statusUpdateAccumulator = statusUpdateAccumulator + deltaTime
		frameCount =frameCount+ 1
		local currentTime = os.clock()

		if currentTime - lastTime >= 1 and statusUpdateAccumulator >= 0.25 then
			fps = frameCount
			frameCount = 0
			lastTime = currentTime
			statusUpdateAccumulator = 0
			local serverTime = math.floor(os.clock() - serverStartTime)

			TextLabel_49.Text=gameName.." | "..fps .." FPS | "..convertSecondsToTime(serverTime).." | v1.0.0"
		end
	end)

	local Close_50 = Instance.new("ImageButton")
	Close_50.Name = "Close"
	Close_50.Position = UDim2.new(0.953333, 0, 0.100000, 0)
	Close_50.Size = UDim2.new(0.032000, 0, 0.800000, 0)
	Close_50.AnchorPoint = Vector2.new(0.000000, 0.000000)
	Close_50.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	Close_50.BackgroundTransparency = 1
	Close_50.BorderSizePixel = 1
	Close_50.Visible = true
	Close_50.ZIndex = 1
	Close_50.Image = "rbxassetid://8445470984"
	Close_50.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Close_50.ImageTransparency = 0
	Close_50.ScaleType = Enum.ScaleType.Stretch
	Close_50.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	Close_50.SliceScale = 1
	Close_50.ImageRectOffset = Vector2.new(304.000000, 304.000000)
	Close_50.ImageRectSize = Vector2.new(96.000000, 96.000000)
	Close_50.ResampleMode = Enum.ResamplerMode.Default
	Close_50.Parent = Bar_46

	local UIAspectRatioConstraint_51 = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint_51.Name = "UIAspectRatioConstraint"
	UIAspectRatioConstraint_51.AspectRatio = 1
	UIAspectRatioConstraint_51.AspectType = Enum.AspectType.FitWithinMaxSize
	UIAspectRatioConstraint_51.DominantAxis = Enum.DominantAxis.Height
	UIAspectRatioConstraint_51.Parent = Close_50

	local Remove_52 = Instance.new("ImageButton")
	Remove_52.Name = "Remove"
	Remove_52.Position = UDim2.new(0.907877, 0, 0.100000, 0)
	Remove_52.Size = UDim2.new(0.000000, 24, 0.000000, 24)
	Remove_52.AnchorPoint = Vector2.new(0.000000, 0.000000)
	Remove_52.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	Remove_52.BackgroundTransparency = 1
	Remove_52.BorderSizePixel = 1
	Remove_52.Visible = true
	Remove_52.ZIndex = 1
	Remove_52.Image = "rbxassetid://8445471499"
	Remove_52.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Remove_52.ImageTransparency = 0
	Remove_52.ScaleType = Enum.ScaleType.Stretch
	Remove_52.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	Remove_52.SliceScale = 1
	Remove_52.ImageRectOffset = Vector2.new(104.000000, 904.000000)
	Remove_52.ImageRectSize = Vector2.new(96.000000, 96.000000)
	Remove_52.ResampleMode = Enum.ResamplerMode.Default
	Remove_52.Parent = Bar_46

	local UIAspectRatioConstraint_53 = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint_53.Name = "UIAspectRatioConstraint"
	UIAspectRatioConstraint_53.AspectRatio = 1
	UIAspectRatioConstraint_53.AspectType = Enum.AspectType.FitWithinMaxSize
	UIAspectRatioConstraint_53.DominantAxis = Enum.DominantAxis.Height
	UIAspectRatioConstraint_53.Parent = Remove_52

	local Add_54 = Instance.new("ImageButton")
	Add_54.Name = "Add"
	Add_54.Position = UDim2.new(0.907877, 0, 0.100000, 0)
	Add_54.Size = UDim2.new(0.000000, 24, 0.000000, 24)
	Add_54.AnchorPoint = Vector2.new(0.000000, 0.000000)
	Add_54.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	Add_54.BackgroundTransparency = 1
	Add_54.BorderSizePixel = 1
	Add_54.Visible = false
	Add_54.ZIndex = 1
	Add_54.Image = "rbxassetid://8445470984"
	Add_54.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Add_54.ImageTransparency = 0
	Add_54.ScaleType = Enum.ScaleType.Stretch
	Add_54.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	Add_54.SliceScale = 1
	Add_54.ImageRectOffset = Vector2.new(804.000000, 704.000000)
	Add_54.ImageRectSize = Vector2.new(96.000000, 96.000000)
	Add_54.ResampleMode = Enum.ResamplerMode.Default
	Add_54.Parent = Bar_46

	local UIAspectRatioConstraint_55 = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint_55.Name = "UIAspectRatioConstraint"
	UIAspectRatioConstraint_55.AspectRatio = 1
	UIAspectRatioConstraint_55.AspectType = Enum.AspectType.FitWithinMaxSize
	UIAspectRatioConstraint_55.DominantAxis = Enum.DominantAxis.Height
	UIAspectRatioConstraint_55.Parent = Add_54

	local Temp_56 = Instance.new("Frame")
	Temp_56.Name = "Temp"
	Temp_56.Position = UDim2.new(0.014000, 0, 0.212000, 0)
	Temp_56.Size = UDim2.new(0.229000, 0, 0.676000, 0)
	Temp_56.AnchorPoint = Vector2.new(0.000000, 0.000000)
	Temp_56.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Temp_56.BackgroundTransparency = 1
	Temp_56.BorderSizePixel = 0
	Temp_56.ClipsDescendants = false
	Temp_56.Visible = true
	Temp_56.ZIndex = 1
	Temp_56.Parent = Frame_2

	local ChooseTab_57 = Instance.new("Frame")
	ChooseTab_57.Name = "ChooseTab"
	ChooseTab_57.Position = UDim2.new(0.500000, 0, 0.000000, 1)
	ChooseTab_57.Size = UDim2.new(1.000000, -2, 0.000000, 35)
	ChooseTab_57.AnchorPoint = Vector2.new(0.500000, 0.000000)
	ChooseTab_57.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ChooseTab_57.BackgroundTransparency = 1
	ChooseTab_57.BorderSizePixel = 0
	ChooseTab_57.ClipsDescendants = false
	ChooseTab_57.Visible = true
	ChooseTab_57.ZIndex = 1
	ChooseTab_57.Parent = Temp_56

	local U_58 = Instance.new("UICorner")
	U_58.Name = "U"
	U_58.CornerRadius = UDim.new(0.000000, 8)
	U_58.Parent = ChooseTab_57

	local UU_59 = Instance.new("UIStroke")
	UU_59.Name = "UU"
	UU_59.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UU_59.Color = Color3.fromRGB(66, 197, 197)
	UU_59.Thickness = 1
	UU_59.Transparency = 0
	UU_59.LineJoinMode = Enum.LineJoinMode.Round
	UU_59.Parent = ChooseTab_57


	local Keyb_1 = Instance.new("TextButton")
	Keyb_1.Name = "Keyb"
	Keyb_1.Position = UDim2.new(0.810000, 0, 0.500000, 0)
	Keyb_1.Size = UDim2.new(0.000000, 67, 0.000000, 20)
	Keyb_1.AnchorPoint = Vector2.new(0.000000, 0.500000)
	Keyb_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Keyb_1.BackgroundTransparency = 1
	Keyb_1.BorderSizePixel = 0
	Keyb_1.Visible = true
	Keyb_1.ZIndex = 1
	Keyb_1.Text = "Button"
	Keyb_1.TextColor3 = Color3.fromRGB(0, 0, 0)
	Keyb_1.TextScaled = false
	Keyb_1.TextSize = 14
	Keyb_1.Font = Enum.Font.SourceSans
	Keyb_1.TextXAlignment = Enum.TextXAlignment.Center
	Keyb_1.TextYAlignment = Enum.TextYAlignment.Center
	Keyb_1.TextWrapped = false
	Keyb_1.TextTransparency = 0
	Keyb_1.AutoButtonColor = true
	Keyb_1.Parent = Bar_46

	local UICorner_2 = Instance.new("UICorner")
	UICorner_2.Name = "UICorner"
	UICorner_2.CornerRadius = UDim.new(0.000000, 8)
	UICorner_2.Parent = Keyb_1

	local UIStroke_3 = Instance.new("UIStroke")
	UIStroke_3.Name = "UIStroke"
	UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_3.Color = Color3.fromRGB(0, 170, 0)
	UIStroke_3.Thickness = 1
	UIStroke_3.Transparency = 0
	UIStroke_3.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke_3.Parent = Keyb_1

	local K_4 = Instance.new("TextLabel")
	K_4.Name = "K"
	K_4.Position = UDim2.new(0.500000, 0, 0.500000, 0)
	K_4.Size = UDim2.new(1.000000, -10, 1.000000, 0)
	K_4.AnchorPoint = Vector2.new(0.500000, 0.500000)
	K_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	K_4.BackgroundTransparency = 1
	K_4.BorderSizePixel = 0
	K_4.Visible = true
	K_4.ZIndex = 1

	K_4.Text = "RightShift"
	K_4.TextColor3 = Color3.fromRGB(0, 170, 0)
	K_4.TextScaled = false
	K_4.TextSize = 10
	K_4.Font = Enum.Font.MontserratBold
	K_4.TextXAlignment = Enum.TextXAlignment.Center
	K_4.TextYAlignment = Enum.TextYAlignment.Center
	K_4.TextWrapped = false
	K_4.TextTransparency = 0
	K_4.Parent = Keyb_1
	K_4.FontFace.Weight=Enum.FontWeight.Bold

	

	local Config2_1 = Instance.new("Frame")
	Config2_1.Name = "Config2"
	Config2_1.Position = UDim2.new(0.500000, 0, 0.068000, 0)
	Config2_1.Size = UDim2.new(1.000000, -10, 0.018364, 402)
	Config2_1.AnchorPoint = Vector2.new(0.500000, 0.000000)
	Config2_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Config2_1.BackgroundTransparency = 1
	Config2_1.BorderSizePixel = 0
	Config2_1.ClipsDescendants = false
	Config2_1.Visible = false
	Config2_1.ZIndex = 1
	Config2_1.Parent = page_4

	local ConfigBox_2 = Instance.new("TextBox")
	ConfigBox_2.Name = "ConfigBox"
	ConfigBox_2.Position = UDim2.new(0.017110, 0, 0.000000, 0)
	ConfigBox_2.Size = UDim2.new(0.000000, 200, 0.000000, 32)
	ConfigBox_2.AnchorPoint = Vector2.new(0.000000, 0.000000)
	ConfigBox_2.BackgroundColor3 = Color3.fromRGB(18, 20, 22)
	ConfigBox_2.BackgroundTransparency = 0
	ConfigBox_2.BorderSizePixel = 0
	ConfigBox_2.Visible = true
	ConfigBox_2.ZIndex = 1
	ConfigBox_2.Text = ""
	ConfigBox_2.TextColor3 = Color3.fromRGB(200, 200, 200)
	ConfigBox_2.TextScaled = false
	ConfigBox_2.TextSize = 14
	ConfigBox_2.Font = Enum.Font.Gotham
	ConfigBox_2.TextXAlignment = Enum.TextXAlignment.Center
	ConfigBox_2.TextYAlignment = Enum.TextYAlignment.Center
	ConfigBox_2.TextWrapped = false
	ConfigBox_2.TextTransparency = 0
	ConfigBox_2.ClearTextOnFocus = true
	ConfigBox_2.MultiLine = false
	ConfigBox_2.Parent = Config2_1

	local asda_3 = Instance.new("UICorner")
	asda_3.Name = "asda"
	asda_3.CornerRadius = UDim.new(0.000000, 8)
	asda_3.Parent = ConfigBox_2

	local gawg_4 = Instance.new("UIStroke")
	gawg_4.Name = "gawg"
	gawg_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	gawg_4.Color = Color3.fromRGB(37, 37, 37)
	gawg_4.Thickness = 1
	gawg_4.Transparency = 0
	gawg_4.LineJoinMode = Enum.LineJoinMode.Round
	gawg_4.Parent = ConfigBox_2

	local Create_5 = Instance.new("TextButton")
	Create_5.Name = "Create"
	Create_5.Position = UDim2.new(0.566540, 0, 0.039901, 0)
	Create_5.Size = UDim2.new(0.000000, 81, 0.000000, 32)
	Create_5.AnchorPoint = Vector2.new(1.000000, 0.500000)
	Create_5.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	Create_5.BackgroundTransparency = 0
	Create_5.BorderSizePixel = 0
	Create_5.Visible = true
	Create_5.ZIndex = 1
	Create_5.Text = "Create"
	Create_5.TextColor3 = Color3.fromRGB(156, 156, 156)
	Create_5.TextScaled = false
	Create_5.TextSize = 12
	Create_5.Font = Enum.Font.GothamBold
	Create_5.TextXAlignment = Enum.TextXAlignment.Center
	Create_5.TextYAlignment = Enum.TextYAlignment.Center
	Create_5.TextWrapped = true
	Create_5.TextTransparency = 0
	Create_5.AutoButtonColor = true
	Create_5.Parent = Config2_1

	local fsac_6 = Instance.new("UICorner")
	fsac_6.Name = "fsac"
	fsac_6.CornerRadius = UDim.new(0.000000, 8)
	fsac_6.Parent = Create_5

	local wfasf_7 = Instance.new("UIStroke")
	wfasf_7.Name = "wfasf"
	wfasf_7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	wfasf_7.Color = Color3.fromRGB(71, 71, 71)
	wfasf_7.Thickness = 1
	wfasf_7.Transparency = 0
	wfasf_7.LineJoinMode = Enum.LineJoinMode.Round
	wfasf_7.Parent = Create_5

	local Save_8 = Instance.new("TextButton")
	Save_8.Name = "Save"
	Save_8.Position = UDim2.new(0.859316, 0, 0.037413, 0)
	Save_8.Size = UDim2.new(0.000000, 65, 0.000000, 32)
	Save_8.AnchorPoint = Vector2.new(1.000000, 0.500000)
	Save_8.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	Save_8.BackgroundTransparency = 0
	Save_8.BorderSizePixel = 0
	Save_8.Visible = false
	Save_8.ZIndex = 1
	Save_8.Text = "Save"
	Save_8.TextColor3 = Color3.fromRGB(156, 156, 156)
	Save_8.TextScaled = false
	Save_8.TextSize = 12
	Save_8.Font = Enum.Font.GothamBold
	Save_8.TextXAlignment = Enum.TextXAlignment.Center
	Save_8.TextYAlignment = Enum.TextYAlignment.Center
	Save_8.TextWrapped = true
	Save_8.TextTransparency = 0
	Save_8.AutoButtonColor = true
	Save_8.Parent = Config2_1

	local acvsa_9 = Instance.new("UICorner")
	acvsa_9.Name = "acvsa"
	acvsa_9.CornerRadius = UDim.new(0.000000, 8)
	acvsa_9.Parent = Save_8

	local wrsf_10 = Instance.new("UIStroke")
	wrsf_10.Name = "wrsf"
	wrsf_10.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	wrsf_10.Color = Color3.fromRGB(71, 71, 71)
	wrsf_10.Thickness = 1
	wrsf_10.Transparency = 0
	wrsf_10.LineJoinMode = Enum.LineJoinMode.Round
	wrsf_10.Parent = Save_8

	local Delete_11 = Instance.new("TextButton")
	Delete_11.Name = "Delete"
	Delete_11.Position = UDim2.new(0.996198, 0, 0.039901, 0)
	Delete_11.Size = UDim2.new(0.000000, 65, 0.000000, 32)
	Delete_11.AnchorPoint = Vector2.new(1.000000, 0.500000)
	Delete_11.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	Delete_11.BackgroundTransparency = 0
	Delete_11.BorderSizePixel = 0
	Delete_11.Visible = false
	Delete_11.ZIndex = 1
	Delete_11.Text = "Delete"
	Delete_11.TextColor3 = Color3.fromRGB(156, 156, 156)
	Delete_11.TextScaled = false
	Delete_11.TextSize = 12
	Delete_11.Font = Enum.Font.GothamBold
	Delete_11.TextXAlignment = Enum.TextXAlignment.Center
	Delete_11.TextYAlignment = Enum.TextYAlignment.Center
	Delete_11.TextWrapped = true
	Delete_11.TextTransparency = 0
	Delete_11.AutoButtonColor = true
	Delete_11.Parent = Config2_1

	local abvca_12 = Instance.new("UICorner")
	abvca_12.Name = "abvca"
	abvca_12.CornerRadius = UDim.new(0.000000, 8)
	abvca_12.Parent = Delete_11

	local faf_13 = Instance.new("UIStroke")
	faf_13.Name = "faf"
	faf_13.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	faf_13.Color = Color3.fromRGB(71, 71, 71)
	faf_13.Thickness = 1
	faf_13.Transparency = 0
	faf_13.LineJoinMode = Enum.LineJoinMode.Round
	faf_13.Parent = Delete_11

	local ListConfig_14 = Instance.new("ScrollingFrame")
	ListConfig_14.Name = "ListConfig"
	ListConfig_14.Position = UDim2.new(0.017110, 0, 0.104478, 0)
	ListConfig_14.Size = UDim2.new(0.000000, 520, 0.000000, 326)
	ListConfig_14.AnchorPoint = Vector2.new(0.000000, 0.000000)
	ListConfig_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ListConfig_14.BackgroundTransparency = 1
	ListConfig_14.BorderSizePixel = 0
	ListConfig_14.ClipsDescendants = true
	ListConfig_14.Visible = true
	ListConfig_14.ZIndex = 1
	ListConfig_14.CanvasSize = UDim2.new(0.000000, 0, 2.000000, 0)
	ListConfig_14.ScrollBarThickness = 5
	ListConfig_14.ScrollingDirection = Enum.ScrollingDirection.XY
	ListConfig_14.Parent = Config2_1

	local UIGridLayout_15 = Instance.new("UIGridLayout")
	UIGridLayout_15.Name = "UIGridLayout"
	UIGridLayout_15.CellPadding = UDim2.new(0.000000, 10, 0.000000, 10)
	UIGridLayout_15.CellSize = UDim2.new(0.500000, -10, 0.000000, 75)
	UIGridLayout_15.FillDirection = Enum.FillDirection.Horizontal
	UIGridLayout_15.FillDirectionMaxCells = 0
	UIGridLayout_15.HorizontalAlignment = Enum.HorizontalAlignment.Left
	UIGridLayout_15.VerticalAlignment = Enum.VerticalAlignment.Top
	UIGridLayout_15.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout_15.Parent = ListConfig_14

	local UIPadding_16 = Instance.new("UIPadding")
	UIPadding_16.Name = "UIPadding"
	UIPadding_16.PaddingBottom = UDim.new(0.000000, 0)
	UIPadding_16.PaddingLeft = UDim.new(0.000000, 1)
	UIPadding_16.PaddingRight = UDim.new(0.000000, 0)
	UIPadding_16.PaddingTop = UDim.new(0.000000, 1)
	UIPadding_16.Parent = ListConfig_14

	local AutoLoadConText_17 = Instance.new("TextButton")
	AutoLoadConText_17.Name = "AutoLoadConText"
	AutoLoadConText_17.Position = UDim2.new(0.717000, 0, 0.040000, 0)
	AutoLoadConText_17.Size = UDim2.new(0.000000, 72, 0.000000, 33)
	AutoLoadConText_17.AnchorPoint = Vector2.new(1.000000, 0.500000)
	AutoLoadConText_17.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	AutoLoadConText_17.BackgroundTransparency = 0
	AutoLoadConText_17.BorderSizePixel = 0
	AutoLoadConText_17.Visible = true
	AutoLoadConText_17.ZIndex = 1
	AutoLoadConText_17.Text = "Auto Load"
	AutoLoadConText_17.TextColor3 = Color3.fromRGB(255, 255, 255)
	AutoLoadConText_17.TextScaled = false
	AutoLoadConText_17.TextSize = 12
	AutoLoadConText_17.Font = Enum.Font.GothamBold
	AutoLoadConText_17.TextXAlignment = Enum.TextXAlignment.Center
	AutoLoadConText_17.TextYAlignment = Enum.TextYAlignment.Center
	AutoLoadConText_17.TextWrapped = false
	AutoLoadConText_17.AutoButtonColor=false
	AutoLoadConText_17.TextTransparency = 0
	AutoLoadConText_17.Parent = Config2_1

	local asda_18 = Instance.new("UICorner")
	asda_18.Name = "asda"
	asda_18.CornerRadius = UDim.new(0.000000, 8)
	asda_18.Parent = AutoLoadConText_17

	local gawg_19 = Instance.new("UIStroke")
	gawg_19.Name = "gawg"
	gawg_19.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	gawg_19.Color = Color3.fromRGB(37, 37, 37)
	gawg_19.Thickness = 1
	gawg_19.Transparency = 0
	gawg_19.LineJoinMode = Enum.LineJoinMode.Round
	gawg_19.Parent = AutoLoadConText_17
	
	AddListCanva(UIGridLayout_15,ListConfig_14)
	
	local function checkcfsame()
		for i,v in pairs(ListConfig_14:GetChildren()) do
			if v:IsA("TextButton") then
				if v.Name==ConfigBox_2.Text then
					return true
					
				end
			end
		end
		return false
	end
	
	local cfchoose
	
	local function rsconfig()
		for i,v in pairs(ListConfig_14:GetChildren()) do
			if v:IsA("TextButton") then
				v.geg.Color=Color3.fromRGB(37, 37, 37)
			end
		end
	end

    
    if not isfolder("Sawhub") then
        makefolder("Sawhub")
    end
    if not isfolder("Sawhub/Config") then
        makefolder("Sawhub/Config")
    end
    local allconfig=listfiles("Sawhub/Config")

    local orguisetting = {
        AutoLoad=false,
        SelectConfig="",
        Keybind="RightShift"
    }

    local nameuicf="UI-"..game:GetService("Players").LocalPlayer.Name
    if not isfile("Sawhub/"..nameuicf..".json") then
        writefile("Sawhub/"..nameuicf..".json",game:GetService("HttpService"):JSONEncode(orguisetting))
    end
    local guisetting=game:GetService("HttpService"):JSONDecode(readfile("Sawhub/"..nameuicf..".json"))

    local function createconfigbutton(name,time)
        local Config_1 = Instance.new("TextButton")
        Config_1.Name = name
        Config_1.Position = UDim2.new(0.000000, 0, 0.000000, 0)
        Config_1.Size = UDim2.new(0.000000, 200, 0.000000, 50)
        Config_1.AnchorPoint = Vector2.new(0.000000, 0.000000)
        Config_1.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
        Config_1.BackgroundTransparency = 0
        Config_1.BorderSizePixel = 0
        Config_1.Visible = true
        Config_1.ZIndex = 1
        Config_1.Text = ""
        Config_1.TextColor3 = Color3.fromRGB(0, 0, 0)
        Config_1.TextScaled = false
        Config_1.TextSize = 14
        Config_1.Font = Enum.Font.SourceSans
        Config_1.TextXAlignment = Enum.TextXAlignment.Center
        Config_1.TextYAlignment = Enum.TextYAlignment.Center
        Config_1.TextWrapped = false
        Config_1.TextTransparency = 0
        Config_1.AutoButtonColor = false
        Config_1.Parent = ListConfig_14

        local faf_2 = Instance.new("UICorner")
        faf_2.Name = "faf"
        faf_2.CornerRadius = UDim.new(0.000000, 8)
        faf_2.Parent = Config_1

        local geg_3 = Instance.new("UIStroke")
        geg_3.Name = "geg"
        geg_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        geg_3.Color = Color3.fromRGB(37, 37, 37)
        geg_3.Thickness = 1
        geg_3.Transparency = 0
        geg_3.LineJoinMode = Enum.LineJoinMode.Round
        geg_3.Parent = Config_1

        local F_4 = Instance.new("Frame")
        F_4.Name = "F"
        F_4.Position = UDim2.new(0.052000, 0, 0.500000, 0)
        F_4.Size = UDim2.new(0.000000, 54, 0.000000, 54)
        F_4.AnchorPoint = Vector2.new(0.000000, 0.500000)
        F_4.BackgroundColor3 = Color3.fromRGB(18, 20, 22)
        F_4.BackgroundTransparency = 0
        F_4.BorderSizePixel = 0
        F_4.ClipsDescendants = false
        F_4.Visible = true
        F_4.ZIndex = 1
        F_4.Parent = Config_1

        local aaa_5 = Instance.new("UICorner")
        aaa_5.Name = "aaa"
        aaa_5.CornerRadius = UDim.new(0.000000, 8)
        aaa_5.Parent = F_4

        local File_6 = Instance.new("ImageLabel")
        File_6.Name = "File"
        File_6.Position = UDim2.new(0.500000, 0, 0.500000, 0)
        File_6.Size = UDim2.new(0.000000, 24, 0.000000, 24)
        File_6.AnchorPoint = Vector2.new(0.500000, 0.500000)
        File_6.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
        File_6.BackgroundTransparency = 1
        File_6.BorderSizePixel = 1
        File_6.Visible = true
        File_6.ZIndex = 1
        File_6.Image = "rbxassetid://8445471499"
        File_6.ImageColor3 = Color3.fromRGB(255, 255, 255)
        File_6.ImageTransparency = 0
        File_6.ScaleType = Enum.ScaleType.Stretch
        File_6.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
        File_6.SliceScale = 1
        File_6.ImageRectOffset = Vector2.new(304.000000, 4.000000)
        File_6.ImageRectSize = Vector2.new(96.000000, 96.000000)
        File_6.ResampleMode = Enum.ResamplerMode.Default
        File_6.Parent = F_4

        local UIAspectRatioConstraint_7 = Instance.new("UIAspectRatioConstraint")
        UIAspectRatioConstraint_7.Name = "UIAspectRatioConstraint"
        UIAspectRatioConstraint_7.AspectRatio = 1
        UIAspectRatioConstraint_7.AspectType = Enum.AspectType.FitWithinMaxSize
        UIAspectRatioConstraint_7.DominantAxis = Enum.DominantAxis.Height
        UIAspectRatioConstraint_7.Parent = File_6

        local NameConfig_8 = Instance.new("TextLabel")
        NameConfig_8.Name = "NameConfig"
        NameConfig_8.Position = UDim2.new(1.166667, 0, 0.055556, 0)
        NameConfig_8.Size = UDim2.new(0.000000, 160, 0.000000, 21)
        NameConfig_8.AnchorPoint = Vector2.new(0.000000, 0.000000)
        NameConfig_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NameConfig_8.BackgroundTransparency = 1
        NameConfig_8.BorderSizePixel = 0
        NameConfig_8.Visible = true
        NameConfig_8.ZIndex = 1
        NameConfig_8.Text = name
        NameConfig_8.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameConfig_8.TextScaled = false
        NameConfig_8.TextSize = 16
        NameConfig_8.Font = Enum.Font.GothamBold
        NameConfig_8.TextXAlignment = Enum.TextXAlignment.Left
        NameConfig_8.TextYAlignment = Enum.TextYAlignment.Bottom
        NameConfig_8.TextWrapped = false
        NameConfig_8.TextTransparency = 0
        NameConfig_8.Parent = F_4

        local Date_9 = Instance.new("TextLabel")
        Date_9.Name = "Date"
        Date_9.Position = UDim2.new(1.166667, 0, 0.444444, 0)
        Date_9.Size = UDim2.new(0.000000, 160, 0.000000, 21)
        Date_9.AnchorPoint = Vector2.new(0.000000, 0.000000)
        Date_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Date_9.BackgroundTransparency = 1
        Date_9.BorderSizePixel = 0
        Date_9.Visible = true
        Date_9.ZIndex = 1
        Date_9.Text = "Created "..time
        Date_9.TextColor3 = Color3.fromRGB(89, 89, 89)
        Date_9.TextScaled = false
        Date_9.TextSize = 13
        Date_9.Font = Enum.Font.Gotham
        Date_9.TextXAlignment = Enum.TextXAlignment.Left
        Date_9.TextYAlignment = Enum.TextYAlignment.Center
        Date_9.TextWrapped = false
        Date_9.TextTransparency = 0
        Date_9.Parent = F_4

        local ContentCopy_10 = Instance.new("ImageButton")
        ContentCopy_10.Name = "ContentCopy"
        ContentCopy_10.Position = UDim2.new(1.000000, -8, 0.000000, 8)
        ContentCopy_10.Size = UDim2.new(0.000000, 12, 0.000000, 12)
        ContentCopy_10.AnchorPoint = Vector2.new(1.000000, 0.000000)
        ContentCopy_10.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
        ContentCopy_10.BackgroundTransparency = 1
        ContentCopy_10.BorderSizePixel = 1
        ContentCopy_10.Visible = true
        ContentCopy_10.ZIndex = 1
        ContentCopy_10.Image = "rbxassetid://8445470559"
        ContentCopy_10.ImageColor3 = Color3.fromRGB(255, 255, 255)
        ContentCopy_10.ImageTransparency = 0
        ContentCopy_10.ScaleType = Enum.ScaleType.Stretch
        ContentCopy_10.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
        ContentCopy_10.SliceScale = 1
        ContentCopy_10.ImageRectOffset = Vector2.new(204.000000, 804.000000)
        ContentCopy_10.ImageRectSize = Vector2.new(96.000000, 96.000000)
        ContentCopy_10.ResampleMode = Enum.ResamplerMode.Default
        ContentCopy_10.Parent = Config_1

        local UIAspectRatioConstraint_11 = Instance.new("UIAspectRatioConstraint")
        UIAspectRatioConstraint_11.Name = "UIAspectRatioConstraint"
        UIAspectRatioConstraint_11.AspectRatio = 1
        UIAspectRatioConstraint_11.AspectType = Enum.AspectType.FitWithinMaxSize
        UIAspectRatioConstraint_11.DominantAxis = Enum.DominantAxis.Height
        UIAspectRatioConstraint_11.Parent = ContentCopy_10

        Config_1.MouseButton1Click:Connect(function ()
            rsconfig()
            TS:Create(geg_3,TweenInfo.new(0.1),{Color = Color3.fromRGB(66, 197, 197)}):Play()
            cfchoose=Config_1
            Save_8.Visible=true
            Delete_11.Visible=true
            guisetting.SelectConfig=Config_1.Name
            writefile("Sawhub/"..nameuicf..".json",game:GetService("HttpService"):JSONEncode(guisetting))
						local cf = readfile("Sawhub/Config/"..Config_1.Name..".json")
				lib:LoadConfig(game:GetService("HttpService"):JSONDecode(cf).Data)

            lib:Notify("Config loaded")
        end)

        ContentCopy_10.MouseButton1Click:Connect(function()
            setclipboard(game:GetService("HttpService"):JSONEncode(lib:GetConfig()))
            lib:Notify("Copied to clipboard")
        end)


    end

    
    local function saveconfig(name)
        local data = {
            Date = os.date("%d.%m.%Y", os.time()),
            Data = lib:GetConfig()
        }
        writefile("Sawhub/Config/"..name..".json",game:GetService("HttpService"):JSONEncode(data))
        lib:Notify("Config saved")
    end

	
	Create_5.MouseButton1Click:Connect(function()
		if ConfigBox_2.Text~="" and not checkcfsame() then
			createconfigbutton(ConfigBox_2.Text,os.date("%d.%m.%Y", os.time()))
		end
	end)
	
	Delete_11.MouseButton1Click:Connect(function()
		cfchoose:Destroy()
        if isfile("Sawhub/Config/"..cfchoose.Name..".json") then
            delfile("Sawhub/Config/"..cfchoose.Name..".json")
        end
		Delete_11.Visible=false
		Save_8.Visible=false
	end)
	
	Save_8.MouseButton1Click:Connect(function()
		saveconfig(cfchoose.Name)
	end)

	
	local Rejoin_1 = Instance.new("ImageButton")
	Rejoin_1.Name = "Rejoin"
	Rejoin_1.Position = UDim2.new(0.789515, 0, 0.500000, 0)
	Rejoin_1.Size = UDim2.new(0.147059, 0, 0.714286, 0)
	Rejoin_1.AnchorPoint = Vector2.new(0.000000, 0.500000)
	Rejoin_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Rejoin_1.BackgroundTransparency = 1
	Rejoin_1.BorderSizePixel = 0
	Rejoin_1.Visible = true
	Rejoin_1.ZIndex = 1
	Rejoin_1.Image = "rbxassetid://138028255370142"
	Rejoin_1.ImageColor3 = Color3.fromRGB(200, 200, 200)
	Rejoin_1.ImageTransparency = 0
	Rejoin_1.ScaleType = Enum.ScaleType.Fit
	Rejoin_1.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	Rejoin_1.SliceScale = 1
	Rejoin_1.ImageRectOffset = Vector2.new(0.000000, 0.000000)
	Rejoin_1.ImageRectSize = Vector2.new(0.000000, 0.000000)
	Rejoin_1.ResampleMode = Enum.ResamplerMode.Default
	Rejoin_1.Parent = others_42

	local Loop_2 = Instance.new("ImageButton")
	Loop_2.Name = "Loop"
	Loop_2.Position = UDim2.new(0.059880, 0, 0.200000, 0)
	Loop_2.Size = UDim2.new(0.000000, 24, 0.000000, 24)
	Loop_2.AnchorPoint = Vector2.new(0.000000, 0.000000)
	Loop_2.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	Loop_2.BackgroundTransparency = 1
	Loop_2.BorderSizePixel = 1
	Loop_2.Visible = true
	Loop_2.ZIndex = 1
	Loop_2.Image = "rbxassetid://8445471713"
	Loop_2.ImageColor3 = Color3.fromRGB(180, 180, 180)
	Loop_2.ImageTransparency = 0
	Loop_2.ScaleType = Enum.ScaleType.Stretch
	Loop_2.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
	Loop_2.SliceScale = 1
	Loop_2.ImageRectOffset = Vector2.new(104.000000, 204.000000)
	Loop_2.ImageRectSize = Vector2.new(96.000000, 96.000000)
	Loop_2.ResampleMode = Enum.ResamplerMode.Default
	Loop_2.Parent = others_42

    Loop_2.MouseButton1Click:Connect(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end)

	local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint_3.Name = "UIAspectRatioConstraint"
	UIAspectRatioConstraint_3.AspectRatio = 1
	UIAspectRatioConstraint_3.AspectType = Enum.AspectType.FitWithinMaxSize
	UIAspectRatioConstraint_3.DominantAxis = Enum.DominantAxis.Height
	UIAspectRatioConstraint_3.Parent = Loop_2

	local dropdown_1 = Instance.new("Frame")
	dropdown_1.Name = "dropdown"
	dropdown_1.Position = UDim2.new(0.271000, 0, 0.100000, 0)
	dropdown_1.Size = UDim2.new(0.715000, 0, 0.880000, 0)
	dropdown_1.AnchorPoint = Vector2.new(0.000000, 0.000000)
	dropdown_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dropdown_1.BackgroundTransparency = 1
	dropdown_1.BorderSizePixel = 0
	dropdown_1.ClipsDescendants = false
	dropdown_1.Visible = false
	dropdown_1.ZIndex = 1
	dropdown_1.Parent = Frame_2

	local close_2 = Instance.new("TextButton")
	close_2.Name = "close"
	close_2.Position = UDim2.new(0.000000, 0, 0.000000, 0)
	close_2.Size = UDim2.new(1.000000, 0, 1.000000, 0)
	close_2.AnchorPoint = Vector2.new(0.000000, 0.000000)
	close_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	close_2.BackgroundTransparency = 0.3
	close_2.BorderSizePixel = 0
	close_2.Visible = true
	close_2.ZIndex = 1
	close_2.Text = ""
	close_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	close_2.TextScaled = false
	close_2.TextSize = 14
	close_2.Font = Enum.Font.SourceSans
	close_2.TextXAlignment = Enum.TextXAlignment.Center
	close_2.TextYAlignment = Enum.TextYAlignment.Center
	close_2.TextWrapped = false
	close_2.TextTransparency = 0
	close_2.AutoButtonColor = false
	close_2.Parent = dropdown_1

	local UICorner_3 = Instance.new("UICorner")
	UICorner_3.Name = "UICorner"
	UICorner_3.CornerRadius = UDim.new(0.000000, 8)
	UICorner_3.Parent = close_2

	local function cleandrop()
		for i,v in pairs(close_2:GetChildren()) do
			if v:IsA("Frame") then
				v.Visible=false
			end
		end
	end

	close_2.MouseButton1Click:Connect(function()
		dropdown_1.Visible=false
		cleandrop()
	end)
	local opend=false

	local function createpage()
		local p_1 = Instance.new("Frame")
		p_1.Name = "p"
		p_1.Position = UDim2.new(0.500000, 0, 0.068000, 0)
		p_1.Size = UDim2.new(1.000000, -10, 0.000000, 402)
		p_1.AnchorPoint = Vector2.new(0.500000, 0.000000)
		p_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		p_1.BackgroundTransparency = 1
		p_1.BorderSizePixel = 0
		p_1.ClipsDescendants = false
		p_1.Visible = false
		p_1.ZIndex = 1
		p_1.Parent = page_4

		local Left_2 = Instance.new("ScrollingFrame")
		Left_2.Name = "Left"
		Left_2.Position = UDim2.new(0.000000, 5, 0.000000, 0)
		Left_2.Size = UDim2.new(0.500000, -10, 0.000000, 401)
		Left_2.AnchorPoint = Vector2.new(0.000000, 0.000000)
		Left_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Left_2.BackgroundTransparency = 1
		Left_2.BorderSizePixel = 0
		Left_2.ClipsDescendants = true
		Left_2.Visible = true
		Left_2.ZIndex = 1
		Left_2.CanvasSize = UDim2.new(0.000000, 0, 2.000000, 0)
		Left_2.ScrollBarThickness = 0
		Left_2.ScrollingDirection = Enum.ScrollingDirection.XY
		Left_2.Parent = p_1

		local LeftList_3 = Instance.new("UIListLayout")
		LeftList_3.Name = "LeftList"
		LeftList_3.Padding = UDim.new(0.000000, 10)
		LeftList_3.FillDirection = Enum.FillDirection.Vertical
		LeftList_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
		LeftList_3.VerticalAlignment = Enum.VerticalAlignment.Top
		LeftList_3.SortOrder = Enum.SortOrder.LayoutOrder
		LeftList_3.Parent = Left_2

		local A_4 = Instance.new("UIPadding")
		A_4.Name = "A"
		A_4.PaddingBottom = UDim.new(0.000000, 0)
		A_4.PaddingLeft = UDim.new(0.000000, 0)
		A_4.PaddingRight = UDim.new(0.000000, 0)
		A_4.PaddingTop = UDim.new(0.000000, 1)
		A_4.Parent = Left_2

		local Right_5 = Instance.new("ScrollingFrame")
		Right_5.Name = "Right"
		Right_5.Position = UDim2.new(1.000000, -5, 0.000000, 0)
		Right_5.Size = UDim2.new(0.500000, -10, 0.000000, 401)
		Right_5.AnchorPoint = Vector2.new(1.000000, 0.000000)
		Right_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Right_5.BackgroundTransparency = 1
		Right_5.BorderSizePixel = 0
		Right_5.ClipsDescendants = true
		Right_5.Visible = true
		Right_5.ZIndex = 1
		Right_5.CanvasSize = UDim2.new(0.000000, 0, 2.000000, 0)
		Right_5.ScrollBarThickness = 0
		Right_5.ScrollingDirection = Enum.ScrollingDirection.XY
		Right_5.Parent = p_1

		local RightList_6 = Instance.new("UIListLayout")
		RightList_6.Name = "RightList"
		RightList_6.Padding = UDim.new(0.000000, 10)
		RightList_6.FillDirection = Enum.FillDirection.Vertical
		RightList_6.HorizontalAlignment = Enum.HorizontalAlignment.Center
		RightList_6.VerticalAlignment = Enum.VerticalAlignment.Top
		RightList_6.SortOrder = Enum.SortOrder.LayoutOrder
		RightList_6.Parent = Right_5

		local B_7 = Instance.new("UIPadding")
		B_7.Name = "B"
		B_7.PaddingBottom = UDim.new(0.000000, 0)
		B_7.PaddingLeft = UDim.new(0.000000, 0)
		B_7.PaddingRight = UDim.new(0.000000, 0)
		B_7.PaddingTop = UDim.new(0.000000, 1)
		B_7.Parent = Right_5

		AddListCanva(RightList_6,Right_5)
		AddListCanva(LeftList_3,Left_2)

		return p_1
	end


	DraggingEnabled(Bar_46,Frame_2)
	DraggingEnabled(Frame_2,Frame_2)

	local first=false
	local function resetpage()
		for i,v in pairs(page_4:GetChildren()) do
			if v:IsA("Frame") then
				v.Visible=false
			end
		end	
	end


	local function cleanUI(val)
		for i,v in pairs(Frame_2:GetChildren()) do
			if v.Name ~= "UIU" and v.Name ~= "Bar" and v.Name ~="dropdown" then
				v.Visible=val
			end
		end

	end

	local minimizedToBar = false
	local savedExpandedSize = Frame_2.Size

	local function tweenFrameFromTop(targetSize, duration)
		local currentPos = Frame_2.Position
		local currentSize = Frame_2.Size
		local deltaY = (currentSize.Y.Offset - targetSize.Y.Offset) * 0.5
		local targetPos = UDim2.new(
			currentPos.X.Scale,
			currentPos.X.Offset,
			currentPos.Y.Scale,
			currentPos.Y.Offset - deltaY
		)
		softTween(Frame_2, {Position = targetPos, Size = targetSize}, duration or 0.12)
	end

	local function minimizeToBar()
		if minimizedToBar then
			return
		end
		savedExpandedSize = Frame_2.Size
		cleanUI(false)
		Add_54.Visible = true
		Remove_52.Visible = false
		tweenFrameFromTop(UDim2.new(0, 750, 0, 30), 0.12)
		minimizedToBar = true
	end

	local function restoreFromBar()
		if not minimizedToBar then
			return
		end
		Add_54.Visible = false
		Remove_52.Visible = true
		cleanUI(true)
		tweenFrameFromTop(savedExpandedSize, 0.12)
		minimizedToBar = false
	end

	local function collapseMainWindow()
		softTween(Frame_2, {Size = UDim2.new(0, 0, 0, 500)}, 0.12)
		task.delay(0.12, function()
			cleanUI(false)
			softTween(Bar_46, {Size = UDim2.new(0, 0, 0, 30)}, 0.12)
			task.delay(0.12, function()
				Bar_46.Visible = false
			end)
		end)
		opend = true
	end

	local function expandMainWindow()
		Bar_46.Visible = true
		softTween(Bar_46, {Size = UDim2.new(0, 750, 0, 30)}, 0.12)
		task.delay(0.12, function()
			Add_54.Visible = false
			Remove_52.Visible = true
			cleanUI(true)
			softTween(Frame_2, {Size = UDim2.new(0, 750, 0, 500)}, 0.12)
		end)
		opend = false
	end
	
	Rejoin_1.MouseButton1Click:Connect(function()
		resetpage()
		Config2_1.Visible=true
	end)

	Remove_52.MouseButton1Click:Connect(function()
		minimizeToBar()
	end)

	Add_54.MouseButton1Click:Connect(function()
		restoreFromBar()
	end)

	Close_50.MouseButton1Click:Connect(function()
		collapseMainWindow()
	end)

    K_4.Text=guisetting.Keybind or "RightShift"

	Keyb_1.MouseButton1Click:Connect(function()
		if K_4.Text ~= "..." then
			K_4.Text = "..."

			local connection
			connection = UIS.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Keyboard then
					local newKey = input.KeyCode

					if newKey ~= Enum.KeyCode.Unknown then
						guisetting.Keybind = newKey.Name
						K_4.Text = newKey.Name
                        writefile("Sawhub/"..nameuicf..".json",game:GetService("HttpService"):JSONEncode(guisetting))
						connection:Disconnect()

					end
				end
			end)
		end
	end)

	UIS.InputBegan:Connect(function(k,c)
		if c then return end 
		if k.KeyCode==Enum.KeyCode[guisetting.Keybind] then
			if not opend then
				collapseMainWindow()
			else
				expandMainWindow()
			end
		end
	end)

	local function CreateSection(page,optionssec)

		local chosel

		if page.Left.LeftList.AbsoluteContentSize.Y <= page.Right.RightList.AbsoluteContentSize.Y then
			chosel=page.Left
		else
			chosel=page.Right
		end
		local Section_1 = Instance.new("Frame")
		Section_1.Name = optionssec.Name
		Section_1.Position = UDim2.new(0.004301, 0, -0.001245, 0)
		Section_1.Size = UDim2.new(1.000000, -2, 0.000000, 200)
		Section_1.AnchorPoint = Vector2.new(0.000000, 0.000000)
		Section_1.BackgroundColor3 = Theme.SecondaryBackground
		Section_1.BackgroundTransparency = 0
		Section_1.BorderSizePixel = 0
		Section_1.ClipsDescendants = false
		Section_1.Visible = true
		Section_1.ZIndex = 1
		Section_1.Parent = chosel

		local hehee_2 = Instance.new("UIStroke")
		hehee_2.Name = "hehee"
		hehee_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		hehee_2.Color = Theme.StrokeColor
		hehee_2.Thickness = 1
		hehee_2.Transparency = 0
		hehee_2.LineJoinMode = Enum.LineJoinMode.Round
		hehee_2.Parent = Section_1

		local UIAA_3 = Instance.new("UICorner")
		UIAA_3.Name = "UIAA"
		UIAA_3.CornerRadius = UDim.new(0.000000, 8)
		UIAA_3.Parent = Section_1
		styleModernSurface(Section_1, 8)

		local SectionList_4 = Instance.new("UIListLayout")
		SectionList_4.Name = "SectionList"
		SectionList_4.Padding = UDim.new(0.000000, 0)
		SectionList_4.FillDirection = Enum.FillDirection.Vertical
		SectionList_4.HorizontalAlignment = Enum.HorizontalAlignment.Center
		SectionList_4.VerticalAlignment = Enum.VerticalAlignment.Top
		SectionList_4.SortOrder = Enum.SortOrder.LayoutOrder
		SectionList_4.Parent = Section_1

		local SectionName_5 = Instance.new("Frame")
		SectionName_5.Name = "SectionName"
		SectionName_5.Position = UDim2.new(0.000000, 0, 0.000000, 0)
		SectionName_5.Size = UDim2.new(1.000000, 0, 0.000000, 25)
		SectionName_5.AnchorPoint = Vector2.new(0.000000, 0.000000)
		SectionName_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SectionName_5.BackgroundTransparency = 1
		SectionName_5.BorderSizePixel = 0
		SectionName_5.ClipsDescendants = false
		SectionName_5.Visible = true
		SectionName_5.ZIndex = 1
		SectionName_5.Parent = Section_1

		local TextLabel_6 = Instance.new("TextLabel")
		TextLabel_6.Name = "TextLabel"
		TextLabel_6.Position = UDim2.new(0.102183, 0, 0.000000, 0)
		TextLabel_6.Size = UDim2.new(0.278175, 0, 1.000000, 0)
		TextLabel_6.AnchorPoint = Vector2.new(0.000000, 0.000000)
		TextLabel_6.BackgroundColor3 = Theme.SecondaryBackground
		TextLabel_6.BackgroundTransparency = 0
		TextLabel_6.BorderSizePixel = 0
		TextLabel_6.Visible = true
		TextLabel_6.ZIndex = 2
		TextLabel_6.Text = optionssec.Name
		TextLabel_6.TextColor3 = Theme.TextColor
		TextLabel_6.TextScaled = false
		TextLabel_6.TextSize = 14
		TextLabel_6.Font = Enum.Font.Montserrat
		TextLabel_6.TextXAlignment = Enum.TextXAlignment.Center
		TextLabel_6.TextYAlignment = Enum.TextYAlignment.Center
		TextLabel_6.TextWrapped = false
		TextLabel_6.TextTransparency = 0
		TextLabel_6.Parent = SectionName_5

		TextLabel_6.Size=UDim2.new(0,TextLabel_6.TextBounds.X+20,1,0)

		local Frame_7 = Instance.new("Frame")
		Frame_7.Name = "Frame"
		Frame_7.Position = UDim2.new(0.500000, 0, 0.500000, 0)
		Frame_7.Size = UDim2.new(1.000000, -20, 0.000000, 2)
		Frame_7.AnchorPoint = Vector2.new(0.500000, 0.500000)
		Frame_7.BackgroundColor3 = Theme.StrokeColor
		Frame_7.BackgroundTransparency = 0
		Frame_7.BorderSizePixel = 0
		Frame_7.ClipsDescendants = false
		Frame_7.Visible = true
		Frame_7.ZIndex = 1
		Frame_7.Parent = SectionName_5

		local UIPadd_8 = Instance.new("UIPadding")
		UIPadd_8.Name = "UIPadd"
		UIPadd_8.PaddingBottom = UDim.new(0.000000, 0)
		UIPadd_8.PaddingLeft = UDim.new(0.000000, 0)
		UIPadd_8.PaddingRight = UDim.new(0.000000, 0)
		UIPadd_8.PaddingTop = UDim.new(0.000000, 5)
		UIPadd_8.Parent = Section_1

		AddListCanva(SectionList_4,Section_1)

		lib[page.Name][optionssec.Name]={}
		local secfunc=lib[page.Name][optionssec.Name]

		function secfunc:CreateButton(optionsbutton)
			local Button_1 = Instance.new("Frame")
			Button_1.Name = optionsbutton.Name
			Button_1.Position = UDim2.new(0.058568, 0, 0.128205, 0)
			Button_1.Size = UDim2.new(1.000000, -20, 0.000000, 30)
			Button_1.AnchorPoint = Vector2.new(0.000000, 0.000000)
			Button_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Button_1.BackgroundTransparency = 1
			Button_1.BorderSizePixel = 0
			Button_1.ClipsDescendants = false
			Button_1.Visible = true
			Button_1.ZIndex = 1
			Button_1.Parent = Section_1

			local ButtonName_2 = Instance.new("TextLabel")
			ButtonName_2.Name = "ButtonName"
			ButtonName_2.Position = UDim2.new(0.000000, 0, 0.000000, 0)
			ButtonName_2.Size = UDim2.new(-0.137767, 187, 1.000000, 0)
			ButtonName_2.AnchorPoint = Vector2.new(0.000000, 0.000000)
			ButtonName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonName_2.BackgroundTransparency = 1
			ButtonName_2.BorderSizePixel = 0
			ButtonName_2.Visible = true
			ButtonName_2.ZIndex = 1
			ButtonName_2.Text = optionsbutton.Name
			ButtonName_2.TextColor3 = Theme.TextColor
			ButtonName_2.TextScaled = false
			ButtonName_2.TextSize = 14
			ButtonName_2.Font = Enum.Font.GothamBold
			ButtonName_2.TextXAlignment = Enum.TextXAlignment.Left
			ButtonName_2.TextYAlignment = Enum.TextYAlignment.Center
			ButtonName_2.TextWrapped = false
			ButtonName_2.TextTransparency = 0
			ButtonName_2.Parent = Button_1

			local Fire_3 = Instance.new("TextButton")
			Fire_3.Name = "Fire"
			Fire_3.Position = UDim2.new(1.000000, 0, 0.500000, 0)
			Fire_3.Size = UDim2.new(0.000000, 49, 0.000000, 20)
			Fire_3.AnchorPoint = Vector2.new(1.000000, 0.500000)
			Fire_3.BackgroundColor3 = Theme.ElementBackground
			Fire_3.BackgroundTransparency = 0
			Fire_3.BorderSizePixel = 0
			Fire_3.Visible = true
			Fire_3.ZIndex = 1
			Fire_3.Text = "Click"
			Fire_3.TextColor3 = Color3.fromRGB(255, 255, 255)
			Fire_3.TextScaled = false
			Fire_3.TextSize = 12
			Fire_3.Font = Enum.Font.GothamBold
			Fire_3.TextXAlignment = Enum.TextXAlignment.Center
			Fire_3.TextYAlignment = Enum.TextYAlignment.Center
			Fire_3.TextWrapped = true
			Fire_3.TextTransparency = 0
			Fire_3.AutoButtonColor = true
			Fire_3.Parent = Button_1

			local abvc_4 = Instance.new("UICorner")
			abvc_4.Name = "abvc"
			abvc_4.CornerRadius = UDim.new(0.000000, 4)
			abvc_4.Parent = Fire_3

			local dad_5 = Instance.new("UIStroke")
			dad_5.Name = "dad"
			dad_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			dad_5.Color = Theme.StrokeColor
			dad_5.Thickness = 1
			dad_5.Transparency = 0
			dad_5.LineJoinMode = Enum.LineJoinMode.Round
			dad_5.Parent = Fire_3

			secfunc[ButtonName_2.Text] = {}
			local buttonlib=secfunc[ButtonName_2.Text]

			Fire_3.MouseButton1Click:Connect(function()
				task.spawn(function()
					optionsbutton.Callback()
				end)
			end)
			Fire_3.MouseEnter:Connect(function()
				softTween(Fire_3, {BackgroundColor3 = Theme.Accent}, 0.12)
			end)
			Fire_3.MouseLeave:Connect(function()
				softTween(Fire_3, {BackgroundColor3 = Theme.ElementBackground}, 0.12)
			end)

			function buttonlib:Fire()
				task.spawn(function()
					optionsbutton.Callback()
				end)
			end
			return buttonlib
		end

		function secfunc:CreateToggle(toggleoptions)
			local Toggle_1 = Instance.new("Frame")
			Toggle_1.Name = toggleoptions.Name
			Toggle_1.Position = UDim2.new(0.058568, 0, 0.128205, 0)
			Toggle_1.Size = UDim2.new(1.000000, -20, 0.000000, 30)
			Toggle_1.AnchorPoint = Vector2.new(0.000000, 0.000000)
			Toggle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Toggle_1.BackgroundTransparency = 1
			Toggle_1.BorderSizePixel = 0
			Toggle_1.ClipsDescendants = false
			Toggle_1.Visible = true
			Toggle_1.ZIndex = 1
			Toggle_1.Parent = Section_1

			local ToggleName_2 = Instance.new("TextLabel")
			ToggleName_2.Name = "ToggleName"
			ToggleName_2.Position = UDim2.new(0.000000, 0, 0.000000, 0)
			ToggleName_2.Size = UDim2.new(0.000000, 187, 1.000000, 0)
			ToggleName_2.AnchorPoint = Vector2.new(0.000000, 0.000000)
			ToggleName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleName_2.BackgroundTransparency = 1
			ToggleName_2.BorderSizePixel = 0
			ToggleName_2.Visible = true
			ToggleName_2.ZIndex = 1
			ToggleName_2.Text = toggleoptions.Name
			ToggleName_2.TextColor3 = Theme.TextColor
			ToggleName_2.TextScaled = false
			ToggleName_2.TextSize = 14
			ToggleName_2.Font = Enum.Font.GothamBold
			ToggleName_2.TextXAlignment = Enum.TextXAlignment.Left
			ToggleName_2.TextYAlignment = Enum.TextYAlignment.Center
			ToggleName_2.TextWrapped = false
			ToggleName_2.TextTransparency = 0
			ToggleName_2.Parent = Toggle_1

			local Fire_3 = Instance.new("TextButton")
			Fire_3.Name = "Fire"
			Fire_3.Position = UDim2.new(1.000000, 0, 0.500000, 0)
			Fire_3.Size = UDim2.new(0.000000, 20, 0.000000, 20)
			Fire_3.AnchorPoint = Vector2.new(1.000000, 0.500000)
			Fire_3.BackgroundColor3 = Theme.ElementBackground
			Fire_3.BackgroundTransparency = 0
			Fire_3.BorderSizePixel = 0
			Fire_3.Visible = true
			Fire_3.ZIndex = 1
			Fire_3.Text = ""
			Fire_3.TextColor3 = Color3.fromRGB(0, 0, 0)
			Fire_3.TextScaled = true
			Fire_3.TextSize = 14
			Fire_3.Font = Enum.Font.SourceSans
			Fire_3.TextXAlignment = Enum.TextXAlignment.Center
			Fire_3.TextYAlignment = Enum.TextYAlignment.Center
			Fire_3.TextWrapped = true
			Fire_3.TextTransparency = 0
			Fire_3.AutoButtonColor = true
			Fire_3.Parent = Toggle_1

			local aaa_4 = Instance.new("UICorner")
			aaa_4.Name = "aaa"
			aaa_4.CornerRadius = UDim.new(0.000000, 4)
			aaa_4.Parent = Fire_3

			local Check_5 = Instance.new("ImageLabel")
			Check_5.Name = "Check"
			Check_5.Position = UDim2.new(0.000000, 0, 0.000000, 0)
			Check_5.Size = UDim2.new(1.000000, 0, 1.000000, 0)
			Check_5.AnchorPoint = Vector2.new(0.000000, 0.000000)
			Check_5.BackgroundColor3 = Theme.Accent
			Check_5.BackgroundTransparency = 0
			Check_5.BorderSizePixel = 1
			Check_5.Visible = true
			Check_5.ZIndex = 1
			Check_5.Image = "rbxassetid://8445471173"
			Check_5.ImageColor3 = Color3.fromRGB(255, 255, 255)
			Check_5.ImageTransparency = 0
			Check_5.ScaleType = Enum.ScaleType.Stretch
			Check_5.SliceCenter = Rect.new(0.000000, 0.000000, 0.000000, 0.000000)
			Check_5.SliceScale = 1
			Check_5.ImageRectOffset = Vector2.new(504.000000, 604.000000)
			Check_5.ImageRectSize = Vector2.new(96.000000, 96.000000)
			Check_5.ResampleMode = Enum.ResamplerMode.Default
			Check_5.Parent = Fire_3

			local bbb_6 = Instance.new("UICorner")
			bbb_6.Name = "bbb"
			bbb_6.CornerRadius = UDim.new(0.000000, 4)
			bbb_6.Parent = Check_5


			secfunc[toggleoptions.Name]={}
			local togglefunc=secfunc[toggleoptions.Name]
			togglefunc.Enabled = toggleoptions.Default

			function togglefunc:Toggle(val)
				togglefunc.Enabled=val
				if val then
					Check_5.Visible=true
					softTween(Fire_3, {BackgroundColor3 = Theme.Accent}, 0.12)
				else
					Check_5.Visible=false
					softTween(Fire_3, {BackgroundColor3 = Theme.ElementBackground}, 0.12)
				end
				toggleoptions.Callback(val)
			end

			togglefunc:Toggle(togglefunc.Enabled)

			Fire_3.MouseButton1Click:Connect(function()
				togglefunc.Enabled=not togglefunc.Enabled
				togglefunc:Toggle(togglefunc.Enabled)
			end)

			return togglefunc
		end

		function secfunc:CreateSlider(slideroptions)

			local Slider_1 = Instance.new("Frame")
			Slider_1.Name = slideroptions.Name
			Slider_1.Position = UDim2.new(0.039841, 0, 0.435897, 0)
			Slider_1.Size = UDim2.new(1.000000, -20, 0.000000, 45)
			Slider_1.AnchorPoint = Vector2.new(0.000000, 0.000000)
			Slider_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Slider_1.BackgroundTransparency = 1
			Slider_1.BorderSizePixel = 0
			Slider_1.ClipsDescendants = false
			Slider_1.Visible = true
			Slider_1.ZIndex = 1
			Slider_1.Parent = Section_1

			local SliderName_2 = Instance.new("TextLabel")
			SliderName_2.Name = "SliderName"
			SliderName_2.Position = UDim2.new(0.000000, 0, 0.133333, 0)
			SliderName_2.Size = UDim2.new(-0.000000, 187, 0.000000, 20)
			SliderName_2.AnchorPoint = Vector2.new(0.000000, 0.000000)
			SliderName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderName_2.BackgroundTransparency = 1
			SliderName_2.BorderSizePixel = 0
			SliderName_2.Visible = true
			SliderName_2.ZIndex = 1
			SliderName_2.Text = slideroptions.Name
			SliderName_2.TextColor3 = Theme.TextColor
			SliderName_2.TextScaled = false
			SliderName_2.TextSize = 14
			SliderName_2.Font = Enum.Font.GothamBold
			SliderName_2.TextXAlignment = Enum.TextXAlignment.Left
			SliderName_2.TextYAlignment = Enum.TextYAlignment.Center
			SliderName_2.TextWrapped = false
			SliderName_2.TextTransparency = 0
			SliderName_2.Parent = Slider_1

			local Number_3 = Instance.new("TextLabel")
			Number_3.Name = "Number"
			Number_3.Position = UDim2.new(1.000000, 0, 0.334000, 0)
			Number_3.Size = UDim2.new(0.000000, 67, 0.000000, 20)
			Number_3.AnchorPoint = Vector2.new(1.000000, 0.500000)
			Number_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Number_3.BackgroundTransparency = 1
			Number_3.BorderSizePixel = 0
			Number_3.Visible = true
			Number_3.ZIndex = 1
			Number_3.Text =  tostring(slideroptions.Default) or tostring(Min)
			Number_3.TextColor3 = Theme.SubTextColor
			Number_3.TextScaled = false
			Number_3.TextSize = 12
			Number_3.Font = Enum.Font.GothamBold
			Number_3.TextXAlignment = Enum.TextXAlignment.Right
			Number_3.TextYAlignment = Enum.TextYAlignment.Bottom
			Number_3.TextWrapped = false
			Number_3.TextTransparency = 0
			Number_3.Parent = Slider_1

			local Fire_4 = Instance.new("TextButton")
			Fire_4.Name = "Fire"
			Fire_4.Position = UDim2.new(0.000000, 0, 0.700000, 0)
			Fire_4.Size = UDim2.new(0.000000, 231, 0.000000, 5)
			Fire_4.AnchorPoint = Vector2.new(0.000000, 0.000000)
			Fire_4.BackgroundColor3 = Theme.ElementBackground
			Fire_4.BackgroundTransparency = 0
			Fire_4.BorderSizePixel = 0
			Fire_4.Visible = true
			Fire_4.ZIndex = 1
			Fire_4.Text = ""
			Fire_4.TextColor3 = Color3.fromRGB(0, 0, 0)
			Fire_4.TextScaled = false
			Fire_4.TextSize = 14
			Fire_4.Font = Enum.Font.SourceSans
			Fire_4.TextXAlignment = Enum.TextXAlignment.Center
			Fire_4.TextYAlignment = Enum.TextYAlignment.Center
			Fire_4.TextWrapped = false
			Fire_4.TextTransparency = 0
			Fire_4.AutoButtonColor = false
			Fire_4.Parent = Slider_1

			local Ttt_5 = Instance.new("Frame")
			Ttt_5.Name = "Ttt"
			Ttt_5.Position = UDim2.new(0.000000, 0, 0.000000, 0)
			Ttt_5.Size = UDim2.new(0.500000, 0, 1.000000, 0)
			Ttt_5.AnchorPoint = Vector2.new(0.000000, 0.000000)
			Ttt_5.BackgroundColor3 = Theme.Accent
			Ttt_5.BackgroundTransparency = 0
			Ttt_5.BorderSizePixel = 0
			Ttt_5.ClipsDescendants = false
			Ttt_5.Visible = true
			Ttt_5.ZIndex = 1
			Ttt_5.Parent = Fire_4

			local UICorner_6 = Instance.new("UICorner")
			UICorner_6.Name = "UICorner"
			UICorner_6.CornerRadius = UDim.new(0.000000, 4)
			UICorner_6.Parent = Ttt_5

			local Cir_7 = Instance.new("Frame")
			Cir_7.Name = "Cir"
			Cir_7.Position = UDim2.new(1.000000, 5, 0.500000, 0)
			Cir_7.Size = UDim2.new(0.000000, 10, 0.000000, 10)
			Cir_7.AnchorPoint = Vector2.new(1.000000, 0.500000)
			Cir_7.BackgroundColor3 = Theme.TextColor
			Cir_7.BackgroundTransparency = 0
			Cir_7.BorderSizePixel = 0
			Cir_7.ClipsDescendants = false
			Cir_7.Visible = true
			Cir_7.ZIndex = 1
			Cir_7.Parent = Ttt_5

			local UICorner_8 = Instance.new("UICorner")
			UICorner_8.Name = "UICorner"
			UICorner_8.CornerRadius = UDim.new(1.000000, 0)
			UICorner_8.Parent = Cir_7

			local UICorner_9 = Instance.new("UICorner")
			UICorner_9.Name = "UICorner"
			UICorner_9.CornerRadius = UDim.new(0.000000, 4)
			UICorner_9.Parent = Fire_4


			secfunc[slideroptions.Name]={}
			local sliderfunc=secfunc[slideroptions.Name]
			sliderfunc.Value = slideroptions.Default


			local Min = slideroptions.Min or 0
			local Max = slideroptions.Max or 100
			local Increment = slideroptions.Increment or 1
			local Callback = slideroptions.Callback or function() end

			local Dragging = false

			local function Sliding(Input)
				local width = math.max(Fire_4.AbsoluteSize.X, 1)
				local pos = math.clamp((Input.Position.X - Fire_4.AbsolutePosition.X) / width, 0, 1)
				local value = Min + (pos * (Max - Min))

				value = math.floor(value / Increment + 0.5) * Increment
				value = math.clamp(value, Min, Max)

				local decimals = tostring(Increment):match("%.(%d+)")
				local precision = decimals and #decimals or 0
				local formattedValue = string.format("%." .. precision .. "f", value)

				local denominator = math.max(Max - Min, 1e-6)
				Ttt_5.Size = UDim2.new((value - Min) / denominator, 0, 1, 0)
				Number_3.Text = formattedValue

				sliderfunc.Value=value
				
				Callback(tonumber(formattedValue))
			end

			local function SetValue(value)
				value = math.clamp(value, Min, Max)

				local decimals = tostring(Increment):match("%.(%d+)")
				local precision = decimals and #decimals or 0
				local formattedValue = string.format("%." .. precision .. "f", value)

				local denominator = math.max(Max - Min, 1e-6)
				Ttt_5.Size = UDim2.new((value - Min) / denominator, 0, 1, 0)
				Number_3.Text = formattedValue

				sliderfunc.Value=value

				Callback(tonumber(formattedValue))
			end

			Fire_4.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true
					Sliding(Input)
					TS:Create(Cir_7, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Size = UDim2.new(0, 15, 0, 15)}):Play()
				end
			end)

			UIS.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = false
					TS:Create(Cir_7, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Size = UDim2.new(0, 10, 0, 10)}):Play()
				end
			end)

			UIS.InputChanged:Connect(function(Input)
				if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
					Sliding(Input)
				end
			end)

			SetValue(slideroptions.Default or Min)

			function sliderfunc:Set(val)
				SetValue(val)
			end
			return sliderfunc
		end

		function secfunc:CreateDropdown(dropoptions)
		
			local Dropdown_1 = Instance.new("Frame")
			Dropdown_1.Name = dropoptions["Name"]
			Dropdown_1.Position = UDim2.new(0.058568, 0, 0.128205, 0)
			Dropdown_1.Size = UDim2.new(1.000000, -20, 0.000000, 30)
			Dropdown_1.AnchorPoint = Vector2.new(0.000000, 0.000000)
			Dropdown_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Dropdown_1.BackgroundTransparency = 1
			Dropdown_1.BorderSizePixel = 0
			Dropdown_1.ClipsDescendants = false
			Dropdown_1.Visible = true
			Dropdown_1.ZIndex = 1
			Dropdown_1.Parent = Section_1

			local namedrop_2 = Instance.new("TextLabel")
			namedrop_2.Name = "namedrop"
			namedrop_2.Position = UDim2.new(0.000000, 0, 0.000000, 0)
			namedrop_2.Size = UDim2.new(-0.363637, 187, 1.000000, 0)
			namedrop_2.AnchorPoint = Vector2.new(0.000000, 0.000000)
			namedrop_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			namedrop_2.BackgroundTransparency = 1
			namedrop_2.BorderSizePixel = 0
			namedrop_2.Visible = true
			namedrop_2.ZIndex = 1
			namedrop_2.Text = dropoptions["Name"]
			namedrop_2.TextColor3 = Theme.TextColor
			namedrop_2.TextScaled = false
			namedrop_2.TextSize = 14
			namedrop_2.Font = Enum.Font.GothamBold
			namedrop_2.TextXAlignment = Enum.TextXAlignment.Left
			namedrop_2.TextYAlignment = Enum.TextYAlignment.Center
			namedrop_2.TextWrapped = false
			namedrop_2.TextTransparency = 0
			namedrop_2.Parent = Dropdown_1

			local Opend_3 = Instance.new("TextButton")
			Opend_3.Name = "Opend"
			Opend_3.Position = UDim2.new(1.000000, 0, 0.500000, 0)
			Opend_3.Size = UDim2.new(0.000000, 128, 0.000000, 20)
			Opend_3.AnchorPoint = Vector2.new(1.000000, 0.500000)
			Opend_3.BackgroundColor3 = Theme.ElementBackground
			Opend_3.BackgroundTransparency = 0
			Opend_3.BorderSizePixel = 0
			Opend_3.Visible = true
			Opend_3.ZIndex = 1
			Opend_3.Text = ""
			Opend_3.TextColor3 = Color3.fromRGB(255, 255, 255)
			Opend_3.TextScaled = false
			Opend_3.TextSize = 14
			Opend_3.Font = Enum.Font.GothamBold
			Opend_3.TextXAlignment = Enum.TextXAlignment.Center
			Opend_3.TextYAlignment = Enum.TextYAlignment.Center
			Opend_3.TextWrapped = true
			Opend_3.TextTransparency = 0
			Opend_3.AutoButtonColor = true
			Opend_3.Parent = Dropdown_1

			local UICorner_4 = Instance.new("UICorner")
			UICorner_4.Name = "UICorner"
			UICorner_4.CornerRadius = UDim.new(0.000000, 4)
			UICorner_4.Parent = Opend_3

			local UIStroke_5 = Instance.new("UIStroke")
			UIStroke_5.Name = "UIStroke"
			UIStroke_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke_5.Color = Theme.StrokeColor
			UIStroke_5.Thickness = 1
			UIStroke_5.Transparency = 0
			UIStroke_5.LineJoinMode = Enum.LineJoinMode.Round
			UIStroke_5.Parent = Opend_3
			styleModernSurface(Opend_3, 4)

			local show_6 = Instance.new("TextLabel")
			show_6.Name = "show"
			show_6.Position = UDim2.new(0.500000, 0, 0.000000, 0)
			show_6.Size = UDim2.new(1.000000, -20, 1.000000, 0)
			show_6.AnchorPoint = Vector2.new(0.500000, 0.000000)
			show_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			show_6.BackgroundTransparency = 1
			show_6.BorderSizePixel = 0
			show_6.Visible = true
			show_6.ZIndex = 1
			show_6.Text = "..."
			show_6.TextColor3 = Theme.SubTextColor
			show_6.TextScaled = false
			show_6.TextSize = 12
			show_6.Font = Enum.Font.GothamBold
			show_6.TextXAlignment = Enum.TextXAlignment.Center
			show_6.TextYAlignment = Enum.TextYAlignment.Center
			show_6.TextWrapped = false
			show_6.TextTransparency = 0
			show_6.Parent = Opend_3

			
			local dropdownname_1 = Instance.new("Frame")
			dropdownname_1.Name = dropoptions["Name"]
			dropdownname_1.Position = UDim2.new(0.689977, 0, -0.004545, 0)
			dropdownname_1.Size = UDim2.new(0.000000, 164, 1.000000, 0)
			dropdownname_1.AnchorPoint = Vector2.new(0.000000, 0.000000)
			dropdownname_1.BackgroundColor3 = Theme.SecondaryBackground
			dropdownname_1.BackgroundTransparency = 0.1
			dropdownname_1.BorderSizePixel = 0
			dropdownname_1.ClipsDescendants = false
			dropdownname_1.Visible = true
			dropdownname_1.ZIndex = 1
			dropdownname_1.Parent = close_2

			local item_2 = Instance.new("ScrollingFrame")
			item_2.Name = "item"
			item_2.Position = UDim2.new(0.000000, 0, 0.086182, 0)
			item_2.Size = UDim2.new(1.000000, 0, 0.913818, 0)
			item_2.AnchorPoint = Vector2.new(0.000000, 0.000000)
			item_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			item_2.BackgroundTransparency = 1
			item_2.BorderSizePixel = 0
			item_2.ClipsDescendants = true
			item_2.Visible = true
			item_2.ZIndex = 1
			item_2.CanvasSize = UDim2.new(0.000000, 0, 2.000000, 0)
			item_2.ScrollBarThickness = 4
			item_2.ScrollingDirection = Enum.ScrollingDirection.XY
			item_2.Parent = dropdownname_1

			local UIListLayout_3 = Instance.new("UIListLayout")
			UIListLayout_3.Name = "UIListLayout"
			UIListLayout_3.Padding = UDim.new(0.000000, 5)
			UIListLayout_3.FillDirection = Enum.FillDirection.Vertical
			UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Top
			UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_3.Parent = item_2

			local UIPadding_4 = Instance.new("UIPadding")
			UIPadding_4.Name = "UIPadding"
			UIPadding_4.PaddingBottom = UDim.new(0.000000, 0)
			UIPadding_4.PaddingLeft = UDim.new(0.000000, 0)
			UIPadding_4.PaddingRight = UDim.new(0.000000, 0)
			UIPadding_4.PaddingTop = UDim.new(0.000000, 10)
			UIPadding_4.Parent = item_2

			local searchdrop_5 = Instance.new("TextBox")
			searchdrop_5.Name = "searchdrop"
			searchdrop_5.Position = UDim2.new(0.060976, 0, 0.029545, 0)
			searchdrop_5.Size = UDim2.new(0.000000, 144, 0.000000, 23)
			searchdrop_5.AnchorPoint = Vector2.new(0.000000, 0.000000)
			searchdrop_5.BackgroundColor3 = Theme.Background
			searchdrop_5.BackgroundTransparency = 0
			searchdrop_5.BorderSizePixel = 0
			searchdrop_5.Visible = true
			searchdrop_5.ZIndex = 1
			searchdrop_5.PlaceholderText = "Search"
			searchdrop_5.TextColor3 = Theme.TextColor
			searchdrop_5.TextScaled = false
			searchdrop_5.TextSize = 14
			searchdrop_5.Font = Enum.Font.Montserrat
			searchdrop_5.TextXAlignment = Enum.TextXAlignment.Center
			searchdrop_5.TextYAlignment = Enum.TextYAlignment.Center
			searchdrop_5.TextWrapped = false
			searchdrop_5.TextTransparency = 0
			searchdrop_5.ClearTextOnFocus = true
			searchdrop_5.MultiLine = false
			searchdrop_5.Parent = dropdownname_1

			local UICorner_6 = Instance.new("UICorner")
			UICorner_6.Name = "UICorner"
			UICorner_6.CornerRadius = UDim.new(0.000000, 4)
			UICorner_6.Parent = searchdrop_5

			local UIStroke_7 = Instance.new("UIStroke")
			UIStroke_7.Name = "UIStroke"
			UIStroke_7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke_7.Color = Theme.StrokeColor
			UIStroke_7.Thickness = 1
			UIStroke_7.Transparency = 0
			UIStroke_7.LineJoinMode = Enum.LineJoinMode.Round
			UIStroke_7.Parent = searchdrop_5

			local dropcall = {}
			local buttonList = {}
			local selectedItems = {}
			local itemSelected
			local itemCount = 0
			local searchSerial = 0
			local allToken = "__ALL__"

			Opend_3.MouseButton1Click:Connect(function()
				cleandrop()
				dropdownname_1.Visible=true
				dropdown_1.Visible=true

			end)

			local function updateText()
				if dropoptions.Multi then
					local names = {}
					for name in pairs(selectedItems) do
						table.insert(names, name)
					end
					show_6.Text = "  " .. (#names > 0 and table.concat(names, ",") or "...")
					
				else
					show_6.Text = "  " .. (itemSelected or "...")
					
				end
			end

			local function updateCallback()
				if dropoptions.Multi then
					local selectedList = {}
					for name in pairs(selectedItems) do
						table.insert(selectedList, name)
					end
					dropoptions.Callback(selectedList)
				else
					dropoptions.Callback(itemSelected or "")
				end
			end
			
			searchdrop_5:GetPropertyChangedSignal("Text"):Connect(function()
				searchSerial = searchSerial + 1
				local serial = searchSerial
				task.delay(0.06, function()
					if serial ~= searchSerial then
						return
					end
					local keyword = searchdrop_5.Text:lower()
					for name, button in pairs(buttonList) do
						if keyword == "" then
							button.Visible = true
						else
							button.Visible = name:lower():find(keyword, 1, true) ~= nil
						end
					end
				end)
			end)


			local function addButton(itemName, displayName)
				local TextButton_1 = Instance.new("TextButton")
				TextButton_1.Name = itemName
				TextButton_1.Position = UDim2.new(0.000000, 0, 0.000000, 0)
				TextButton_1.Size = UDim2.new(1.000000, -20, 0.000000, 19)
				TextButton_1.AnchorPoint = Vector2.new(0.000000, 0.000000)
				TextButton_1.BackgroundColor3 = Theme.Background
				TextButton_1.BackgroundTransparency = 0
				TextButton_1.BorderSizePixel = 0
				TextButton_1.Visible = true
				TextButton_1.ZIndex = 1
				TextButton_1.Text = displayName or itemName
				TextButton_1.TextColor3 = Theme.TextColor
				TextButton_1.TextScaled = false
				TextButton_1.TextSize = 14
				TextButton_1.Font = Enum.Font.Gotham
				TextButton_1.TextXAlignment = Enum.TextXAlignment.Left
				TextButton_1.TextYAlignment = Enum.TextYAlignment.Center
				TextButton_1.TextWrapped = true
				TextButton_1.TextTransparency = 0
				TextButton_1.AutoButtonColor = true
				TextButton_1.Parent = item_2
				local textPadding = Instance.new("UIPadding")
				textPadding.PaddingLeft = UDim.new(0, 8)
				textPadding.Parent = TextButton_1

				local UICorner_2 = Instance.new("UICorner")
				UICorner_2.Name = "UICorner"
				UICorner_2.CornerRadius = UDim.new(0.000000, 4)
				UICorner_2.Parent = TextButton_1

				if itemName == allToken then
					TextButton_1.LayoutOrder = -1000
					TextButton_1.Size = UDim2.new(1.000000, -20, 0.000000, 22)
					TextButton_1.BackgroundColor3 = Theme.ElementBackground
					local allStroke = Instance.new("UIStroke")
					allStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					allStroke.Color = Theme.Accent
					allStroke.Thickness = 1
					allStroke.Parent = TextButton_1

					local spacer = Instance.new("Frame")
					spacer.Name = "AllSpacer"
					spacer.LayoutOrder = -999
					spacer.Size = UDim2.new(1, -20, 0, 6)
					spacer.BackgroundTransparency = 1
					spacer.BorderSizePixel = 0
					spacer.Parent = item_2
				end




				buttonList[itemName] = TextButton_1

				TextButton_1.MouseButton1Click:Connect(function()
					dropcall:Set(itemName)
				end)
				TextButton_1.MouseEnter:Connect(function()
					if (dropoptions.Multi and selectedItems[itemName]) or ((not dropoptions.Multi) and itemSelected == itemName) then
						return
					end
					softTween(TextButton_1, {BackgroundColor3 = Theme.ElementBackground}, 0.1)
				end)
				TextButton_1.MouseLeave:Connect(function()
					if (dropoptions.Multi and selectedItems[itemName]) or ((not dropoptions.Multi) and itemSelected == itemName) then
						return
					end
					softTween(TextButton_1, {BackgroundColor3 = Theme.Background}, 0.1)
				end)
			end

			function dropcall:Add(item)
				addButton(item)
				itemCount =itemCount+ 1
			end

			function dropcall:Set(item)
				if not buttonList[item] then return end

				if dropoptions.Multi then
					if item == allToken then
						for name, btn in pairs(buttonList) do
							if name ~= allToken then
								local nextState = not selectedItems[name]
								selectedItems[name] = nextState or nil
								btn.BackgroundColor3 = nextState and Theme.Accent or Theme.Background
							end
						end
						updateText()
						updateCallback()
						return
					end
					-- Toggle selection
					local isSelected = not selectedItems[item]
					selectedItems[item] = isSelected or nil
					buttonList[item].BackgroundColor3 = isSelected and Theme.Accent or Theme.Background

				else
					itemSelected = item
					for _, btn in pairs(buttonList) do
						btn.BackgroundColor3 = Theme.Background
					end
					buttonList[item].BackgroundColor3 = Theme.Accent
				end

				updateText()
				updateCallback()
			end

			function dropcall:New(items)
				table.sort(items)
				itemCount = 0
				selectedItems = {}
				table.clear(buttonList)

				for _, child in pairs(item_2:GetChildren()) do
					if child:IsA("TextButton") then
						child:Destroy()
					end
				end

				for _, item in pairs(items) do
					addButton(item)
					itemCount =itemCount+ 1
				end
				if dropoptions.Multi then
					addButton(allToken, "ALL")
				end
			end

			if dropoptions.List then
				dropcall:New(dropoptions.List)
			end

			if dropoptions.Default then
				if dropoptions.Multi then
					if typeof(dropoptions.Default) == "table" then
						for _, item in pairs(dropoptions.Default) do
							dropcall:Set(item)
						end
					else
						dropcall:Set(dropoptions.Default)
					end
				else
					dropcall:Set(dropoptions.Default[1])
				end
			else
				updateText()
				updateCallback()
			end


			return dropcall
		end

		return secfunc
	end




	local activeTabButton
	local tabRegistry = {}
	local function applyTabVisual(button, isActive)
		local title = button:FindFirstChild("TextLabel")
		local icon = button:FindFirstChild("ImageLabel")
		softTween(button, {
			BackgroundColor3 = isActive and Theme.Accent or Theme.ElementBackground,
			BackgroundTransparency = isActive and 0.82 or 1
		}, 0.12)
		if title and title:IsA("TextLabel") then
			softTween(title, {TextColor3 = isActive and Theme.TextColor or Theme.SubTextColor}, 0.12)
		end
		if icon and icon:IsA("ImageLabel") then
			softTween(icon, {ImageColor3 = isActive and Theme.TextColor or Theme.SubTextColor}, 0.12)
		end
	end

	local function styleTabButton(button)
		if not button or not button:IsA("TextButton") then
			return
		end
		button.AutoButtonColor = false
		button.BackgroundColor3 = Theme.ElementBackground
		applyTabVisual(button, false)
		button.MouseEnter:Connect(function()
			if activeTabButton == button then
				return
			end
			applyTabVisual(button, true)
		end)
		button.MouseLeave:Connect(function()
			if activeTabButton == button then
				return
			end
			applyTabVisual(button, false)
		end)
	end

	for i,v in pairs(ListTab_21:GetChildren()) do
		if v:IsA("TextButton") then
			styleTabButton(v)
			local page=createpage()
			local tabName = v.TextLabel.Text
			page.Name=tabName
			page.Visible=false
			tabRegistry[tabName] = {
				name = tabName,
				button = v,
				page = page,
				hasSection = false
			}
			lib[tabName]={}
			local l = lib[tabName]
			function l:CreateSection(op)
				tabRegistry[tabName].hasSection = true
				return CreateSection(page,op)
			end

			v.MouseButton1Click:Connect(function()
				if not v.Visible then
					return
				end
				if activeTabButton and activeTabButton ~= v then
					applyTabVisual(activeTabButton, false)
				end
				activeTabButton = v
				applyTabVisual(v, true)
				TS:Create(ChooseTab_57,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{Position=UDim2.new(0.5,0,0,math.abs(v.AbsolutePosition.Y-ChooseTab_57.AbsolutePosition.Y+ChooseTab_57.Position.Y.Offset))}):Play()
				resetpage()
				PageName_7.Text=v.TextLabel.Text
				page.Visible=true
			end)
			if not first then
				activeTabButton = v
				applyTabVisual(v, true)
				TS:Create(ChooseTab_57,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{Position=UDim2.new(0.5,0,0,math.abs(v.AbsolutePosition.Y-ChooseTab_57.AbsolutePosition.Y+ChooseTab_57.Position.Y.Offset))}):Play()
				resetpage()
				page.Visible=true
				PageName_7.Text=v.TextLabel.Text
				first=true
			end
		end
	end

	local function refreshVisibleTabs()
		local fallbackTab
		local activeInfo
		for _, tabInfo in pairs(tabRegistry) do
			local visible = tabInfo.hasSection
			tabInfo.button.Visible = visible
			tabInfo.page.Visible = false
			if visible and not fallbackTab then
				fallbackTab = tabInfo
			end
			if activeTabButton == tabInfo.button then
				activeInfo = tabInfo
			end
		end

		if activeTabButton and (not activeTabButton.Visible) then
			activeTabButton = nil
			activeInfo = nil
		end

		if activeInfo and activeTabButton then
			PageName_7.Text = activeInfo.name
			activeInfo.page.Visible = true
			return
		end

		if not activeTabButton and fallbackTab then
			local v = fallbackTab.button
			activeTabButton = v
			applyTabVisual(v, true)
			TS:Create(ChooseTab_57,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{Position=UDim2.new(0.5,0,0,math.abs(v.AbsolutePosition.Y-ChooseTab_57.AbsolutePosition.Y+ChooseTab_57.Position.Y.Offset))}):Play()
			PageName_7.Text = fallbackTab.name
			fallbackTab.page.Visible = true
		elseif not fallbackTab then
			PageName_7.Text = "No Sections"
		end
	end

    function lib:GetConfig()
        local conf={}
        for page,tab in pairs(lib) do
            if type(tab)=="table" then
                conf[page]={}   
                for section,tab2 in pairs(tab) do
                    if type(tab2)=="table" then
                        conf[page][section]={}   
                        for elem,val in pairs(tab2) do
                            if type(val)=="table" then
                                conf[page][section][elem]=val["Enabled"] or val["Value"]
                            end
                        end
                    end
                end
            end
        end
        return conf
    end

	function lib:LoadConfig(conf)
		for page,tab in pairs(conf) do
			for sec,tab2 in pairs(tab) do
				for elem,val in pairs(tab2) do
					if lib[page][sec] and lib[page][sec][elem] then
						if type(val)=="boolean" then
							lib[page][sec][elem]:Toggle(val)
						elseif type(val)=="number" then
							lib[page][sec][elem]:Set(val)
						end
					end
				end
			end
		end
	end


    for i,v in pairs(allconfig) do
        local fileName = string.match(v, "([^\\]+)%.json$")
        local suc,data = pcall(function()
            local data=game:GetService("HttpService"):JSONDecode(readfile("Sawhub/Config/"..fileName..".json"))
            if data["Date"] and data["Data"] then
                return data
            end

        end)
        print(suc,data)
        if suc and data then
            print(fileName)
            createconfigbutton(fileName,data.Date)
        end
    end

    function lib:Init(conf)
		refreshVisibleTabs()

        if guisetting.AutoLoad then
            TS:Create(AutoLoadConText_17,TweenInfo.new(.3),{BackgroundColor3=Color3.fromRGB(0, 170, 0)}):Play()
            local suc,data = pcall(function()
                local data=game:GetService("HttpService"):JSONDecode(readfile("Sawhub/Config/"..guisetting.SelectConfig..".json"))
                if data["Date"] and data["Data"] then
                    return data
                end
            end)
            if suc and data then
                lib:LoadConfig(data.Data)
            end
        end


        AutoLoadConText_17.MouseButton1Click:Connect(function()
		    if AutoLoadConText_17.BackgroundColor3==Color3.fromRGB(255, 0, 0) then
			    TS:Create(AutoLoadConText_17,TweenInfo.new(.3),{BackgroundColor3=Color3.fromRGB(0, 170, 0)}):Play()
                guisetting.AutoLoad=true
            writefile("Sawhub/"..nameuicf..".json",game:GetService("HttpService"):JSONEncode(guisetting))
		    elseif AutoLoadConText_17.BackgroundColor3==Color3.fromRGB(0, 170, 0) then
			    TS:Create(AutoLoadConText_17,TweenInfo.new(.3),{BackgroundColor3=Color3.fromRGB(255, 0, 0)}):Play()
                guisetting.AutoLoad=false
            writefile("Sawhub/"..nameuicf..".json",game:GetService("HttpService"):JSONEncode(guisetting))
		    end

            
		end)
    end
	return lib
end


if not getgenv().Config then
	getgenv().Config={}
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")

local CombatRemotes = ReplicatedStorage.CombatSystem.Remotes
local RequestHitRemote = CombatRemotes.RequestHit
local TeleportToPortalRemote = ReplicatedStorage.Remotes.TeleportToPortal
function Attack()
	RequestHitRemote:FireServer()
end

function checktable(a,k)
	for _,a in ipairs(a) do
		if a == k or string.find(a,k,1,true) or string.find(k,a,1,true) then
			return true
		end
	end
	return false
end

local LP = Players.LocalPlayer
function getRoot(char)
	if char then
		local rootPart = char:FindFirstChild('HumanoidRootPart')
		return rootPart
	end
	return false
end
local VIM = game:GetService("VirtualInputManager")
local x, y = 100, 200 -- Tọa độ trên màn hình

function sendkey(key)
    VIM:SendKeyEvent(true, key, false, game)
    task.wait()
    VIM:SendKeyEvent(false, key, false, game)
end
function TweenFloat()
	local root = getRoot(LP.Character)
	if root then
		if not root:FindFirstChild("VelocityBody") then
			local BV = Instance.new("BodyVelocity")
			BV.Parent = root
			BV.Name = "VelocityBody"
			BV.MaxForce = Vector3.new(100000, 100000, 100000)
			BV.Velocity = Vector3.new(0, 0, 0)
		end
	end
end
function RemoveFloat()
	local root = getRoot(LP.Character)
	if root then
		if root:FindFirstChild("VelocityBody") then
			root.VelocityBody:Destroy()
		end
	end
end

local PortalConfig = require(game:GetService("ReplicatedStorage").PortalConfig)
local datamap={}

for _, v in ipairs(PortalConfig.GetSortedPortals()) do
	local data = v.data

	if workspace:FindFirstChild(data.IslandFolder) then
		local island=workspace[data.IslandFolder]
		local n

		for k,c in pairs(island:GetChildren()) do
			if c:GetAttribute("CheckpointId") then
				n=c:GetPivot().Position
			end
		end

		datamap[v.id]={island,n}
	end
end
local currentTween
function tpTomap(pos)
    local bestPortalId = nil
    local minDistanceToTarget = math.huge


	for id, portalData in pairs(datamap) do
		local portalPos = portalData[2]

		for _,chil in pairs(portalData[1]:GetChildren()) do
			if string.find(chil.Name,"Portal") then
				portalPos = chil.Position
				
				datamap[id][2] = portalPos
				break
			end
		end
		
		local distFromPortalToTarget = (portalPos - targetPos).Magnitude+30


		if distFromPortalToTarget < minDistanceToTarget then
			minDistanceToTarget = distFromPortalToTarget
			bestPortalId = id
		end
	end

	    if bestPortalId then

		if currentTween then
			currentTween:Cancel()
			task.wait(.1) 
		end
        game:GetService("ReplicatedStorage").Remotes.TeleportToPortal:FireServer(bestPortalId)
        task.wait(0.3) 
    end

end


function TpTo(targetCFrame)
    local root = getRoot(LP.Character)
    if not root then return end

    local targetPos = targetCFrame.Position
    local distanceToTarget = (root.Position - targetPos).Magnitude

    local bestPortalId = nil
    local minDistanceToTarget = distanceToTarget -- Mặc định là khoảng cách hiện tại


	for id, portalData in pairs(datamap) do
		local portalPos = portalData[2]

		for _,chil in pairs(portalData[1]:GetChildren()) do

			if string.find(chil.Name,"Portal") then
				portalPos = chil.Position
				
				datamap[id][2] = portalPos
				break
			end
		end
		
		local distFromPortalToTarget = (portalPos - targetPos).Magnitude+30


		if distFromPortalToTarget < minDistanceToTarget then
			minDistanceToTarget = distFromPortalToTarget
			bestPortalId = id
		end
	end

    if bestPortalId then

		if currentTween then
			currentTween:Cancel()
			task.wait(.1) 
		end
        game:GetService("ReplicatedStorage").Remotes.TeleportToPortal:FireServer(bestPortalId)
        task.wait(0.3) 
    end

    local newDistance = (root.Position - targetPos).Magnitude
    if newDistance > 50 then
        currentTween = game:GetService("TweenService"):Create(root, TweenInfo.new(newDistance/75), {CFrame = targetCFrame})
		currentTween:Play()
    else
		if currentTween then
			currentTween:Cancel()
		end
        root.CFrame = targetCFrame
    end
end

function equiptool(itemName)
	if LP.Backpack:FindFirstChild(itemName) then
		LP.Character.Humanoid:EquipTool(LP.Backpack:FindFirstChild(itemName))
	end
end

function getBoss()
	if getRoot(LP.Character) then
		local nearestBoss = nil
		local nearestDistance = math.huge
		for _,v in ipairs(workspace.NPCs:GetChildren()) do
			if checktable(getgenv().Config.Bosses,v.Name) then
				local distance = (v:GetPivot().Position - getRoot(LP.Character).Position).Magnitude
				if distance < nearestDistance then
					if not v:FindFirstChild("Humanoid") or v.Humanoid.Health>0 then
						nearestDistance = distance
						nearestBoss = v
					end
				end
			end
		end
		return nearestBoss
	end
	return nil
end

function getBoss2(pos)
	if getRoot(LP.Character) then
		local nearestBoss = nil
		local nearestDistance = 200
		for _,v in ipairs(workspace.NPCs:GetChildren()) do
			local distance = (v:GetPivot().Position - pos).Magnitude
			if distance < nearestDistance then
				if not v:FindFirstChild("Humanoid") or v.Humanoid.Health>0 then
					nearestDistance = distance
					nearestBoss = v
				end
			end
		end
		return nearestBoss
	end
	return nil
end

local bossmodu=require(game:GetService("ReplicatedStorage").Modules.BossConfig)
local allbosses=bossmodu:GetAllBossNames()

local mobquest = require(game:GetService("ReplicatedStorage").Modules.QuestConfig)
local allmobs={}
local quests={}

for i,v in pairs(mobquest.RepeatableQuests) do
	table.insert(allmobs,v["requirements"][1]["npcType"])
	quests[v["requirements"][1]["npcType"]]=i
end

function AddQuest(quest2)
    if not game:GetService("Players").LocalPlayer.PlayerGui.QuestUI.Quest.Visible then
		game:GetService("ReplicatedStorage").RemoteEvents.QuestAccept:FireServer(quest2)
    end
end

function getTools()
    local tools={}
    for _,v in ipairs(LP.Backpack:GetChildren()) do
        table.insert(tools,v.Name)
    end
	for i,v in ipairs(LP.Character:GetChildren()) do
		if v:IsA("Tool") then
			table.insert(tools,v.Name)
		end
	end
    return tools
end


local espProxyFolder = Workspace:FindFirstChild("SawHubEspProxies") or Instance.new("Folder")
espProxyFolder.Name = "SawHubEspProxies"
espProxyFolder.Parent = Workspace
local playerEspCache = {}

local function clearPlayerEsp(player)
	local cache = playerEspCache[player]
	if not cache then
		return
	end
	if cache.billboard then
		cache.billboard:Destroy()
	end
	if cache.highlight then
		cache.highlight:Destroy()
	end
	if cache.proxy then
		cache.proxy:Destroy()
	end
	playerEspCache[player] = nil
end

local function applyESP(player)
	if player == LP then
		return
	end
	local character = player.Character
	if not character then
		clearPlayerEsp(player)
		return
	end

	local cache = playerEspCache[player]
	if not cache then
		local proxy = Instance.new("Part")
		proxy.Name = "ESP_" .. player.Name
		proxy.Anchored = true
		proxy.CanCollide = false
		proxy.CanQuery = false
		proxy.CanTouch = false
		proxy.Transparency = 1
		proxy.Size = Vector3.new(1, 1, 1)
		proxy.Parent = espProxyFolder

		local billboard = Instance.new("BillboardGui")
		billboard.Name = "PlayerESP"
		billboard.Adornee = proxy
		billboard.Size = UDim2.new(0, 140, 0, 50)
		billboard.StudsOffset = Vector3.new(0, 3, 0)
		billboard.AlwaysOnTop = true
		billboard.Parent = proxy

		local label = Instance.new("TextLabel")
		label.Parent = billboard
		label.BackgroundTransparency = 1
		label.Size = UDim2.new(1, 0, 1, 0)
		label.Text = player.Name
		label.TextColor3 = Color3.fromRGB(80, 255, 120)
		label.TextStrokeTransparency = 0
		label.TextScaled = true
		label.Font = Enum.Font.GothamBold

		local highlight = Instance.new("Highlight")
		highlight.Name = "PlayerESPHighlight"
		highlight.FillTransparency = 1
		highlight.OutlineColor = Color3.fromRGB(80, 255, 120)
		highlight.OutlineTransparency = 0.2
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = proxy

		cache = {proxy = proxy, billboard = billboard, highlight = highlight, label = label}
		playerEspCache[player] = cache
	end

	local playerPivot = character:GetPivot()
	cache.proxy.CFrame = playerPivot + Vector3.new(0, 3, 0)
	cache.highlight.Adornee = character
	cache.highlight.Enabled = getgenv().Config.ShowPlayerOutlineESP ~= false
	local myRoot = getRoot(LP.Character)
	if cache.label then
		if getgenv().Config.ShowPlayerDistanceESP and myRoot then
			local distance = math.floor((myRoot.Position - playerPivot.Position).Magnitude)
			cache.label.Text = string.format("%s [%dm]", player.Name, distance)
		else
			cache.label.Text = player.Name
		end
	end
end

Players.PlayerRemoving:Connect(function(player)
	clearPlayerEsp(player)
end)

function getmobnearest()
	if getRoot(LP.Character) then
		local nearestBoss = nil
		local nearestDistance = getgenv().Config.DistanceFarm or 500
		for _,v in ipairs(workspace.NPCs:GetChildren()) do
			if v.Name~="TrainingDummy" then
				local distance = (v:GetPivot().Position - getRoot(LP.Character).Position).Magnitude
				if distance < nearestDistance then
					if not v:FindFirstChild("Humanoid") or v.Humanoid.Health>0 then
						nearestDistance = distance
						nearestBoss = v
					end
				end
			end
		end
		return nearestBoss
	end
	return nil

end

function skiluse()
	for i,v in pairs(getgenv().Config.UseSkill or {}) do
		sendkey(Enum.KeyCode[v])
	end
end

function getpityboss()
    local gui = game:GetService("Players").LocalPlayer.PlayerGui.BossUI.MainFrame.BossHPBar.Pity
    local te = gui.Text
    

    local pity = string.match(te, "(%d+)") 

    if pity then
        return tonumber(pity)
    end
    return 0 
end

function addhighlight(obj)
    if not obj or obj:FindFirstChild("sawhubontop") then return end
    
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 165, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
	highlight.Name="sawhubontop"
    highlight.Adornee = obj
    highlight.Parent = obj

    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = obj
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = obj

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = obj.Name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard
end

function findbossname(name)
	for i,v in pairs(workspace.NPCs:GetChildren()) do
		if v.Name==name then
			return v 
		end
	end
	return false
end
local Sawhub= UI:CreateWindow({Name="Saw Hub"})



local FixSec = Sawhub.Home:CreateSection({Name="Fix"})
FixSec:CreateButton({Name="Fix Float",Callback=function()
    RemoveFloat()
end})

local ConfigSec = Sawhub.Home:CreateSection({Name="Config"})

local selectwep=ConfigSec:CreateDropdown({Name="Select Weapon",List=getTools(),Default=getgenv().Config.Weapon or "Soul Reaper",Multi=false,Callback=function(v)
	getgenv().Config.Weapon=v
 end})

ConfigSec:CreateButton({Name="Refresh Weapons",Callback=function()
selectwep:New(getTools())
end})

ConfigSec:CreateDropdown({Name="Use Skill",List={"Z","X","C","V","F"},Default=getgenv().Config.UseSkill or {"Z","X","C","V"},Multi=true,Callback=function(v)
	getgenv().Config.UseSkill=v
end})

ConfigSec:CreateToggle({Name="Only Skill Boss",Default=getgenv().Config.OnlySkillBoss or false,Callback=function(v)
	getgenv().Config.OnlySkillBoss=v
end})

local TeleportSec = Sawhub.Players:CreateSection({Name="Teleport Maps"})
do
	local portalIds = {}
	for portalId in pairs(datamap) do
		table.insert(portalIds, portalId)
	end
	table.sort(portalIds, function(a, b)
		return tostring(a) < tostring(b)
	end)

	for _, portalId in ipairs(portalIds) do
		local safePortalId = portalId
		TeleportSec:CreateButton({
			Name = "TP " .. tostring(safePortalId),
			Callback = function()
				if currentTween then
					currentTween:Cancel()
				end
				TeleportToPortalRemote:FireServer(safePortalId)
			end
		})
	end
end

local PlayerToolsSec = Sawhub.Players:CreateSection({Name="Player Tools"})
local selectedPlayerName = ""
local function getOtherPlayers()
	local names = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LP then
			table.insert(names, player.Name)
		end
	end
	table.sort(names)
	return names
end

local playerDropdown = PlayerToolsSec:CreateDropdown({
	Name = "Select Player",
	List = getOtherPlayers(),
	Default = {selectedPlayerName},
	Multi = false,
	Callback = function(v)
		selectedPlayerName = v
	end
})

PlayerToolsSec:CreateButton({
	Name = "Refresh Players",
	Callback = function()
		playerDropdown:New(getOtherPlayers())
	end
})

PlayerToolsSec:CreateButton({
	Name = "TP To Player",
	Callback = function()
		local target = Players:FindFirstChild(selectedPlayerName)
		if target and target.Character then
			TpTo(target.Character:GetPivot())
		end
	end
})

local Sea2Sec = Sawhub.Home:CreateSection({Name="Sea 2"})
Sea2Sec:CreateToggle({Name="Esp Ancient Fragment",Default=getgenv().Config.EspAncientFragment or false,Callback=function(v)
	getgenv().Config.EspAncientFragment=v
	task.spawn(function()
		while wait() and getgenv().Config.EspAncientFragment do 
		for _,item in pairs(workspace.Sea2MapQuest:GetChildren()) do
				if item.Name=="MapFragment_Ancient Fragment" or string.find(item.Name,"MapFragment_Ancient Fragment") or string.find("MapFragment_Ancient Fragment",item.Name) then
					addhighlight(item)
				end
			end
		end
	end)
end})

Sea2Sec:CreateToggle({Name="Auto Kraken",Default=getgenv().Config.AutoKraken or false,Callback=function(v)
	getgenv().Config.AutoKraken=v
end})
Sea2Sec:CreateToggle({Name="Auto Spawn Kraken",Default=getgenv().Config.AutoSpawnKraken or false,Callback=function(v)
	getgenv().Config.AutoSpawnKraken=v
	task.spawn(function()
		while task.wait(.1) and getgenv().Config.AutoSpawnKraken do
			if not findbossname("Kraken") and not findbossname("Sea Serpent") then
				TpTo(CFrame.new(-2364.94434, -8.30165672, 932.541626))
			end
		end
	end)
end})


local MobSec = Sawhub.Home:CreateSection({Name="Mob"})
MobSec:CreateDropdown({Name="Select Mob",List=allmobs,Default=getgenv().Config.Mob or "",Multi=false,Callback=function(v)
	getgenv().Config.Mob=v
end})
MobSec:CreateToggle({Name="Auto Farm Mob",Default=getgenv().Config.AutoFarmMob,Callback=function(v)
	getgenv().Config.AutoFarmMob= v
end})

local BossesSec=Sawhub.Home:CreateSection({Name="Bosses"})
BossesSec:CreateDropdown({Name="Select Boss",List=allbosses,Default=getgenv().Config.Bosses or {},Multi=true,Callback=function(v)
	getgenv().Config.Bosses=v
end})
BossesSec:CreateToggle({Name="Auto Farm Boss",Default=getgenv().Config.AutoFarmBoss,Callback=function(v)
	getgenv().Config.AutoFarmBoss= v
end})

local NearestSec=Sawhub.Home:CreateSection({Name="Nearest"})

NearestSec:CreateSlider({Name="Distance Farm",Min=100,Default=getgenv().Config.DistanceFarm or 500,Max=10000,Callback=function(v)
	getgenv().Config.DistanceFarm=v
end})
NearestSec:CreateToggle({Name="Auto Farm Nearest",Default=getgenv().Config.AutoFarmNearest,Callback=function(v)
	getgenv().Config.AutoFarmNearest = v
end})

if not getgenv().Config then
	getgenv().Config={}
end

local PitySec=Sawhub.Home:CreateSection({Name="Pity Farm"})
PitySec:CreateToggle({Name="Auto Farm Pity",Default=getgenv().Config.AutoFarmPity,Callback=function(v)
	getgenv().Config.AutoFarmPity = v
end})

PitySec:CreateDropdown({Name="Select Boss Final",List=allbosses,Default=getgenv().Config.BossPity or "",Multi=false,Callback=function(v)
	getgenv().Config.BossPity=v
end})

local PowerSec = Sawhub.Settings:CreateSection({Name="Power"})
PowerSec:CreateToggle({Name="Power Saver",Default=getgenv().Config.PowerSaver or false,Callback=function(v)
	getgenv().Config.PowerSaver = v
	if v then
		setfpscap(10)
		game:GetService("RunService"):Set3dRenderingEnabled(false)
	else
		setfpscap(120)
		game:GetService("RunService"):Set3dRenderingEnabled(true)
	end
end})

PowerSec:CreateButton({Name="Disable LocalScripts (BreakGame)",Callback=function()
	for i,v in pairs(game:GetDescendants()) do
		if v:IsA("LocalScript") then
			v.Enabled=false
		end
	end
end})

local SettingsToolsSec = Sawhub.Settings:CreateSection({Name="Session"})
SettingsToolsSec:CreateButton({Name="Rejoin Server",Callback=function()
	local TeleportService = game:GetService("TeleportService")
	TeleportService:Teleport(game.PlaceId, LP)
end})

SettingsToolsSec:CreateButton({Name="Copy JobId",Callback=function()
	if setclipboard then
		setclipboard(game.JobId)
		CreateNotify("Copied JobId", 2)
	end
end})


local TaskFarm="None"

function checkgetname(a,b)
	for i,v in pairs(a:GetChildren()) do
		if v.Name == b or string.find(v.Name,b) or string.find(b,v.Name) then
			return v
		end
	end
	return false
end

local bossspawn={"QinShiBoss","SaberBoss","MoonSlayerBoss","IchigoBoss","BlessedMaidenBoss","SaberAlterBoss","IceQueenBoss"}
local BossStronge={"StrongestinHistoryBoss","StrongestofTodayBoss"}

function spawnbossfinal(bn)
	if table.find(bossspawn,bn) then
		local bos=bossmodu:GetBoss(bn)
		if not bos.hasDifficulty then
			game:GetService("ReplicatedStorage").Remotes.RequestSummonBoss:FireServer(bn)
		else
			game:GetService("ReplicatedStorage").Remotes.RequestSummonBoss:FireServer(bn,"Normal")
		end
	elseif table.find(BossStronge,bn) then
		if bn=="StrongestinHistoryBoss" then
			bn="StrongestHistory"
		elseif bn=="StrongestofTodayBoss" then
			bn="StrongestToday"
		end
		game:GetService("ReplicatedStorage").Remotes.RequestSpawnStrongestBoss:FireServer(bn,"Normal")
	elseif bn=="AtomicBoss" then
		game:GetService("ReplicatedStorage").RemoteEvents.RequestSpawnAtomic:FireServer("Normal")
	elseif bn=="RimuruBoss" then
		game:GetService("ReplicatedStorage").RemoteEvents.RequestSpawnRimuru:FireServer("Normal")
	end
end

function attackmob(boss)
	if not boss then
		return
	end

	repeat
		task.wait()
		local root = getRoot(LP.Character)
		local humanoid = boss:FindFirstChild("Humanoid")
		local hrp = boss:FindFirstChild("HumanoidRootPart")
		local isAlive = (not humanoid) or humanoid.Health > 0

		if root and hrp and isAlive and (root.Position - hrp.Position + Vector3.new(0, 10, 0)).Magnitude <= 30 then
			TpTo(CFrame.new(hrp.Position + Vector3.new(0, 0, 10), hrp.Position))
			equiptool(getgenv().Config.Weapon)
			Attack()
			skiluse()
		elseif boss.Parent and isAlive then
			local currentPivot = boss:GetPivot()
			if currentPivot then
				TpTo(currentPivot)
			end
		end
	until (not boss) or (not boss.Parent) or (humanoid and humanoid.Health <= 0)
end

local function attackTargetLoop(target, shouldContinue, useSkill)
	if not target then
		return
	end
	repeat
		task.wait()
		if shouldContinue and not shouldContinue() then
			break
		end
		local root = getRoot(LP.Character)
		local humanoid = target:FindFirstChild("Humanoid")
		local hrp = target:FindFirstChild("HumanoidRootPart")
		local isAlive = (not humanoid) or humanoid.Health > 0

		if root and hrp and isAlive and (root.Position - hrp.Position + Vector3.new(0, 10, 0)).Magnitude <= 30 then
			TpTo(CFrame.new(hrp.Position + Vector3.new(0, 0, 10), hrp.Position))
			equiptool(getgenv().Config.Weapon)
			Attack()
			if useSkill ~= false then
				skiluse()
			end
		elseif target.Parent and isAlive then
			local pivot = target:GetPivot()
			if pivot then
				TpTo(pivot)
			end
		end
	until (not target) or (not target.Parent) or (humanoid and humanoid.Health <= 0)
end

task.spawn(function()
    while task.wait(.1) do
        if getgenv().Config.AutoFarmPity then
			local piti=getpityboss()

			if piti and piti >= 24 then
				local bn=getgenv().Config.BossPity or ""
				local b2=getBoss2(Vector3.new(764.051513671875, -0.6666639447212219, -1086.5523681640625))
				if table.find(bossspawn,bn) and (b2 and not (string.find(b2.Name,bn) or string.find(bn,b2.Name) or b2.Name==bn)) then
					attackmob(b2)
				end
				if not checkgetname(workspace.NPCs,bn) then
					spawnbossfinal(bn)
				else
					local boss=checkgetname(workspace.NPCs,bn)
					if boss then
						attackTargetLoop(boss, function()
							return getgenv().Config.AutoFarmPity
						end, true)
					end
				end

			else
				if not checkgetname(workspace.NPCs,"SaberBoss") and not getBoss2(Vector3.new(764.051513671875, -0.6666639447212219, -1086.5523681640625)) then
					game:GetService("ReplicatedStorage").Remotes.RequestSummonBoss:FireServer("SaberBoss")
				else
					local boss=checkgetname(workspace.NPCs,"SaberBoss") or getBoss2(Vector3.new(764.051513671875, -0.6666639447212219, -1086.5523681640625))
					if boss then
						attackTargetLoop(boss, function()
							return getgenv().Config.AutoFarmPity
						end, true)
					end
				end
			end
		end
	end
end)

task.spawn(function()
    while task.wait() do
        if getgenv().Config.AutoFarmBoss and TaskFarm=="FarmBoss" then

            local boss = getBoss()
            if boss then
				attackTargetLoop(boss, function()
					return getgenv().Config.AutoFarmBoss and TaskFarm=="FarmBoss"
				end, true)
			end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if getgenv().Config.AutoKraken and TaskFarm=="AutoKraken" then

            local boss
			for i,v in pairs(workspace.NPCs:GetChildren()) do
				if v.Name=="Kraken" or v.Name== "Sea Serpent" then
					boss = v
					break
				end
			end
            if boss then
				repeat
                    task.wait()
                    local root = getRoot(LP.Character)
                    local hitbox = boss:FindFirstChild("SeaBeastHitbox")
                    
                    if boss.Parent and root and hitbox then
                        -- Luôn luôn duy trì vị trí phía trên boss
                        local targetCFrame = CFrame.new(hitbox.Position + Vector3.new(0, 50, 0), hitbox.Position)
                        TpTo(targetCFrame)

                        -- Kiểm tra khoảng cách để đánh (có thể nới lỏng Magnitude lên 50-60 cho chắc chắn)
                        if (root.Position - targetCFrame.Position).Magnitude <= 60 then
                            equiptool(getgenv().Config.Weapon)
                            Attack()
                            skiluse()
                        end
                    elseif boss.Parent then
                        -- Nếu chưa tìm thấy hitbox thì TP tới Pivot chính của boss
                        TpTo(boss:GetPivot())
                    end
                until not boss or not boss.Parent or (boss:GetAttribute("_BossHP") and tonumber(boss:GetAttribute("_BossHP")) <= 0) or not getgenv().Config.AutoKraken or TaskFarm ~= "AutoKraken"
			end
        end
    end
end)

task.spawn(function()
	while task.wait() do
		if getgenv().Config.AutoFarmMob and TaskFarm=="FarmMob" then

			AddQuest(quests[getgenv().Config.Mob])
			if game:GetService("Players").LocalPlayer.PlayerGui.QuestUI.Quest.Visible then
				for _, v in ipairs(workspace.NPCs:GetChildren()) do
					if string.find(v.Name, getgenv().Config.Mob) then
						if (v:FindFirstChild("Humanoid") and v.Humanoid.Health <= 0) then
							continue
						end
						repeat
			
							task.wait()
							local char = LP.Character
							local myRoot = char and char:FindFirstChild("HumanoidRootPart")
							local myHum = char and char:FindFirstChild("Humanoid")
							
							if myRoot and myHum and myHum.Health > 0 then
								local vPivot = v:GetPivot()
								local vPos = vPivot.Position
								local targetPos = vPos + Vector3.new(0, 0, 10)

								TpTo(CFrame.new(targetPos, vPos))

								equiptool(getgenv().Config.Weapon)
								
								Attack()
								if not getgenv().Config.OnlySkillBoss then
									skiluse()
								end
							end

							local vHum = v:FindFirstChild("Humanoid")
						until not v or not v.Parent or (vHum and vHum.Health <= 0) or TaskFarm~="FarmMob"
					end
				end
			end
		end
	end
end)

task.spawn(function()
    while task.wait() do
        if getgenv().Config.AutoFarmNearest and TaskFarm=="FarmNearest" then

            local boss = getmobnearest()
            if boss then
				if boss:FindFirstChild("Humanoid") and boss.Humanoid.Health <= 0 or not boss:FindFirstChild("HumanoidRootPart") then
					continue
				end
				attackTargetLoop(boss, function()
					return getgenv().Config.AutoFarmNearest and TaskFarm=="FarmNearest"
				end, true)
			end
        end
    end
end)


local EspSec=Sawhub.Visuals:CreateSection({Name="Esp"})	
EspSec:CreateToggle({Name="Player ESP Distance",Default=getgenv().Config.ShowPlayerDistanceESP or false,Callback=function(v)
	getgenv().Config.ShowPlayerDistanceESP = v
end})

EspSec:CreateToggle({Name="Player ESP Outline",Default=(getgenv().Config.ShowPlayerOutlineESP ~= false),Callback=function(v)
	getgenv().Config.ShowPlayerOutlineESP = v
end})

EspSec:CreateToggle({Name="Player Name ESP",Default=getgenv().Config.ShowBossESP,Callback=function(v)
	getgenv().Config.ShowBossESP= v
	task.spawn(function()
		while task.wait(.5) and getgenv().Config.ShowBossESP do

			for _, player in ipairs(Players:GetPlayers()) do
				applyESP(player)
			end
			
		end
		for player, _ in pairs(playerEspCache) do
			clearPlayerEsp(player)
		end
	end)
end})


task.spawn(function()
	while task.wait() do
		if getgenv().Config.AutoKraken and (findbossname("Kraken") or findbossname("Sea Serpent")) then
			TaskFarm="AutoKraken"
		elseif getgenv().Config.AutoFarmBoss and getBoss() then
			TaskFarm="FarmBoss"
		elseif getgenv().Config.AutoFarmMob then
			TaskFarm="FarmMob"
		elseif getgenv().Config.AutoFarmNearest then
			TaskFarm="FarmNearest"
		else
			TaskFarm="None"
		end
		if TaskFarm~="None" then
			TweenFloat()
		else
			RemoveFloat()
		end
	end

end)
game:GetService("Players").LocalPlayer.Idled:connect(function()
   
        VirtualUser:Button2Down(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
   
end)

RunService.Stepped:Connect(function()
	local character = LP.Character
	if character and character:FindFirstChild('HumanoidRootPart') and (TaskFarm~="None") then
		for k,v in next,character:GetChildren() do
			if v:IsA('BasePart') then
				v.CanCollide = false
			end
		end
	end
end)

Sawhub:Init()
