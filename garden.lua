repeat wait() until game:IsLoaded()
wait(2)
local VirtualUser = game:GetService('VirtualUser')
VirtualUser:CaptureController()
VirtualUser:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
local SawUI={}
local TS = game:GetService("TweenService")
local plr = game:GetService("Players").LocalPlayer
local Mouse = plr:GetMouse()
local UIS = game:GetService("UserInputService")
local Tweeninfo = TweenInfo.new
local vim = game:service('VirtualInputManager')
local TweenService = game:GetService("TweenService")

function TweenObject(obj, properties, duration, ...)
	game:GetService("TweenService"):Create(obj, Tweeninfo(duration, ...), properties):Play()
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

local ServerTime=0

spawn(function()
	while wait(1) do
		ServerTime+=1
	end
end)

function SawUI:CreateWindow(wintab)
	local UI = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local Bar = Instance.new("Frame")
	local titlemain = Instance.new("TextLabel")
	local Close = Instance.new("ImageButton")
	local UM = Instance.new("UICorner")
	local Line = Instance.new("Frame")
	local LeftPage = Instance.new("ScrollingFrame")
	local ListPage = Instance.new("UIListLayout")
	local PaddingPage = Instance.new("UIPadding")
	local Line_2 = Instance.new("Frame")
	local Pages = Instance.new("Frame")
	local Display = Instance.new("Frame")
	local UIDIs = Instance.new("UICorner")
	local HowToUse = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local Close2 = Instance.new("ImageButton")
	local Line3 = Instance.new("Frame")
	local TextLabel_2 = Instance.new("TextLabel")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local UIStroke2 = Instance.new("UIStroke")
	local UIScale = Instance.new("UIScale")
	local UIScale2 = Instance.new("UIScale")
	local Notify = Instance.new("Frame")
	local NotiList = Instance.new("UIListLayout")
	local NotiPadding = Instance.new("UIPadding")
	local BtnMobile = Instance.new("TextButton")
	local UICorner124 = Instance.new("UICorner")
	local UIStrokeHe = Instance.new("UIStroke")
	UIStrokeHe.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStrokeHe.Color = Theme.Accent
    UIStrokeHe.Thickness = 2
    UIStrokeHe.Transparency = 0.2
    UIStrokeHe.Parent = BtnMobile
    
    BtnMobile.Name = "BtnMobile"
    BtnMobile.Parent = UI
    BtnMobile.BackgroundColor3 = Theme.SecondaryBackground
    BtnMobile.BackgroundTransparency = 0.3
    BtnMobile.BorderSizePixel = 0
    BtnMobile.Position = UDim2.new(0.03, 0, 0.06, 0)
    BtnMobile.Size = UDim2.new(0, 50, 0, 50)
    BtnMobile.AutoButtonColor = false
    BtnMobile.Font = Enum.Font.GothamBold
    BtnMobile.Text = "MENU"
    BtnMobile.TextColor3 = Theme.TextColor
    BtnMobile.TextSize = 14.000

	UICorner124.CornerRadius = UDim.new(1, 0)  -- Make it round
    UICorner124.Parent = BtnMobile

    -- Improved notification system
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
	UIScale.Parent=HowToUse
	UIScale.Scale=0
	UIScale2.Parent=Main

	UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
	UIStroke.Color=Color3.fromRGB(255,255,255)
	UIStroke.Parent=Main

	UIStroke2.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
	UIStroke2.Color=Color3.fromRGB(255,255,255)
	UIStroke2.Parent=HowToUse

	Display.Name = "Display"
	Display.Parent = Main
	Display.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Display.BackgroundTransparency = 0.500
	Display.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Display.BorderSizePixel = 0
	Display.Size = UDim2.new(1, 0, 1, 0)
	Display.ZIndex = 2
	Display.Visible=true
	Display.Transparency=1

	UIDIs.Name = "UIDIs"
	UIDIs.Parent = Display

	HowToUse.Name = "HowToUse"
	HowToUse.Parent = Main
	HowToUse.Visible=true
	HowToUse.AnchorPoint = Vector2.new(0.5, 0.5)
	HowToUse.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	HowToUse.BorderColor3 = Color3.fromRGB(255, 255, 255)
	HowToUse.Position = UDim2.new(0.5, 0, 0.5, 0)
	HowToUse.Size = UDim2.new(0, 300, 0, 200)
	HowToUse.ZIndex = 3
	
	local function set_use(des)
		TextLabel_2.Text=des
		TweenObject(Display,{Transparency=0.5},.2)
		TweenObject(UIScale,{Scale=1},.2)
	end
	
	
	
	TextLabel.Parent = HowToUse
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.0399999991, 0, 0, 0)
	TextLabel.Size = UDim2.new(0, 238, 0, 30)
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.Text = "#HOW TO USE"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 14.000
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	Close2.Name = "Close"
	Close2.Parent = HowToUse
	Close2.BackgroundTransparency = 1.000
	Close2.Position = UDim2.new(0.916999996, -5, 0, 5)
	Close2.Size = UDim2.new(0, 25, 0, 25)
	Close2.AutoButtonColor=false
	Close2.ZIndex = 3
	Close2.Image = "rbxassetid://3926305904"
	Close2.ImageColor3 = Color3.fromRGB(255, 0, 0)
	Close2.ImageRectOffset = Vector2.new(164, 164)
	Close2.ImageRectSize = Vector2.new(36, 36)
	
	Close2.MouseButton1Click:Connect(function()
		TweenObject(Display,{Transparency=1},.2)
		TweenObject(UIScale,{Scale=0},.2)
	end)
	Line3.Name = "Line"
	Line3.Parent = HowToUse
	Line3.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
	Line3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line3.BorderSizePixel = 0
	Line3.Position = UDim2.new(0, 0, 0.185000002, 0)
	Line3.Size = UDim2.new(1, 0, 0, 1)

	TextLabel_2.Parent = HowToUse
	TextLabel_2.AnchorPoint = Vector2.new(0.5, 0)
	TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_2.BackgroundTransparency = 1.000
	TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_2.BorderSizePixel = 0
	TextLabel_2.Position = UDim2.new(0.5, 0, 0.219999999, 0)
	TextLabel_2.Size = UDim2.new(0, 290, 0, 156)
	TextLabel_2.Font = Enum.Font.Gotham
	TextLabel_2.Text = "None"
	TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_2.TextSize = 14.000
	TextLabel_2.TextWrapped = true
	TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_2.TextYAlignment = Enum.TextYAlignment.Top

	UICorner.Parent = HowToUse

	UI.Name = "UI"
	UI.Parent = game:GetService("CoreGui")
	UI.DisplayOrder = 2
	UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Main.Name = "Main"
	Main.Parent = UI
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 500, 0, 350)

	Bar.Name = "Bar"
	Bar.Parent = Main
	Bar.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
	Bar.BackgroundTransparency = 1.000
	Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Bar.BorderSizePixel = 0
	Bar.Size = UDim2.new(0, 500, 0, 40)
	DraggingEnabled(Bar,Main)

	titlemain.Name = "titlemain"
	titlemain.Parent = Bar
	titlemain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	titlemain.BackgroundTransparency = 1.000
	titlemain.BorderColor3 = Color3.fromRGB(0, 0, 0)
	titlemain.BorderSizePixel = 0
	titlemain.Size = UDim2.new(0, 350, 1, 0)
	titlemain.Font = Enum.Font.Gotham
	titlemain.Text = "    "..wintab["title"].." | "..game.Name.." | "..os.date("%d/%m/%Y")
	titlemain.TextColor3 = Color3.fromRGB(255, 255, 255)
	titlemain.TextSize = 12.000
	titlemain.TextXAlignment = Enum.TextXAlignment.Left

	Close.Name = "Close"
	Close.Parent = Bar
	Close.BackgroundTransparency = 1.000
	Close.Position = UDim2.new(0.930000007, 0, 0.174999997, 0)
	Close.Size = UDim2.new(0, 25, 0, 25)
	Close.ZIndex = 2
	Close.Image = "rbxassetid://3926305904"
	Close.ImageRectOffset = Vector2.new(164, 164)
	Close.ImageRectSize = Vector2.new(36, 36)
	
	local opendui=false
	Close.MouseButton1Click:Connect(function()
		TweenObject(UIScale2,{Scale=0},.2)
		opendui=true
	end)

	DraggingEnabled(BtnMobile,BtnMobile)

	BtnMobile.MouseButton1Click:Connect(function()
		opendui=not opendui
		if opendui then
			TweenObject(UIScale2,{Scale=0},.2)
		else
			TweenObject(UIScale2,{Scale=1},.2)
		end
	end)
	

	UIS.InputBegan:Connect(function(i,u)
		if u then return end
		if i.KeyCode==Enum.KeyCode.RightControl then
			opendui=not opendui
			if opendui then
				TweenObject(UIScale2,{Scale=0},.2)
			else
				TweenObject(UIScale2,{Scale=1},.2)
				
			end
		end
	end)

	UM.Name = "UM"
	UM.Parent = Main

	Line.Name = "Line"
	Line.Parent = Main
	Line.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
	Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 0, 0.109999999, 0)
	Line.Size = UDim2.new(0, 500, 0, 1)

	LeftPage.Name = "LeftPage"
	LeftPage.Parent = Main
	LeftPage.Active = true
	LeftPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftPage.BackgroundTransparency = 1.000
	LeftPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LeftPage.BorderSizePixel = 0
	LeftPage.Position = UDim2.new(0, 0, 0, 40)
	LeftPage.Size = UDim2.new(0, 160, 1, -40)
	LeftPage.CanvasSize = UDim2.new(0, 0, 0, 0)
	LeftPage.ScrollBarThickness = 0

	ListPage.Name = "ListPage"
	ListPage.Parent = LeftPage
	ListPage.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ListPage.SortOrder = Enum.SortOrder.LayoutOrder
	ListPage.Padding = UDim.new(0, 5)
	
	ListPage:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		LeftPage.CanvasSize=UDim2.new(0,0,0,ListPage.AbsoluteContentSize.Y+10)
	end)
	
	PaddingPage.Name = "PaddingPage"
	PaddingPage.Parent = LeftPage
	PaddingPage.PaddingTop = UDim.new(0, 7)

	Line_2.Name = "Line"
	Line_2.Parent = Main
	Line_2.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
	Line_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line_2.BorderSizePixel = 0
	Line_2.Position = UDim2.new(0, 160, 0, 40)
	Line_2.Size = UDim2.new(0, 1, 1, -40)

	Pages.Name = "Pages"
	Pages.Parent = Main
	Pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Pages.BackgroundTransparency = 1.000
	Pages.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Pages.BorderSizePixel = 0
	Pages.Position = UDim2.new(0, 160, 0, 40)
	Pages.Size = UDim2.new(1, -160, 1, -40)
	
	local crepage={}
	local listpage={}
	local startpage=false
	
	function crepage:Notify(message, options)
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
	
	function crepage:CreatePage(pagetab)
		local Page = Instance.new("ScrollingFrame")
		local ListTab = Instance.new("UIListLayout")
		local PaddingTab = Instance.new("UIPadding")
		local TabButton = Instance.new("TextButton")

		Page.Name = "Page"
		Page.Parent = Pages
		Page.Active = true
		Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Page.BackgroundTransparency = 1.000
		Page.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Page.BorderSizePixel = 0
		Page.Size = UDim2.new(1, 0, 1, 0)
		Page.Visible=false
		Page.ScrollBarThickness = 6

		ListTab.Name = "ListTab"
		ListTab.Parent = Page
		ListTab.HorizontalAlignment = Enum.HorizontalAlignment.Center
		ListTab.SortOrder = Enum.SortOrder.LayoutOrder
		ListTab.Padding = UDim.new(0, 8)
		ListTab:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Page.CanvasSize=UDim2.new(0,0,0,ListTab.AbsoluteContentSize.Y+15)
		end)
		
		PaddingTab.Name = "PaddingTab"
		PaddingTab.Parent = Page
		PaddingTab.PaddingTop = UDim.new(0, 7)

		TabButton.Name = "TabButton"
		TabButton.Parent = LeftPage
		TabButton.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(1, -14, 0, 30)
		TabButton.AutoButtonColor = false
		TabButton.Font = Enum.Font.Gotham
		TabButton.Text = pagetab["title"]
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.TextSize = 14.000
		
		table.insert(listpage,TabButton)
		
		if not startpage then
			startpage=true
			for i=1,#listpage do
				listpage[i].BackgroundColor3=Color3.fromRGB(56,56,56)
			end
			for i,v in pairs(Pages:GetChildren()) do
				v.Visible=false
			end
			TabButton.BackgroundColor3=Color3.fromRGB(85, 170, 255)
			Page.Visible=true
		end
		
		TabButton.MouseButton1Click:Connect(function()
			for i=1,#listpage do
				listpage[i].BackgroundColor3=Color3.fromRGB(56,56,56)
			end
			for i,v in pairs(Pages:GetChildren()) do
				v.Visible=false
			end
			TabButton.BackgroundColor3=Color3.fromRGB(85, 170, 255)
			Page.Visible=true
		end)
		
		local elems={}

		function elems:CreateSlider(slidertab)
			local Slider = Instance.new("TextButton")
			local USlider = Instance.new("UICorner")
			local title = Instance.new("TextLabel")
			local SliderFrame = Instance.new("Frame")
			local USlider_2 = Instance.new("UICorner")
			local SliderFrame2 = Instance.new("Frame")
			local USlider_3 = Instance.new("UICorner")
			local Box = Instance.new("TextBox")
			local USlider_4 = Instance.new("UICorner")
			local SliderBall = Instance.new("Frame")
			local SliderBallCorner = Instance.new("UICorner")
			local UIStro = Instance.new("UIStroke")
			
			UIStro.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStro.Color = Theme.Accent
			UIStro.Thickness = 1.5
			UIStro.Transparency = 0.5
			UIStro.Parent = Slider
			
			Slider.Name = "Slider"
			Slider.Parent = Page
			Slider.BackgroundColor3 = Theme.ElementBackground
			Slider.BorderSizePixel = 0
			Slider.ClipsDescendants = true
			Slider.Position = UDim2.new(0.029, 0, -0.218, 0)
			Slider.Size = UDim2.new(1, -20, 0, 60)
			Slider.AutoButtonColor = false
			Slider.Font = Enum.Font.Gotham
			Slider.Text = ""
			Slider.TextColor3 = Theme.TextColor
			Slider.TextSize = 18.000
			
			-- Add hover effect
			Slider.MouseEnter:Connect(function()
				TweenObject(Slider, {BackgroundColor3 = Color3.fromRGB(
					Theme.ElementBackground.R * 1.1,
					Theme.ElementBackground.G * 1.1,
					Theme.ElementBackground.B * 1.1
				)}, 0.2)
			end)
			
			Slider.MouseLeave:Connect(function()
				TweenObject(Slider, {BackgroundColor3 = Theme.ElementBackground}, 0.2)
			end)
			
			USlider.CornerRadius = UDim.new(0, 6)
			USlider.Parent = Slider
			
			title.Name = "title"
			title.Parent = Slider
			title.BackgroundTransparency = 1
			title.Position = UDim2.new(0, 10, 0, 0)
			title.Size = UDim2.new(0, 234, 0, 28)
			title.Font = Enum.Font.GothamSemibold
			title.Text = slidertab["title"]
			title.TextColor3 = Theme.TextColor
			title.TextSize = 16
			title.TextXAlignment = Enum.TextXAlignment.Left
			
			SliderFrame.Name = "SliderFrame"
			SliderFrame.Parent = Slider
			SliderFrame.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
			SliderFrame.BorderSizePixel = 0
			SliderFrame.AnchorPoint=Vector2.new(0.5,0)
			SliderFrame.Position = UDim2.new(0.5, 0, 0, 40)
			SliderFrame.Size = UDim2.new(0, 290, 0, 6)  -- Thinner slider track
			
			USlider_2.CornerRadius = UDim.new(0, 3)
			USlider_2.Parent = SliderFrame
			
			SliderFrame2.Name = "SliderFrame2"
			SliderFrame2.Parent = SliderFrame
			SliderFrame2.BackgroundColor3 = Theme.Accent
			SliderFrame2.BorderSizePixel = 0
			SliderFrame2.Size = UDim2.new(0.5, 0, 1, 0)
			
			USlider_3.CornerRadius = UDim.new(0, 3)
			USlider_3.Parent = SliderFrame2
			
			-- Add slider ball for better UX
			SliderBall.Name = "SliderBall"
			SliderBall.Parent = SliderFrame
			SliderBall.AnchorPoint = Vector2.new(0.5, 0.5)
			SliderBall.BackgroundColor3 = Theme.TextColor
			SliderBall.BorderSizePixel = 0
			SliderBall.Position = UDim2.new(0.5, 0, 0.5, 0)
			SliderBall.Size = UDim2.new(0, 16, 0, 16)
			
			SliderBallCorner.CornerRadius = UDim.new(1, 0)
			SliderBallCorner.Parent = SliderBall
			
			-- Add shadow to the ball
			local BallShadow = Instance.new("ImageLabel")
			BallShadow.Name = "BallShadow"
			BallShadow.Parent = SliderBall
			BallShadow.AnchorPoint = Vector2.new(0.5, 0.5)
			BallShadow.BackgroundTransparency = 1
			BallShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
			BallShadow.Size = UDim2.new(1.5, 0, 1.5, 0)
			BallShadow.ZIndex = 0
			BallShadow.Image = "rbxassetid://1316045217"
			BallShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
			BallShadow.ImageTransparency = 0.6
			BallShadow.ScaleType = Enum.ScaleType.Slice
			BallShadow.SliceCenter = Rect.new(10, 10, 118, 118)
			
			Box.Name = "Box"
			Box.Parent = Slider
			Box.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
			Box.BorderSizePixel = 0
			Box.Position = UDim2.new(0.675, 0, 0.1, 0)
			Box.Size = UDim2.new(0, 95, 0, 21)
			Box.ClearTextOnFocus = false
			Box.Font = Enum.Font.Gotham
			Box.Text = ""
			Box.TextColor3 = Theme.TextColor
			Box.TextSize = 14
			Box.TextWrapped = true
			
			USlider_4.CornerRadius = UDim.new(0, 4)
			USlider_4.Parent = Box
		
			local GlobalSliderValue = 0
			local Dragging = false
			
			local function UpdateSliderBall(Position)
				SliderBall.Position = UDim2.new(Position.X.Scale, 0, 0.5, 0)
			end
			
			local function Sliding(Input)
				local Position = UDim2.new(math.clamp((Input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1), 0, 1, 0)
				SliderFrame2.Size = Position
				UpdateSliderBall(Position)
				
				local SliderPrecise = ((Position.X.Scale * slidertab["Max"]) / slidertab["Max"]) * (slidertab["Max"] - slidertab["Min"]) + slidertab["Min"]
				local SliderNonPrecise = math.floor(((Position.X.Scale * slidertab["Max"]) / slidertab["Max"]) * (slidertab["Max"] - slidertab["Min"]) + slidertab["Min"])
				local SliderValue = slidertab["Precise"] and SliderNonPrecise or SliderPrecise
				SliderValue = tonumber(string.format("%.2f", SliderValue))
				
				GlobalSliderValue = SliderValue
				Box.Text = tostring(SliderValue)
				slidertab["callback"](GlobalSliderValue)
			end
			
			local function SetValue(Value)
				Value = math.clamp(Value, slidertab["Min"], slidertab["Max"])
				GlobalSliderValue = Value
				local Position = UDim2.new((Value - slidertab["Min"]) / (slidertab["Max"] - slidertab["Min"]), 0, 1, 0)
				SliderFrame2.Size = Position
				UpdateSliderBall(Position)
				Box.Text = tostring(Value)
				slidertab["callback"](Value)
			end
			
			SetValue(slidertab["Precise"] or slidertab["Min"])
			
			Box.FocusLost:Connect(function()
				if not tonumber(Box.Text) then
					Box.Text = tostring(GlobalSliderValue)
				else
					local Value = tonumber(Box.Text)
					Value = math.clamp(Value, slidertab["Min"], slidertab["Max"])
					SetValue(Value)
				end
			end)
			
			SliderFrame.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Sliding(Input)
					Dragging = true
					
					-- Animate the ball to appear larger when dragging
					TweenObject(SliderBall, {Size = UDim2.new(0, 20, 0, 20)}, 0.2, Enum.EasingStyle.Back)
				end
			end)
			
			SliderFrame.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = false
					
					-- Animate the ball back to normal size
					TweenObject(SliderBall, {Size = UDim2.new(0, 16, 0, 16)}, 0.2, Enum.EasingStyle.Back)
				end
			end)
			
			UIS.InputChanged:Connect(function(Input)
				if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
					Sliding(Input)
				end
			end)
		end
		
		function elems:CreateTextbox(boxtab)
			local Textbox = Instance.new("TextButton")
			local Ubox = Instance.new("UICorner")
			local help_outline = Instance.new("ImageButton")
			local title = Instance.new("TextLabel")
			local Box = Instance.new("TextBox")
			local UBox = Instance.new("UICorner")
			local UIStro=Instance.new("UIStroke")
			
			UIStro.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
			UIStro.Color=Color3.fromRGB(149, 149, 149)
			UIStro.Parent=Textbox
			
			local UIStro2=Instance.new("UIStroke")
			
			UIStro2.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
			UIStro2.Color=Color3.fromRGB(149, 149, 149)
			UIStro2.Parent=Box
			
			Textbox.Name = "Textbox"
			Textbox.Parent = Page
			Textbox.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
			Textbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Textbox.BorderSizePixel = 0
			Textbox.ClipsDescendants = true
			Textbox.Position = UDim2.new(0.0294117648, 0, -0.217821777, 0)
			Textbox.Size = UDim2.new(1, -20, 0, 60)
			Textbox.AutoButtonColor = false
			Textbox.Font = Enum.Font.Gotham
			Textbox.Text = ""
			Textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
			Textbox.TextSize = 18.000
			
			Ubox.Name = "Ubox"
			Ubox.Parent = Textbox
			
			help_outline.Name = "help_outline"
			help_outline.Parent = Textbox
			help_outline.AnchorPoint = Vector2.new(0, 0.5)
			help_outline.BackgroundTransparency = 1.000
			help_outline.Position = UDim2.new(1, -32, 0, 14)
			help_outline.Size = UDim2.new(0, 25, 0, 25)
			help_outline.ZIndex = 2
			help_outline.AutoButtonColor = false
			help_outline.Image = "rbxassetid://3926305904"
			help_outline.ImageRectOffset = Vector2.new(684, 804)
			help_outline.ImageRectSize = Vector2.new(36, 36)
			help_outline.MouseButton1Click:Connect(function()
				set_use(boxtab["des"])
			end)
			title.Name = "title"
			title.Parent = Textbox
			title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title.BackgroundTransparency = 1.000
			title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			title.BorderSizePixel = 0
			title.Position = UDim2.new(0, 10, 0, 0)
			title.Size = UDim2.new(0, 234, 0, 28)
			title.Font = Enum.Font.Gotham
			title.Text = boxtab.title
			title.TextColor3 = Color3.fromRGB(255, 255, 255)
			title.TextSize = 20.000
			title.TextXAlignment = Enum.TextXAlignment.Left
			
			Box.Name = "Box"
			Box.Parent = Textbox
			Box.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
			Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Box.BorderSizePixel = 0
			Box.Position = UDim2.new(0.0309999995, 0, 0, 32)
			Box.Size = UDim2.new(0, 303, 0, 20)
			Box.ClearTextOnFocus = false
			Box.Font = Enum.Font.Gotham
			Box.Text = boxtab.default or ""
			Box.PlaceholderText=boxtab["title"]
			Box.TextColor3 = Color3.fromRGB(255, 255, 255)
			Box.TextSize = 14.000
			Box.TextWrapped = true
			
			UBox.CornerRadius = UDim.new(0, 4)
			UBox.Name = "UBox"
			UBox.Parent = Box

			boxtab.callback(Box.Text)
				
			Box.FocusLost:Connect(function()
				boxtab.callback(Box.Text)
			end)
		end

		function elems:CreateButton(buttontab)
			local TextButton = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local help_outline = Instance.new("ImageButton")
			local UIStroke3 = Instance.new("UIStroke")


			UIStroke3.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
			UIStroke3.Color=Color3.fromRGB(255,255,255)
			UIStroke3.Parent=TextButton
			
			TextButton.Parent = Page
			TextButton.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
			TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextButton.BorderSizePixel = 0
			TextButton.Position = UDim2.new(0.0235294122, 0, 0, 0)
			TextButton.Size = UDim2.new(1, -20, 0, 45)
			TextButton.AutoButtonColor = false
			TextButton.Font = Enum.Font.Gotham
			TextButton.Text = buttontab["title"]
			TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextButton.TextSize = 18.000

			UICorner.Parent = TextButton

			help_outline.Name = "help_outline"
			help_outline.Parent = TextButton
			help_outline.AnchorPoint = Vector2.new(0, 0.5)
			help_outline.BackgroundTransparency = 1.000
			help_outline.Position = UDim2.new(1, -32, 0.5, 0)
			help_outline.Size = UDim2.new(0, 25, 0, 25)
			help_outline.ZIndex = 2
			help_outline.AutoButtonColor = false
			help_outline.Image = "rbxassetid://3926305904"
			help_outline.ImageRectOffset = Vector2.new(684, 804)
			help_outline.ImageRectSize = Vector2.new(36, 36)
			
			TextButton.MouseButton1Click:Connect(function()
				buttontab["callback"]()
			end)
			
			help_outline.MouseButton1Click:Connect(function()
				set_use(buttontab["des"] or "None")
			end)
		end
		
		function elems:CreateToggle(toggletab)
			local Toggle = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local help_outline = Instance.new("ImageButton")
			local title = Instance.new("TextLabel")
			local ToggleFrame = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local Cir = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local UIStroke3 = Instance.new("UIStroke")
		
			-- Enhanced stroke appearance
			UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke3.Color = Theme.Accent
			UIStroke3.Thickness = 1.5
			UIStroke3.Transparency = 0.5
			UIStroke3.Parent = Toggle
			
			Toggle.Name = "Toggle"
			Toggle.Parent = Page
			Toggle.BackgroundColor3 = Theme.ElementBackground
			Toggle.BorderSizePixel = 0
			Toggle.Position = UDim2.new(0.024, 0, 0, 0)
			Toggle.Size = UDim2.new(1, -20, 0, 45)
			Toggle.AutoButtonColor = false
			Toggle.Font = Enum.Font.Gotham
			Toggle.Text = ""
			Toggle.TextColor3 = Theme.TextColor
			Toggle.TextSize = 18.000
			
			-- Add subtle hover effect
			Toggle.MouseEnter:Connect(function()
				TweenObject(Toggle, {BackgroundColor3 = Color3.fromRGB(
					Theme.ElementBackground.R * 1.1,
					Theme.ElementBackground.G * 1.1,
					Theme.ElementBackground.B * 1.1
				)}, 0.2)
			end)
			
			Toggle.MouseLeave:Connect(function()
				TweenObject(Toggle, {BackgroundColor3 = Theme.ElementBackground}, 0.2)
			end)
		
			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = Toggle
		
			help_outline.Name = "help_outline"
			help_outline.Parent = Toggle
			help_outline.AnchorPoint = Vector2.new(0, 0.5)
			help_outline.BackgroundTransparency = 1
			help_outline.Position = UDim2.new(0, 10, 0.5, 0)
			help_outline.Size = UDim2.new(0, 25, 0, 25)
			help_outline.ZIndex = 2
			help_outline.AutoButtonColor = false
			help_outline.Image = "rbxassetid://3926305904"
			help_outline.ImageRectOffset = Vector2.new(684, 804)
			help_outline.ImageRectSize = Vector2.new(36, 36)
			help_outline.ImageColor3 = Theme.Accent  -- Changed to accent color
			
			title.Name = "title"
			title.Parent = Toggle
			title.BackgroundTransparency = 1
			title.Position = UDim2.new(0, 45, 0, 0)
			title.Size = UDim2.new(0, 200, 0, 45)
			title.Font = Enum.Font.GothamSemibold
			title.Text = toggletab["title"]
			title.TextColor3 = Theme.TextColor
			title.TextSize = 16
			title.TextXAlignment = Enum.TextXAlignment.Left
		
			-- Modern toggle switch design
			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.Parent = Toggle
			ToggleFrame.AnchorPoint = Vector2.new(0, 0.5)
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
			ToggleFrame.BorderSizePixel = 0
			ToggleFrame.Position = UDim2.new(0.78, 0, 0.5, 0)
			ToggleFrame.Size = UDim2.new(0, 60, 0, 25)
		
			UICorner_2.CornerRadius = UDim.new(0, 16)
			UICorner_2.Parent = ToggleFrame
		
			Cir.Name = "Cir"
			Cir.Parent = ToggleFrame
			Cir.AnchorPoint = Vector2.new(0, 0.5)
			Cir.BackgroundColor3 = Theme.TextColor
			Cir.BorderSizePixel = 0
			Cir.Position = UDim2.new(0, 4, 0.5, 0)
			Cir.Size = UDim2.new(0, 19, 0, 19)
			
			-- Add shadow to the circle for depth
			local CircleShadow = Instance.new("ImageLabel")
			CircleShadow.Name = "CircleShadow"
			CircleShadow.Parent = Cir
			CircleShadow.AnchorPoint = Vector2.new(0.5, 0.5)
			CircleShadow.BackgroundTransparency = 1
			CircleShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
			CircleShadow.Size = UDim2.new(1.5, 0, 1.5, 0)
			CircleShadow.ZIndex = 0
			CircleShadow.Image = "rbxassetid://1316045217"
			CircleShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
			CircleShadow.ImageTransparency = 0.6
			CircleShadow.ScaleType = Enum.ScaleType.Slice
			CircleShadow.SliceCenter = Rect.new(10, 10, 118, 118)
		
			UICorner_3.CornerRadius = UDim.new(1, 0)
			UICorner_3.Parent = Cir
			
			local toggled = false
		
			local togglecall = {}
			function togglecall:Set(val)
				toggled = val
				toggletab.callback(toggled)
				if toggled then
					-- Enhanced animation for toggle
					TweenObject(ToggleFrame, {BackgroundColor3 = Theme.Accent}, 0.2)
					TweenObject(Cir, {Position = UDim2.new(1, -23, 0.5, 0)}, 0.2, Enum.EasingStyle.Back)
					TweenObject(Cir, {BackgroundColor3 = Theme.TextColor}, 0.2)
				else
					TweenObject(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(61, 61, 61)}, 0.2)
					TweenObject(Cir, {Position = UDim2.new(0, 4, 0.5, 0)}, 0.2, Enum.EasingStyle.Back)
					TweenObject(Cir, {BackgroundColor3 = Theme.TextColor}, 0.2)
				end
			end
			
			togglecall:Set(toggletab.default or false)
		
			Toggle.MouseButton1Click:Connect(function()
				toggled = not toggled
				togglecall:Set(toggled)
			end)
			
			help_outline.MouseButton1Click:Connect(function()
				set_use(toggletab["des"] or "None")
			end)
			
			return togglecall
		end
		function elems:CreateDropdown(droptab)
			local Dropdown = Instance.new("TextButton")
			local UDrop = Instance.new("UICorner")
			local help_outline = Instance.new("ImageButton")
			local title = Instance.new("TextLabel")
			local OpendDrop = Instance.new("TextButton")
			local UICorner = Instance.new("UICorner")
			local Items = Instance.new("ScrollingFrame")
			local ListItem = Instance.new("UIListLayout")
			local PaddingItem = Instance.new("UIPadding")
			local UIStroke3 = Instance.new("UIStroke")


			UIStroke3.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
			UIStroke3.Color=Color3.fromRGB(255,255,255)
			UIStroke3.Parent=Dropdown
			Dropdown.Name = "Dropdown"
			Dropdown.Parent = Page
			Dropdown.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
			Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.ClipsDescendants = true
			Dropdown.Position = UDim2.new(0.0294117648, 0, -0.217821777, 0)
			Dropdown.Size = UDim2.new(1, -20, 0, 60)
			Dropdown.AutoButtonColor = false
			Dropdown.Font = Enum.Font.Gotham
			Dropdown.Text = ""

			Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
			Dropdown.TextSize = 18.000

			UDrop.Name = "UDrop"
			UDrop.Parent = Dropdown

			help_outline.Name = "help_outline"
			help_outline.Parent = Dropdown
			help_outline.AnchorPoint = Vector2.new(0, 0.5)
			help_outline.BackgroundTransparency = 1.000
			help_outline.Position = UDim2.new(1, -32, 0, 14)
			help_outline.Size = UDim2.new(0, 25, 0, 25)
			help_outline.ZIndex = 2
			help_outline.AutoButtonColor = false
			help_outline.Image = "rbxassetid://3926305904"
			help_outline.ImageRectOffset = Vector2.new(684, 804)
			help_outline.ImageRectSize = Vector2.new(36, 36)
			help_outline.MouseButton1Click:Connect(function()
				set_use(droptab["des"] or "None")
			end)
			title.Name = "title"
			title.Parent = Dropdown
			title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title.BackgroundTransparency = 1.000
			title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			title.BorderSizePixel = 0
			title.Position = UDim2.new(0, 10, 0, 0)
			title.Size = UDim2.new(0, 234, 0, 28)
			title.Font = Enum.Font.Gotham
			title.Text = droptab["title"]
			title.TextColor3 = Color3.fromRGB(255, 255, 255)
			title.TextSize = 20.000
			title.TextXAlignment = Enum.TextXAlignment.Left

			OpendDrop.Name = "OpendDrop"
			OpendDrop.Parent = Dropdown
			OpendDrop.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
			OpendDrop.BorderColor3 = Color3.fromRGB(0, 0, 0)
			OpendDrop.BorderSizePixel = 0
			OpendDrop.Position = UDim2.new(0.0250000004, 0, 0, 31)
			OpendDrop.Size = UDim2.new(0, 303, 0, 22)
			OpendDrop.AutoButtonColor = false
			OpendDrop.Font = Enum.Font.Gotham
			OpendDrop.Text = "  "..droptab["title"]
			OpendDrop.TextTruncate=Enum.TextTruncate.AtEnd
			OpendDrop.TextColor3 = Color3.fromRGB(255, 255, 255)
			OpendDrop.TextSize = 14.000
			OpendDrop.TextXAlignment = Enum.TextXAlignment.Left

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = OpendDrop

			Items.Name = "Items"
			Items.Parent = Dropdown
			Items.Active = true
			Items.AnchorPoint = Vector2.new(0.5, 0)
			Items.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
			Items.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Items.BorderSizePixel = 0
			Items.Position = UDim2.new(0.5, 0, 0, 65)
			Items.Size = UDim2.new(0, 302, 0, 179)

			ListItem.Name = "ListItem"
			ListItem.Parent = Items
			ListItem.HorizontalAlignment = Enum.HorizontalAlignment.Center
			ListItem.SortOrder = Enum.SortOrder.LayoutOrder
			ListItem.Padding = UDim.new(0, 5)
			
			ListItem:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Items.CanvasSize=UDim2.new(0,0,0,ListItem.AbsoluteContentSize.Y+10)
			end)
			
			PaddingItem.Name = "PaddingItem"
			PaddingItem.Parent = Items
			PaddingItem.PaddingTop = UDim.new(0, 5)
			
			local opend = false
			OpendDrop.MouseButton1Click:Connect(function()
				if not opend then
					TweenObject(Dropdown, {Size = UDim2.new(1, -20, 0, 250)}, 0.1)

					opend = true
				else
					TweenObject(Dropdown, {Size = UDim2.new(1, -20, 0, 60)}, 0.1)

					opend = false
				end
			end)


			local dropcall = {}
			local list = {}
			local count = 0
			local itemchoose
			local selected_items = {}

			local function add_button(itemname)
				local selectdrop = Instance.new("TextButton")


				selectdrop.Parent = Items
				selectdrop.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
				selectdrop.BorderColor3 = Color3.fromRGB(0, 0, 0)
				selectdrop.BorderSizePixel = 0
				selectdrop.Size = UDim2.new(1, -10, 0, 25)
				selectdrop.Font = Enum.Font.Gotham
				selectdrop.AutoButtonColor=false
				selectdrop.Text = itemname
				selectdrop.TextColor3 = Color3.fromRGB(255, 255, 255)
				selectdrop.TextSize = 14.000

				list[itemname] = selectdrop

				selectdrop.MouseButton1Click:Connect(function()
					dropcall:Set(itemname)
				end)
			end

			function dropcall:Add(item)
				add_button(item)
				count += 1
			end

			function dropcall:Set(item)
				if count > 0 then
					if droptab.multi then
						if list[item] then
						-- MULTI SELECT
							if selected_items[item] then
								selected_items[item] = nil
								list[item].BackgroundColor3=Color3.fromRGB(38, 38, 38)
							else
								selected_items[item] = true
								list[item].BackgroundColor3=Color3.fromRGB(0, 135, 203)
							end

							local selected_list = {}
							for name, _ in pairs(selected_items) do
								table.insert(selected_list, name)
							end
							
							if #selected_list>0 then
								OpendDrop.Text="  "..table.concat(selected_list,",")

							else
								OpendDrop.Text="  "..droptab["title"]
							end
							
							droptab.callback(selected_list)
						end
					else
						itemchoose = item
						for i, v in pairs(Items:GetChildren()) do
							if v:IsA("TextButton") then
								v.BackgroundColor3=Color3.fromRGB(38, 38, 38)
							end
						end
						OpendDrop.Text="  "..itemchoose
						list[item].BackgroundColor3=Color3.fromRGB(0, 135, 203)
						droptab.callback(itemchoose)
					end
				end
			end

			function dropcall:New(items)
				count = 0
				selected_items = {}
				table.clear(list)
				for i, v in pairs(Items:GetChildren()) do
					if v:IsA("TextButton") then
						v:Destroy()
					end
				end
				for _, v in pairs(items) do
					add_button(v)
					count += 1
				end
			end

			if droptab.list then
				dropcall:New(droptab.list)
			end

			if droptab.default then
				if droptab.multi then
					if typeof(droptab.default) == "table" then
						for _, v in pairs(droptab.default) do
							dropcall:Set(v)
						end
					else
						dropcall:Set(droptab.default)
					end
				else
					dropcall:Set(droptab.default[1])
				end
			end

			return dropcall
		end

        function elems:CreateSection(sectitle)
            local SectionTitle = Instance.new("TextLabel")

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Page
            SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.BackgroundTransparency = 1.000
            SectionTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionTitle.BorderSizePixel = 0
            SectionTitle.Size = UDim2.new(1, -20, 0, 30)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = sectitle["title"]
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 18.000
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        end
		return elems
	end
	return crepage
