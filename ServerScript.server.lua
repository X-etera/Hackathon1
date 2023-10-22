local replicated_storage = game:GetService("ReplicatedStorage")
local fade_event = replicated_storage:WaitForChild("FadeEvent")
local create_lost_item_event = replicated_storage:WaitForChild("CreateLostItem")
local add_item_event = replicated_storage:WaitForChild("AddItemEvent")

fade_event.OnServerEvent:Connect(function(player, currentPage, newPage)
    fade_event:FireClient(player, currentPage, newPage)
end)

create_lost_item_event.OnServerEvent:Connect(function(player, name, contact, item, detail)
    create_lost_item_event:FireClient(player, name, contact, item, detail )
end)

add_item_event.OnServerEvent:Connect(function(player, item, clicked_location, extra)
    add_item_event:FireClient(player, item, clicked_location, extra)
end)