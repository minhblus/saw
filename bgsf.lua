wait(1)
repeat wait(1) until game:IsLoaded()
repeat wait()
	if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Intro") then
		for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Intro.Play.Button.Activated)) do
			v.Function()
		end
		for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Intro.Graphics.Content.Low.Action.Button.Activated)) do
			v.Function()
		end
	end
until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Intro")
wait(1)
local SawUI = {}
local EnableTP=false
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
	UIStrokeHe.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
	UIStrokeHe.Color=Color3.fromRGB(0,0,0)
	UIStrokeHe.Thickness=2
	UIStrokeHe.Parent=BtnMobile
	
	BtnMobile.Name = "BtnMobile"
	BtnMobile.Parent = UI
	BtnMobile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BtnMobile.BackgroundTransparency = 0.500
	BtnMobile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BtnMobile.BorderSizePixel = 0
	BtnMobile.Position = UDim2.new(0.03622251, 0, 0.0609756112, 0)
	BtnMobile.Size = UDim2.new(0, 50, 0, 50)
	BtnMobile.AutoButtonColor = false
	BtnMobile.Font = Enum.Font.SourceSansBold
	BtnMobile.Text = "OPEN"
	BtnMobile.TextColor3 = Color3.fromRGB(0, 0, 0)
	BtnMobile.TextScaled = true
	BtnMobile.TextSize = 14.000
	BtnMobile.TextWrapped = true
	
	UICorner124.Parent = BtnMobile

	Notify.Name = "Notify"
	Notify.Parent = UI
	Notify.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Notify.BackgroundTransparency = 1.000
	Notify.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Notify.BorderSizePixel = 0
	Notify.Size = UDim2.new(1, 0, 1, 0)
	Notify.ZIndex = 2

	NotiList.Name = "NotiList"
	NotiList.Parent = Notify
	NotiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	NotiList.SortOrder = Enum.SortOrder.LayoutOrder
	NotiList.Padding = UDim.new(0, 7)

	NotiPadding.Name = "NotiPadding"
	NotiPadding.Parent = Notify
	NotiPadding.PaddingTop = UDim.new(0, 10)
	
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
	
	function crepage:Notify(message,colors)
		colors = colors or Color3.fromRGB(0, 170, 0)
		message= message or "None"
		
		local TextLabele = Instance.new("TextLabel")
		local UICorner = Instance.new("UICorner")
		local UIStroke5 = Instance.new("UIStroke")


		UIStroke5.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
		UIStroke5.Color=colors
		UIStroke5.Parent=TextLabele


		TextLabele.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
		TextLabele.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabele.BorderSizePixel = 0

		TextLabele.Font = Enum.Font.Gotham
		TextLabele.Text=message

		TextLabele.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabele.TextSize = 14.000
		TextLabele.Parent = Notify
		


		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = TextLabele
		
		local tweenIn = TweenService:Create(TextLabele, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, TextLabele.TextBounds.X + 10, 0, 20)
		})
		tweenIn:Play()

		task.delay(1.5, function()
			local tweenOut = TweenService:Create(TextLabele, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				Size = UDim2.new(0, 0, 0, 0)
			})
			tweenOut:Play()

			tweenOut.Completed:Wait()
			TextLabele:Destroy()
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
		ListTab.Padding = UDim.new(0, 5)
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


			UIStroke3.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
			UIStroke3.Color=Color3.fromRGB(255,255,255)
			UIStroke3.Parent=Toggle
			
			Toggle.Name = "Toggle"
			Toggle.Parent = Page
			Toggle.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
			Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Position = UDim2.new(0.0235294122, 0, 0, 0)
			Toggle.Size = UDim2.new(1, -20, 0, 45)
			Toggle.AutoButtonColor = false
			Toggle.Font = Enum.Font.Gotham
			Toggle.Text = ""
			Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.TextSize = 18.000

			UICorner.Parent = Toggle

			help_outline.Name = "help_outline"
			help_outline.Parent = Toggle
			help_outline.AnchorPoint = Vector2.new(0, 0.5)
			help_outline.BackgroundTransparency = 1.000
			help_outline.Position = UDim2.new(0, 10, 0.5, 0)
			help_outline.Size = UDim2.new(0, 25, 0, 25)
			help_outline.ZIndex = 2
			help_outline.AutoButtonColor = false
			help_outline.Image = "rbxassetid://3926305904"
			help_outline.ImageRectOffset = Vector2.new(684, 804)
			help_outline.ImageRectSize = Vector2.new(36, 36)
			help_outline.MouseButton1Click:Connect(function()
				set_use(toggletab["des"] or "None")
			end)
			title.Name = "title"
			title.Parent = Toggle
			title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title.BackgroundTransparency = 1.000
			title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			title.BorderSizePixel = 0
			title.Position = UDim2.new(0, 45, 0, 0)
			title.Size = UDim2.new(0, 200, 0, 45)
			title.Font = Enum.Font.Gotham
			title.Text = toggletab["title"]
			title.TextColor3 = Color3.fromRGB(255, 255, 255)
			title.TextSize = 20.000
			title.TextXAlignment = Enum.TextXAlignment.Left

			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.Parent = Toggle
			ToggleFrame.AnchorPoint = Vector2.new(0, 0.5)
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
			ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleFrame.BorderSizePixel = 0
			ToggleFrame.Position = UDim2.new(0.78125, 0, 0.5, 0)
			ToggleFrame.Size = UDim2.new(0, 60, 0, 25)

			UICorner_2.CornerRadius = UDim.new(0, 16)
			UICorner_2.Parent = ToggleFrame

			Cir.Name = "Cir"
			Cir.Parent = ToggleFrame
			Cir.AnchorPoint = Vector2.new(0, 0.5)
			Cir.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Cir.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Cir.BorderSizePixel = 0
			Cir.Position = UDim2.new(0, 4, 0.5, 0)
			Cir.Size = UDim2.new(0, 19, 0, 19)

			UICorner_3.CornerRadius = UDim.new(1, 0)
			UICorner_3.Parent = Cir
			
			local toggled=false

			local togglecall={}
			function togglecall:Set(val)
				toggled=val
				toggletab.callback(toggled)
				if toggled then
					TweenObject(Cir,{BackgroundColor3=Color3.fromRGB(0, 170, 255)},.1)
					TweenObject(Cir,{Position=UDim2.new(1, -23,0.5, 0)},.1)
				else
					TweenObject(Cir,{BackgroundColor3=Color3.fromRGB(255, 255, 255)},.1)
					TweenObject(Cir,{Position=UDim2.new(0, 4,0.5, 0)},.1)
				end
			end
			togglecall:Set(toggletab.default or false)

			Toggle.MouseButton1Click:Connect(function()
				toggled=not toggled
				togglecall:Set(toggled)
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
spawn(function()
    SetSettingGame()
end)
local SelectTab=""
local Sawhub= SawUI:CreateWindow({title="Saw Hub"})
local HomeTab=Sawhub:CreatePage({title="Home"})

HomeTab:CreateSection({title="Coins"})
HomeTab:CreateToggle({title="Auto Farm Coins",des="min 10m coins , max 10b coins",default=getgenv().Configs.AutoFarmCoins,callback=function(v)
    getgenv().Configs.AutoFarmCoins=v
end})

HomeTab:CreateSection({title="Automatic"})
HomeTab:CreateToggle({title="Auto Bubble",default=getgenv().Configs.AutoBubble,callback=function(v)
    getgenv().Configs.AutoBubble=v
    spawn(function()
        while wait(.1) and getgenv().Configs.AutoBubble do
            local args = {
                [1] = "BlowBubble"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args)) 
        end       
    end)
end})

