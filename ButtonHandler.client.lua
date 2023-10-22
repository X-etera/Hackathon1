local ReplicatedStorage = game:GetService("ReplicatedStorage")
local fade_event = ReplicatedStorage:WaitForChild("FadeEvent")
local screen_gui = script.Parent
local scroll_frame = screen_gui:WaitForChild("ScrollingFrame")
local lost_item_requests_button = scroll_frame:WaitForChild("LostItemRequestsButton")
local lost_item_requests_frame = scroll_frame:WaitForChild("LostItemRequestsFrame")

--General Variables--
local local_player = game.Players.LocalPlayer
local player_gui = local_player:WaitForChild("PlayerGui")

--Lost Item Requests Dropdown Variables-- 
local open = false
local open_size = UDim2.new(0.521, 0, 0.5, 0)
local close_size = UDim2.new(0.521, 0, 0, 0)
local tween_time = 0.5

for _, button in pairs(scroll_frame:GetChildren()) do

    local currentPage = player_gui:FindFirstChild("MainPage")
    
    if button:IsA("TextButton") then
        if button.Name == "LostItemRequestsButton" then continue end
        button.MouseButton1Click:Connect(function()
            local string_location = string.find(button.Name, "L")
            local L_location = string_location - 1
            local button_pressed_name = string.sub(button.Name, 1, L_location)
            local newPage = player_gui:FindFirstChild(button_pressed_name.."Page")
            fade_event:FireServer(currentPage.Name, newPage.Name)
        end)
    end
end

lost_item_requests_button.Activated:Connect(function()
	if not open then
		lost_item_requests_button.Text = "Lost Item Requests v"
		lost_item_requests_frame.Visible = true
		lost_item_requests_frame:TweenSize(
			open_size,
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quart,
			tween_time,
			true,
			function(state)
				if state == Enum.TweenStatus.Completed then
					open = true
				end
			end
		)
	elseif open then
		lost_item_requests_button.Text = "Lost Item Requests ^"
		lost_item_requests_frame:TweenSize(
			close_size,
			Enum.EasingDirection.In,
			Enum.EasingStyle.Quart,
			tween_time,
			true,
			function(state)
				if state == Enum.TweenStatus.Completed then
					open = false
					lost_item_requests_frame.Visible = false
				end
			end
		)
	end
end)