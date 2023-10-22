local uis = game:GetService("UserInputService")
local local_player = game.Players.LocalPlayer
local player_gui = local_player:WaitForChild("PlayerGui")
local replicated_storage = game:GetService("ReplicatedStorage")
local fade_event = replicated_storage:WaitForChild("FadeEvent")

uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Z then
        for _, ui_item in pairs(player_gui:GetChildren()) do
            if not ui_item:IsA("ScreenGui") then continue end
            if ui_item.Name == "FadeScreen" or ui_item.Name == "Freecam" then continue end
            if ui_item.Enabled == true then
                if ui_item.Name == "MainPage" then continue end
                local currentPage = ui_item
                local newPage = "MainPage"
                fade_event:FireServer(currentPage.Name, newPage)
            end
        end
    end
end)