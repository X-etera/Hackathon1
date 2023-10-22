local screen_gui = script.Parent
local main_frame = screen_gui:WaitForChild("Frame")
local main_background = main_frame:WaitForChild("MainBackground")
local drop_list_frame = main_background:WaitForChild("DropListFrame")
local submit_button = main_background:WaitForChild("SubmitButton")
local replicated_storage = game:GetService("ReplicatedStorage")
local add_item_event = replicated_storage:WaitForChild("AddItemEvent")
local end_frame = screen_gui:WaitForChild("EndFrame")
local tween_service = game:GetService("TweenService")

local tween_time = 1

local local_player = game.Players.LocalPlayer
local player_gui = local_player:WaitForChild("PlayerGui")
local main_page = player_gui:WaitForChild("MainPage")

local location

 for _, button in pairs(drop_list_frame:GetChildren()) do
    if not button:IsA("TextButton") then continue end
     button.MouseButton1Click:Connect(function()
        location = button.Text
    end)
 end

submit_button.MouseButton1Click:Connect(function()
    local item = main_background.NameBox.Text
    local extra = main_background.ExtraLocationBox.Text
    local clicked_location = location

    add_item_event:FireServer(item, clicked_location, extra)

    end_frame.Visible = true
    main_frame.Visible = false
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


end)