end
if not getgenv().Configs then
    getgenv().Configs={}
end


local plr = game.Players.LocalPlayer
function Get_Farm()
    for i,v in pairs(workspace.Farm:GetChildren()) do
        if v.Important.Data.Owner.Value == game.Players.LocalPlayer.Name then
            return v
        end
    end
end

local MyFarm=Get_Farm()

local allseeds={}
for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Seed_Shop.Frame.ScrollingFrame:GetChildren()) do
    if v:IsA("Frame") and not string.find(v.Name,"Padding") then
		table.insert(allseeds,v.Name)
        if v.Main_Frame.Cost_Text.Text ~="NO STOCK" then
            print(v.Main_Frame.Seed_Text.Text,v.Main_Frame.Stock_Text.Text)
        end
    end
end


function Get_Fruit()
    local fruit={}
    for i,v in pairs(MyFarm.Important.Plants_Physical:GetDescendants()) do
        if v.Name=="ProximityPrompt" then
            table.insert(fruit,v)
            -- print(v.Parent.Parent:GetAttribute("Moonlit"))
        end
    end
    return fruit
end

function Collect_Moonlit()
    local fruits=Get_Fruit()
    for i,v in pairs(fruits) do
        if v.Parent.Parent:GetAttribute("Moonlit") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=v.Parent.CFrame
            fireproximityprompt(v, 1, true)
            task.wait()
        end
    end
