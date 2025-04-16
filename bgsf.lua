local Lib = {}
local LP = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local Tweeninfo = TweenInfo.new

function TweenObject(obj, properties, duration, ...)
	game:GetService("TweenService"):Create(obj, Tweeninfo(duration, ...), properties):Play()
end

function DraggingEnabled(frame, parent)
	parent = parent or frame

	local dragging = false
	local dragInput, mousePos, framePos

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - mousePos
			TweenObject(parent, {Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)}, 0.25)
		end
	end)
end

function TextFit(object,parent)
	local obj = (parent and object.Parent) or object
	if not object.TextFits then
		obj.Size = UDim2.new(1,0,0,obj.AbsoluteSize.Y + object.TextSize)
		if object.TextFits then
			return true
		else
			return false
		end
	end
	return false
end

function Pop(object, shrink)
	local clone = object:Clone()

	clone.AnchorPoint = Vector2.new(0.5, 0.5)
	clone.Size = clone.Size - UDim2.new(0, shrink, 0, shrink)
	clone.Position = UDim2.new(0.5, 0, 0.5, 0)

	clone.Parent = object

	object.BackgroundTransparency = 1
	TweenObject(clone, {Size = object.Size}, 0.2)

	spawn(function()
		wait(0.2)

		object.BackgroundTransparency = 0
		clone:Destroy()
	end)

	return clone
end

