local MainUI={}

local TS = game:GetService("TweenService")
local plr = game:GetService("Players").LocalPlayer
local Mouse = plr:GetMouse()
local UIS = game:GetService("UserInputService")
local Tweeninfo = TweenInfo.new
local MainUI={}

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

function Pop(object, shrink, position)
	local clone = object:Clone()

	-- Tạo hiệu ứng tròn bằng cách chỉnh CornerRadius
	clone.AnchorPoint = Vector2.new(0.5, 0.5)
	clone.Size = UDim2.new(0, shrink, 0, shrink)
	clone.Position = UDim2.new(0, position.X, 0, position.Y)

	-- Thiết lập màu sắc cho clone (màu trắng)
	clone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	clone.BackgroundTransparency = 0

	-- Tạo CornerRadius để clone thành hình tròn
	clone.UICorner = Instance.new("UICorner")
	clone.UICorner.CornerRadius = UDim.new(1, 0)  -- Tạo hình tròn hoàn hảo
	clone.UICorner.Parent = clone

	-- Đặt clone vào vị trí của object
	clone.Parent = object.Parent

	-- Ẩn đối tượng gốc (tạm thời)
	object.BackgroundTransparency = 1

	-- Phóng to clone từ kích thước nhỏ lên
	TweenObject(clone, {Size = object.Size}, 0.5)

	-- Sau khi hiệu ứng hoàn thành, trả lại background của đối tượng gốc và destroy clone
	spawn(function()
		wait(0.5)
		object.BackgroundTransparency = 0
		clone:Destroy()
	end)

	return clone
end