end

function UnLock_Moonlit()
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.BackpackGui.Backpack.Inventory.ScrollingFrame.UIGridFrame:GetChildren()) do
        if v.Name ~="UIGridLayout" and v:FindFirstChild("ToolName") and string.find(v.ToolName.Text,"Moonlit") and v.FavIcon.Visible==true then
            for i,v in pairs(getconnections(v.MouseButton2Click)) do
                v.Function()
            end
        end
    end
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.BackpackGui.Backpack.Hotbar:GetChildren()) do
        if v.Name ~="UIGridLayout" and v:FindFirstChild("ToolName") and string.find(v.ToolName.Text,"Moonlit") and v.FavIcon.Visible==true then
            for i,v in pairs(getconnections(v.MouseButton2Click)) do
                v.Function()
            end
        end
    end
end 

function Lock_Moonlit()
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.BackpackGui.Backpack.Inventory.ScrollingFrame.UIGridFrame:GetChildren()) do
        if v.Name ~="UIGridLayout" and v:FindFirstChild("ToolName") and string.find(v.ToolName.Text,"Moonlit") and v.FavIcon.Visible==false then
            for i,v in pairs(getconnections(v.MouseButton2Click)) do
                v.Function()
            end
        end
    end
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.BackpackGui.Backpack.Hotbar:GetChildren()) do
        if v.Name ~="UIGridLayout" and v:FindFirstChild("ToolName") and string.find(v.ToolName.Text,"Moonlit") and v.FavIcon.Visible==false then
            for i,v in pairs(getconnections(v.MouseButton2Click)) do
                v.Function()
            end
        end
    end