function Lib:CreateWindow(wintable)
	local Main,TabScroll,PageFrame = (function ()
		local UI = Instance.new("ScreenGui")
		local Main = Instance.new("Frame")
		local ShadowBlack = Instance.new("ImageLabel")
		local CShadow = Instance.new("UICorner")
		local CMain = Instance.new("UICorner")
		local Header = Instance.new("Frame")
		local CHeader = Instance.new("UICorner")
		local Title = Instance.new("TextLabel")
		local UIScale = Instance.new("UIScale")
		local Elements = Instance.new("Frame")
		local PageFrame = Instance.new("Frame")
		local CPage = Instance.new("UICorner")
		local TabFrame = Instance.new("Frame")
		local CPage_2 = Instance.new("UICorner")
		local TabScroll = Instance.new("ScrollingFrame")
		local LTab = Instance.new("UIListLayout")


		UI.Name = "UI"
		UI.Parent = game.CoreGui
		UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		Main.Name = "Main"
		Main.Parent = UI
		Main.AnchorPoint = Vector2.new(0.5, 0.5)
		Main.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		Main.BorderSizePixel = 0
		Main.Position = UDim2.new(0.5, 0, 0.5, 0)
		Main.Size = UDim2.new(0, 500, 0, 300)

		ShadowBlack.Name = "ShadowBlack"
		ShadowBlack.Parent = Main
		ShadowBlack.AnchorPoint = Vector2.new(0.5, 0.5)
		ShadowBlack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ShadowBlack.BackgroundTransparency = 1.000
		ShadowBlack.BorderSizePixel = 0
		ShadowBlack.Position = UDim2.new(0.5, 0, 0.5, 0)
		ShadowBlack.Size = UDim2.new(1.11000001, 0, 1.11000001, 0)
		ShadowBlack.ZIndex = 0
		ShadowBlack.Image = "http://www.roblox.com/asset/?id=7495863394"
		ShadowBlack.ImageColor3 = Color3.fromRGB(0, 0, 0)

		CShadow.Name = "CShadow"
		CShadow.Parent = ShadowBlack

		CMain.Name = "CMain"
		CMain.Parent = Main

		Header.Name = "Header"
		Header.Parent = Main
		Header.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
		Header.BorderSizePixel = 0
		Header.Size = UDim2.new(1, 0, 0, 35)

		CHeader.Name = "CHeader"
		CHeader.Parent = Header

		Title.Name = "Title"
		Title.Parent = Header
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.Position = UDim2.new(0.0500000007, 0, 0, 0)
		Title.Size = UDim2.new(0, 400, 0, 35)
		Title.Font = Enum.Font.SourceSansSemibold
		Title.Text = wintable["Title"]
		Title.TextColor3 = Color3.fromRGB(130, 130, 130)
		Title.TextSize = 22.000
		Title.TextXAlignment = Enum.TextXAlignment.Left

		UIScale.Parent = Main

		Elements.Name = "Elements"
		Elements.Parent = Main
		Elements.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Elements.BackgroundTransparency = 1.000
		Elements.BorderSizePixel = 0
		Elements.Position = UDim2.new(0, 0, 0.116666667, 0)
		Elements.Size = UDim2.new(0, 500, 0, 265)

		PageFrame.Name = "PageFrame"
		PageFrame.Parent = Elements
		PageFrame.ClipsDescendants = true
		PageFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
		PageFrame.BorderSizePixel = 0
		PageFrame.Position = UDim2.new(0.275000006, 0, 0.0260000005, 0)
		PageFrame.Size = UDim2.new(0.714999974, 0, 0, 250)

		local UIPageLayout = Instance.new("UIPageLayout")

		UIPageLayout.Parent = PageFrame
		UIPageLayout.FillDirection = Enum.FillDirection.Vertical
		UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
		UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
		UIPageLayout.Padding = UDim.new(0, 0)
		UIPageLayout.TweenTime = 0.500

		CPage.Name = "CPage"
		CPage.Parent = PageFrame

		TabFrame.Name = "TabFrame"
		TabFrame.Parent = Elements
		TabFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
		TabFrame.BorderSizePixel = 0
		TabFrame.Position = UDim2.new(0.0189999994, 0, 0.0260000005, 0)
		TabFrame.Size = UDim2.new(0.240999997, 0, 0, 250)

		CPage_2.Name = "CPage"
		CPage_2.Parent = TabFrame

		TabScroll.Name = "TabScroll"
		TabScroll.Parent = TabFrame
		TabScroll.Active = true
		TabScroll.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
		TabScroll.BackgroundTransparency = 1.000
		TabScroll.BorderColor3 = Color3.fromRGB(27, 42, 53)
		TabScroll.BorderSizePixel = 0
		TabScroll.Size = UDim2.new(1, 0, 1, 0)
		TabScroll.ScrollBarThickness = 6

		LTab.Name = "LTab"
		LTab.Parent = TabScroll
		LTab.HorizontalAlignment = Enum.HorizontalAlignment.Center
		LTab.SortOrder = Enum.SortOrder.LayoutOrder

		return Main,TabScroll,PageFrame
	end)()

	DraggingEnabled(Main.Header,Main)

	local Opend = false
	local ToggleKey = wintable["Keybind"] or Enum.KeyCode.RightControl
	local function ToggleUI(key,chat)
		if chat then return end
		if key.KeyCode == ToggleKey then
			if Opend == false then
				TweenObject(Main.UIScale,{Scale = 0},0.2)
				Opend = true
			elseif Opend == true then
				TweenObject(Main.UIScale,{Scale = 1},0.2)
				Opend = false
			end
		end
	end

	UIS.InputBegan:Connect(ToggleUI)

	TabScroll.LTab:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		local absoluteSize = TabScroll.LTab.AbsoluteContentSize
		TabScroll.CanvasSize = UDim2.new(0, 0, 0, absoluteSize.Y+6)
	end)


	local PageFunction = {}

	function PageFunction:ChangeKeybind(key)
		ToggleKey = key
	end

	local first = true
	local LayoutOrder = - 1
	function PageFunction:CreatePage(pagetable)
		LayoutOrder = LayoutOrder + 1
		local TabButton,Page = (function()
			local TabButton = Instance.new("TextButton")
			local TabTitle = Instance.new("TextLabel")
			local Page = Instance.new("ScrollingFrame")
			local LPage = Instance.new("UIListLayout")
			local PPage = Instance.new("UIPadding")

			TabButton.Name = "TabButton"
			TabButton.Parent = TabScroll
			TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TabButton.BackgroundTransparency = 1.000
			TabButton.BorderSizePixel = 0
			TabButton.Size = UDim2.new(1, -20, 0, 40)
			TabButton.Selected = true
			TabButton.Font = Enum.Font.SourceSansSemibold
			TabButton.Text = ""
			TabButton.TextColor3 = Color3.fromRGB(100, 100, 100)
			TabButton.TextSize = 22.000

			TabTitle.Name = "TabTitle"
			TabTitle.Parent = TabButton
			TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TabTitle.BackgroundTransparency = 1.000
			TabTitle.BorderSizePixel = 0
			TabTitle.Size = UDim2.new(1, 0, 1, 0)
			TabTitle.Font = Enum.Font.SourceSansSemibold
			TabTitle.TextTransparency = 0.5
			TabTitle.Text = pagetable["Title"]
			TabTitle.TextColor3 = Color3.fromRGB(130, 130, 130)
			TabTitle.TextSize = 18.000
			TabTitle.TextWrapped = true

			TextFit(TabButton,true)

			Page.Name = "Page"
			Page.Parent = PageFrame
			Page.Active = true
			Page.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
			Page.BackgroundTransparency = 1.000
			Page.BorderSizePixel = 0
			Page.Size = UDim2.new(1, 0, 1, 0)
			Page.LayoutOrder = LayoutOrder
			Page.ScrollBarThickness = 6

			LPage.Name = "LPage"
			LPage.Parent = Page
			LPage.Padding = UDim.new(0, 4)
			LPage.HorizontalAlignment = Enum.HorizontalAlignment.Center
			LPage.SortOrder = Enum.SortOrder.LayoutOrder

			PPage.Name = "PPage"
			PPage.Parent = Page
			PPage.PaddingTop = UDim.new(0, 5)
			PPage.PaddingRight = UDim.new(0, 5)

			return TabButton,Page
		end)()
		Page.LPage:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			local absoluteSize =  Page.LPage.AbsoluteContentSize
			Page.CanvasSize = UDim2.new(0, 0, 0, absoluteSize.Y+10)
		end)
		if first then
			first = false
			PageFrame.UIPageLayout:JumpToIndex(Page.LayoutOrder)
			for i, v in next, TabScroll:GetChildren() do
				if v:IsA("TextButton") then
					TweenObject(v.TabTitle, {TextTransparency = .5}, 0.1)
				end
			end
			TweenObject(TabButton.TabTitle, {TextTransparency = 0}, 0.1)
		else
			TweenObject(TabButton.TabTitle, {TextTransparency = .5}, 0.1)
		end
		TabButton.MouseButton1Click:Connect(function ()
			PageFrame.UIPageLayout:JumpToIndex(Page.LayoutOrder)
			for i, v in next, TabScroll:GetChildren() do
				if v:IsA("TextButton") then
					TweenObject(v.TabTitle, {TextTransparency = .5}, 0.1)
				end
			end
			TweenObject(TabButton.TabTitle, {TextTransparency = 0}, 0.1)
		end)
		local SectionFunc = {}
		function SectionFunc:CreateSection(sectiontable)
			local Section = (function ()
				local Section = Instance.new("Frame")
				local CSection = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local Grow = Instance.new("Frame")
				local LSection = Instance.new("UIListLayout")

				Section.Name = "Section"
				Section.Parent = Page
				Section.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Section.BorderSizePixel = 0
				Section.Position = UDim2.new(0.215384617, 0, 0.319999993, 0)
				Section.Size = UDim2.new(1, -15, 0, 200)
				
				LSection.Name = "LSection"
				LSection.Parent = Section
				LSection.HorizontalAlignment = Enum.HorizontalAlignment.Center
				LSection.SortOrder = Enum.SortOrder.LayoutOrder
				LSection.Padding = UDim.new(0, 4)

				CSection.Name = "CSection"
				CSection.Parent = Section

				local Gr = Instance.new("Frame")

				Gr.Name = "Gr"
				Gr.Parent = Section
				Gr.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Gr.BackgroundTransparency = 1.000
				Gr.Size = UDim2.new(1, -20, 0, 30)

				Title.Name = "Title"
				Title.Parent = Gr
				Title.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.BorderSizePixel = 0
				Title.Size = UDim2.new(1, 0, 1, 0)
				Title.Font = Enum.Font.SourceSansSemibold
				Title.Text = sectiontable["Title"]
				Title.TextColor3 = Color3.fromRGB(79, 195, 247)
				Title.TextSize = 20.000
				Title.TextWrapped = true

				Grow.Name = "Grow"
				Grow.Parent = Gr
				Grow.AnchorPoint = Vector2.new(0.5, 0)
				Grow.BackgroundColor3 = Color3.fromRGB(79, 195, 247)
				Grow.BorderSizePixel = 0
				Grow.Position = UDim2.new(0.497637808, 0, 0.833333313, 0)
				Grow.Size = UDim2.new(1, 0, 0, 3)
				return Section
			end)()
			Section.LSection:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				local absoluteSize =  Section.LSection.AbsoluteContentSize
				Section.Size = UDim2.new(1, -15, 0, absoluteSize.Y+10)
			end)
			local ObjectFunc = {}
			function  ObjectFunc:CreateButton(buttontable)
				local Button = (function()
					local Button = Instance.new("TextButton")
					local Title = Instance.new("TextLabel")
					local CButtonT = Instance.new("UICorner")

					Button.Name = "Button"
					Button.Parent = Section
					Button.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
					Button.BorderSizePixel = 0
					Button.Position = UDim2.new(0.0287769791, 0, 0.335000008, 0)
					Button.Size = UDim2.new(1, -20, 0, 30)
					Button.Font = Enum.Font.SourceSansSemibold
					Button.Text = ""
					Button.TextColor3 = Color3.fromRGB(0, 0, 0)
					Button.TextSize = 14.000

					Title.Name = "Title"
					Title.Parent = Button
					Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title.BackgroundTransparency = 1.000
					Title.Size = UDim2.new(1, 0, 1, 0)
					Title.Font = Enum.Font.SourceSansSemibold
					Title.Text = "   "..buttontable["Title"]
					Title.TextColor3 = Color3.fromRGB(70, 70, 70)
					Title.TextSize = 18.000
					Title.TextXAlignment = Enum.TextXAlignment.Left

					CButtonT.CornerRadius = UDim.new(0, 4)
					CButtonT.Name = "CButtonT"
					CButtonT.Parent = Button
					return Button
				end)()
				Button.MouseButton1Click:Connect(function()
					game:GetService("TweenService"):Create(Button.Title,TweenInfo.new(.05,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{TextSize = 14}):Play()
					wait(.05)
					game:GetService("TweenService"):Create(Button.Title,TweenInfo.new(.05,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{TextSize = 18}):Play()
					buttontable["Callback"]()
				end)
			end
			function ObjectFunc:CreateToggle(toggletable)
				local Toggle = (function()
					local Toggle = Instance.new("TextButton")
					local Title = Instance.new("TextLabel")
					local IconEnabled = Instance.new("ImageLabel")
					local IconDisabled = Instance.new("ImageLabel")
					local CToggleT = Instance.new("UICorner")

					Toggle.Name = "Toggle"
					Toggle.Parent = Section
					Toggle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
					Toggle.BorderSizePixel = 0
					Toggle.Position = UDim2.new(0.0287769791, 0, 0.335000008, 0)
					Toggle.Size = UDim2.new(1, -20, 0, 35)
					Toggle.Font = Enum.Font.SourceSansSemibold
					Toggle.Text = ""
					Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
					Toggle.TextSize = 14.000

					Title.Name = "Title"
					Title.Parent = Toggle
					Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title.BackgroundTransparency = 1.000
					Title.Size = UDim2.new(1, 0, 1, 0)
					Title.Font = Enum.Font.SourceSansSemibold
					Title.Text = "   "..toggletable["Title"]
					Title.TextColor3 = Color3.fromRGB(70, 70, 70)
					Title.TextSize = 18.000
					Title.TextXAlignment = Enum.TextXAlignment.Left

					IconEnabled.Name = "IconEnabled"
					IconEnabled.Parent = Toggle
					IconEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					IconEnabled.BackgroundTransparency = 1.000
					IconEnabled.Position = UDim2.new(0.899053633, 0, 0.138095245, 0)
					IconEnabled.Size = UDim2.new(0, 25, 0, 25)
					IconEnabled.ImageTransparency = 1
					IconEnabled.Visible = true

					IconEnabled.Image = "rbxassetid://3926309567"
					IconEnabled.ImageRectOffset = Vector2.new(784, 420)
					IconEnabled.ImageRectSize = Vector2.new(48, 48)

					IconDisabled.Name = "IconDisabled"
					IconDisabled.Parent = Toggle
					IconDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					IconDisabled.BackgroundTransparency = 1.000
					IconDisabled.Position = UDim2.new(0.899053633, 0, 0.138095245, 0)
					IconDisabled.Size = UDim2.new(0, 25, 0, 25)
					IconDisabled.Image = "rbxassetid://3926309567"
					IconDisabled.ImageRectOffset = Vector2.new(628, 420)
					IconDisabled.ImageRectSize = Vector2.new(48, 48)

					CToggleT.CornerRadius = UDim.new(0, 4)
					CToggleT.Name = "CToggleT"
					CToggleT.Parent = Toggle
					return Toggle
				end)()
				local istoggle = false
				if toggletable["Enable"] then
					istoggle = true
					game.TweenService:Create(Toggle.IconEnabled, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
						ImageTransparency = 0
					}):Play()
					toggletable["Callback"](istoggle)
				end
				Toggle.MouseButton1Click:Connect(function()
					if istoggle == false then
						istoggle = true
						game.TweenService:Create(Toggle.IconEnabled, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
							ImageTransparency = 0
						}):Play()
					else
						istoggle = false
						game.TweenService:Create(Toggle.IconEnabled, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
							ImageTransparency = 1
						}):Play()
					end
					toggletable["Callback"](istoggle)
				end)
			end
			function ObjectFunc:CreateDropdown(dropdowntable)
				local Dropdown = (function()
					local Dropdown = Instance.new("TextButton")
					local Title = Instance.new("TextLabel")
					local Icon = Instance.new("ImageLabel")
					local CDropdown = Instance.new("UICorner")
					local DropdownScoll = Instance.new("ScrollingFrame")
					local LDropdown = Instance.new("UIListLayout")

					Dropdown.Name = "Dropdown"
					Dropdown.Parent = Section
					Dropdown.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
					Dropdown.BorderSizePixel = 0
					Dropdown.ClipsDescendants = true
					Dropdown.Position = UDim2.new(0.0287769791, 0, 0.335000008, 0)
					Dropdown.Size = UDim2.new(1, -20, 0, 30)
					Dropdown.Font = Enum.Font.SourceSansSemibold
					Dropdown.Text = ""
					Dropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
					Dropdown.TextSize = 14.000
					
					Title.Name = "Title"
					Title.Parent = Dropdown
					Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title.BackgroundTransparency = 1.000
					Title.Size = UDim2.new(1, 0, 0, 30)
					Title.Font = Enum.Font.SourceSansSemibold
					Title.Text = "   "..dropdowntable["Title"]..": nil"
					Title.TextColor3 = Color3.fromRGB(70, 70, 70)
					Title.TextSize = 18.000
					Title.TextXAlignment = Enum.TextXAlignment.Left
					
					Icon.Name = "Icon"
					Icon.Parent = Dropdown
					Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Icon.BackgroundTransparency = 1.000
					Icon.Position = UDim2.new(0.889999986, 0, 0, 0)
					Icon.Size = UDim2.new(0, 30, 0, 30)
					Icon.Image = "rbxassetid://3926305904"
					Icon.ImageRectOffset = Vector2.new(444, 844)
					Icon.ImageRectSize = Vector2.new(36, 36)
					
					CDropdown.CornerRadius = UDim.new(0, 4)
					CDropdown.Name = "CDropdown"
					CDropdown.Parent = Dropdown
					
					DropdownScoll.Name = "DropdownScoll"
					DropdownScoll.Parent = Dropdown
					DropdownScoll.Active = true
					DropdownScoll.AnchorPoint = Vector2.new(0.5, 0)
					DropdownScoll.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
					DropdownScoll.BorderSizePixel = 0
					DropdownScoll.Position = UDim2.new(0.5, 0, 0, 30)
					DropdownScoll.Size = UDim2.new(0, 300, 0, 90)
					DropdownScoll.ScrollBarThickness = 6
					
					LDropdown.Name = "LDropdown"
					LDropdown.Parent = DropdownScoll
					LDropdown.HorizontalAlignment = Enum.HorizontalAlignment.Center
					LDropdown.SortOrder = Enum.SortOrder.LayoutOrder
					return Dropdown
				end)()
				Dropdown.DropdownScoll.LDropdown:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					local absoluteSize =  Dropdown.DropdownScoll.LDropdown.AbsoluteContentSize
					Dropdown.DropdownScoll.CanvasSize = UDim2.new(0, 0, 0, absoluteSize.Y+10)
				end)
				local Dropdownfunc = {Opend=false}
				Dropdown.MouseButton1Click:Connect(function()
					if not Dropdownfunc["Opend"] then
						Dropdownfunc["Opend"] = true
						game:GetService("TweenService"):Create(Dropdown.Icon,TweenInfo.new(0.1,Enum.EasingStyle.Linear),{Rotation = 90}):Play()
						game:GetService("TweenService"):Create(Dropdown,TweenInfo.new(0.1,Enum.EasingStyle.Linear),{Size = UDim2.new(1,-20,0,130)}):Play()
					else
						Dropdownfunc["Opend"] = false
						game:GetService("TweenService"):Create(Dropdown.Icon,TweenInfo.new(0.1,Enum.EasingStyle.Linear),{Rotation = 0}):Play()
						game:GetService("TweenService"):Create(Dropdown,TweenInfo.new(0.1,Enum.EasingStyle.Linear),{Size = UDim2.new(1,-20,0,30)}):Play()
					end
				end)
				function Dropdownfunc:Add(v)
					local Option = Instance.new("TextButton")
					local Line = Instance.new("Frame")

					Option.Name = "Option"
					Option.Parent = Dropdown.DropdownScoll
					Option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Option.BackgroundTransparency = 1.000
					Option.Text = v
					Option.Size = UDim2.new(1, -20, 0, 20)
					Option.Font = Enum.Font.SourceSansSemibold
					Option.TextColor3 = Color3.fromRGB(70, 70, 70)
					Option.TextSize = 14.000
					
					Line.Name = "Line"
					Line.Parent = Dropdown.DropdownScoll
					Line.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
					Line.BorderSizePixel = 0
					Line.Size = UDim2.new(1, -20, 0, 1)
					Option.MouseButton1Click:Connect(function()
						for i,v in pairs(Dropdown.DropdownScoll:GetChildren()) do
							if v:IsA("TextButton") then
								v.TextColor3 = Color3.fromRGB(70, 70, 70)
							end
						end
						Option.TextColor3 = Color3.fromRGB(30, 30, 30)
						Dropdown.Title.Text = "   "..dropdowntable["Title"]..": "..v
						dropdowntable["Callback"](v)
					end)
				end
				function Dropdownfunc:New(c)
					for i,v in pairs(Dropdown.DropdownScoll:GetChildren()) do
						if v:IsA("TextButton") or v.Name == "Line" then
							v:Destroy()
						end
					end
					for i,v in pairs(c) do
						Dropdownfunc:Add(v)
					end
				end
				for i,v in pairs(dropdowntable["Table"]) do
					Dropdownfunc:Add(v)
				end
				return Dropdownfunc
			end
			function ObjectFunc:CreateaSlider(slidertable)
				local Slider = (function()
					local Slider = Instance.new("TextButton")
					local Title = Instance.new("TextLabel")
					local CSliderM = Instance.new("UICorner")
					local SliderFrame = Instance.new("Frame")
					local CSliderF = Instance.new("UICorner")
					local SliderDrag = Instance.new("Frame")
					local CSliderD = Instance.new("UICorner")
					local Icon = Instance.new("ImageLabel")
					local Box = Instance.new("TextBox")


					Slider.Name = "Slider"
					Slider.Parent = Section
					Slider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
					Slider.BorderSizePixel = 0
					Slider.Position = UDim2.new(0.0287769791, 0, 0.335000008, 0)
					Slider.Size = UDim2.new(1, -20, 0, 50)
					Slider.Font = Enum.Font.SourceSansSemibold
					Slider.Text = ""
					Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
					Slider.TextSize = 14.000

					Title.Name = "Title"
					Title.Parent = Slider
					Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title.BackgroundTransparency = 1.000
					Title.Size = UDim2.new(1, 0, 0, 30)
					Title.Font = Enum.Font.SourceSansSemibold
					Title.Text = "   "..slidertable["Title"]
					Title.TextColor3 = Color3.fromRGB(70, 70, 70)
					Title.TextSize = 18.000
					Title.TextXAlignment = Enum.TextXAlignment.Left

					CSliderM.CornerRadius = UDim.new(0, 4)
					CSliderM.Name = "CSliderM"
					CSliderM.Parent = Slider

					SliderFrame.Name = "SliderFrame"
					SliderFrame.Parent = Slider
					SliderFrame.AnchorPoint = Vector2.new(0.5, 0)
					SliderFrame.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
					SliderFrame.BorderSizePixel = 0
					SliderFrame.Position = UDim2.new(0.5, 0, 0.699999988, 0)
					SliderFrame.Size = UDim2.new(0, 300, 0, 5)

					CSliderF.Name = "CSliderF"
					CSliderF.Parent = SliderFrame

					SliderDrag.Name = "SliderDrag"
					SliderDrag.Parent = SliderFrame
					SliderDrag.BackgroundColor3 = Color3.fromRGB(79, 195, 247)
					SliderDrag.BorderSizePixel = 0
					SliderDrag.Size = UDim2.new(1, 0, 1, 0)

					CSliderD.Name = "CSliderD"
					CSliderD.Parent = SliderDrag

					Icon.Name = "Icon"
					Icon.Parent = SliderDrag
					Icon.AnchorPoint = Vector2.new(0, 0.5)
					Icon.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
					Icon.BackgroundTransparency = 1.000
					Icon.Position = UDim2.new(0.970000029, 0, 0.5, 0)
					Icon.Size = UDim2.new(0, 15, 0, 15)
					Icon.Image = "rbxassetid://3926307971"
					Icon.ImageColor3 = Color3.fromRGB(85, 170, 255)
					Icon.ImageRectOffset = Vector2.new(644, 44)
					Icon.ImageRectSize = Vector2.new(36, 36)

					Box.Name = "Box"
					Box.Parent = Slider
					Box.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
					Box.BorderSizePixel = 0
					Box.Position = UDim2.new(0.730708659, 0, 0.155555561, 0)
					Box.Size = UDim2.new(0, 78, 0, 18)
					Box.Font = Enum.Font.SourceSansSemibold
					Box.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
					Box.ClearTextOnFocus = false
					Box.Text = ""
					Box.TextColor3 = Color3.fromRGB(255, 255, 255)
					Box.TextSize = 14.000
					return Slider
				end)()
				local GlobalSliderValue = 0
				local Dragging = false
				local function Sliding(Input)
                    local Position = UDim2.new(math.clamp((Input.Position.X - Slider.SliderFrame.AbsolutePosition.X) / Slider.SliderFrame.AbsoluteSize.X,0,1),0,1,0)
                    Slider.SliderFrame.SliderDrag.Size = Position
					local SliderPrecise = ((Position.X.Scale * slidertable["Max"]) / slidertable["Max"]) * (slidertable["Max"] - slidertable["Min"]) + slidertable["Min"]
					local SliderNonPrecise = math.floor(((Position.X.Scale * slidertable["Max"]) / slidertable["Max"]) * (slidertable["Max"] - slidertable["Min"]) + slidertable["Min"])
                    local SliderValue = slidertable["Precise"] and SliderNonPrecise or SliderPrecise
					SliderValue = tonumber(string.format("%.2f", SliderValue))
					GlobalSliderValue = SliderValue
                    Slider.Box.Text = tostring(SliderValue)
                    slidertable["Callback"](GlobalSliderValue)
                end
				local function SetValue(Value)
					GlobalSliderValue = Value
					Slider.SliderFrame.SliderDrag.Size = UDim2.new(Value / slidertable["Max"],0,1,0)
					Slider.Box.Text = Value
					slidertable["Callback"](Value)
				end
				SetValue(slidertable["Precise"])
				Slider.Box.FocusLost:Connect(function()
					if not tonumber(Slider.Box.Text) then
						Slider.Box.Text = GlobalSliderValue
					elseif Slider.Box.Text == "" or tonumber(Slider.Box.Text) <= slidertable["Min"] then
						Slider.Box.Text = slidertable["Min"]
					elseif Slider.Box.Text == "" or tonumber(Slider.Box.Text) >= slidertable["Max"] then
						Slider.Box.Text = slidertable["Max"]
					end
		
					GlobalSliderValue = Slider.Box.Text
					Slider.SliderFrame.SliderDrag.Size = UDim2.new(Slider.Box.Text / slidertable["Max"],0,1,0)
					slidertable["Callback"](tonumber(Slider.Box.Text))
				end)
				Slider.SliderFrame.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Sliding(Input)
						Dragging = true
                    end
                end)

				Slider.SliderFrame.InputEnded:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Dragging = false
                    end
                end)
				game:GetService("UserInputService").InputChanged:Connect(function(Input)
					if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
						Sliding(Input)
					end
				end)
			end
			return ObjectFunc
		end
		return SectionFunc
	end
	return PageFunction