function MainUI:CreateWindow(win_val : {})
	local UI = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Bar = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local ListTab = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local Pages = Instance.new("Frame")
	local TitleTab = Instance.new("TextLabel")
	local UICorner_2 = Instance.new("UICorner")
	local Line = Instance.new("Frame")
	local close = Instance.new("ImageButton")
	local UIScale = Instance.new("UIScale")

	UI.Name = "UI"
	UI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Main.Name = "Main"
	Main.Parent = UI
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 500, 0, 300)
	UIScale.Parent=Main
	UICorner.Parent = Main

	Bar.Name = "Bar"
	Bar.Parent = Main
	Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Bar.BackgroundTransparency = 1.000
	Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Bar.BorderSizePixel = 0
	Bar.Size = UDim2.new(0, 500, 0, 35)

	Title.Name = "Title"
	Title.Parent = Bar
	Title.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
	Title.BackgroundTransparency = 1.000
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.BorderSizePixel = 0
	Title.Size = UDim2.new(0, 135, 0, 35)
	Title.Font = Enum.Font.SourceSansBold
	Title.Text = "    "..win_val.title
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 23.000
	Title.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextXAlignment = Enum.TextXAlignment.Left

	ListTab.Name = "ListTab"
	ListTab.Parent = Main
	ListTab.Active = true
	ListTab.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
	ListTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ListTab.BorderSizePixel = 0
	ListTab.Position = UDim2.new(0, 0, 0.117, 0)
	ListTab.Size = UDim2.new(0, 135, 0, 260)
	ListTab.ScrollBarThickness = 0

	UIListLayout.Parent = ListTab
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)
	
	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ListTab.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y+5)
	end)
	
	UIPadding.Parent = ListTab
	UIPadding.PaddingTop = UDim.new(0, 5)

	Pages.Name = "Pages"
	Pages.Parent = Main
	Pages.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
	Pages.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Pages.BorderSizePixel = 0
	Pages.Position = UDim2.new(0.27, 0, 0, 0)
	Pages.Size = UDim2.new(0, 365, 0, 300)

	TitleTab.Parent = Pages
	TitleTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleTab.BackgroundTransparency = 1.000
	TitleTab.Name="TitleTab"
	TitleTab.BorderColor3 = Color3.fromRGB(255, 255, 255)
	TitleTab.Size = UDim2.new(1, 0, 0, 35)
	TitleTab.Font = Enum.Font.RobotoMono
	TitleTab.Text = " #None"
	TitleTab.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleTab.TextSize = 23.000
	TitleTab.TextXAlignment = Enum.TextXAlignment.Left

	UICorner_2.Parent = Pages

	Line.Name = "Line"
	Line.Parent = Main
	Line.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 0, 0.117, 0)
	Line.Size = UDim2.new(1, 0, 0, 1)

	close.Name = "close"
	close.Parent = Main
	close.BackgroundTransparency = 1.000
	close.Position = UDim2.new(0.93, 0, 0.015, 0)
	close.Size = UDim2.new(0, 25, 0, 25)
	close.Image = "rbxassetid://3926305904"
	close.ImageRectOffset = Vector2.new(284, 4)
	close.ImageRectSize = Vector2.new(24, 24)
	
	local mobilesp = Instance.new("TextButton")

	mobilesp.Name = "mobilesp"
	mobilesp.Parent = UI
	mobilesp.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
	mobilesp.BorderColor3 = Color3.fromRGB(0, 0, 0)
	mobilesp.BorderSizePixel = 0
	mobilesp.Position = UDim2.new(0.0, 0, 0.0, 0)
	mobilesp.Size = UDim2.new(0, 50, 0, 50)
	mobilesp.AutoButtonColor = false
	mobilesp.Font = Enum.Font.SourceSans
	mobilesp.Text = "Open/close"
	mobilesp.TextColor3 = Color3.fromRGB(255, 255, 255)
	mobilesp.TextSize = 14.000
	mobilesp.TextWrapped = true
	
	DraggingEnabled(Bar,Main)
	DraggingEnabled(mobilesp,mobilesp)
	
	local Opend = false
	local ToggleKey = win_val["Keybind"] or Enum.KeyCode.RightControl
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
	mobilesp.MouseButton1Click:Connect(function()
		ToggleUI({KeyCode = ToggleKey})
	end)
	close.MouseButton1Click:Connect(function()
		ToggleUI({KeyCode = ToggleKey})
	end)
	local pages={}
	local start_section=false
	
	function pages:CreatePage(page_val)
		local PageFrame = Instance.new("Frame")
		local open = Instance.new("TextButton")
		local arrow = Instance.new("ImageLabel")
		local UIListLayout_2 = Instance.new("UIListLayout")

		PageFrame.Name = "PageFrame"
		PageFrame.Parent = ListTab
		PageFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		PageFrame.BackgroundTransparency = 1.000
		PageFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		PageFrame.BorderSizePixel = 0
		PageFrame.ClipsDescendants = true
		PageFrame.Size = UDim2.new(1, -10, 0, 30)

		open.Name = "open"
		open.Parent = PageFrame
		open.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		open.BorderColor3 = Color3.fromRGB(0, 0, 0)
		open.BorderSizePixel = 0
		open.Size = UDim2.new(1, 0, 0, 30)
		open.Font = Enum.Font.RobotoMono
		open.Text = page_val.title
		open.TextColor3 = Color3.fromRGB(255, 255, 255)
		open.TextSize = 20.000
		
		open.MouseButton1Click:Connect(function()
			if arrow.Rotation==0 then
				TS:Create(PageFrame,TweenInfo.new(.1,Enum.EasingStyle.Linear),{Size=UDim2.new(1,-10,0,30)}):Play()
				TS:Create(arrow,TweenInfo.new(.1,Enum.EasingStyle.Linear),{Rotation=-90}):Play()
			else if arrow.Rotation==-90 then
					TS:Create(PageFrame,TweenInfo.new(.1,Enum.EasingStyle.Linear),{Size=UDim2.new(1,-10,0,UIListLayout_2.AbsoluteContentSize.Y+5)}):Play()
					TS:Create(arrow,TweenInfo.new(.1,Enum.EasingStyle.Linear),{Rotation=0}):Play()
				end
			end
		end)

		arrow.Name = "arrow"
		arrow.Parent = open
		arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		arrow.BackgroundTransparency = 1.000
		arrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
		arrow.BorderSizePixel = 0
		arrow.Position = UDim2.new(1, -25, 0, 4)
		arrow.Rotation = -90.000
		arrow.Size = UDim2.new(0, 25, 0, 25)
		arrow.Image = "rbxassetid://3926305904"
		arrow.ImageRectOffset = Vector2.new(404, 284)
		arrow.ImageRectSize = Vector2.new(36, 36)

		UIListLayout_2.Parent = PageFrame
		UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 5)
		
		local sections = {}
		
		local function disableallpage()
			for i,v in pairs(Pages:GetChildren()) do
				if v.Name~="UICorner" and v.Name~="TitleTab" then
					v.Visible=false
				end
			end
			for i,v in pairs(ListTab:GetDescendants()) do
				if v.Name=="Sec" then
					TS:Create(v,Tweeninfo(0.05),{BackgroundColor3=Color3.fromRGB(18, 18, 20)}):Play()
				end
			end
		end
		
		function sections:CreateSection(sec_val)			
			sec_val.title=string.gsub(sec_val.title, " ", "-")
			local Page = Instance.new("ScrollingFrame")
			local u = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")
			local Sec = Instance.new("TextButton")
			


			Sec.Name = "Sec"
			Sec.Parent = PageFrame
			Sec.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
			Sec.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Sec.BorderSizePixel = 0
			Sec.Position = UDim2.new(0, 0, 0, 70)
			Sec.Size = UDim2.new(1, 0, 0, 30)
			Sec.Font = Enum.Font.RobotoMono
			Sec.Text = "# "..sec_val.title
			Sec.AutoButtonColor=false
			Sec.TextColor3 = Color3.fromRGB(255, 255, 255)
			Sec.TextSize = 18.000
			Sec.TextWrapped = true
			
			Sec.MouseButton1Click:Connect(function()
				disableallpage()
				TS:Create(Sec,Tweeninfo(0.1),{BackgroundColor3=Color3.fromRGB(30, 30, 30)}):Play()
				Page.Visible=true
				TitleTab.Text=" #"..sec_val.title
			end)
			
			Page.Name = "Page"
			Page.Parent = Pages
			Page.Active = true
			Page.Visible=false
			Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Page.BackgroundTransparency = 1.000
			Page.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Page.BorderSizePixel = 0
			Page.Position = UDim2.new(0, 0, 0.12, 0)
			Page.Size = UDim2.new(0, 365, 0, 264)
			Page.ScrollBarThickness = 3
			if not start_section then
				disableallpage()
				TS:Create(Sec,Tweeninfo(0.1),{BackgroundColor3=Color3.fromRGB(30, 30, 30)}):Play()
				Page.Visible=true
				TitleTab.Text=" #"..sec_val.title
				start_section=true
			end
			u.Parent = Page
			u.HorizontalAlignment = Enum.HorizontalAlignment.Center
			u.SortOrder = Enum.SortOrder.LayoutOrder
			u.Padding = UDim.new(0, 5)

			u:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Page.CanvasSize = UDim2.new(0, 0, 0, u.AbsoluteContentSize.Y+10)
			end)

			UIPadding.Parent = Page
			UIPadding.PaddingTop = UDim.new(0, 5)
			
			local callback_func= {}
			
			function callback_func:CreateButton(button_val)
				local Button = Instance.new("Frame")
				local Click = Instance.new("TextButton")


				Button.Name = "Button"
				Button.Parent = Page
				Button.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
				Button.BackgroundTransparency = 1.000
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.Size = UDim2.new(1, -10, 0, 30)

				Click.Name = "Click"
				Click.Parent = Button
				Click.AnchorPoint = Vector2.new(0.5, 0.5)
				Click.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
				Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Click.BorderSizePixel = 0
				Click.Position = UDim2.new(0.5, 0, 0.5, 0)
				Click.Size = UDim2.new(1, 0, 1, 0)
				Click.Font = Enum.Font.RobotoMono
				Click.AutoButtonColor=false
				Click.Text = button_val.title
				Click.TextColor3 = Color3.fromRGB(255, 255, 255)
				Click.TextSize = 20.000
				
				Click.MouseButton1Click:Connect(function(input)
					button_val.callback()
					TweenObject(Click, {Size = UDim2.new(0.95,0,0.9,0)}, 0.1)
					wait(0.1)
					TweenObject(Click, {Size = UDim2.new(1,0,1,0)}, 0.1)
				end)
			end
			
			function callback_func:CreateToggle(toggle_val)
				local Toggle = Instance.new("TextButton")
				local Frame = Instance.new("Frame")
				local UIStroke=Instance.new("UIStroke")
				
				UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
				UIStroke.Color=Color3.fromRGB(85, 85, 85)
				UIStroke.Thickness=2
				UIStroke.Parent=Frame

				Toggle.Name = "Toggle"
				Toggle.Parent = Page
				Toggle.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(0.0164383557, 0, 0, 0)
				Toggle.AutoButtonColor=false
				Toggle.Size = UDim2.new(1, -10, 0, 30)
				Toggle.Font = Enum.Font.RobotoMono
				Toggle.Text = " "..toggle_val.title
				Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.TextSize = 20.000
				Toggle.TextXAlignment = Enum.TextXAlignment.Left

				Frame.Parent = Toggle
				Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Frame.BackgroundTransparency = 1.000
				Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Frame.BorderSizePixel = 0
				Frame.Position = UDim2.new(0.926760554, 0, 0.233333334, 0)
				Frame.Size = UDim2.new(0, 16, 0, 16)
				
				local toggled=false
				
				local togglecall={}
				function togglecall:Set(val)
					toggled=val
					toggle_val.callback(toggled)
					if toggled then
						TweenObject(Frame,{BackgroundTransparency=0},.1)
					else
						TweenObject(Frame,{BackgroundTransparency=1},.1)
					end
				end
				togglecall:Set(toggle_val.default or false)
				
				Toggle.MouseButton1Click:Connect(function()
					toggled=not toggled
					togglecall:Set(toggled)
				end)
				return togglecall
			end
			
			function callback_func:CreateDropdown(drop_val)
				local Dropdown = Instance.new("TextButton")
				local arr = Instance.new("ImageLabel")
				local titledrop = Instance.new("TextLabel")
				local ItemsList = Instance.new("ScrollingFrame")
				local U2 = Instance.new("UIListLayout")

				Dropdown.Name = "Dropdown"
				Dropdown.Parent = Page
				Dropdown.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
				Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Dropdown.BorderSizePixel = 0
				Dropdown.ClipsDescendants = true
				Dropdown.Position = UDim2.new(0.01369863, 0, 0.405405402, 0)
				Dropdown.Size = UDim2.new(1, -10, 0, 30)
				Dropdown.Font = Enum.Font.RobotoMono
				Dropdown.Text = ""
				Dropdown.AutoButtonColor=false
				Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
				Dropdown.TextSize = 20.000
				Dropdown.TextXAlignment = Enum.TextXAlignment.Left
				
				local opend=false
				Dropdown.MouseButton1Click:Connect(function()
					if not opend then
						TweenObject(Dropdown,{Size=UDim2.new(1, -10, 0, 180)},.1)
						TweenObject(arr,{Rotation=0},.1)
						opend=true
					else
						TweenObject(Dropdown,{Size=UDim2.new(1, -10, 0, 30)},.1)
						TweenObject(arr,{Rotation=-90},.1)
						opend=false
					end
				end)
				
				arr.Name = "arr"
				arr.Parent = Dropdown
				arr.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				arr.BackgroundTransparency = 1.000
				arr.BorderColor3 = Color3.fromRGB(0, 0, 0)
				arr.BorderSizePixel = 0
				arr.Position = UDim2.new(1, -30, 0, 3)
				arr.Rotation = -90.000
				arr.Size = UDim2.new(0, 25, 0, 25)
				arr.Image = "rbxassetid://3926305904"
				arr.ImageRectOffset = Vector2.new(404, 284)
				arr.ImageRectSize = Vector2.new(36, 36)

				titledrop.Name = "titledrop"
				titledrop.Parent = Dropdown
				titledrop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				titledrop.BackgroundTransparency = 1.000
				titledrop.BorderColor3 = Color3.fromRGB(0, 0, 0)
				titledrop.BorderSizePixel = 0
				titledrop.LayoutOrder = 1
				titledrop.Size = UDim2.new(1, 0, 0, 30)
				titledrop.Font = Enum.Font.RobotoMono
				titledrop.Text = " "..drop_val.title
				titledrop.TextColor3 = Color3.fromRGB(255, 255, 255)
				titledrop.TextSize = 20.000
				titledrop.TextXAlignment = Enum.TextXAlignment.Left

				ItemsList.Name = "ItemsList"
				ItemsList.Parent = Dropdown
				ItemsList.Active = true
				ItemsList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ItemsList.BackgroundTransparency = 1.000
				ItemsList.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ItemsList.BorderSizePixel = 0
				ItemsList.Position = UDim2.new(0, 0, 0, 35)
				ItemsList.Size = UDim2.new(1, 0, 1, -35)
				ItemsList.ScrollBarThickness = 6
				
				U2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					ItemsList.CanvasSize=UDim2.new(0,0,0, U2.AbsoluteContentSize.Y+5)
				end)

				U2.Name = "U2"
				U2.Parent = ItemsList
				U2.HorizontalAlignment = Enum.HorizontalAlignment.Center
				U2.SortOrder = Enum.SortOrder.LayoutOrder
				U2.Padding = UDim.new(0, 5)
				
				local dropcall={}
				local list={}
				local count=0
				local itemchoose
				
				local function add_button(itemname)
					local selectdrop = Instance.new("TextButton")

					selectdrop.Name = "selectdrop"
					selectdrop.Parent = ItemsList
					selectdrop.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
					selectdrop.BorderColor3 = Color3.fromRGB(0, 0, 0)
					selectdrop.BorderSizePixel = 0
					selectdrop.Size = UDim2.new(1, -20, 0, 15)
					selectdrop.Font = Enum.Font.Roboto
					selectdrop.Text = itemname
					selectdrop.TextColor3 = Color3.fromRGB(255, 255, 255)
					selectdrop.TextSize = 14.000
					list[itemname]=selectdrop
					selectdrop.MouseButton1Click:Connect(function() 
						
						dropcall:Set(itemname)
					end)
				end
				
				function dropcall:Add(item)
					add_button(item)
					count+=1
				end
				
				function dropcall:Set(item)
					if count>0 then
						itemchoose=item
						for i,v in pairs(ItemsList:GetChildren()) do
							if v.Name~="U2" then
								v.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
							end
						end	
						list[item].BackgroundColor3=Color3.fromRGB(26, 26, 30)
						drop_val.callback(itemchoose)
					end
				end
				
				function dropcall:New(items)
					count=0
					table.clear(list)
					for i,v in pairs(ItemsList:GetChildren()) do
						if v.Name~="U2" then
							v:Destroy()
						end
					end	
					for i,v in pairs(items) do
						add_button(v)
						count+=1
					end	
				end
				
				if drop_val.list then
					dropcall:New(drop_val.list)
				end
				
				if drop_val.default then
					dropcall:Set(drop_val.default)
				end
				return dropcall
			end
			
			function callback_func:CreateSlider(slider_val)
				local Slider = Instance.new("Frame")
				local titleslider = Instance.new("TextLabel")
				local SliderF = Instance.new("Frame")
				local SliderMove = Instance.new("Frame")
				local BoxNum = Instance.new("TextBox")

				Slider.Name = "Slider"
				Slider.Parent = Page
				Slider.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
				Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider.BorderSizePixel = 0
				Slider.Size = UDim2.new(1, -10, 0, 50)

				titleslider.Name = "titleslider"
				titleslider.Parent = Slider
				titleslider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				titleslider.BackgroundTransparency = 1.000
				titleslider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				titleslider.BorderSizePixel = 0
				titleslider.LayoutOrder = 1
				titleslider.Size = UDim2.new(0, 120, 0, 30)
				titleslider.Font = Enum.Font.RobotoMono
				titleslider.Text = " "..slider_val.title
				titleslider.TextColor3 = Color3.fromRGB(255, 255, 255)
				titleslider.TextSize = 20.000
				titleslider.TextXAlignment = Enum.TextXAlignment.Left

				SliderF.Name = "SliderF"
				SliderF.Parent = Slider
				SliderF.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderF.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderF.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderF.BorderSizePixel = 0
				SliderF.Position = UDim2.new(0.5, 0, 0.699999988, 0)
				SliderF.Size = UDim2.new(1, -20, 0, 5)

				SliderMove.Name = "SliderMove"
				SliderMove.Parent = SliderF
				SliderMove.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
				SliderMove.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderMove.BorderSizePixel = 0
				SliderMove.Size = UDim2.new(0.5, 0, 1, 0)

				BoxNum.Name = "BoxNum"
				BoxNum.Parent = Slider
				BoxNum.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
				BoxNum.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BoxNum.BorderSizePixel = 0
				BoxNum.Position = UDim2.new(0.800000012, 0, 0.219999999, 0)
				BoxNum.Size = UDim2.new(0, 61, 0, 15)
				BoxNum.ClearTextOnFocus = false
				BoxNum.Font = Enum.Font.RobotoMono
				BoxNum.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
				BoxNum.Text = "0"
				BoxNum.TextColor3 = Color3.fromRGB(255, 255, 255)
				BoxNum.TextScaled = true
				BoxNum.TextSize = 14.000
				BoxNum.TextWrapped = true
				
				local GlobalSliderValue = 0
				local Dragging = false
				local function Sliding(Input)
					local Position = UDim2.new(math.clamp((Input.Position.X - SliderF.AbsolutePosition.X) / SliderF.AbsoluteSize.X,0,1),0,1,0)
					SliderMove.Size = Position
					local SliderPrecise = ((Position.X.Scale * slider_val["Max"]) / slider_val["Max"]) * (slider_val["Max"] - slider_val["Min"]) + slider_val["Min"]
					local SliderNonPrecise = math.floor(((Position.X.Scale * slider_val["Max"]) / slider_val["Max"]) * (slider_val["Max"] - slider_val["Min"]) + slider_val["Min"])
					local SliderValue = slider_val["Precise"] and SliderNonPrecise or SliderPrecise
					SliderValue = tonumber(string.format("%.2f", SliderValue))
					GlobalSliderValue = SliderValue
					BoxNum.Text = tostring(SliderValue)
					slider_val["callback"](GlobalSliderValue)
				end
				local function SetValue(Value)
					GlobalSliderValue = Value
					SliderMove.Size = UDim2.new(Value / slider_val["Max"],0,1,0)
					BoxNum.Text = Value
					slider_val["callback"](Value)
				end
				SetValue(slider_val["Precise"])
				BoxNum.FocusLost:Connect(function()
					if not tonumber(BoxNum.Text) then
						BoxNum.Text = GlobalSliderValue
					elseif BoxNum.Text == "" or tonumber(BoxNum.Text) <= slider_val["Min"] then
						BoxNum.Text = slider_val["Min"]
					elseif BoxNum.Text == "" or tonumber(BoxNum.Text) >= slider_val["Max"] then
						BoxNum.Text = slider_val["Max"]
					end

					GlobalSliderValue = BoxNum.Text
					SliderMove.Size = UDim2.new(BoxNum.Text / slider_val["Max"],0,1,0)
					slider_val["callback"](tonumber(BoxNum.Text))
				end)
				SliderF.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Sliding(Input)
						Dragging = true
					end
				end)

				SliderF.InputEnded:Connect(function(Input)
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
			
			function callback_func:CreateLabel(label_val)
				local Label = Instance.new("TextLabel")

				Label.Name = "Label"
				Label.Parent = Page
				Label.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
				Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Label.BorderSizePixel = 0
				Label.Size = UDim2.new(1, -10, 0, 30)
				Label.Font = Enum.Font.RobotoMono
				Label.Text = "Server Time : 20d 0h 1m 2s"
				Label.TextColor3 = Color3.fromRGB(255, 255, 255)
				Label.TextSize = 20.000
				
				local labelcall={}
				Label.Text=label_val.default or ""
				function labelcall:Set(text)
					Label.Text=text
				end
				return labelcall
			end
			
			function callback_func:Line()
				local AddLine = Instance.new("Frame")

				AddLine.Name = "AddLine"
				AddLine.Parent = Page
				AddLine.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
				AddLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
				AddLine.BorderSizePixel = 0
				AddLine.Size = UDim2.new(1, -10, 0, 2)
			end
			
			function callback_func:CreateTextbox(textbox_val)
				local Box = Instance.new("Frame")
				local titleslider = Instance.new("TextLabel")
				local BoxText = Instance.new("TextBox")

				Box.Name = "Box"
				Box.Parent = Page
				Box.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
				Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Box.BorderSizePixel = 0
				Box.Size = UDim2.new(1, -10, 0, 40)

				titleslider.Name = "titleslider"
				titleslider.Parent = Box
				titleslider.AnchorPoint = Vector2.new(0, 0.5)
				titleslider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				titleslider.BackgroundTransparency = 1.000
				titleslider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				titleslider.BorderSizePixel = 0
				titleslider.LayoutOrder = 1
				titleslider.Position = UDim2.new(0, 0, 0.5, 0)
				titleslider.Size = UDim2.new(0, 120, 0, 30)
				titleslider.Font = Enum.Font.RobotoMono
				titleslider.Text = " "..textbox_val.title
				titleslider.TextColor3 = Color3.fromRGB(255, 255, 255)
				titleslider.TextSize = 20.000
				titleslider.TextXAlignment = Enum.TextXAlignment.Left

				BoxText.Name = "BoxText"
				BoxText.Parent = Box
				BoxText.AnchorPoint = Vector2.new(0.5, 0.5)
				BoxText.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
				BoxText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BoxText.BorderSizePixel = 0
				BoxText.Position = UDim2.new(1, -50, 0.5, 0)
				BoxText.Size = UDim2.new(0, 83, 0, 25)
				BoxText.ClearTextOnFocus = false
				BoxText.Font = Enum.Font.RobotoMono
				BoxText.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
				BoxText.Text = textbox_val.default or ""
				BoxText.TextColor3 = Color3.fromRGB(255, 255, 255)
				BoxText.TextScaled = true
				BoxText.TextSize = 14.000
				BoxText.TextWrapped = true
				
				textbox_val.callback(BoxText.Text)
				
				BoxText.FocusLost:Connect(function()
					textbox_val.callback(BoxText.Text)
				end)
				
				
			end
			return callback_func
		end
		return sections
	end
	
	return pages
end


local Sawhub = MainUI:CreateWindow({
	title = "Saw Hub",
	Keybind = Enum.KeyCode.RightControl
})


local Main = Sawhub:CreatePage({title = "Main"})

local AutoFarmSec = Main:CreateSection({title = "Auto Farm"})

AutoFarmSec:CreateButton({title="Unlock Island",callback=function()
    UnlockIsland()
end})
local island_farm={}

for i,v in pairs(workspace.Worlds["The Overworld"].Islands:GetChildren()) do
    table.insert(island_farm,v.Name)
end

local DropLane = AutoFarmSec:CreateDropdown({title = "Select Island Farm",list = island_farm,callback = function (v)
    getgenv().Configs.SelectIsland=v
end})

AutoFarmSec:CreateToggle({title="Auto Farm",default=getgenv().Configs.AutoFarm,callback=function(v)
    getgenv().Configs.AutoFarm=v
end})

AutoFarmSec:CreateToggle({title="Auto Bubble",default=getgenv().Configs.AutoBubble,callback=function(v)
    getgenv().Configs.AutoBubble=v
end})

AutoFarmSec:CreateToggle({title="Auto Collect",default=getgenv().Configs.AutoCollect,callback=function(v)
    getgenv().Configs.AutoCollect=v
end})

local eggpos = {
	["Bunny Egg"]=CFrame.new(-404.22879, 12012.3809, -58.892086),
	["Nightmare Egg"]=CFrame.new(-17.5698757, 10148.1084, 186.612473),
	["Rainbow Egg"]=CFrame.new(-34.4163857, 15972.7217, 43.4907036),
	["Void Egg"]=CFrame.new(7.74198961, 10148.1748, 186.165726)
}

local AutoBoostSec = Main:CreateSection({title = "Auto Boost"})

local EggSelect=AutoBoostSec:CreateLabel({default="Egg Select: "..getgenv().Configs.SelectEgg})
AutoBoostSec:Line()
local DropLane = AutoBoostSec:CreateDropdown({title = "Select Egg",list = {"Rainbow Egg","Nightmare Egg","Void Egg","Bunny Egg"},callback = function (v)
    getgenv().Configs.SelectEgg=v
	EggSelect:Set("Egg Select: "..v)
end})



AutoBoostSec:CreateToggle({title="Auto Egg",default=getgenv().Configs.AutoEgg,callback=function(v)
    getgenv().Configs.AutoEgg=v
end})

AutoBoostSec:CreateToggle({title="Auto Equip Best",default=getgenv().Configs.AutoEquipBest,callback=function(v)
    getgenv().Configs.AutoEquipBest=v
end})

AutoBoostSec:CreateToggle({title="Auto Use Potion",default=getgenv().Configs.AutoUsePotion,callback=function(v)
    getgenv().Configs.AutoUsePotion=v
end})

AutoBoostSec:CreateToggle({title="Auto Claim Gift",default=getgenv().Configs.AutoClaimGift,callback=function(v)
    getgenv().Configs.AutoClaimGift=v
end})

AutoBoostSec:CreateToggle({title="Auto Playtime",default=getgenv().Configs.AutoPlaytime,callback=function(v)
    getgenv().Configs.AutoPlaytime=v
end})

AutoBoostSec:CreateToggle({title="Auto Mastery",default=getgenv().Configs.AutoMastery,callback=function(v)
    getgenv().Configs.AutoMastery=v
end})

AutoBoostSec:CreateToggle({title="Auto Hatch Powerup Egg",default=getgenv().Configs.AutoHateeggpr,callback=function(v)
    getgenv().Configs.AutoHateeggpr=v
end})

AutoBoostSec:CreateToggle({title="Auto Buy Gum",default=getgenv().Configs.AutoBuyGum,callback=function(v)
    getgenv().Configs.AutoBuyGum=v
end})

AutoBoostSec:CreateToggle({title="Auto Alen Shop",default=getgenv().Configs.AutoBuyAllienShop,callback=function(v)
    getgenv().Configs.AutoBuyAllienShop=v
end})
AutoBoostSec:CreateToggle({title="Auto BlackMakert Shop",default=getgenv().Configs.BuyBlackMarket,callback=function(v)
    getgenv().Configs.BuyBlackMarket=v
end})

local Misc = Sawhub:CreatePage({title="Misc"})
local MiscSec = Misc:CreateSection({title="Others"})

MiscSec:CreateButton({title="Open/close enchant ui",callback=function()
	game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Enchants.Visible = not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Enchants.Visible
end})

MiscSec:CreateButton({title="Rejoin",callback=function()
	game:GetService("TeleportService"):Teleport(game.PlaceId,game.Players.LocalPlayer)
end})

local rejoinauto=false
MiscSec:CreateToggle({title="Auto Rejoin (3hours)",default=false,callback=function(v)
	rejoinauto=v
end})

local buff=false
MiscSec:CreateToggle({title="Boost Fps",default=getgenv().Configs.boostfps,callback=function(v)
	if v then
		game:GetService("RunService"):Set3dRenderingEnabled(false)
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
			for _, guiType in pairs(Enum.CoreGuiType:GetEnumItems()) do
				game:GetService("StarterGui"):SetCoreGuiEnabled(guiType, false)
			end
			workspace.Terrain:Clear()
			local ss = game:GetService("SoundService")
			ss.RespectFilteringEnabled = false
			ss.AmbientReverb = Enum.ReverbType.NoReverb			
		end
	else
		game:GetService("RunService"):Set3dRenderingEnabled(true)
	end
end})



task.spawn(function()
    while wait(1) do
        if rejoinauto then
            if math.floor(workspace.DistributedGameTime+0.5) >= 11100 then
                game:GetService("TeleportService"):Teleport(game.PlaceId,game.Players.LocalPlayer)
            end
        end
    end
end)

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
    while wait(0.1) do
        if getgenv().Configs.AutoEgg then
			while (player.Character.HumanoidRootPart.Position - eggpos[getgenv().Configs.SelectEgg].Position).Magnitude >= 5 do
				TP(eggpos[getgenv().Configs.SelectEgg])
				task.wait(0.1)
			end
			
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
        if getgenv().Configs.AutoCollect then
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

function BuyBlackMarket()
	for i =1,3 do

		local args = {
			[1] = "BuyShopItem",
			[2] = "shard-shop",
			[3] = i
		  }
		  
		  game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
		  
	end
end

task.spawn(function()
	while wait(1) do
		if getgenv().Configs.BuyBlackMarket then
			BuyBlackMarket()
			wait(60)
		end
	end
end)


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
local besttpnew={
	["Workspace.Event.Portal.Spawn"]=CFrame.new(-378.902679, 12014.5693, 140.281555)
}

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
        
    end

    local times = (player.Character.HumanoidRootPart.Position - cf.Position).Magnitude / 20
    local tween = TS:Create(player.Character.HumanoidRootPart, TweenInfo.new(times,Enum.EasingStyle.Linear), {CFrame = cf})
    tween:Play()



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
        ["content"] = (a == "NULLVoid") and "<@&1360175696579662016>" or nil,
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
	if getgenv().Configs.AutoCollect then
		for i,c in v do
			local args = {
				[1] = c.Id
			}


			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup"):FireServer(unpack(args))
		end
	end
end)