end 

function check_str_and(v,v2)
    for i,k in pairs(v2) do
        if v==v2 or string.find(v,k) or string.find(k,v) then
            return true
        end
    end
    return false
end
function Get_Seed()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if string.find(v.Name,"Seed") and check_str_and(v.Name,getgenv().Configs.SeedPut) then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
            local clean=v.Name:gsub(" Seed", ""):gsub(" %[%w+%]", "")
            repeat wait()
                for k,kuku in pairs(MyFarm.Important.Plant_Locations:GetChildren()) do
                    if not v or not getgenv().Configs.AutoPuts or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) then
                        break
                    end
                    local cf=kuku.CFrame
                    local sizex,sizez=kuku.Size.X,kuku.Size.Z
                    local fx=math.round(sizex/2)
                    local fz=math.round(sizez/2)
                    for z=-fz,fz do    
                        for x=-fx,fx do
                            if v.Parent==game:GetService("Players").LocalPlayer.Backpack then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                            end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(cf.X+x,5,cf.Z+z)
                            local args = {
                                [1] = Vector3.new(cf.X+x,cf.Y,cf.Z+z),
                                [2] = clean
                            }

                            game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Plant_RE"):FireServer(unpack(args))
                            if not v or not getgenv().Configs.AutoPuts or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) then
                                break
                            end
                            wait()
                        end
                        if not v or not getgenv().Configs.AutoPuts or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) then
                            break
                        end
                    end
                end
            until not v or not getgenv().Configs.AutoPuts or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) 
        end
    end
    for k,kuku in pairs(MyFarm.Important.Plant_Locations:GetChildren()) do
        if not v or not getgenv().Configs.AutoPuts or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) then
            break
        end
        local cf=kuku.CFrame
        local sizex,sizez=kuku.Size.X,kuku.Size.Z
        local fx=math.round(sizex/2)
        local fz=math.round(sizez/2)
        for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if string.find(v.Name,"Seed") then
                local clean=v.Name:gsub(" Seed", ""):gsub(" %[%w+%]", "")
                repeat wait()
                    for z=-fz,fz do    
                        for x=-fx,fx do
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(cf.X+x,5,cf.Z+z)
                            local args = {
                                [1] = Vector3.new(cf.X+x,cf.Y,cf.Z+z),
                                [2] = clean
                            }

                            game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Plant_RE"):FireServer(unpack(args))
                            if not v or not getgenv().Configs.AutoPuts or v.Parent ~= game:GetService("Players").LocalPlayer.Character then
                                break
                            end
                            wait()
                        end
                        if not v or not getgenv().Configs.AutoPuts or v.Parent ~= game:GetService("Players").LocalPlayer.Character then
                            break
                        end
                    end
                until not v or not getgenv().Configs.AutoPuts or v.Parent ~= game:GetService("Players").LocalPlayer.Character
            end
        end
    end