HomeTab:CreateToggle({title="Auto Golden chest",default=getgenv().Configs.AutoGoldenChest,callback=function(v)
	getgenv().Configs.AutoGoldenChest=v
    spawn(function()
        while wait(.1) and autogolden do
            if workspace.Rendered.Rifts:FindFirstChild("golden-chest") then
                EnableTP=true
                while wait() and autogolden and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-workspace.Rendered.Rifts["golden-chest"].Output.Position).Magnitude >=5 do
                    TP(workspace.Rendered.Rifts["golden-chest"].Output.CFrame)
                end
                EnableTP=false
                local args = {
                    [1] = "UnlockRiftChest",
                    [2] = "golden-chest",
                    [3] = false
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))                
            end
        end
    end)
end})

HomeTab:CreateSection({title="Loot"})

HomeTab:CreateToggle({title="Auto Collect Ore",default=getgenv().Configs.AutoCollect,callback=function(v)
    getgenv().Configs.AutoCollect=v
end})

HomeTab:CreateSection({title="Claim"})
HomeTab:CreateToggle({title="Auto Play Time",default=getgenv().Configs.AutoPlaytime,callback=function(v)
    getgenv().Configs.AutoPlaytime=v
    spawn(function()
        while wait() and getgenv().Configs.AutoPlaytime do
            for i =1,9 do
                local args = {
                    [1] = "ClaimPlaytime",
                    [2] = i
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function"):InvokeServer(unpack(args))
                wait(2)
            end
            wait(60)
        end
    end)
end})
HomeTab:CreateToggle({title="Auto Session",default=getgenv().Configs.AutoSession,callback=function(v)
    getgenv().Configs.AutoSession=v
    spawn(function()
        while wait() and getgenv().Configs.AutoSession do
            local args = {
                [1] = "ClaimSeason"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            wait(60)
        end
    end)
end})
HomeTab:CreateToggle({title="Auto Quest",default=getgenv().Configs.AutoQuest,callback=function(v)
    getgenv().Configs.AutoQuest=v
    spawn(function()
        while wait() and getgenv().Configs.AutoQuest do
            for i=1,32 do
                local args = {
                    [1] = "ClaimPrize",
                    [2] = i
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                wait(5)
            end
            wait(60)
        end
    end)
end})

HomeTab:CreateToggle({title="Auto Void Chest",default=getgenv().Configs.AutoVoidChest,callback=function(v)
    getgenv().Configs.AutoVoidChest=v
    spawn(function()
        while wait() and getgenv().Configs.AutoVoidChest do
            local args = {
                [1] = "ClaimChest",
                [2] = "Void Chest"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            wait(60)
        end
    end)
end})

HomeTab:CreateToggle({title="Auto Golden Chest",default=getgenv().Configs.AutoGoldenChest,callback=function(v)
    getgenv().Configs.AutoGoldenChest=v
    spawn(function()
        while wait() and getgenv().Configs.AutoGoldenChest do
            local args = {
                [1] = "ClaimChest",
                [2] = "Golden Chest"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            wait(60)
        end
    end)
end})

HomeTab:CreateSection({title="Use"})
HomeTab:CreateToggle({title="Auto Golden Ore",default=getgenv().Configs.AutoGoldrenOre,callback=function(v)
    getgenv().Configs.AutoGoldrenOre=v
    spawn(function()
        while wait() and getgenv().Configs.AutoGoldrenOre do
            local args = {
                [1] = "UseGoldenOrb"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            wait(30)
        end
    end)
end})
HomeTab:CreateToggle({title="Auto Mystery Box",default=getgenv().Configs.AutoMysteryBox,callback=function(v)
    getgenv().Configs.AutoMysteryBox=v
    spawn(function()
        while wait(1) and getgenv().Configs.AutoMysteryBox do
            if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Inventory.Frame.Inner.Items.Main.ScrollingFrame.Powerups.Items:FindFirstChild("Mystery Box") and game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Inventory.Frame.Inner.Items.Main.ScrollingFrame.Powerups.Items:FindFirstChild("Mystery Box").Visible==true then
                local Amount=tonumber(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Inventory.Frame.Inner.Items.Main.ScrollingFrame.Powerups.Items:FindFirstChild("Mystery Box").Inner.Button.Inner.Amount.Text:split(" ")[2]:split(" ")[1])
                if Amount>=10 then
                    Amount=10
                end
                local args = {
                    [1] = "UseGift",
                    [2] = "Mystery Box",
                    [3] = Amount
                }
            
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            end
        end
    end)
end})
local acoconma=require(game:GetService("ReplicatedStorage").Shared.Data.Buffs)
function FuseBoost()
	for i,v in acoconma do
		for u = 2,6 do
			local args = {
				[1] = "CraftPotion",
				[2] = i,
				[3] = u,
				[4] = true
			}
			
			game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
			wait(0.2)
		end
	end
end	
HomeTab:CreateSection({title="Potions"})
local pointselect={}
HomeTab:CreateToggle({title="Auto Potions",default=getgenv().Configs.AutoPotions,callback=function(v)
    getgenv().Configs.AutoPotions=v
    spawn(function()
        while wait() and getgenv().Configs.AutoPotions do
            FuseBoost()
			for i,v in pairs(pointselect) do
                local bucu=v:split(" ")
                local args = {
                    [1] = "UsePotion",
                    [2] = bucu[1],
                    [3] = tonumber(bucu[2])
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))           
                wait(1)
            end
            wait(60)
        end
    end)
end})

local pointlist={}
for i,v in acoconma do
	if i~="GoldRush" then
		for level,_ in pairs(v.Level) do
			table.insert(pointlist,i.." "..level)
			if level>=5 then
				table.insert(pointselect,i.." "..level)
			end
		end
	end
end

HomeTab:CreateDropdown({title="Select Potions",list=pointlist,default=pointselect,multi=true,callback=function(v)
    pointselect=v
end})

function SetSettingGame()
    local args = {
        [1] = "SetSetting",
        [2] = "Music",
        [3] = 0
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
    wait(.7)
    local args = {
        [1] = "SetSetting",
        [2] = "Sound Effects",
        [3] = 0
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
    wait(.7)
    local args = {
        [1] = "SetSetting",
        [2] = "Hide Bubbles",
        [3] = true
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
    wait(.7)
    local args = {
        [1] = "SetSetting",
        [2] = "Skip Easy Legendary",
        [3] = true
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
    wait(.7)
    local args = {
        [1] = "SetSetting",
        [2] = "Hide Others Pets",
        [3] = true
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
    wait(.7)
    local args = {
        [1] = "SetSetting",
        [2] = "Hide All Pets",
        [3] = true
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                    
end

HomeTab:CreateSection({title="Performance"})
local buff=false
HomeTab:CreateToggle({title="Boost Fps",default=getgenv().Configs.BoostFps,callback=function(v)
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
            spawn(function()
                SetSettingGame()
            end)
		end
	end)
end})  

local UIFARM = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local hehe = Instance.new("TextLabel")
local nameplayer = Instance.new("TextLabel")
local coinsgem = Instance.new("TextLabel")
local total = Instance.new("TextLabel")
local timelaps = Instance.new("TextLabel")

UIFARM.Name = "UIFARM"
UIFARM.IgnoreGuiInset=true
UIFARM.Enabled=false
UIFARM.Parent = game:GetService("CoreGui")
UIFARM.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UIFARM.DisplayOrder = 1

Main.Name = "Main"
Main.Parent = UIFARM
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Size = UDim2.new(1, 0, 1, 0)

hehe.Name = "hehe"
hehe.Parent = Main
hehe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hehe.BackgroundTransparency = 1.000
hehe.BorderColor3 = Color3.fromRGB(0, 0, 0)
hehe.BorderSizePixel = 0
hehe.Size = UDim2.new(1, 0, 0.150000006, 0)
hehe.Font = Enum.Font.Unknown
hehe.Text = "Saw Hub"
hehe.TextColor3 = Color3.fromRGB(85, 170, 255)
hehe.TextScaled = true
hehe.TextSize = 14.000
hehe.TextWrapped = true

nameplayer.Name = "nameplayer"
nameplayer.Parent = Main
nameplayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
nameplayer.BackgroundTransparency = 1.000
nameplayer.BorderColor3 = Color3.fromRGB(0, 0, 0)
nameplayer.BorderSizePixel = 0
nameplayer.Position = UDim2.new(0, 0, 0.150000006, 0)
nameplayer.Size = UDim2.new(1, 0, 0.150000006, 0)
nameplayer.Font = Enum.Font.Unknown
nameplayer.Text = plr.Name
nameplayer.TextColor3 = Color3.fromRGB(255, 255, 0)
nameplayer.TextScaled = true
nameplayer.TextSize = 14.000
nameplayer.TextWrapped = true

coinsgem.Name = "coinsgem"
coinsgem.Parent = Main
coinsgem.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
coinsgem.BackgroundTransparency = 1.000
coinsgem.BorderColor3 = Color3.fromRGB(0, 0, 0)
coinsgem.BorderSizePixel = 0
coinsgem.Position = UDim2.new(0, 0, 0.543902397, 0)
coinsgem.Size = UDim2.new(1, 0, 0.214227632, 0)
coinsgem.Font = Enum.Font.Unknown
coinsgem.Text = "Coins:100b | Gems:100b"
coinsgem.TextColor3 = Color3.fromRGB(255, 255, 255)
coinsgem.TextScaled = true
coinsgem.TextSize = 14.000
coinsgem.TextWrapped = true

total.Name = "total"
total.Parent = Main
total.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
total.BackgroundTransparency = 1.000
total.BorderColor3 = Color3.fromRGB(0, 0, 0)
total.BorderSizePixel = 0
total.Position = UDim2.new(0, 0, 0.320325166, 0)
total.Size = UDim2.new(1, 0, 0.214227632, 0)
total.Font = Enum.Font.Unknown
total.Text = "Hatch Total : 10000"
total.TextColor3 = Color3.fromRGB(255, 0, 0)
total.TextScaled = true
total.TextSize = 14.000
total.TextWrapped = true

timelaps.Name = "timelaps"
timelaps.Parent = Main
timelaps.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
timelaps.BackgroundTransparency = 1.000
timelaps.BorderColor3 = Color3.fromRGB(0, 0, 0)
timelaps.BorderSizePixel = 0
timelaps.Position = UDim2.new(0, 0, 0.747154415, 0)
timelaps.Size = UDim2.new(1, 0, 0.214227632, 0)
timelaps.Font = Enum.Font.Unknown
timelaps.Text = "20:01:12"
timelaps.TextColor3 = Color3.fromRGB(85, 170, 255)
timelaps.TextScaled = true
timelaps.TextSize = 14.000
timelaps.TextWrapped = true
function format_thousands(n)
    local str = tostring(n)
    local result = str
    local k
    repeat
        result, k = string.gsub(result, "^(-?%d+)(%d%d%d)", "%1.%2")
    until k == 0
    return result
end
function format_number(n)
    if n >= 1e9 then
        return string.format("%.1fb", n / 1e9)
    elseif n >= 1e6 then
        return string.format("%.1fm", n / 1e6)
    elseif n >= 1e3 then
        return string.format("%.1fk", n / 1e3)
    else
        return tostring(n)
    end
end

function Update_Time()
	local Hour = math.floor(ServerTime / 3600) % 24
	local Minute = math.floor((ServerTime % 3600) / 60)
	local Second = math.floor(ServerTime % 60)

	Hour = string.format("%02d", Hour)
	Minute = string.format("%02d", Minute)
	Second = string.format("%02d", Second)
	
	timelaps.Text = Hour..":"..Minute..":"..Second
end
HomeTab:CreateToggle({title="Black Screen",default=getgenv().Configs.BackScreen,callback=function(v)
	getgenv().Configs.BackScreen=v
	UIFARM.Enabled=v
	pcall(function()
		if v then
			game:GetService("RunService"):Set3dRenderingEnabled(false)
			spawn(function()
				while wait() and getgenv().Configs.BackScreen do
					Update_Time()
					local coinsget=game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Currency.Coins.Frame.Label.Text
					local gemsget=game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Currency.Gems.Frame.Label.Text
					coinsgem.Text="Coins:"..coinsget.." | Gems:"..gemsget
					total.Text="Total Hatched: "..format_thousands(game:GetService("Players").LocalPlayer.leaderstats["\240\159\165\154 Hatches"].Value)
					
				end
			end)
		else
			game:GetService("RunService"):Set3dRenderingEnabled(true)
		end
	end)
end})

local PurchaseTab=Sawhub:CreatePage({title="Purchase"})
PurchaseTab:CreateSection({title="Mastery"})
PurchaseTab:CreateToggle({title="Auto Mastery",default=getgenv().Configs.AutoMastery,callback=function(v)
    getgenv().Configs.AutoMastery=v
    spawn(function()
        while wait() and getgenv().Configs.AutoMastery do
            local args = {
                [1] = "UpgradeMastery",
                [2] = "Pets"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            wait(.7)
            local args = {
                [1] = "UpgradeMastery",
                [2] = "Buffs"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            wait(60)
        end
    end)
end})

PurchaseTab:CreateSection({title="Shop"})
PurchaseTab:CreateToggle({title="Auto Blackmarket",default=getgenv().Configs.AutoBlackmarket,callback=function(v)
    getgenv().Configs.AutoBlackmarket=v
    spawn(function()
        while wait() and getgenv().Configs.AutoBlackmarket do
            for i =1,3 do
                local args = {
                    [1] = "BuyShopItem",
                    [2] = "shard-shop",
                    [3] = i
                  }
                  
                  game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                wait(0.7)
            end
            wait(60)
        end
    end)
end})

PurchaseTab:CreateToggle({title="Auto Alien Shop",default=getgenv().Configs.AutoAlienShop,callback=function(v)
    getgenv().Configs.AutoAlienShop=v
    spawn(function()
        while wait() and getgenv().Configs.AutoAlienShop do
            for i =1,3 do

                local args = {
                    [1] = "BuyShopItem",
                    [2] = "alien-shop",
                    [3] = i
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                wait(0.7)
            end
            wait(5)
        end
    end)
end})
local riftsegg={}
local covertrift_to_egg={}
local allrifts=require(game:GetService("ReplicatedStorage").Shared.Data.Rifts)
for i,v in pairs(allrifts) do
    if v.Type=="Egg" then
        table.insert(riftsegg,v.Egg)
        covertrift_to_egg[v.Egg]=i
    end
end
local HatchTab=Sawhub:CreatePage({title="Hatch"})
HatchTab:CreateSection({title="Automatic"})
HatchTab:CreateToggle({title="Auto Egg",default=getgenv().Configs.AutoEgg,callback=function(v)
    getgenv().Configs.AutoEgg=v
end})
HatchTab:CreateToggle({title="Auto Egg Rifts",default=getgenv().Configs.AutoEggRifts,callback=function(v)
    getgenv().Configs.AutoEggRifts=v
end})

HatchTab:CreateSection({title="Others"})
HatchTab:CreateToggle({title="Auto Royal Chest",default=getgenv().Configs.AutoRoyal,callback=function(v)
    getgenv().Configs.AutoRoyal=v
end})

HatchTab:CreateSection({title="Egg"})

local v_u_14 = require(game:GetService("ReplicatedStorage").Client.Framework.Services.LocalData)
function Get_Data()
    return v_u_14:Get()
end

local v2 = require(game:GetService("ReplicatedStorage").Shared.Data.Eggs)
local eggs={}
for k,u in v2 do
    if u.Cost.Currency=="Coins" then

        table.insert(eggs,k)
    end
end

HatchTab:CreateDropdown({title="Select Egg",list=eggs,default={getgenv().Configs.SelectEgg},callback=function(v)
    getgenv().Configs.SelectEgg=v
end})

HatchTab:CreateDropdown({title="Select Rifts Egg",default=getgenv().Configs.SelectEggRifts,list=riftsegg,multi=true,callback=function(v)
    getgenv().Configs.SelectEggRifts=v
end})


function CheckEnchant(pet_check)    
    local enchantshave={}
    for i,v in Get_Data().Pets do
        if v.Id==pet_check and v.Enchants~=nil then
            for i,v in pairs(v.Enchants) do
                table.insert(enchantshave,v.Id.."-"..v.Level)
            end
        end
    end
    if #enchantshave==0 then
        return "None"
    elseif #enchantshave==1 then
        return enchantshave[1]
    else
        return table.concat(enchantshave,",")
    end
end

function convert_enchant(name,level)
    local lowername=string.lower(name)
    local newText = string.gsub(lowername, " ", "-")

    if level then
        newText=newText.."-"..level
    end
    return newText
end

function enchant(petid)
    local enthave = CheckEnchant(petid)

    
    for i,v in pairs(getgenv().Configs.ListEnchants) do
        local letters = string.match(v, "^(.-)%s%d+$") or v
        local number = string.match(v, "%d+")
        local newname=convert_enchant(letters,number)

        if string.find(enthave,newname,1,true) or enthave==newname then
            return true
        end
    end

    local args = {
        [1] = "RerollEnchants",
        [2] = petid
    }
    
game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function"):InvokeServer(unpack(args))
end

local EnchantTab=Sawhub:CreatePage({title="Enchant"})
EnchantTab:CreateSection({title="UI"})
EnchantTab:CreateButton({title="Open/close enchant ui",callback=function()
	game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Enchants.Visible = not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Enchants.Visible
end})
EnchantTab:CreateSection({title="Automatic"})

EnchantTab:CreateToggle({title="Enchant Equip Team",default=getgenv().Configs.AutoEnchantTeam,callback=function(v)
    getgenv().Configs.AutoEnchantTeam=v
    spawn(function()
        while wait() and getgenv().Configs.AutoEnchantTeam do
            for i,v in Get_Data().Teams[1].Pets do
                enchant(v)
                wait(.1)
            end
        end
    end)
end})

EnchantTab:CreateToggle({title="Enchant From UI (Chua lam)",default=getgenv().Configs.AutoEnchantUI,callback=function(v)
    getgenv().Configs.AutoEnchantUI=v
end})

local enchantslist=require(game:GetService("ReplicatedStorage").Shared.Data.Enchants)
local listenchant={}

for i,v in pairs(enchantslist) do
    local display=v.DisplayName
    for u,ku in v.Buffs do
		if u~=1 then
        	table.insert(listenchant,display.." "..u)
		else
			table.insert(listenchant,display)
		end
    end
end
EnchantTab:CreateSection({title="Enchants"})


EnchantTab:CreateDropdown({title="Enchant 1",list=listenchant,default=getgenv().Configs.ListEnchants,multi=true,callback=function(v)
	getgenv().Configs.ListEnchants=v
end})

local IslandTab=Sawhub:CreatePage({title="Island"})
IslandTab:CreateSection({title="Unlock"})
IslandTab:CreateButton({title="Unlock Island",callback=function()
    for _,__ in pairs(workspace.Worlds["The Overworld"].Islands:GetChildren()) do
        for i,v in pairs(workspace.Worlds["The Overworld"].Islands:GetChildren()) do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=v.Island.UnlockHitbox.CFrame
            wait(0.3)
        end
    end
end})

IslandTab:CreateSection({title="Teleport"})
IslandTab:CreateButton({title="Home",callback=function()
    UseTpGame(nil)
end})
for i,v in pairs(workspace.Worlds["The Overworld"].Islands:GetChildren()) do
    IslandTab:CreateButton({title=v.Name,callback=function()
        UseTpGame(v.Name)
    end})
end

local PetTab=Sawhub:CreatePage({title="Pets"})
PetTab:CreateSection({title="Automatic"})
PetTab:CreateToggle({title="Auto Equip Pet",default=getgenv().Configs.AutoEquipPet,callback=function(v)
    getgenv().Configs.AutoEquipPet=v
    spawn(function()
        while wait() and getgenv().Configs.AutoEquipPet do
            local args = {
                [1] = "EquipBestPets"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            wait(30)            
        end
    end)
end})

PetTab:CreateToggle({title="Auto Delete Pet",default=getgenv().Configs.AutoDeletePet,callback=function(v)
    getgenv().Configs.AutoDeletePet=v
    
end})

PetTab:CreateDropdown({title="Select Pet Delete",list={"Common","Rare","Unique","Epic"},default=getgenv().Configs.deletepet or {},multi=true,callback=function(v)
	getgenv().Configs.deletepet=v
end})

spawn(function()
	while wait(60) do
        if AutoDeletePet then
            local petdelte={}
            for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Inventory.Frame.Inner.Pets.Main.ScrollingFrame.Pets:GetChildren()) do
                if v.Name~="UIPadding" and v.Name~="UIGridLayout" and v.Name~="Frame" and string.find(v.Name,"-") then
                    local namepet=v.Inner.Button.Inner.DisplayName.Text
                    if table.find(deletepet,petall[namepet].Rarity) then
                        table.insert(petdelte,v.Name)
                    end
                end
            end

            if #petdelte > 10 then
                local args = {
                    [1] = "MultiDeletePets",
                    [2] = petdelte
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            end
        end
	end
end)


function GetRoot()
    local plr = game.Players.LocalPlayer
    while true do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            return plr.Character.HumanoidRootPart
        end
        task.wait(0.5)
    end
end

function GetDis(pos)
    return (GetRoot().Position-pos).Magnitude
end

function check_table(tab,tab2)
    for i,v in pairs(tab) do
        for k,c in pairs(tab2) do

            if v.Name==covertrift_to_egg[c] then

                return v
            end
        end
    end
    return false
end

function dao_nguoc(t,v)
	for i,k in t do
		if k==v then
			return i
		end
	end
	return false
end

spawn(function()
    while wait() do
        if getgenv().Configs.AutoRoyal and workspace.Rendered.Rifts:FindFirstChild("royal-chest") and game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Inventory.Frame.Inner.Items.Main.ScrollingFrame.Powerups.Items:FindFirstChild("Royal Key") and game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Inventory.Frame.Inner.Items.Main.ScrollingFrame.Powerups.Items:FindFirstChild("Royal Key").Visible==true then
            EnableTP=true
            while getgenv().Configs.AutoRoyal and workspace.Rendered.Rifts:FindFirstChild("royal-chest") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Rendered.Rifts:FindFirstChild("royal-chest").Output.Position).Magnitude >= 10 do
                TP(workspace.Rendered.Rifts:FindFirstChild("royal-chest").Output.CFrame)
                wait()
            end
            EnableTP=false
            
            local args = {
                [1] = "UnlockRiftChest",
                [2] = "royal-chest",
                [3] = false
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            
        elseif getgenv().Configs.AutoMysteryBox and #workspace.Rendered.Gifts:GetChildren() > 0 then

            for i,v in pairs(workspace.Rendered.Gifts:GetChildren()) do
                EnableTP=true
                while wait() and getgenv().Configs.AutoMysteryBox and v and v.Parent==workspace.Rendered.Gifts do
                    TP(v.CFrame)
                    local VirtualInputManager = game:GetService("VirtualInputManager")

                    VirtualInputManager:SendMouseButtonEvent(500, 300, 0, true, game, 0)
                    VirtualInputManager:SendMouseButtonEvent(500, 300, 0, false, game, 0)

                end
                EnableTP=false
            end
        elseif getgenv().Configs.AutoFarmCoins and Get_Data().Coins <= 10000000 then
            while wait(1) and getgenv().Configs.AutoFarmCoins and Get_Data().Coins <= 10000000000 do
                UseTpGame("Zen")
            end
        elseif getgenv().Configs.AutoEggRifts and check_table(workspace.Rendered.Rifts:GetChildren(),getgenv().Configs.SelectEggRifts or {}) then
            EnableTP=true
            local eggsfind=check_table(workspace.Rendered.Rifts:GetChildren(),getgenv().Configs.SelectEggRifts or {}).Name
           
            while getgenv().Configs.AutoEggRifts and workspace.Rendered.Rifts:FindFirstChild(eggsfind) and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Rendered.Rifts:FindFirstChild(eggsfind).Output.Position).Magnitude >= 10 do
                TP(workspace.Rendered.Rifts:FindFirstChild(eggsfind).Output.CFrame)
                wait()
            end
            EnableTP=false
            local args = {
                [1] = "HatchEgg",
                [2] = dao_nguoc(covertrift_to_egg,eggsfind),
                [3] = 7
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))        
        elseif getgenv().Configs.AutoEgg and getgenv().Configs.SelectEgg then

            if v2[getgenv().Configs.SelectEgg].Island ~= nil then
                if GetDis(workspace.Worlds["The Overworld"].Islands[v2[getgenv().Configs.SelectEgg].Island].Island.UnlockHitbox.Position) >= 200 then
                    UseTpGame(v2[getgenv().Configs.SelectEgg].Island)
                    wait(1)
                end
            elseif GetDis(Vector3.new(93.82564544677734, 9.194348335266113, -78.05198669433594)) >= 200 then
                UseTpGame(nil)
                wait(1)
            end
            if workspace.Rendered.Generic:FindFirstChild(getgenv().Configs.SelectEgg) then
                EnableTP=true
                while wait() and workspace.Rendered.Generic:FindFirstChild(getgenv().Configs.SelectEgg) and GetDis(workspace.Rendered.Generic[getgenv().Configs.SelectEgg].Hitbox.Position) >= 5 do
                    TP(workspace.Rendered.Generic[getgenv().Configs.SelectEgg].Hitbox.CFrame)
                end
                EnableTP=false
                local args = {
                    [1] = "HatchEgg",
                    [2] = getgenv().Configs.SelectEgg,
                    [3] = 7
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

            end
        

        end
    end
end)

local besttpnew={}
local player=game.Players.LocalPlayer
function TP(cf)
    local besttp
    local bestpos=math.huge
    for i,v in pairs(workspace.Worlds["The Overworld"].Islands:GetChildren()) do
        if (cf.Position-v.Island.UnlockHitbox.Position).Magnitude < (cf.Position-player.Character.HumanoidRootPart.Position).Magnitude -  50 and (cf.Position-v.Island.UnlockHitbox.Position).Magnitude<bestpos then
            bestpos=(cf.Position-v.Island.UnlockHitbox.Position).Magnitude
            besttp="Workspace.Worlds.The Overworld.Islands."..v.Name..".Island.Portal.Spawn"
        end
    end

	for i,v in pairs(besttpnew) do
		if (cf.Position-v.Position).Magnitude < (cf.Position-player.Character.HumanoidRootPart.Position).Magnitude - 50 and (cf.Position-v.Position).Magnitude<bestpos then
            bestpos=(cf.Position-v.Position).Magnitude
            besttp=i
        end
	end

    local vitridacbiet=workspace.Worlds["The Overworld"].SpawnLocation.Position
    if (cf.Position-vitridacbiet).Magnitude < (cf.Position-player.Character.HumanoidRootPart.Position).Magnitude -  50 and (cf.Position-vitridacbiet).Magnitude<bestpos then
        besttp="Workspace.Worlds.The Overworld.PortalSpawn"
    end

    if besttp then
        local times = 0
        local tween = TS:Create(player.Character.HumanoidRootPart, TweenInfo.new(times,Enum.EasingStyle.Linear), {CFrame = player.Character.HumanoidRootPart.CFrame})
        tween:Play()
        tween:Cancel()
        wait(.1)
        local args = {
            [1] = "Teleport",
            [2] = besttp
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
        wait(1)
		player.Character.HumanoidRootPart.CFrame*=CFrame.new(0,15,0)
        
    end

    if (player.Character.HumanoidRootPart.Position - Vector3.new(cf.X,player.Character.HumanoidRootPart.Position.Y,cf.Z)).Magnitude >= 1 then
		
        local times = (player.Character.HumanoidRootPart.Position - Vector3.new(cf.X,player.Character.HumanoidRootPart.Position.Y,cf.Z)).Magnitude / 20
        local tween = TS:Create(player.Character.HumanoidRootPart, TweenInfo.new(times,Enum.EasingStyle.Linear), {CFrame = CFrame.new(Vector3.new(cf.X,player.Character.HumanoidRootPart.Position.Y,cf.Z))})
        tween:Play()
    else
        player.Character.HumanoidRootPart.CFrame=cf
    end
end

function UseTpGame(name)
    if name==nil then 
        besttp="Workspace.Worlds.The Overworld.PortalSpawn"
    else
        besttp="Workspace.Worlds.The Overworld.Islands."..name..".Island.Portal.Spawn"
    end
    local args = {
        [1] = "Teleport",
        [2] = besttp
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
end

spawn(function()
	local u44 = require(game:GetService("ReplicatedStorage").Shared.Utils.Stats.StatsUtil)
	local oldGetPickupRange = u44.GetPickupRange
	hookfunction(u44.GetPickupRange, function(...)
		if getgenv().Configs.AutoCollect then
			return 10000
		else
			return 10
		end
	end)
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
	if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') and EnableTP then
		for k,v in next,game.Players.LocalPlayer.Character:GetChildren() do
			if v:IsA('BasePart') then
				v.CanCollide = false
			end
		end
	end
end)
task.spawn(function()
	while wait(1) do
		if EnableTP then
			TweenFloat()
		else

			RemoveFloat()
		end
	end
end)