end


local Sawhub = Lib:CreateWindow({
	Title = "Saw Hub",
	Keybind = Enum.KeyCode.RightControl
})


local Main = Sawhub:CreatePage({Title = "Main"})
local MainSection = Main:CreateSection({Title = "Auto Farm"})

MainSection:CreateButton({Title="Unlock Island",Callback=function()
    UnlockIsland()
end})
local island_farm={}

for i,v in pairs(workspace.Worlds["The Overworld"].Islands:GetChildren()) do
       
    table.insert(island_farm,v.Name)
end

local DropLane = MainSection:CreateDropdown({Title = "Select Island Farm",Table = island_farm,Callback = function (v)
    getgenv().Configs.SelectIsland=v
end})

MainSection:CreateToggle({Title="Auto Farm",Enable=getgenv().Configs.AutoFarm,Callback=function(v)
    getgenv().Configs.AutoFarm=v
end})

MainSection:CreateToggle({Title="Auto Bubble",Enable=getgenv().Configs.AutoBubble,Callback=function(v)
    getgenv().Configs.AutoBubble=v
end})

MainSection:CreateToggle({Title="Auto Collect",Enable=getgenv().Configs.AutoCollect,Callback=function(v)
    getgenv().Configs.AutoCollect=v
end})

local eggpos = {
	["Nightmare Egg"]=CFrame.new(-17.5698757, 10148.1084, 186.612473),
	["Rainbow Egg"]=CFrame.new(-34.4163857, 15972.7217, 43.4907036),
	["Void Egg"]=CFrame.new(7.74198961, 10148.1748, 186.165726)
}

