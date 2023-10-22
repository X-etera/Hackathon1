local uis = game:GetService("UserInputService")
local screen_gui = script.Parent
local background_frame = screen_gui:WaitForChild("Background")
local list_frames = background_frame:WaitForChild("ListFrames")
local campus_map = background_frame:WaitForChild("CampusMap")
local pings_folder = campus_map:WaitForChild("Pings")
local search_item_box = campus_map:WaitForChild("SearchItemBox")
local on_screen_pos = UDim2.new(0.723, 0, 0.044, 0)
local off_screen_pos = UDim2.new(1, 0, 0.044, 0)
local replicated_storage = game:GetService("ReplicatedStorage")
local add_item_event = replicated_storage:WaitForChild("AddItemEvent")

local list_open = false
local tween_time = .75
local bubble_tween_time = .45

for _, map_ping_frame in pairs(pings_folder:GetChildren()) do
    map_ping_frame:FindFirstChild("LocationPingButton").Activated:Connect(function()
        if not list_open then
            local string_location = string.find(map_ping_frame.Name, "P")
            local P_location = string_location - 1
            local button_pressed_name = string.sub(map_ping_frame.Name, 1, P_location)
            local list_to_open = list_frames:FindFirstChild(button_pressed_name.."ListFrame")
            list_to_open.Visible = true
            list_to_open:TweenPosition(
                on_screen_pos,
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Back,
                tween_time,
                true
            )
            list_open = true
        elseif list_open then
            for _, list_frame in pairs(list_frames:GetChildren()) do
                if list_frame.Visible == true then
                    list_frame:TweenPosition(
                        off_screen_pos, 
                        Enum.EasingDirection.In,
                        Enum.EasingStyle.Back,
                        tween_time,
                        true,
                        function(status)
                            if status == Enum.TweenStatus.Completed then
                                local string_location = string.find(map_ping_frame.Name, "P")
                                local P_location = string_location - 1
                                local pressed_button_name = string.sub(map_ping_frame.Name, 1, P_location)
                                local list_to_open = list_frames:FindFirstChild(pressed_button_name.."ListFrame")
                                list_to_open.Visible = true
                                list_to_open:TweenPosition(
                                    on_screen_pos,
                                    Enum.EasingDirection.Out,
                                    Enum.EasingStyle.Back,
                                    tween_time,
                                    true
                                )
                            end
                        end
                    )
                end
            end
        end     
    end)
end

uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.S then
        local item_to_find = search_item_box.Text
        for _, listFrame in pairs(list_frames:GetChildren()) do
            local item_list = listFrame:FindFirstChild("ItemListFrame")
            for _, item_frame in pairs(item_list:GetChildren()) do
                if not item_frame:IsA("Frame") then continue end
                local item_frame_name = item_frame:FindFirstChild("NameText").Text
                local split_item_name_table = string.split(item_frame_name, " ")
                for _, word in pairs(split_item_name_table) do
                    if word == item_to_find then
                        local string_location = string.find(listFrame.Name, "L")
                        local L_location = string_location - 1
                        local location_name = string.sub(listFrame.Name, 1, L_location)
                        local button_to_highlight = pings_folder:FindFirstChild(location_name.."PingFrame")
                        for _, item in pairs(button_to_highlight:GetChildren()) do
                            item.ImageColor3 = Color3.fromRGB(255, 255, 0)
                            item:TweenSize(
                                UDim2.new(1.25, 0, 1.25, 0),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                bubble_tween_time,
                                true
                            )
                        end
                    end
                end
            end
        end
    end
end)


add_item_event.OnClientEvent:Connect(function(item, clicked_location, extra)

    if clicked_location == "University Center" then 
        clicked_location = "UC" 
    end
 
    for _, list_frame in pairs(list_frames:GetChildren()) do
        local string_location = string.find(list_frame.Name, "Lis")
        local L_location = string_location - 1
        local needed_list_frame = string.sub(list_frame.Name, 1, L_location)
        if clicked_location == needed_list_frame then
            print("found match")
            local selected_list_frame = list_frames:FindFirstChild(needed_list_frame.."ListFrame")
            local item_list_frame = selected_list_frame:FindFirstChild("ItemListFrame")
            local clone = item_list_frame:FindFirstChildOfClass("Frame"):Clone()
            clone.Parent = item_list_frame
            clone.NameText.Text = item
            clone.LocationText.Text = extra
            clone.ImageLabel:Destroy()
        end
    end
end)