end

function Place_NightStaff()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v.Name=="Night Staff" then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
            repeat wait()
                for k,kuku in pairs(MyFarm.Important.Plant_Locations:GetChildren()) do
                    if not v or not getgenv().Configs.AutoPlaceNightStaff or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) then
                        break
                    end
                    local cf=kuku.CFrame
                    local sizex,sizez=kuku.Size.X,kuku.Size.Z
                    local fx=math.round(sizex/2)
                    local fz=math.round(sizez/2)
                    for z=-fz,fz do    
                        for x=-fx,fx do
                            if v.Parent==game:GetService("Players").LocalPlayer.Backpack then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                            end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(cf.X-x,5,cf.Z-z)
                            wait()
							local args = {
								[1] = "Create",
								[2] = CFrame.new(cf.X-x,5,cf.Z-z)
							}
							
							game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("NightStaffRemoteEvent"):FireServer(unpack(args))							
                            if not v or not getgenv().Configs.AutoPlaceNightStaff or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) then
                                break
                            end
                            wait()
                        end
                        if not v or not getgenv().Configs.AutoPlaceNightStaff or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) then
                            break
                        end
                    end
                end
            until not v or not getgenv().Configs.AutoPlaceNightStaff or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) 
        end
    end
    for k,kuku in pairs(MyFarm.Important.Plant_Locations:GetChildren()) do
        if not v or not getgenv().Configs.AutoPlaceNightStaff or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) then
            break
        end
        local cf=kuku.CFrame
        local sizex,sizez=kuku.Size.X,kuku.Size.Z
        local fx=math.round(sizex/2)
        local fz=math.round(sizez/2)
        for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if v.Name=="Night Staff" then
                repeat wait()
                    for z=-fz,fz do    
                        for x=-fx,fx do
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(cf.X-x,5,cf.Z-z)
                            wait()
							local args = {
								[1] = "Create",
								[2] = CFrame.new(cf.X-x,5,cf.Z-z)
							}
							
							game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("NightStaffRemoteEvent"):FireServer(unpack(args))							
                            if not v or not getgenv().Configs.AutoPlaceNightStaff or v.Parent ~= game:GetService("Players").LocalPlayer.Character then
                                break
                            end
                            wait()
                        end
                        if not v or not getgenv().Configs.AutoPlaceNightStaff or v.Parent ~= game:GetService("Players").LocalPlayer.Character then
                            break
                        end
                    end
                until not v or not getgenv().Configs.AutoPlaceNightStaff or v.Parent ~= game:GetService("Players").LocalPlayer.Character
            end
        end
    end