local DropLane = MainSection:CreateDropdown({Title = "Select Egg",Table = {"Rainbow Egg","Nightmare Egg","Void Egg"},Callback = function (v)
    getgenv().Configs.SelectEgg=v
end})

MainSection:CreateToggle({Title="Auto Egg",Enable=getgenv().Configs.AutoEgg,Callback=function(v)
    getgenv().Configs.AutoEgg=v
end})

MainSection:CreateToggle({Title="Auto Equip Best",Enable=getgenv().Configs.AutoEquipBest,Callback=function(v)
    getgenv().Configs.AutoEquipBest=v
end})

MainSection:CreateToggle({Title="Auto Use Potion",Enable=getgenv().Configs.AutoUsePotion,Callback=function(v)
    getgenv().Configs.AutoUsePotion=v
end})

MainSection:CreateToggle({Title="Auto Claim Gift",Enable=getgenv().Configs.AutoClaimGift,Callback=function(v)
    getgenv().Configs.AutoClaimGift=v
end})

MainSection:CreateToggle({Title="Auto Playtime",Enable=getgenv().Configs.AutoPlaytime,Callback=function(v)
    getgenv().Configs.AutoPlaytime=v
end})

MainSection:CreateToggle({Title="Auto Mastery",Enable=getgenv().Configs.AutoMastery,Callback=function(v)
    getgenv().Configs.AutoMastery=v
end})

