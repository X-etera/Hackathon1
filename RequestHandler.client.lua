--Services--
local replicated_storage = game:GetService("ReplicatedStorage")
local tween_service = game:GetService("TweenService")
local create_lost_item_event = replicated_storage:WaitForChild("CreateLostItem")

local local_player = game.Players.LocalPlayer
local player_gui = local_player:WaitForChild("PlayerGui")

--Variables--
local screen_gui = script.Parent
local scroll_frame = screen_gui:WaitForChild("ScrollingFrame")
local main_background = scroll_frame:WaitForChild("MainBackground")
local submit_button = main_background:WaitForChild("SubmitButton")
local end_frame = screen_gui:WaitForChild("EndFrame")
local main_page = player_gui:WaitForChild("MainPage")
local tween_time = 1

submit_button.Activated:Connect(function()
    local name = main_background.NameBox.Text
    local contact = main_background.ContactBox.Text
    local item = main_background.ItemBox.Text
    local detail = main_background.DetailBox.Text

    if name == "" then return end

    create_lost_item_event:FireServer(name, contact, item, detail)
end)

create_lost_item_event.OnClientEvent:Connect(function(name, contact, item, detail)
    end_frame.Visible = true
    scroll_frame.Visible = false
    main_page.Enabled = true
    wait(2)
    local close_tween = tween_service:Create(
        end_frame,
        TweenInfo.new(
            tween_time,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.InOut),
            {BackgroundTransparency = 1}
    )
    local close_tween2 = tween_service:Create(
        end_frame.TextLabel,
        TweenInfo.new(
            tween_time,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.InOut),
            {TextTransparency = 1}
    )
    close_tween:Play()
    close_tween2:Play()
    close_tween.Completed:Connect(function()
        end_frame.Visible = false
        end_frame.BackgroundTransparency = 0
        end_frame.TextLabel.TextTransparency = 0
        wait()
        screen_gui.Enabled = false
    end)
    
    local lost_item_list = main_page.ScrollingFrame.LostItemRequestsFrame

    for _, frame in pairs(lost_item_list:GetChildren()) do
        if frame:IsA("Frame") and frame.Name == "1" then
            frame.Name = "ItemFrame"
        end
    end

    local new_lost_item = lost_item_list.ItemFrame:Clone()
    new_lost_item.Parent = lost_item_list
    new_lost_item.Name = "1"
    new_lost_item.NameLabel.Text = "Name:".." "..name
    new_lost_item.ContactLabel.Text = "Contact:".." "..contact
    new_lost_item.PersonDescriptionLabel.Text = detail
    new_lost_item.DescriptionLabel.Text = "Description:".." "..item
    new_lost_item.ImageLabel:Destroy()
end)