end

function Auto_Egg()
	if #MyFarm.Important.Objects_Physical:GetChildren() < 3 then
		for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
			if string.find(v.Name,"Egg") then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
				repeat wait()
					for k,kuku in pairs(MyFarm.Important.Plant_Locations:GetChildren()) do
						if not v or MyFarm.Important.Objects_Physical:GetChildren() >= 3 or not getgenv().Configs.AutoEgg or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) then
							break
						end
						local cf=kuku.CFrame
						local sizex,sizez=kuku.Size.X,kuku.Size.Z
						local fx=math.round(sizex/2)
						local fz=math.round(sizez/2)
						for z=-fz,fz do    
							for x=-fx,fx do
								if v.Parent==game:GetService("Players").LocalPlayer.Backpack then
									game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(cf.X-x,5,cf.Z-z)
								wait()
								local args = {
									[1] = "CreateEgg",
									[2] = Vector3.new(cf.X-x,cf.Y,cf.Z-z)
								}
								
								game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetEggService"):FireServer(unpack(args))
								
								if not v or MyFarm.Important.Objects_Physical:GetChildren() >= 3 or not getgenv().Configs.AutoEgg or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) then
									break
								end
								wait()
							end
							if not v or MyFarm.Important.Objects_Physical:GetChildren() >= 3 or not getgenv().Configs.AutoEgg or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) then
								break
							end
						end
					end
				until not v or MyFarm.Important.Objects_Physical:GetChildren() >= 3 or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) or not getgenv().Configs.AutoEgg 
			end
		end
		for k,kuku in pairs(MyFarm.Important.Plant_Locations:GetChildren()) do
			if not v or MyFarm.Important.Objects_Physical:GetChildren() >= 3 or not getgenv().Configs.AutoEgg or (v.Parent ~= game:GetService("Players").LocalPlayer.Character and v.Parent~=game:GetService("Players").LocalPlayer.Backpack) then
				break
			end
			local cf=kuku.CFrame
			local sizex,sizez=kuku.Size.X,kuku.Size.Z
			local fx=math.round(sizex/2)
			local fz=math.round(sizez/2)
			for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
				if string.find(v.Name,"Egg") then

					repeat wait()
						for z=-fz,fz do    
							for x=-fx,fx do
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(cf.X-x,5,cf.Z-z)
								wait()
								local args = {
									[1] = "CreateEgg",
									[2] = Vector3.new(cf.X-x,cf.Y,cf.Z-z)
								}
								
								game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetEggService"):FireServer(unpack(args))
								
								if not v or MyFarm.Important.Objects_Physical:GetChildren() >= 3  or not getgenv().Configs.AutoEgg or v.Parent ~= game:GetService("Players").LocalPlayer.Character then
									break
								end
								wait()
							end
							if not v or MyFarm.Important.Objects_Physical:GetChildren() >= 3 or not getgenv().Configs.AutoEgg or v.Parent ~= game:GetService("Players").LocalPlayer.Character then
								break
							end
						end
					until not v or MyFarm.Important.Objects_Physical:GetChildren() >= 3 or v.Parent ~= game:GetService("Players").LocalPlayer.Character or not getgenv().Configs.AutoEgg
				end
			end
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

local Sawhub= SawUI:CreateWindow({title="Saw Hub"})
local HomeTab=Sawhub:CreatePage({title="Home"})
HomeTab:CreateSection({title="Settings"})
HomeTab:CreateSlider({title="Time Sell (s)",Min=60,Max=1800,Precise=getgenv().Configs.TimeSell or 600,callback=function(v)
	getgenv().Configs.TimeSell=v
end})
HomeTab:CreateSlider({title="Time Collect (s)",Min=1800,Max=3600,Precise=getgenv().Configs.TimeCollect or 1800,callback=function(v)
	getgenv().Configs.TimeCollect=v
end})
HomeTab:CreateSlider({title="Backpack Sell (Item)",Min=1,Max=199,Precise=getgenv().Configs.BackpackSell or 199,callback=function(v)
	getgenv().Configs.BackpackSell=v
end})

HomeTab:CreateToggle({title="Auto Lock Moonlit",default=getgenv().Configs.AutoLockMoonlit,callback=function(v)
    getgenv().Configs.AutoLockMoonlit= v
end})

HomeTab:CreateToggle({title="Auto Feed Moonlit",default=getgenv().Configs.AutoFeedMoonlit,callback=function(v)
    getgenv().Configs.AutoFeedMoonlit= v
end})
HomeTab:CreateButton({title="Unlock Moonlit",callback=UnLock_Moonlit})
HomeTab:CreateButton({title="Lock Moonlit",callback=Lock_Moonlit})