MainSection:CreateToggle({Title="Auto Hatch Powerup Egg",Enable=getgenv().Configs.AutoHateeggpr,Callback=function(v)
    getgenv().Configs.AutoHateeggpr=v
end})

MainSection:CreateToggle({Title="Auto Buy Gum",Enable=getgenv().Configs.AutoBuyGum,Callback=function(v)
    getgenv().Configs.AutoBuyGum=v
end})

MainSection:CreateToggle({Title="Auto Alen Shop",Enable=getgenv().Configs.AutoBuyAllienShop,Callback=function(v)
    getgenv().Configs.AutoBuyAllienShop=v
end})


local Misc = Sawhub:CreatePage({Title="Misc"})
local MiscSec = Misc:CreateSection({Title="Others"})

MiscSec:CreateButton({Title="Open/close enchant ui",Callback=function()
	game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Enchants.Visible = not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Enchants.Visible
end})

MiscSec:CreateButton({Title="Rejoin",Callback=function()
	game:GetService("TeleportService"):Teleport(game.PlaceId,game.Players.LocalPlayer)
end})

function ClaimGift()
    for i=10,1,-1 do
		local args = {
			[1] = "UseGift",
			[2] = "Mystery Box",
			[3] = i
		}
	
		game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
	
		wait(1)
		for i,v in pairs(workspace.Rendered.Gifts:GetChildren()) do
			local args = {
				[1] = "ClaimGift",
				[2] = v.Name
			}
	
			game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
			wait()
			v:Destroy()
		end
	end
