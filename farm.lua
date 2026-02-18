repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("CoreGui")
local TS = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local plr = Players.LocalPlayer
local Mouse = plr:GetMouse()
local UIS = game:GetService("UserInputService")
local Tweeninfo = TweenInfo.new
local vim = game:service('VirtualInputManager')
local Camera = Workspace.CurrentCamera
local UI={}

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

local ServerTime=0
spawn(function()
	while wait(1) do
		ServerTime=ServerTime+1
	end
end)

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
	Frame_2.BackgroundColor3 = Color3.fromRGB(17, 19, 21)
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
	page_4.BackgroundColor3 = Color3.fromRGB(18, 20, 22)
	page_4.BackgroundTransparency = 0
	page_4.BorderSizePixel = 0
	page_4.ClipsDescendants = false
	page_4.Visible = true
	page_4.ZIndex = 1
	page_4.Parent = Frame_2

	local UIStroke_5 = Instance.new("UIStroke")
	UIStroke_5.Name = "UIStroke"
	UIStroke_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_5.Color = Color3.fromRGB(37, 37, 37)
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
	PageName_7.TextColor3 = Color3.fromRGB(200, 200, 200)
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
	search_8.BackgroundColor3 = Color3.fromRGB(18, 20, 22)
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
	UIStroke_10.Color = Color3.fromRGB(37, 37, 37)
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
	Search_11.ImageColor3 = Color3.fromRGB(177, 177, 177)
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
	searchbox_13.TextColor3 = Color3.fromRGB(255, 255, 255)
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
	NameHub_14.BackgroundColor3 = Color3.fromRGB(18, 20, 22)
	NameHub_14.BackgroundTransparency = 0
	NameHub_14.BorderSizePixel = 0
	NameHub_14.ClipsDescendants = false
	NameHub_14.Visible = true
	NameHub_14.ZIndex = 1
	NameHub_14.Parent = Frame_2

	local UIStroke_15 = Instance.new("UIStroke")
	UIStroke_15.Name = "UIStroke"
	UIStroke_15.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_15.Color = Color3.fromRGB(37, 37, 37)
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
	local gameName
	local lastTime = tick()
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

	game:GetService("RunService").RenderStepped:Connect(function()
		frameCount =frameCount+ 1
		local currentTime = tick()

		if currentTime - lastTime >= 1 then
			fps = frameCount
			frameCount = 0
			lastTime = currentTime

			TextLabel_49.Text=gameName.." | "..fps .." FPS | "..convertSecondsToTime(ServerTime).." | v1.0.0"
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

	local kb = Enum.KeyCode.RightShift


	Keyb_1.MouseButton1Click:Connect(function()
		if K_4.Text ~= "..." then
			K_4.Text = "..."

			local connection
			connection = UIS.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Keyboard then
					local newKey = input.KeyCode

					if newKey ~= Enum.KeyCode.Unknown then
						kb = newKey
						K_4.Text = newKey.Name
						connection:Disconnect()
					end
				end
			end)
		end
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
			if v.Name ~= "UIU" and v.Name ~= "Bar" then
				v.Visible=val
			end
		end

	end

	Remove_52.MouseButton1Click:Connect(function()
		TS:Create(Frame_2,TweenInfo.new(0.1),{Size=UDim2.new(0.627, 0,0, 0)}):Play()
		task.wait(.1)
		cleanUI(false)
		Add_54.Visible=true
		Remove_52.Visible=false
	end)

	Add_54.MouseButton1Click:Connect(function()
		Add_54.Visible=false
		Remove_52.Visible=true
		cleanUI(true)
		TS:Create(Frame_2,TweenInfo.new(0.1),{Size=UDim2.new(0, 750,0, 500)}):Play()
	end)

	Close_50.MouseButton1Click:Connect(function()
		TS:Create(Frame_2,TweenInfo.new(0.1),{Size=UDim2.new(0, 0,0, 500)}):Play()
		task.wait(.1)
		cleanUI(false)
		TS:Create(Bar_46,TweenInfo.new(0.1),{Size=UDim2.new(0, 0,0, 30)}):Play()
		task.wait(.1)
		Bar_46.Visible=false
		opend=true
	end)

	UIS.InputBegan:Connect(function(k,c)
		if c then return end 
		if k.KeyCode==kb then
			if not opend then
				TS:Create(Frame_2,TweenInfo.new(0.1),{Size=UDim2.new(00, 0,0, 500)}):Play()
				task.wait(.1)
				cleanUI(false)
				TS:Create(Bar_46,TweenInfo.new(0.1),{Size=UDim2.new(0, 0,0, 30)}):Play()
				task.wait(.1)
				Bar_46.Visible=false
				opend=true
			else
				Bar_46.Visible=true
				TS:Create(Bar_46,TweenInfo.new(0.1),{Size=UDim2.new(0, 750,0, 30)}):Play()
				task.wait(.1)
				Add_54.Visible=false
				Remove_52.Visible=true
				cleanUI(true)
				TS:Create(Frame_2,TweenInfo.new(0.1),{Size=UDim2.new(0, 750,0, 500)}):Play()
				opend=false
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
		Section_1.BackgroundColor3 = Color3.fromRGB(15, 17, 18)
		Section_1.BackgroundTransparency = 0
		Section_1.BorderSizePixel = 0
		Section_1.ClipsDescendants = false
		Section_1.Visible = true
		Section_1.ZIndex = 1
		Section_1.Parent = chosel

		local hehee_2 = Instance.new("UIStroke")
		hehee_2.Name = "hehee"
		hehee_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		hehee_2.Color = Color3.fromRGB(37, 37, 37)
		hehee_2.Thickness = 1
		hehee_2.Transparency = 0
		hehee_2.LineJoinMode = Enum.LineJoinMode.Round
		hehee_2.Parent = Section_1

		local UIAA_3 = Instance.new("UICorner")
		UIAA_3.Name = "UIAA"
		UIAA_3.CornerRadius = UDim.new(0.000000, 8)
		UIAA_3.Parent = Section_1

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
		TextLabel_6.BackgroundColor3 = Color3.fromRGB(15, 17, 18)
		TextLabel_6.BackgroundTransparency = 0
		TextLabel_6.BorderSizePixel = 0
		TextLabel_6.Visible = true
		TextLabel_6.ZIndex = 2
		TextLabel_6.Text = optionssec.Name
		TextLabel_6.TextColor3 = Color3.fromRGB(255, 255, 255)
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
		Frame_7.BackgroundColor3 = Color3.fromRGB(139, 139, 139)
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
			ButtonName_2.TextColor3 = Color3.fromRGB(255, 255, 255)
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
			Fire_3.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
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
			dad_5.Color = Color3.fromRGB(71, 71, 71)
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
			ToggleName_2.TextColor3 = Color3.fromRGB(255, 255, 255)
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
			Fire_3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
			Check_5.BackgroundColor3 = Color3.fromRGB(66, 197, 197)
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
				if val then
					Check_5.Visible=true
				else
					Check_5.Visible=false
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
			SliderName_2.TextColor3 = Color3.fromRGB(255, 255, 255)
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
			Number_3.TextColor3 = Color3.fromRGB(72, 72, 72)
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
			Fire_4.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
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
			Ttt_5.BackgroundColor3 = Color3.fromRGB(66, 197, 197)
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
			Cir_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
				local pos = math.clamp((Input.Position.X - Fire_4.AbsolutePosition.X) / Fire_4.AbsoluteSize.X, 0, 1)
				local value = Min + (pos * (Max - Min))

				value = math.floor(value / Increment + 0.5) * Increment
				value = math.clamp(value, Min, Max)

				local decimals = tostring(Increment):match("%.(%d+)")
				local precision = decimals and #decimals or 0
				local formattedValue = string.format("%." .. precision .. "f", value)

				Ttt_5.Size = UDim2.new((value - Min) / (Max - Min), 0, 1, 0)
				Number_3.Text = formattedValue

				Callback(tonumber(formattedValue))
			end

			local function SetValue(value)
				value = math.clamp(value, Min, Max)

				local decimals = tostring(Increment):match("%.(%d+)")
				local precision = decimals and #decimals or 0
				local formattedValue = string.format("%." .. precision .. "f", value)

				Ttt_5.Size = UDim2.new((value - Min) / (Max - Min), 0, 1, 0)
				Number_3.Text = formattedValue

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

        return secfunc
	end


	for i,v in pairs(ListTab_21:GetChildren()) do
		if v:IsA("TextButton") then
			local page=createpage()
			page.Name=v.TextLabel.Text
			page.Visible=false
			lib[v.TextLabel.Text]={}
			local l = lib[v.TextLabel.Text]
			function l:CreateSection(op)
				return CreateSection(page,op)
			end

			v.MouseButton1Click:Connect(function()
				TS:Create(ChooseTab_57,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{Position=UDim2.new(0.5,0,0,math.abs(v.AbsolutePosition.Y-ChooseTab_57.AbsolutePosition.Y+ChooseTab_57.Position.Y.Offset))}):Play()
				resetpage()
				PageName_7.Text=v.TextLabel.Text
				page.Visible=true
			end)
			if not first then
				TS:Create(ChooseTab_57,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{Position=UDim2.new(0.5,0,0,math.abs(v.AbsolutePosition.Y-ChooseTab_57.AbsolutePosition.Y+ChooseTab_57.Position.Y.Offset))}):Play()
				resetpage()
				page.Visible=true
				PageName_7.Text=v.TextLabel.Text
				first=true
			end
		end
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
	return lib
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

local loadhubb=CreateNotify("Loading Hub")

task.spawn(function()
	while task.wait(.1) and loadhubb:Check() do
		loadhubb:Set("Loading Hub.")
		task.wait(.1)
		loadhubb:Set("Loading Hub..")
		task.wait(.1)
		loadhubb:Set("Loading Hub...")
	end
end)

repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
repeat task.wait() until game:GetService("Players").LocalPlayer.Character

loadhubb:Destroy()

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
      
        Network = require(Players.LocalPlayer.PlayerScripts.TS.lib.network),
        PlayerUtil = require(replicatedStorage.TS.player["player-util"]).GamePlayerUtil,
        
        ProjMeta = require(replicatedStorage.TS.projectile['projectile-meta']).ProjectileMeta,
        Promise = require(replicatedStorage.rbxts_include.node_modules["@easy-games"].knit.src.Knit.Util.Promise),
        Remotes = require(replicatedStorage.TS.remotes).default.Client,
        Shop = require(replicatedStorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop,
        ShopPurchase = require(Players.LocalPlayer.PlayerScripts.TS.controllers.global.shop.api["purchase-item"]).shopPurchaseItem,
        Sound = require(replicatedStorage.rbxts_include.node_modules["@easy-games"]["game-core"].out).SoundManager,
        Store = require(Players.LocalPlayer.PlayerScripts.TS.ui.store).ClientStore,
        SyncEvents = require(Players.LocalPlayer.PlayerScripts.TS["client-sync-events"]).ClientSyncEvents,
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

function load()
	if isfolder("Sawhub") == false then
		makefolder("Sawhub")
	end
	if isfile("/Sawhub/Bedwar-" .. game.Players.LocalPlayer.Name .. ".json") == false then
		writefile("/Sawhub/Bedwar-" .. game.Players.LocalPlayer.Name .. ".json", HttpService:JSONEncode(getgenv().Config))
	else
		local Decode = HttpService:JSONDecode(readfile("/Sawhub/Bedwar-" .. game.Players.LocalPlayer.Name .. ".json"))
		for i,v in pairs(Decode) do
			getgenv().Config[i] = v
		end
	end
end

function Save()
	writefile("/Sawhub/Bedwar-" .. game.Players.LocalPlayer.Name .. ".json", HttpService:JSONEncode(getgenv().Config))
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

function RayCast(origin, direction)
    local ignored = {Players.LocalPlayer.Character,workspace:FindFirstChild("AntiVVV")}
    local raycastParameters = RaycastParams.new()
    raycastParameters.FilterDescendantsInstances = ignored
    raycastParameters.FilterType = Enum.RaycastFilterType.Exclude
    raycastParameters.IgnoreWater = true
    
    return workspace:Raycast(origin, direction, raycastParameters)
end


local AntiHitSettings = {
    Range = 18,
    Height = 50,
    Up = 0.3,
    Down = 0.2,
    Trans = 0.5,
    Material = "ForceField",
    Color = Color3.fromRGB(255, 0, 0),
    Dynamic = true
}

local cloneChar
local hbConnection

local function IsAlive(checkPlr)
    checkPlr = checkPlr or plr
    local char = checkPlr.Character
    if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
        return char.Humanoid.Health > 0
    end
    return false
end

local function GetNearestEntity(maxRange)
    local nearest = nil
    local minDist = maxRange

    if not IsAlive() then return nil, maxRange end

    local lpRoot = plr.Character.HumanoidRootPart

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= plr and IsAlive(player) and player.Team ~= plr.Team then
            local targetRoot = player.Character.HumanoidRootPart
            local dist = (lpRoot.Position - targetRoot.Position).Magnitude
            if dist <= minDist then
                minDist = dist
                nearest = player
            end
        end
    end
    return nearest, minDist
end

local function cleanAntiHit()
    if hbConnection then 
        hbConnection:Disconnect() 
        hbConnection = nil 
    end
    if cloneChar then 
        cloneChar:Destroy() 
        cloneChar = nil 
    end
    if IsAlive() then
        Camera.CameraSubject = plr.Character.Humanoid
    end
end

local Sawhub= UI:CreateWindow({title="Saw Hub"})


local OffenseSec=Sawhub.Combat:CreateSection({Name="Offense"})
local BowSec=Sawhub.Combat:CreateSection({Name="Bow"})
local DefenseSec=Sawhub.Combat:CreateSection({Name="Defense"})


local MovementSec=Sawhub.Players:CreateSection({Name="Movement"})
local SafetySec=Sawhub.Players:CreateSection({Name="Safety"})


local BlockSec=Sawhub.Items:CreateSection({Name="Block"})
local MiscSec=Sawhub.Items:CreateSection({Name="Misc"})

local EspSec=Sawhub.Visuals:CreateSection({Name="Esp"})


local ConfigSec=Sawhub.Settings:CreateSection({Name="Config"})

print(OffenseSec)
for i,v in pairs(Sawhub.Combat) do
    print(i,v)
end
OffenseSec:CreateToggle({Name="Click No Delay",Default=getgenv().Config.NoClickDelay,Callback=function(v)
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

OffenseSec:CreateToggle({Name="Auto Attack",Default=getgenv().Config.AutoAttack,Callback=function(v)
    getgenv().Config.AutoAttack=v
end})

BowSec:CreateToggle({Name="Auto Bow",Default=getgenv().Config.AutoBow,Callback=function(v)
    getgenv().Config.AutoBow=v
end})

BowSec:CreateSlider({Name="Fov",Min=1,Max=180,Default=getgenv().Config.Fov or 180,Callback=function(v)
    getgenv().Config.Fov=v
end})

BowSec:CreateToggle({Name="Show FOV",Default=getgenv().Config.ShowFOV,Callback=function(v)
    getgenv().Config.ShowFOV=v
end})


local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.NumSides = 11
FOVCircle.Filled = false
FOVCircle.Transparency = 0.5
FOVCircle.Radius = 200
FOVCircle.Color = Color3.fromRGB(255, 0, 0)

RunService.Stepped:Connect(function()
    FOVCircle.Radius = getgenv().Config.Fov
    FOVCircle.Position = UIS:GetMouseLocation()
    FOVCircle.Visible = getgenv().Config.ShowFOV
end)


DefenseSec:CreateToggle({Name="Anti Knockback",Default=getgenv().Config.AntiKnockback,Callback=function(v)
    getgenv().Config.AntiKnockback=v
end})

DefenseSec:CreateToggle({
    Name = "Anti Hit",
    Default = getgenv().Config.AntiHit,
    Callback = function(v)
        getgenv().Config.AntiHit = v
        
        if not v then
            cleanAntiHit()
        else
            task.spawn(function()
                while getgenv().Config.AntiHit do
                    task.wait()
                    
                    if not IsAlive() then
                        cleanAntiHit()
                        continue
                    end

                    local target, dist = GetNearestEntity(AntiHitSettings.Range)
                    
                    if not target then
                        cleanAntiHit()
                        continue
                    end



                    local char = plr.Character
                    local root = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChild("Humanoid")

					if RayCast(root.Position, Vector3.new(0,100,0), {plr.Character,workspace:FindFirstChild("AntiVVV")}) then
						continue
					end

                    if not cloneChar then
                        char.Archivable = true
                        cloneChar = char:Clone()
                        cloneChar.Parent = Workspace
                        Camera.CameraSubject = cloneChar:FindFirstChild("Humanoid") or hum

                        for _, obj in next, cloneChar:GetChildren() do
                            if obj:IsA("Accessory") and obj:FindFirstChild("Handle") then
                                obj.Handle.Transparency = 1
                            elseif obj:IsA("BasePart") then
                                obj.Transparency = obj.Name == "HumanoidRootPart" and AntiHitSettings.Trans or 1
                                if obj.Name == "HumanoidRootPart" then
                                    obj.Material = Enum.Material[AntiHitSettings.Material] or Enum.Material.ForceField
                                    obj.Color = AntiHitSettings.Color
                                elseif obj.Name == "Head" then
                                    obj:ClearAllChildren()
                                end
                            end
                        end

                        local cloneRoot = cloneChar:FindFirstChild("HumanoidRootPart")
                        if cloneRoot then
                            hbConnection = RunService.Heartbeat:Connect(function()
                                if cloneRoot and root then
                                    cloneRoot.Position = Vector3.new(root.Position.X, cloneRoot.Position.Y, root.Position.Z)
                                end
                            end)
                        end
                    end

                    local cloneRoot = cloneChar:FindFirstChild("HumanoidRootPart")

                    if cloneRoot then
                        local h1 = hum.Health
                        local targetHum = target.Character:FindFirstChild("Humanoid")
                        local h2 = targetHum and targetHum.Health or 100
                        
                        local upTime = AntiHitSettings.Up
                        local downTime = AntiHitSettings.Down

                        if AntiHitSettings.Dynamic then
                            local diff = h1 - h2
                            if math.abs(diff) > 5 then
                                if diff > 0 then
                                    downTime = AntiHitSettings.Down + 0.2
                                    upTime = math.max(AntiHitSettings.Up - 0.1, 0.1)
                                else
                                    downTime = math.max(AntiHitSettings.Down - 0.1, 0.1)
                                    upTime = math.max(AntiHitSettings.Up + 0.2, 0.3)
                                end
                            end
							if h1 <= 20 then
								upTime=1.5
							end
                        end

                        root.CFrame += Vector3.new(0, AntiHitSettings.Height, 0)
						root.Velocity = Vector3.new(0, -getgenv().Config.AntiFallSpeed, 0)
                        task.wait(upTime)
                        root.CFrame = cloneRoot.CFrame
                        task.wait(downTime)
                    end
                end
            end)
        end
    end
})


local FlyConfig = {
    Speed = 20,
    VerticalSpeed = 18,
    TPDownInterval = 2,
    HeightOffset = 3.5
}

local flyConnection
local lastGroundReset = os.clock()

local function getMoveDirection()
    local char = plr.Character
    if not char or not char:FindFirstChild("Humanoid") then return Vector3.zero end
    return char.Humanoid.MoveDirection
end
local rayParams = RaycastParams.new()
local function resetFallDistance()
    local char = plr.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end


    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    rayParams.FilterDescendantsInstances = {char,workspace:FindFirstChild("AntiVVV")}

    local ray = workspace:Raycast(root.Position, Vector3.new(0, -500, 0), rayParams)
    if ray then
        local oldCFrame = root.CFrame
        root.CFrame = CFrame.new(ray.Position + Vector3.new(0, 3, 0))
        task.wait(0.1)
        root.CFrame = oldCFrame
    end
end

MovementSec:CreateToggle({Name="Fly",Default=getgenv().Config.Fly,Callback=function(v)
    getgenv().Config.Fly=v
    task.spawn(function()
        if getgenv().Config.Fly then
            lastGroundReset = os.clock()
            
            while wait() and getgenv().Config.Fly do
                local char = plr.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChild("Humanoid")
                
                if not root or not hum then return end

                local moveDir = getMoveDirection()
                local verticalVel = 0

                if UIS:IsKeyDown(Enum.KeyCode.Space) then
                    verticalVel = FlyConfig.VerticalSpeed
                elseif UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                    verticalVel = -FlyConfig.VerticalSpeed
                end

                root.AssemblyLinearVelocity = Vector3.new(
                    moveDir.X * FlyConfig.Speed,
                    verticalVel + 0.85,
                    moveDir.Z * FlyConfig.Speed
                )

                if os.clock() - lastGroundReset >= FlyConfig.TPDownInterval then
                    resetFallDistance()
                    lastGroundReset = os.clock()
                end
            end
       
        end
    end)
end})

MovementSec:CreateSlider({Name="Speed",Min=16,Max=50,Precise=getgenv().Config.Speed or 20,Callback=function(v)
    getgenv().Config.Speed=v
end})

MovementSec:CreateSlider({Name="Jump Height",Min=5,Max=100,Precise=getgenv().Config.JumpHeight or 30,Callback=function(v)
    getgenv().Config.JumpHeight=v
end})

MovementSec:CreateToggle({Name="Boost Speed Jump",Default=getgenv().Config.BoostSpeed,Callback=function(v)
    getgenv().Config.BoostSpeed=v
end})
local RunService = game:GetService("RunService")

local voidConnection
local countdownActive = false
local currentNotify = nil

SafetySec:CreateToggle({
    Name = "Void Notify",
    Default = getgenv().Config.VoidNotify,
    Callback = function(v)
        getgenv().Config.VoidNotify = v
        
        if voidConnection then voidConnection:Disconnect() end
        
        if not v then 
            if currentNotify then 
                currentNotify:Destroy() 
                currentNotify = nil 
            end
            countdownActive = false
            return 
        end

        voidConnection = RunService.Heartbeat:Connect(function()
            local char = plr.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local params = RaycastParams.new()
            params.FilterDescendantsInstances = {char,workspace:FindFirstChild("AntiVVV"),workspace.CurrentCamera}
            params.FilterType = Enum.RaycastFilterType.Exclude
            
            local result = workspace:Raycast(root.Position, Vector3.new(0, -50, 0), params)

            if not result then 
                if not countdownActive then
                    countdownActive = true
                    
                    task.spawn(function()
                        if currentNotify then currentNotify:Destroy() end
                        
                        currentNotify = CreateNotify("Void Time: 2.00s")
                        local timeLeft = 2.0
                        
                        while timeLeft > 0 and countdownActive do
                            timeLeft = timeLeft - 0.05
                            if currentNotify and currentNotify:Check() then
                                currentNotify:Set("Void Time: " .. string.format("%.2f", math.max(0, timeLeft)) .. "s")
                            end
                            task.wait(0.05)
                        end
                        
                        if currentNotify then
                            currentNotify:Destroy()
                            currentNotify = nil
                        end
                        countdownActive = false
                    end)
                end
            else
                if countdownActive then
                    countdownActive = false
                    if currentNotify then
                        currentNotify:Destroy()
                        currentNotify = nil
                    end
                end
            end
        end)
    end
})
SafetySec:CreateToggle({Name="Anti Void",Default=getgenv().Config.AntiVoid,Callback=function(v)
    getgenv().Config.AntiVoid=v
    task.spawn(function()
        if getgenv().Config.AntiVoid then
            local part = Instance.new("Part")
            part.Name="AntiVVV"
            part.Size=Vector3.new(2024,5,2024)
            part.Anchored=true
            part.Position = Vector3.new(plr.Character.HumanoidRootPart.Position.X,plr.Character.HumanoidRootPart.Position.Y-10,plr.Character.HumanoidRootPart.Position.Z)
            part.Parent=workspace
        else
            local part = workspace:FindFirstChild("AntiVVV")
            if part then
                part:Destroy()
            end
        end
    end)
end})

SafetySec:CreateSlider({Name="Anti Fall Speed",Min=10,Max=100,Precise=getgenv().Config.AntiFallSpeed or 70,Callback=function(v)
    getgenv().Config.AntiFallSpeed=v
end})

local rayParams = RaycastParams.new()
local power=0
SafetySec:CreateToggle({Name="Anti Fall",Default=getgenv().Config.AntiFall,Callback=function(v)
    getgenv().Config.AntiFall=v
	task.spawn(function()
		local tracked, extraGravity, velocity = 0, 0, 0
		local antiFall
		antiFall = RunService.PreSimulation:Connect(function(dt)
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

						root.Velocity = Vector3.new(0, -getgenv().Config.AntiFallSpeed, 0)
						

						velocity = velo

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

BlockSec:CreateSlider({Name="Fast Break Cooldown",Precise=getgenv().Config.FastBreakCooldown or 25,Min=0,Max=30,Callback=function(v)
    getgenv().Config.FastBreakCooldown=v
end})

BlockSec:CreateToggle({Name="Fast Break",Default=getgenv().Config.FastBreak,Callback=function(v)
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

local autoblock = BlockSec:CreateToggle({Name="Auto Block",Default=getgenv().Config.AutoBlock,Callback=function(v)
    getgenv().Config.AutoBlock=v
end})

MiscSec:CreateToggle({Name="Auto Collect",Default=getgenv().Config.AutoCollect,Callback=function(v)
    getgenv().Config.AutoCollect=v
end})

EspSec:CreateToggle({Name="Highlight Players",Default=getgenv().Config.HighlightPlayers,Callback=function(v)
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
	Name="Tracker",
	Default=getgenv().Config.Tracker,
	Callback=function(v)
		getgenv().Config.Tracker=v
	end
})

EspSec:CreateToggle({Name="Esp Bee",Default=getgenv().Config.EspBee,Callback=function(v)
    getgenv().Config.EspBee=v
end})

ConfigSec:CreateButton({Name="Save Config",Callback=Save})


UIS.InputBegan:Connect(function(input)
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
    local mousePos = UIS:GetMouseLocation()
    local closestPlr, closestDist = nil, getgenv().Config.Fov

    for _, p in pairs(Players:GetPlayers()) do
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

local GetItemType = function(Item: string, find: boolean, checkitemmeta: string)
    for i,v in GetInventory().items do
        if v and typeof(v) == "table" then
            if v.itemType then
                local metadata = bedwars.ItemMeta[v.itemType]
                if Item and v.itemType == Item or Item and find and tostring(v.itemType):find(Item) then
                    return {Item = v, Meta = metadata}
                else
                    if checkitemmeta then
                        if metadata[checkitemmeta] then
                            return {Item = v, Meta = metadata}
                        end
                    end
                end
            end
        end
    end
    return
end

local GetBestSword = function()
    local inventory = GetInventory()
    local Sword = {Sword = nil, Damage = 0}
    for i,v in inventory.items do
        if bedwars.ItemMeta[v.itemType] and bedwars.ItemMeta[v.itemType].sword then
            local sword = bedwars.ItemMeta[v.itemType].sword
            if sword.damage > Sword.Damage then
                Sword = {Sword = v, Damage = sword.damage}
            end
        end
    end
    return Sword
end

local GroundRay = RaycastParams.new()
GroundRay.FilterType = Enum.RaycastFilterType.Include
GroundRay.FilterDescendantsInstances = {workspace:WaitForChild("Map")}
function firebow(pos2)
    local Pos=plr.Character.HumanoidRootPart.Position
	print(GetTools())
    for i,v in pairs(GetTools()) do

		if plr.Character:FindFirstChild(v.Item.tool.Name) then

			local ProjData = GameData.Modules.ProjMeta[v.Proj]
			local AimPos = Aim(Pos, ProjData.launchVelocity, ProjData.gravitationalAcceleration or 196.2, pos2.Head.Position+Vector3.new(0,1.2,0), pos2.HumanoidRootPart.Velocity, workspace.Gravity,pos2.Humanoid.HipHeight, GroundRay)
			if AimPos ~= 0 then
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
end


-- Cache remote paths (used by AutoCollect, AutoAttack, AutoBlock)
local NetManaged = replicatedStorage.rbxts_include.node_modules["@rbxts"].net.out._NetManaged
local PickupItemDropRemote = NetManaged.PickupItemDrop
local SwordHitRemote = NetManaged.SwordHit

task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Config.BoostSpeed then
            pcall(function()
                plr.Character.Humanoid.WalkSpeed = getgenv().Config.Speed
                plr.Character.Humanoid.JumpPower = getgenv().Config.JumpHeight * 10
                plr.Character.Humanoid.JumpHeight = getgenv().Config.JumpHeight
            end)
        end

        if getgenv().Config.AutoCollect then
            for i,v in pairs(workspace.ItemDrops:GetChildren()) do
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and (v.Position-plr.Character.HumanoidRootPart.Position).Magnitude < 30 then
                    local args = {
                        [1] = {
                            ["itemDrop"] = v
                        }
                    }
                    PickupItemDropRemote:InvokeServer(unpack(args))
                end
            end
        end

        if getgenv().Config.AutoBow then
            if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                local closestPlr = getClosestToMouse()
                if closestPlr then
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

task.spawn(function()
    while task.wait(0.5) do
        if getgenv().Config.HighlightPlayers then
            for _, v in ipairs(Players:GetPlayers()) do
                if v ~= plr and v.Character then
                    local char = v.Character
					
                    local isEnemy = (v.Team ~= plr.Team)
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
            for _, v in ipairs(Players:GetPlayers()) do
                if v.Character and v.Character:FindFirstChild("EspHl") then
                    v.Character.EspHl:Destroy()
                end
            end
        end

        if getgenv().Config.EspBee then
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

        if getgenv().Config.Tracker then
            for _, otherPlayer in ipairs(Players:GetPlayers()) do
                if otherPlayer ~= plr and otherPlayer.TeamColor ~= plr.TeamColor then
                    createBeam(plr, otherPlayer)
                end
            end
        end
    end
end)

local placeBlockRemote = replicatedStorage:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@easy-games"):WaitForChild("block-engine"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("PlaceBlock")

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

-- Merged RenderStepped: AutoAttack + AutoBlock in a single connection
RunService.RenderStepped:Connect(function()
    -- AutoAttack
    if getgenv().Config.AutoAttack then
        for i,v in pairs(Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Team ~= plr.Team and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Name ~= plr.Name then
                local sw=GetBestSword()
                if sw and plr.Character and sw.Sword and plr.Character:FindFirstChild(sw.Sword.tool.Name) and plr.Character:FindFirstChild("HumanoidRootPart") and (v.Character.HumanoidRootPart.Position-plr.Character.HumanoidRootPart.Position).Magnitude < 20 then
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
                                    ["value"] = plr.Character.HumanoidRootPart.Position
                                },
                                ["cursorDirection"] = {
                                    ["value"] = (v.Character.HumanoidRootPart.Position-plr.Character.HumanoidRootPart.Position).unit
                                }
                            },
                            ["selfPosition"] = {
                                ["value"] = plr.Character.HumanoidRootPart.Position
                            }
                        },
                        ["weapon"] = sw.Sword.tool
                    }
                }
                SwordHitRemote:FireServer(unpack(args))
                end
            end
        end
    end

    -- AutoBlock
    if getgenv().Config.AutoBlock then
        local character = plr.Character
        if character and character:FindFirstChild("HumanoidRootPart") and plr.Team then
            local blockType = "wool_" .. string.lower(plr.Team.Name)
            local inventory = game:GetService("ReplicatedStorage").Inventories:FindFirstChild(plr.Name)

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
        end
    end
end)