HomeTab:CreateSection({title="Automatic"})
HomeTab:CreateDropdown({title="Anti Collect (Moonlit)",list=allseeds,default=getgenv().Configs.Anticollect,multi=true,callback=function(v)
	getgenv().Configs.Anticollect=v
end})
local tick_out=tick()
local tick_moonsell=tick()
local tick_sell=tick()
HomeTab:CreateToggle({title="Auto Collect",default=getgenv().Configs.AutoCollect,callback=function(v)
    getgenv().Configs.AutoCollect= v
    spawn(function()
        while getgenv().Configs.AutoCollect and wait() do
            local fruits=Get_Fruit()
            for i,v in pairs(fruits) do
                if v and v.Parent and v.Parent.Parent:GetAttribute("Moonlit") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=v.Parent.CFrame
                    wait(0.05)
                    fireproximityprompt(v, 1, true)
                    wait()
                end
            end

			if tick()-tick_moonsell>=300 and getgenv().Configs.AutoFeedMoonlit then
				UnLock_Moonlit()
				wait(1)
				local args = {
					[1] = "SubmitAllPlants"
				}
				game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("NightQuestRemoteEvent"):FireServer(unpack(args))			
			end
	
			if getgenv().Configs.AutoLockMoonlit then
				wait(1)
				Lock_Moonlit()
			end
            if tick()-tick_out >= getgenv().Configs.TimeCollect then
                local fruits=Get_Fruit()
                for i,v in pairs(fruits) do
                    if v and v.Parent and (not check_str_and(v.Parent.Parent.Name,getgenv().Configs.Anticollect) or v.Parent.Parent:GetAttribute("Moonlit")) then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=v.Parent.CFrame
                        wait(0.05)
                        fireproximityprompt(v, 1, true)
                        wait()
						if #game.Players.LocalPlayer.Backpack:GetChildren() >= getgenv().Configs.BackpackSell or tick()-tick_sell >= getgenv().Configs.TimeSell then
							if tick()-tick_moonsell>=300 and getgenv().Configs.AutoFeedMoonlit then
								UnLock_Moonlit()
								wait(1)
								local args = {
									[1] = "SubmitAllPlants"
								}
								game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("NightQuestRemoteEvent"):FireServer(unpack(args))			
							end
							wait(0.1)
							if getgenv().Configs.AutoLockMoonlit then
								wait(1)
								Lock_Moonlit()
							end
							tick_sell=tick()
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(61.5817299, 2.99999976, 0.426786184, -0.000244111798, 4.3232312e-08, -1, 1.65697653e-12, 1, 4.3232312e-08, 1, 8.89654062e-12, -0.000244111798)
							wait(1)
							game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
							wait(5)
						end
                    end
                end
                tick_out=tick()
            end
			if tick()-tick_moonsell>=300 and getgenv().Configs.AutoFeedMoonlit then
				UnLock_Moonlit()
				wait(1)
				local args = {
					[1] = "SubmitAllPlants"
				}
				game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("NightQuestRemoteEvent"):FireServer(unpack(args))			
				tick_moonsell=tick()
			end
			if getgenv().Configs.AutoLockMoonlit then
				wait(1)
				Lock_Moonlit()
				wait(1)
				Lock_Moonlit()
			end
            if #game.Players.LocalPlayer.Backpack:GetChildren() >= getgenv().Configs.BackpackSell  or tick()-tick_sell >= getgenv().Configs.TimeSell then
                tick_sell=tick()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(61.5817299, 2.99999976, 0.426786184, -0.000244111798, 4.3232312e-08, -1, 1.65697653e-12, 1, 4.3232312e-08, 1, 8.89654062e-12, -0.000244111798)
                wait(1)
                game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
                wait(5)
            end
        end
    end)
end})

HomeTab:CreateDropdown({title="Seeds Put",list=allseeds,default=getgenv().Configs.SeedPut,multi=true,callback=function(v)
	getgenv().Configs.SeedPut=v
end})

HomeTab:CreateToggle({title="Auto Put Seeds",default=getgenv().Configs.AutoPuts,callback=function(v)
    getgenv().Configs.AutoPuts=v    
    spawn(function()
        while wait() and getgenv().Configs.AutoPuts do
            Get_Seed()
        end
    end)
end})

HomeTab:CreateToggle({title="Auto Night Staff",default=getgenv().Configs.AutoPlaceNightStaff,callback=function(v)
    getgenv().Configs.AutoPlaceNightStaff=v    
    spawn(function()
        while wait() and getgenv().Configs.AutoPlaceNightStaff do
            Place_NightStaff()
        end
    end)
end})

local PetsTab=Sawhub:CreatePage({title="Pets"})
PetsTab:CreateSection({title="Egg"})
PetsTab:CreateToggle({title="Auto Egg",default=getgenv().Configs.AutoEgg,callback=function(v)
    getgenv().Configs.AutoEgg=v    
    spawn(function()
        while wait() and getgenv().Configs.AutoEgg do
            Auto_Egg()
			HatchEgg()
        end
    end)
end})
PetsTab:CreateSection({title="Pets"})

PetsTab:CreateDropdown({title="Fruit Feed",list=allseeds,default=getgenv().Configs.FruitFeed,multi=true,callback=function(v)
	getgenv().Configs.FruitFeed=v
end})
PetsTab:CreateToggle({title="Auto Collect Feed",default=getgenv().Configs.AutoCollectFast,callback=function(v)
    getgenv().Configs.AutoCollectFast= v
    spawn(function()
        while getgenv().Configs.AutoCollectFast and wait() do
            local fruits=Get_Fruit()
            for i,v in pairs(fruits) do
                if v and v.Parent and check_str_and(v.Parent.Parent.Name,getgenv().Configs.FruitFeed) and not v.Parent.Parent:GetAttribute("Moonlit") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=v.Parent.CFrame
                    wait(0.05)
                    fireproximityprompt(v, 1, true)
                    wait()
					if #game.Players.LocalPlayer.Backpack:GetChildren() >= getgenv().Configs.BackpackSell or tick()-tick_sell >= getgenv().Configs.TimeSell then
						if tick()-tick_moonsell>=300 and getgenv().Configs.AutoFeedMoonlit then
							UnLock_Moonlit()
							wait(1)
							local args = {
								[1] = "SubmitAllPlants"
							}
							game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("NightQuestRemoteEvent"):FireServer(unpack(args))			
						end
						wait(0.1)
						if getgenv().Configs.AutoLockMoonlit then
							wait(1)
							Lock_Moonlit()
						end
						tick_sell=tick()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(61.5817299, 2.99999976, 0.426786184, -0.000244111798, 4.3232312e-08, -1, 1.65697653e-12, 1, 4.3232312e-08, 1, 8.89654062e-12, -0.000244111798)
						wait(1)
						game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
						wait(5)
					end
                end
            end
			if getgenv().Configs.AutoLockMoonlit then
				wait(1)
				Lock_Moonlit()
			end
        end
    end)
end})
PetsTab:CreateToggle({title="Auto Feed",default=getgenv().Configs.AutoFeed,callback=function(v)
    getgenv().Configs.AutoFeed=v    
    spawn(function()
        while wait() and getgenv().Configs.AutoFeed do
            for i,pet in pairs(workspace.PetsPhysical:GetChildren()) do
				if pet:GetAttribute("OWNER")==plr.Name then
					local eat_val=false
					repeat wait(1)
						for _,fruit in pairs(plr.Backpack:GetChildren()) do
							if fruit:HasTag("FruitTool") and not string.find(fruit.Name,"Moonlit") and check_str_and(fruit.Name,getgenv().Configs.FruitFeed) then
								plr.Character.Humanoid:EquipTool(fruit)
								wait()
								local args = {
									[1] = "Feed",
									[2] = pet:GetAttribute("UUID")
								}
								
								game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("ActivePetService"):FireServer(unpack(args))							
								eat_val=true
								break
							end
						end
					until eat_val or not getgenv().Configs.AutoFeed
				end
			end
        end
    end)
end})

local PurchaseTab=Sawhub:CreatePage({title="Purchase"})
PurchaseTab:CreateSection({title="Seed"})
PurchaseTab:CreateToggle({title="Auto Buy Seeds",default=getgenv().Configs.AutoBuySeeds,callback=function(v)
    getgenv().Configs.AutoBuySeeds = v
    spawn(function()
        while wait() and getgenv().Configs.AutoBuySeeds do
            for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Seed_Shop.Frame.ScrollingFrame:GetChildren()) do
                if v:IsA("Frame") and not string.find(v.Name,"Padding") then
                    if v.Main_Frame.Cost_Text.Text ~="NO STOCK" and table.find(getgenv().Configs.Seeds,v.Name) then
                        Sawhub:Notify("Successfully purchased ["..v.Name.." Seed]")
						local args = {
                            [1] = v.Name
                        }
                        
                        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(unpack(args))
                        
                    end
                end
            end
        end
    end)
end})