end

function ClaimPlaytime()
	for i =1,9 do
		local args = {
			[1] = "ClaimPlaytime",
			[2] = i
		}
		
		game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function"):InvokeServer(unpack(args))
	end
end

function AutoHateeggpr()
	for i =10,1,-1 do
		local args = {
			[1] = "HatchPowerupEgg",
			[2] = "Season 1 Egg",
			[3] = i
		}
	
		game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

	end
end

task.spawn(function()
	while wait() do
		if getgenv().Configs.AutoHateeggpr then
			AutoHateeggpr()
		end
	end
end)

function AutoMastery()
	local args = {
		[1] = "UpgradeMastery",
		[2] = "Pets"
	}
	
	game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
	
	local args = {
		[1] = "UpgradeMastery",
		[2] = "Buffs"
	}
	
	game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
end

task.spawn(function()
	while wait(1) do
		if getgenv().Configs.AutoMastery then
			AutoMastery()
			wait(60)
		end
	end
end)
task.spawn(function()
	while wait(1) do
		if getgenv().Configs.AutoClaimGift then
			ClaimGift()
			wait(300)
		end
	end
end)

task.spawn(function()
	while wait(1) do
		if getgenv().Configs.AutoPlaytime then
			ClaimPlaytime()
			wait(300)
		end
	end
end)


function GetCoins()
    local text = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Currency.Coins.Frame.Label.Text
    local text1,i=text:gsub(",", "")
    return tonumber(text1)
end

local allGum={
    [1]={Name="Basic Gum",Amount=0},
    [2]={Name="Stretchy Gum",Amount=25},
    [3]={Name="Chewy Gum",Amount=250},
    [4]={Name="Epic Gum",Amount=1500},
    [5]={Name="Ultra Gum",Amount=5000},
    [6]={Name="Omega Gum",Amount=12000},
    [7]={Name="Unreal Gum",Amount=45000},
    [8]={Name="Cosmic Gum",Amount=125000},
    [9]={Name="XL Gum",Amount=650000},
    [10]={Name="Mega Gum",Amount=1500000},
    [11]={Name="Quantum Gum",Amount=5000000},
    [12]={Name="Alien Gum",Amount=35000000},
    [13]={Name="Radioactive Gum",Amount=150000000},
    [14]={Name="Experiment #52",Amount=1000000000},
}

local allFlavor={
    [1]={Name="Bubble Gum",Amount=0},
    [2]={Name="Blueberry",Amount=25},
    [3]={Name="Cherry",Amount=500},
    [4]={Name="Pizza",Amount=1500},
    [5]={Name="Watermelon",Amount=3500},
    [6]={Name="Chocolate",Amount=10000},
    [7]={Name="Contrast",Amount=35000},
    [8]={Name="Gold",Amount=100000},
    [9]={Name="Lemon",Amount=450000},
    [10]={Name="Donut",Amount=1500000},
    [11]={Name="Swirl",Amount=30000000},
    [12]={Name="Molten",Amount=350000000},
}