PurchaseTab:CreateDropdown({title="Select Seeds",list=allseeds,default=getgenv().Configs.Seeds or {},multi=true,callback=function(v)
	getgenv().Configs.Seeds=v
end})

getgenv().Configs.Gears={}
PurchaseTab:CreateSection({title="Gear"})
PurchaseTab:CreateToggle({title="Auto Buy Gears",default=getgenv().Configs.AutoBuyGears,callback=function(v)
    getgenv().Configs.AutoBuyGears = v
    spawn(function()
        while wait() and getgenv().Configs.AutoBuyGears do
            for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Gear_Shop.Frame.ScrollingFrame:GetChildren()) do
                if v:IsA("Frame") and not string.find(v.Name,"Padding") then
                    if v.Main_Frame.Cost_Text.Text ~="NO STOCK" and table.find(getgenv().Configs.Gears,v.Name) then
                        Sawhub:Notify("Successfully purchased ["..v.Name.."]")
						local args = {
                            [1] = v.Name
                        }
                        
                        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer(unpack(args))
                        
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
--"Basic Sprinkler","Godly Sprinkler","Master Sprinkler","Advanced Sprinkler"
PurchaseTab:CreateDropdown({title="Select Gears",list=allgeears,default=getgenv().Configs.Gears or {},multi=true,callback=function(v)
	getgenv().Configs.Gears=v
end})

local SettingTab=Sawhub:CreatePage({title="Settings"})
SettingTab:CreateSection({title="Performance"})
local buff=false
SettingTab:CreateToggle({title="Boost Fps",default=getgenv().Configs.BoostFps,callback=function(v)
	getgenv().Configs.BoostFps=v
	pcall(function()
		if v then
			spawn(function()
                if not buff then
                    buff=true
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
                    local index_wait=0
                    for i, v in pairs(g:GetDescendants()) do
                        index_wait+=1
                        if index_wait>=10 then
                            task.wait()
                            index_wait=0
                        end
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
                end
                Sawhub:Notify("Boost Fps Succes")
            end)
		end
	end)
end})  
SettingTab:CreateToggle({title="Black Screen",default=getgenv().Configs.BlackScreen,callback=function(v)
	getgenv().Configs.BlackScreen=v
	pcall(function()
		if v then
			game:GetService("RunService"):Set3dRenderingEnabled(false)
		else
			game:GetService("RunService"):Set3dRenderingEnabled(true)
		end
	end)
end})
SettingTab:CreateSection({title="Humanoid"})
local org_speed=32
SettingTab:CreateToggle({title="Buff Walkspeed",default=getgenv().Configs.Walkspeed,callback=function(v)
	getgenv().Configs.Walkspeed=v
	spawn(function()
		if getgenv().Configs.Walkspeed then
			org_speed=game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
			while wait() and getgenv().Configs.Walkspeed do
				pcall(function()
					game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=org_speed+getgenv().Configs.WalkspeedVal
				end)
			end
		else
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=org_speed
		end
	end)
end})
SettingTab:CreateSlider({title="Walkspeed",Min=10,Max=1000,Precise=getgenv().Configs.WalkspeedVal or 20,callback=function(v)
	getgenv().Configs.WalkspeedVal=v
end})
SettingTab:CreateSection({title="Others"})
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

SettingTab:CreateButton({title="Copy Configs",callback=function()
	local save_configs = "getgenv().Configs = {\n    "
	for i, v in pairs(getgenv().Configs) do
		if type(i) == "string" then
			save_configs = save_configs .. "[" .. '"' .. i .. '"' .. "] = " .. Convert_value(v) .. ",\n    "
		else
			save_configs = save_configs .. "[" .. tostring(i) .. "] = " .. Convert_value(v) .. ",\n    "
		end
	end
	save_configs = save_configs:sub(1, -6) .. "\n}"
	setclipboard(save_configs)
end})
SettingTab:CreateButton({title="Rejoin",callback=function()
	game:GetService("TeleportService"):Teleport(game.PlaceId,game.Players.LocalPlayer)
end})
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
	if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') and getgenv().Configs.AutoCollect then
		for k,v in next,game.Players.LocalPlayer.Character:GetChildren() do
			if v:IsA('BasePart') then
				v.CanCollide = false
			end
		end
	end
end)

task.spawn(function()
	while wait(1) do
		if getgenv().Configs.AutoCollect then
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
-- local v_u_4 = require(game:GetService("ReplicatedStorage").Modules.DataService)
-- local SeedData=require(game:GetService("ReplicatedStorage").Data.SeedData)
-- local v_u_10 = require(game:GetService("ReplicatedStorage").Data.SeedShopData)
-- function WebhookSeed()
--     local b = v_u_4:GetData()
--     local msg2 = "**Account**\n||"..game.Players.LocalPlayer.Name.."||\n**Seeds**\n"
--     for i,v in pairs(b.SeedStock.Stocks) do
--         msg2=msg2.."- "..i.." x"..v.MaxStock.." Stock ["..SeedData[i]["SeedRarity"].."]\n"
--     end
--     local msg = {
--         ["content"] = "@everyone",
--         ["embeds"] = {{
--             ["title"] = "Saw Hub",
--             ["description"]=msg2,
    
--             ["type"] = "rich",
--             ["color"] = tonumber(47103),
--             ["footer"] = {
--                 ["text"] = "Saw Hub (" .. os.date("%X") .. ")"
--             }
--         }}
--     }
    
--     request({
--         Url ="https://discord.com/api/webhooks/1367707476719304704/NB6gEKsaydnj8J-O7YaRJZVJo5y8fk33r-ccunfbSiX5QQZ1GgKZf9rgzJ0DF0jj2zi3",
--         Method = "POST",
--         Headers = {
--             ["Content-Type"] = "application/json"
--         },
--         Body = game:GetService("HttpService"):JSONEncode(msg)
--     })
-- end
-- spawn(function()
--     while true do
--         local v21 = workspace:GetServerTimeNow()
--         local v22 = v_u_4:GetData()
--         local v23 = v22.SeedStock.ForcedSeedEndTimestamp and (v22.SeedStock.ForcedSeedEndTimestamp - v21 or -1) or -1
--         if v23 < 0 then
--             v23 = v_u_10.RefreshTime - v21 % v_u_10.RefreshTime
--         end
    
--         if v23 <= 1 then
--             wait(10)
--             WebhookSeed()
--         end
--         task.wait(1)
--     end
-- end)

-- local GearData=require(game:GetService("ReplicatedStorage").Data.GearData)
-- local v_u_100 = require(game:GetService("ReplicatedStorage").Data.GearShopData)
-- function WebhookGear()
--     local b = v_u_4:GetData()
--     local msg2 = "**Account**\n||"..game.Players.LocalPlayer.Name.."||\n**Seeds**\n"
--     for i,v in pairs(b.GearStock.Stocks) do
--         msg2=msg2.."- "..i.." x"..v.MaxStock.." Stock ["..GearData[i]["GearRarity"].."]\n"
--     end
--     local msg = {
--         ["content"] = "@everyone",
--         ["embeds"] = {{
--             ["title"] = "Saw Hub",
--             ["description"]=msg2,
    
--             ["type"] = "rich",
--             ["color"] = tonumber(47103),
--             ["footer"] = {
--                 ["text"] = "Saw Hub (" .. os.date("%X") .. ")"
--             }
--         }}
--     }
    
--     request({
--         Url ="https://discord.com/api/webhooks/1367715113322287134/MEqvIUg5gtZkCHEFB9LJwjNigpN2SFOG3JygEgc5mXUo_jgj9eDCELmMaNPhQNf5JoK_",
--         Method = "POST",
--         Headers = {
--             ["Content-Type"] = "application/json"
--         },
--         Body = game:GetService("HttpService"):JSONEncode(msg)
--     })
-- end
-- spawn(function()
--     while true do
--         local v21 = workspace:GetServerTimeNow()
--         local v22 = v_u_4:GetData()
--         local v23 = v22.GearStock.ForcedSeedEndTimestamp and (v22.GearStock.ForcedSeedEndTimestamp - v21 or -1) or -1
--         if v23 < 0 then
--             v23 = v_u_10.RefreshTime - v21 % v_u_10.RefreshTime
--         end
    
--         if v23 <= 1 then
--             wait(10)
--             WebhookGear()
--         end
--         task.wait(1)
--     end
-- end)
Sawhub:Notify("Script Loaded!")