local player=game.Players.LocalPlayer
function EquipGumBest()
    for i = #allGum, 1, -1 do
        local gum = allGum[i]
        local args = {
            [1] = "UpdateStorage",
            [2] = gum.Name
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
        task.wait(0.5)
        print(player:GetAttribute("Bubble"),gum.Name)
        if string.find(player:GetAttribute("Bubble"),gum.Name) then
            break
        end
    end
end

function EquipFlavorBest()
    for i = #allFlavor, 1, -1 do
        local flavor = allFlavor[i]
        local args = {
            [1] = "UpdateFlavor",
            [2] = flavor.Name
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
        task.wait(0.5)

        if string.find(player:GetAttribute("Bubble"),flavor.Name) then
            break
        end
    end
end

function BuyGumGood()
    local goodgum
    for i,v in pairs(allGum) do
        if GetCoins() >= v.Amount then
            goodgum=v.Name
        else
            break
        end
    end
    local args = {
        [1] = "GumShopPurchase",
        [2] = goodgum
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
    EquipGumBest()
end

function BuyFlavorGood()
    local goodflavor
    for i,v in pairs(allFlavor) do
        if GetCoins() >= v.Amount then
            goodflavor=v.Name
        else
            break
        end
    end
    local args = {
        [1] = "GumShopPurchase",
        [2] = goodflavor
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
    EquipFlavorBest()
end

task.spawn(function()
    while wait(3) do
		if getgenv().Configs.AutoBuyGum then
			BuyGumGood()

			BuyFlavorGood()
		end
    end
end)

function UnlockIsland()
    for _,__ in pairs(workspace.Worlds["The Overworld"].Islands:GetChildren()) do
        for i,v in pairs(workspace.Worlds["The Overworld"].Islands:GetChildren()) do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=v.Island.UnlockHitbox.CFrame
            wait(0.3)
        end
    end
end
local acoconma=require(game:GetService("ReplicatedStorage").Shared.Data.Buffs)
function UsePotion()

    for i,v in acoconma do
        for kuku=1,6 do
            local args = {
                [1] = "UsePotion",
                [2] = i,
                [3] = kuku
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            
        end
        
    end
end
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
			wait(0.01)
		end
	end
end	


task.spawn(function()
    while wait(1) do
        if getgenv().Configs.AutoUsePotion then
			FuseBoost()
            UsePotion()
			wait(300)
        end
    end
end)

task.spawn(function()
    while wait(0.5) do
        if getgenv().Configs.AutoEgg then
			TP(eggpos[getgenv().Configs.SelectEgg])
            local args = {
                [1] = "HatchEgg",
                [2] = getgenv().Configs.SelectEgg,
                [3] = 5
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
        end
    end
end)
task.spawn(function()
    while wait(3) do
        if getgenv().Configs.AutoEquipBest then
            local args = {
                [1] = "EquipBestPets"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
        end
    end
end)
task.spawn(function()
    while wait(1) do
        if getgenv().Configs.AutoFarm then
            local args = {
                [1] = "Teleport",
                
                [2] =  "Workspace.Worlds.The Overworld.Islands."..getgenv().Configs.SelectIsland..".Island.Portal.Spawn"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
        end
    end
end)

task.spawn(function()
    while wait(.5) do
        if getgenv().Configs.AutoCollect or getgenv().Configs.AutoFarm then
            for i,v in pairs(workspace.Rendered:GetChildren()) do
                if v.Name=="Chunker" then
                    for _,block in pairs(v:GetChildren()) do
                        if string.find(block.Name,"-")  then

                            local args = {
                                [1] = block.Name
                            }


                            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup"):FireServer(unpack(args))
							block:Destroy()
                        end
                    end
                end
            end
        end
    end
end)

function BuyAllienShop()
	for i =1,3 do

		local args = {
			[1] = "BuyShopItem",
			[2] = "alien-shop",
			[3] = i
		}
		
		game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
	end
end




task.spawn(function()
	while wait(1) do
		if getgenv().Configs.AutoBuyAllienShop then
			BuyAllienShop()
			wait(60)
		end
	end
end)

function sell()
    local args = {
        [1] = "SellBubble"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
end

function bubble()
    local args = {
        [1] = "BlowBubble"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
end
local player = game:GetService("Players").LocalPlayer
local TS=game:GetService("TweenService")
function TP(cf)
    local besttp
    local bestpos=math.huge
    for i,v in pairs(workspace.Worlds["The Overworld"].Islands:GetChildren()) do
       
        if (cf.Position-v.Island.UnlockHitbox.Position).Magnitude < (cf.Position-player.Character.HumanoidRootPart.Position).Magnitude and (cf.Position-v.Island.UnlockHitbox.Position).Magnitude<bestpos then
            bestpos=(cf.Position-v.Island.UnlockHitbox.Position).Magnitude
            besttp="Workspace.Worlds.The Overworld.Islands."..v.Name..".Island.Portal.Spawn"
    
        end
    end
    local vitridacbiet=workspace.Worlds["The Overworld"].SpawnLocation.Position
    if (cf.Position-vitridacbiet).Magnitude < (cf.Position-player.Character.HumanoidRootPart.Position).Magnitude and (cf.Position-vitridacbiet).Magnitude<bestpos then
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
        
    end

    local times = (player.Character.HumanoidRootPart.Position - cf.Position).Magnitude / 20
    local tween = TS:Create(player.Character.HumanoidRootPart, TweenInfo.new(times,Enum.EasingStyle.Linear), {CFrame = cf})
    tween:Play()

    while (player.Character.HumanoidRootPart.Position - cf.Position).Magnitude >= 5 do
        task.wait(0.1)
    end

end
timesell=tick()
task.spawn(function()
    while wait(.1) do
        if getgenv().Configs.AutoBubble or getgenv().Configs.AutoFarm then
            if tick()-timesell>5 then
                sell()
                timesell=tick()
            end
            bubble()
        end
    end
end)

task.spawn(function()
	while wait(1) do
		local args = {
			[1] = "ClaimChest",
			[2] = "Void Chest"
		}
		
		game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
		wait(60)
	end
end)
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local v1 = game:GetService("ReplicatedStorage")
local v_u_5 = require(v1.Shared.Framework.Network.Remote)

function webhook(a,c,b)
    local msg = {
        ["embeds"] = {{
            ["title"] = "Saw Hub",
            ["description"]="Account: ||"..game.Players.LocalPlayer.Name.."||",
            ["fields"] = {
                {
                    ["name"] = "Name :",
                    ["value"] = "```"..a.."```",
                    ["inline"] = true
                },
                {
                    ["name"] = "Shiny :",
                    ["value"] = "```"..c.."```",
                    ["inline"] = true
                },
                {
                    ["name"] = "Mythic :",
                    ["value"] = "```"..b.."```",
                    ["inline"] = true
                }
            }, 
            ["type"] = "rich",
            ["color"] = tonumber(47103),
            ["footer"] = {
                ["text"] = "Saw Hub (" .. os.date("%X") .. ")"
            }
        }}
    }
    request({
        Url ="https://discord.com/api/webhooks/1360617343499370768/xfso2SpxQYsRMwjg-CEp2vzDqAWYjeDU8rS8wDe3xQSJgORwHHXrriRBw5kMGeT_6InN",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(msg)
    })
end
v_u_5.Event("HatchEgg"):Connect(function(p13)
    if p13 then
        for _, v14 in p13.Pets do
            if not v14.Deleted then
                local v15 = v14.Pet
                webhook(v15.Name,tostring(v15.Shiny),tostring(v15.Mythic))

            end
        end
    end
end)

game:GetService("ReplicatedStorage").Remotes.Pickups.SpawnPickups.OnClientEvent:Connect(function(v)
	for i,c in v do
		local args = {
			[1] = c.Id
		}


		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup"):FireServer(unpack(args))
	end
end)
